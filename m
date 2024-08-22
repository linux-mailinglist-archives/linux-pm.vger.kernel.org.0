Return-Path: <linux-pm+bounces-12704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61895AE6A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CB7282CE6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B313C9CA;
	Thu, 22 Aug 2024 07:06:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AA13A3FD;
	Thu, 22 Aug 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310390; cv=none; b=jtryaIEF2nA6PmYtB26plqFqN1OcNAkrzLUzRe4P4lVRh4NAk6VCejxdnJBHQB9a/MQ3+5yhzSRFCoPN33cMVu0RBA7g7KUjwXezyqU5zItsw5AWHT+n9unlJgeyIhhnaieMUisW0N/dg8S3Nu6rB5VqW/fO1oyFFuwWDOU5bXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310390; c=relaxed/simple;
	bh=FLilspV2tZ+qW+2d8uObAeKfCmFZIti9Wu0nFfRYwgs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KckoehFEaEb4eDzx0EHzLtH/N7EhNivSIl7W6fr2Q8uk5IzhVFtepCsKgHDo2MasQCABXbwulcwVqynGswg6UQrRvN3mO6HUeuqe0mxMbWvbzWP7lk4hkqLm5HPjmBnhiGSUzPJD9olkDbyHZnrG54bgTrHAuLz0CGKJlEDOcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af532.dynamic.kabel-deutschland.de [95.90.245.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D9E2E61E5FE05;
	Thu, 22 Aug 2024 09:06:12 +0200 (CEST)
Message-ID: <8092403e-cc8a-45ce-982a-c954e7428c32@molgen.mpg.de>
Date: Thu, 22 Aug 2024 09:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: USB-C adapter like Dell DA300 using > 5 W
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
References: <38b871f7-8583-4b9a-940b-ee33a1b6206d@molgen.mpg.de>
 <2024082207-foothill-swirl-0ad0@gregkh>
Content-Language: en-US
In-Reply-To: <2024082207-foothill-swirl-0ad0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Greg,


Thank you for your quick response.

Am 22.08.24 um 01:31 schrieb Greg KH:
> On Wed, Aug 21, 2024 at 11:32:04PM +0200, Paul Menzel wrote:

>> On the Intel Kaby Lake laptop Dell XPS 13 9360 with Debian sid/unstable and
>> *powertop* 2.15-3, connecting a USB-C adapter like Dell DA300 or LMP USB-C
>> mini Dock (P/N 15954) [1] and connecting only an Ethernet cable (module
>> r8152 is used), the adapter gets very hot, and according to PowerTOP it uses
>> over 5 Watts – almost more as the laptop idling.
>>
>>      $ lsusb # Dell DA300
>>      Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>      Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4 Bluetooth 4.0
>>      Bus 001 Device 003: ID 04f3:2234 Elan Microelectronics Corp. Touchscreen
>>      Bus 001 Device 004: ID 0c45:670c Microdia Integrated Webcam HD
>>      Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>      Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>>      Bus 003 Device 002: ID 2109:2820 VIA Labs, Inc. VL820 Hub
>>      Bus 003 Device 003: ID 06c4:c412 Bizlink International Corp. DELL DA300
>>      Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>      Bus 004 Device 002: ID 2109:0820 VIA Labs, Inc. VL820 Hub
>>      Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
>>
>> With `LANG= sudo powertop --auto-tune` it stays high.
>>
>> PowerTOP:
>>
>> ```
>> The battery reports a discharge rate of 6.01 W
>> The energy consumed was 146 J
>> The estimated remaining time is 3 hours, 51 minutes
>>
>> Summary: 384.6 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and
>> 8.5% CPU use
>>
>> Power est.              Usage       Events/s    Category       Description
>>    5.94 W      0.0%                      Device         Display backlight
>>    5.23 W    100.0%                      Device         USB device: USB Optical Mouse (Logitech)
>>    4.62 W     66.1%                      Device         USB device: USB 10/100/1000 LAN (Realtek)
>>    205 mW    100.0%                      Device         USB device: Fujitsu Keyboard (Fujitsu)
>>   14.1 mW     13.5 ms/s       0.9        kWork intel_atomic_commit_work
>> ```
>>
>> At another time:
>>
>> ```
>> The battery reports a discharge rate of 10.5 W
>> The energy consumed was 235 J
>> The estimated remaining time is 2 hours, 20 minutes
>>
>> Summary: 395.8 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 23.8% CPU use
>>
>> Power est.              Usage       Events/s    Category       Description
>>    7.13 W    100.0%                      Device         USB device: USB 10/100/1000 LAN (Realtek)
>>    3.92 W     15.8%                      Device         Display backlight
>>    320 mW      0.0 us/s      0.00        Process        [PID 1349] /usr/bin/pipewire
>>   63.6 mW     65.4 ms/s       0.5        Process        [PID 4982] /usr/lib/thunderbird/thunderbird
>>   24.9 mW     25.6 ms/s       6.7        Process        [PID 37753] /usr/lib/firefox-nightly/firefox-bin -contentproc -isForBrowser -prefsLen 36793 -prefMapSize 265654 -jsInitLe
>>   14.7 mW     15.1 ms/s       0.5        kWork intel_atomic_commit_work
>> ```
>>
>> The heat of the USB-C adapter might suggest, that it draws that much power.
>> What is your experience? Can you suggest something?
> 
> Buy a different adapter?  That seems like something is really wrong with
> it.  Does other devices also suck that much power from that port on the
> laptop?

It happens with two Dell DA300 adapters and two LMP USB-C mini Dock (P/N 
15954, 12-22 Rev. 3):

     $ lsusb # LMP USB-C
     Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications 
QCA61x4 Bluetooth 4.0
     Bus 001 Device 003: ID 04f3:2234 Elan Microelectronics Corp. 
Touchscreen
     Bus 001 Device 004: ID 0c45:670c Microdia Integrated Webcam HD
     Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
     Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
     Bus 003 Device 002: ID 2109:2817 VIA Labs, Inc. USB2.0 Hub
     Bus 003 Device 003: ID 2109:2817 VIA Labs, Inc. USB2.0 Hub
     Bus 003 Device 005: ID 2109:8817 VIA Labs, Inc. USB Billboard Device
     Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
     Bus 004 Device 002: ID 2109:0817 VIA Labs, Inc. USB3.0 Hub
     Bus 004 Device 003: ID 2109:0817 VIA Labs, Inc. USB3.0 Hub
     Bus 004 Device 004: ID 058f:8468 Alcor Micro Corp. Mass Storage Device
     Bus 004 Device 005: ID 0bda:8153 Realtek Semiconductor Corp. 
RTL8153 Gigabit Ethernet Adapter

Both use a Realtek RTL8153 Ethernet adapter.

### LMP device

With *no* auto-tuning:

```
 >> Bad           VM writeback timeout 

    Bad           NMI watchdog should be turned off
    Bad           Autosuspend for USB device USB Billboard Device 
[VIA Labs, Inc.         ]
    Bad           Autosuspend for USB device Mass Storage Device [Generic]
    Bad           Autosuspend for USB device Touchscreen [ELAN]
    Bad           Autosuspend for USB device USB 10/100/1000 LAN [Realtek]
    Bad           Runtime PM for PCI Device SK hynix PC300 NVMe Solid 
State Drive 512GB
    Bad           Runtime PM for disk sda
    Bad           Runtime PM for disk sdb
    Bad           Runtime PM for PCI Device Intel Corporation Sunrise 
Point-LP PCI Express Root Port #1
    Bad           Runtime PM for PCI Device Qualcomm Atheros QCA6174 
802.11ac Wireless Network Adapter
    Bad           Runtime PM for PCI Device Intel Corporation DSL6340 
Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
    Bad           Runtime PM for PCI Device Intel Corporation Sunrise 
Point-LP LPC Controller
    Bad           Runtime PM for PCI Device Intel Corporation DSL6340 
Thunderbolt 3 Bridge [Alpine Ridge 2C 2015]
```

```
The battery reports a discharge rate of 8.89 W
The energy consumed was 243 J
The estimated remaining time is 0 hours, 42 minutes

Summary: 572.3 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 
54.8% CPU use

Power est.              Usage       Events/s    Category       Description
   6.00 W      5.9%                      Device         Display backlight
   2.33 W    100.0%                      Device         USB device: USB 
Billboard Device    (VIA Labs, Inc.         )
```

After `powertop --auto-tune`:

```
The battery reports a discharge rate of 8.58 W
The energy consumed was 213 J
The estimated remaining time is 0 hours, 39 minutes

Summary: 509.3 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 
34.3% CPU use

Power est.              Usage       Events/s    Category       Description
   8.23 W      5.9%                      Device         Display backlight
   6.21 W     7938 pkts/s                Device         Network 
interface: enx00e04ceabb21 (r8152)
```

But it also shows:

```
The battery reports a discharge rate of 9.54 W
The energy consumed was 189 J
The estimated remaining time is 0 hours, 33 minutes

Summary: 509.0 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 
44.0% CPU use

Power est.              Usage       Events/s    Category       Description
   7.39 W      5.9%                      Device         Display backlight
   776 mW    12391 pkts/s                Device         Network 
interface: enx00e04ceabb21 (r8152)
   210 mW    357.9 ms/s       0.4        kWork 
intel_atomic_commit_work
```

So measuring energy consumption, and attributing it to devices, also 
seems to be hard and sometimes unreliable.

Therefore, I’d be interested, it what numbers to expect, and also, if 
the developers have other methods and tools for measuring this.



Kind regards,

Paul

