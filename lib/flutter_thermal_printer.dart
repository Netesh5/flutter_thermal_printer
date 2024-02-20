import 'dart:io';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_thermal_printer/WindowBle/window_ble_manager.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

import 'OthersBle/other_ble_manager.dart';

export 'package:esc_pos_utils/esc_pos_utils.dart';
export 'package:flutter_blue_plus/flutter_blue_plus.dart' show BluetoothDevice;

class FlutterThermalPrinter {
  FlutterThermalPrinter._();

  static FlutterThermalPrinter? _instance;

  static FlutterThermalPrinter get instance {
    FlutterBluePlus.setLogLevel(LogLevel.debug);
    _instance ??= FlutterThermalPrinter._();
    return _instance!;
  }

  Stream<List<Printer>> get devicesStream {
    if (Platform.isWindows) {
      return WindowBleManager.instance.devicesStream;
    } else {
      return OtherBleManager.instance.devicesStream;
    }
  }

  Future<void> startScan() async {
    if (Platform.isWindows) {
      await WindowBleManager.instance.startscan();
    } else {
      await OtherBleManager.instance.startScan();
    }
  }

  Future<void> stopScan() async {
    if (Platform.isWindows) {
      await WindowBleManager.instance.stopscan();
    } else {
      await OtherBleManager.instance.stopScan();
    }
  }

  Future<bool> connect(Printer device) async {
    if (Platform.isWindows) {
      return await WindowBleManager.instance.connect(device);
    } else {
      return await OtherBleManager.instance.connect(device);
    }
  }

  Future<void> printData(
    Printer device,
    List<int> bytes, {
    bool longData = false,
  }) async {
    if (Platform.isWindows) {
      return await WindowBleManager.instance.printData(
        device,
        bytes,
        longData: longData,
      );
    } else {
      return await OtherBleManager.instance.printData(
        device,
        bytes,
        longData: longData,
      );
    }
  }

  Future<void> getUsbDevices() async {
    if (Platform.isWindows) {
    } else {
      await OtherBleManager.instance.startUsbScan();
    }
  }

  Future<void> getPrinters({
    Duration refreshDuration = const Duration(seconds: 2),
    List<ConnectionType> connectionTypes = const [
      ConnectionType.USB,
      ConnectionType.BLE
    ],
  }) async {
    if (Platform.isWindows) {
      // await WindowBleManager.instance.getPrinters();
    } else {
      OtherBleManager.instance.getPrinters(
        refreshDuration: refreshDuration,
        connectionTypes: connectionTypes,
      );
    }
  }
}