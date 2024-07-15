Return-Path: <linux-pm+bounces-11086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D519310D7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9481DB21797
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A1186E2C;
	Mon, 15 Jul 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="W88TM+TR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62E1862B3;
	Mon, 15 Jul 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034457; cv=none; b=f6UjLCQFtpVlxHE22BPcwv9b+jdD8y7W1jJFjy9nOtdOAJLroYk92nBhvizW73RdCprD8qpPwPYN7spT4Q4xJRDejVWjeVgKw0DRdPT5p0SyasJYGhYFgf4ZbY0ZL0O25N5QClSaDPLjkhXxsQsa0Gxxx8fkPhdhJtasmWag6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034457; c=relaxed/simple;
	bh=paHFHwm3rTxBpjdwAtf/sBa2LvFZ4srJHC3zGN0LVFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwGj+uF9hSCXjYuQHc84f0T6OaTI6/OxAxbH7Vif7hkAJewIwJJBryJ9u34vznBaOGki1Mis7GM5U9LCvWCh3PXAcJLW78SdFNRbmRyEGU/PjjSZi3QVYEY3GKFciJHrlsXB9LPS9krgH/macwT7X3raF7AuuE9UQYyCNPCNkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=W88TM+TR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1721034425; x=1721639225; i=s.l-h@gmx.de;
	bh=4NEHlhdrVGqTml36hLyAlKKZc/ZJmLmPF4YdDUwYXWc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W88TM+TRQRe02ytY4htuJTeN44k6ck6q9MWMDIywdB3AE6ygU/WYma8fC9snnfgk
	 6eqpS0a10XUUA4kYaPDSGi4mbvxDGHo+dQgLvpzl0/P3Yil+Xn/CijGxfQdUJnR1i
	 kAmiiwuQ0tuCk0Ip++xZrac70GjyI8xvoePkIxzf5A7fJhYaIqKnIsdQyiDPIrnRn
	 s6uyrGphYYHt2cZw0gntnGvI0A/hCD6Rclrko8Ji0UahGcfJLfW2fZ+x2K3++Nf3G
	 LHhhB5W10+2zIVS+R7R4c/G6fIVDWk3q9/5e9wAUDUijpmlBXoJZar0xGC500UVv4
	 8g5e8L6efKlyrVO+kA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MORAU-1si5GJ2NKw-00X3Gv; Mon, 15
 Jul 2024 11:07:05 +0200
Date: Mon, 15 Jul 2024 11:06:59 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui
 <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, "Linux
 regression tracking (Thorsten Leemhuis)"  <regressions@leemhuis.info>
Subject: Re: [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone
 temperature is invalid
Message-ID: <20240715110659.51b441e2@mir>
In-Reply-To: <20240715044527.GA1544@sol.localdomain>
References: <6064157.lOV4Wx5bFT@rjwysocki.net>
	<20240715044527.GA1544@sol.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:41/1wgnZZWzTNm/5IY9QYbvPWSJMeRZdQmtM1ayvJHmL9kVYEFS
 8neWzN8Bv4Y8ZQGSIPfqHFC5Uq/UhGUE7dwBE1vfrb+JqRvcHPLTHGbwiTa6XzewwZhQqK7
 TsojEvc5J3dKt+xP93Xsb4R4uskjLSeAkADomSIm/DUdOnoUjGLMXA7nntAJPwkI2YHE9RN
 b5DuPdHQ1D3LUFczvPeeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j6P1731f3U4=;nPBtrnYOCbjwe7e3ru+jpI6noJH
 gYqTVOnAxonWSs8943MeH/bnZ/AD9xY47uTMmxBb3WRC8vkpcMUmkEGlFRpZQfzzLLJIfqN7x
 EDaOq4Nj/he47URkgKy2q1nfMmxiAZrLCZpQlXIMplr4lR00NZCgYBQ5fpcSQvplHeYmTK/6E
 uP9z1h0arJvReQfsq4/S15+fniQw7jX+bHpp+VR3kKprNypNG+M50dSeN4Nr3t3VPeySnyDc/
 4Ksemo+vd50UPRKOK253jGirF/fC1m+Qe54h30kAVGSY0gf6tcFyL46IR7K8j68W9/tadbV9z
 uf/vOBz+Dh9EM7YyrhuhQwtG7xaezKnTgNDd3vMFL8Rlebauy/QTe+Si7iRUTZr8I1io/O9QZ
 w2UxiK0BGMUBlXh8aev8eiIyI30W7Muk8/ixC09l2tEfppt2WG2WIu1mml6aGkA51HhaLdnAC
 q78khMKw2jDx3u60rJ18iZpG1DNSuid8+u+WUUB6h5s/0DKHJ67o6Kk3z7YqlZSVvw82cOKnH
 qAVdGlWpZraSgDs2k7+g6WJ2eHN9+RPg0X0UdHC+TXtQYfxhRYIrxlhBvKMQlYnc48nHB3Jot
 JeC1Npn6I92G6HXtiRxQxDzJvmte0tkbHlZaMfdGu5hvKQJ+FwfvXY7hAKhgmH2YxaEQz4pQj
 YzIh639t1DlYeqEi7KaGb2Lx8/NmpZ19DUYi208EI6OGMGtuI5WkRH879cwZOwF9K0+L4Tf1E
 kYGxnyW+8dTM9Lac1qCZuyoVZ7bM9gpFoOQ7YbwegQmgIzGcEyVjNKEkcZc+78UaGSmko6Vf2
 xmipmh/0pFKUDtOefH9aUTGQ==

Hi

On 2024-07-14, Eric Biggers wrote:
> On Thu, Jul 04, 2024 at 01:46:26PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
> > if zone temperature is invalid") caused __thermal_zone_device_update()
> > to return early if the current thermal zone temperature was invalid.
> >
> > This was done to avoid running handle_thermal_trip() and governor
> > callbacks in that case which led to confusion.  However, it went too
> > far because monitor_thermal_zone() still needs to be called even when
> > the zone temperature is invalid to ensure that it will be updated
> > eventually in case thermal polling is enabled and the driver has no
> > other means to notify the core of zone temperature changes (for exampl=
e,
> > it does not register an interrupt handler or ACPI notifier).
> >
> > Also if the .set_trips() zone callback is expected to set up monitorin=
g
> > interrupts for a thermal zone, it needs to be provided with valid
> > boundaries and that can only be done if the zone temperature is known.
> >
> > Accordingly, to ensure that __thermal_zone_device_update() will
> > run again after a failing zone temperature check, make it call
> > monitor_thermal_zone() regardless of whether or not the zone
> > temperature is valid and make the latter schedule a thermal zone
> > temperature update if the zone temperature is invalid even if
> > polling is not enabled for the thermal zone (however, if this
> > continues to fail, give up after some time).
> >
> > Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()=
 if zone temperature is invalid")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033=
fca16@linaro.org
> > Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.ne=
t
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> On v6.10 I'm seeing the following messages spammed to the kernel log end=
lessly,
> and reverting this commit fixes it.
>
>     [  156.410567] thermal thermal_zone0: failed to read out thermal zon=
e (-61)
[...]
>     [  158.458697] thermal thermal_zone0: failed to read out thermal zon=
e (-61)
>
> /sys/class/thermal/thermal_zone0/type contains "iwlwifi_1".

I am observing the same issue on v6.10 with an Intel ax200 WLAN
card in a kaby-lake/ i5-7400 system and a Fujitsu D3400-B22
mainboard and the 'newest' BIOS (V5.0.0.12 R1.29.0) as well:

$ dmesg | grep -i -e iwlwifi -e thermal_zone2
[    3.692433] iwlwifi 0000:04:00.0: enabling device (0140 -> 0142)
[    3.698547] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1005=
30 wfpm id 0x80000000
[    3.698556] iwlwifi 0000:04:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
[    3.703292] iwlwifi 0000:04:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89=
.3.35.37
[    3.797296] iwlwifi 0000:04:00.0: loaded firmware version 77.a20fb07d.0=
 cc-a0-77.ucode op_mode iwlmvm
[    4.090341] iwlwifi 0000:04:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MH=
z, REV=3D0x340
[    4.090524] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    4.218496] iwlwifi 0000:04:00.0: Detected RF HR B3, rfid=3D0x10a100
[    4.285399] iwlwifi 0000:04:00.0: base HW address: 94:e6:f7:XX:XX:XX
[    4.341754] iwlwifi 0000:04:00.0 wlp4s0: renamed from wlan0
[    4.345445] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    4.601400] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    4.857372] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[    5.114387] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[...]
[  143.643801] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  143.899818] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  144.155813] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  144.411815] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  144.667828] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  144.923801] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[  145.179822] thermal thermal_zone2: failed to read out thermal zone (-61=
)
[...]

$ cat  /sys/class/thermal/thermal_zone2/type
iwlwifi_1

38cba05a86d157685d930a4400022eb4  /lib/firmware/iwlwifi-cc-a0-77.ucode
ce9c6e3bda22003f9a9b97cbca94b8215911b7a146c0f4f017963dbb1a233351  /lib/fir=
mware/iwlwifi-cc-a0-77.ucode

git bisect led me to this commit as part of kernel v6.10:

$ LANG=3D git bisect log
git bisect start
# Status: warte auf guten und schlechten Commit
# bad: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect bad 0c3836482481200ead7b416ca80c68a29cfdaabd
# Status: warte auf gute(n) Commit(s), schlechter Commit bekannt
# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# good: [33e02dc69afbd8f1b85a51d74d72f139ba4ca623] Merge tag 'sound-6.10-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 33e02dc69afbd8f1b85a51d74d72f139ba4ca623
# good: [29c73fc794c83505066ee6db893b2a83ac5fac63] Merge tag 'perf-tools-f=
or-v6.10-1-2024-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/pe=
rf/perf-tools
git bisect good 29c73fc794c83505066ee6db893b2a83ac5fac63
# good: [e159d63e6940a2a16bb73616d8c528e93b84a6bb] Merge tag 'kvm-riscv-fi=
xes-6.10-2' of https://github.com/kvm-riscv/linux into HEAD
git bisect good e159d63e6940a2a16bb73616d8c528e93b84a6bb
# good: [d1505b5cd0426bbddbbc99f10e3ae0b52aaa1d1f] Merge tag 'powerpc-6.10=
-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good d1505b5cd0426bbddbbc99f10e3ae0b52aaa1d1f
# good: [4a0929b0062a6b04207a414be9be97eb22965bc1] Merge tag 'media/v6.10-=
3' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 4a0929b0062a6b04207a414be9be97eb22965bc1
# bad: [ef2b7eb55e10294f4f384f21506ef20a6184128c] Merge tag 'scsi-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad ef2b7eb55e10294f4f384f21506ef20a6184128c
# good: [968460731f95be9977bc59a513acbc5afc71117d] Merge tag 'gpio-fixes-f=
or-v6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect good 968460731f95be9977bc59a513acbc5afc71117d
# good: [5a4bd506ddad75f1f2711cfbcf7551a5504e3f1e] Merge tag 'clk-fixes-fo=
r-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good 5a4bd506ddad75f1f2711cfbcf7551a5504e3f1e
# bad: [a19ea421490dcc45c9f78145bb2703ac5d373b28] Merge tag 'platform-driv=
ers-x86-v6.10-6' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pl=
atform-drivers-x86
git bisect bad a19ea421490dcc45c9f78145bb2703ac5d373b28
# good: [34afb82a3c67f869267a26f593b6f8fc6bf35905] Merge tag '6.10-rc6-smb=
3-server-fixes' of git://git.samba.org/ksmbd
git bisect good 34afb82a3c67f869267a26f593b6f8fc6bf35905
# bad: [d045c46c52740b0d5e92d376f0b7843b0c0d935a] Merge tag 'thermal-6.10-=
rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad d045c46c52740b0d5e92d376f0b7843b0c0d935a
# bad: [94eacc1c583dd2ba51a2158fb13285f5dc42714b] thermal: core: Fix list =
sorting in __thermal_zone_device_update()
git bisect bad 94eacc1c583dd2ba51a2158fb13285f5dc42714b
# bad: [a8a261774466d8691e555ea674c193bb1b09edab] thermal: core: Call moni=
tor_thermal_zone() if zone temperature is invalid
git bisect bad a8a261774466d8691e555ea674c193bb1b09edab
# good: [aaa18ff54b97706b84306b6613630262706b1f6b] thermal: gov_power_allo=
cator: Return early in manage if trip_max is NULL
git bisect good aaa18ff54b97706b84306b6613630262706b1f6b
# first bad commit: [a8a261774466d8691e555ea674c193bb1b09edab] thermal: co=
re: Call monitor_thermal_zone() if zone temperature is invalid

Reverting 202aa0d4bb532338cd27bcc64c60abc2987a2be7 on top of v6.10 avoids
the issue for me.

$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core=
 Processor Host Bridge/DRAM Registers [8086:591f] (rev 05)
00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor P=
CIe Controller (x16) [8086:1901] (rev 05)
00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 63=
0 [8086:5912] (rev 04)
00:14.0 USB controller [0c03]: Intel Corporation 100 Series/C230 Series Ch=
ipset Family USB 3.0 xHCI Controller [8086:a12f] (rev 31)
00:14.2 Signal processing controller [1180]: Intel Corporation 100 Series/=
C230 Series Chipset Family Thermal Subsystem [8086:a131] (rev 31)
00:16.0 Communication controller [0780]: Intel Corporation 100 Series/C230=
 Series Chipset Family MEI Controller #1 [8086:a13a] (rev 31)
00:17.0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H170/H110=
/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
00:1c.0 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipse=
t Family PCI Express Root Port #5 [8086:a114] (rev f1)
00:1c.6 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipse=
t Family PCI Express Root Port #7 [8086:a116] (rev f1)
00:1c.7 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipse=
t Family PCI Express Root Port #8 [8086:a117] (rev f1)
00:1f.0 ISA bridge [0601]: Intel Corporation H110 Chipset LPC/eSPI Control=
ler [8086:a143] (rev 31)
00:1f.2 Memory controller [0580]: Intel Corporation 100 Series/C230 Series=
 Chipset Family Power Management Controller [8086:a121] (rev 31)
00:1f.3 Audio device [0403]: Intel Corporation 100 Series/C230 Series Chip=
set Family HD Audio Controller [8086:a170] (rev 31)
00:1f.4 SMBus [0c05]: Intel Corporation 100 Series/C230 Series Chipset Fam=
ily SMBus [8086:a123] (rev 31)
01:00.0 Non-Volatile memory controller [0108]: SK hynix BC901 NVMe Solid S=
tate Drive (DRAM-less) [1c5c:1d59] (rev 03)
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL812=
5 2.5GbE Controller [10ec:8125] (rev 05)
03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL811=
1/8168/8211/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev =
0c)
04:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:2=
723] (rev 1a)

04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
        Subsystem: Intel Corporation Wi-Fi 6 AX200NGW
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <=
TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        IOMMU group: 12
        Region 0: Memory at efb00000 (64-bit, non-prefetchable) [size=3D16=
K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D=
2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <51=
2ns, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Sl=
otPowerLimit 0W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLRes=
et-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ =
TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit Late=
ncy L1 <8us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP=
- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt=
- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyP=
owerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq=
-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Reti=
mer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedD=
is-
                         Transmit Margin: Normal Operating Range, EnterMod=
ifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, =
0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComp=
lete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqual=
izationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [80] MSI-X: Enable+ Count=3D16 Masked-
                Vector table: BAR=3D0 offset=3D00002000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=
 RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-=
 AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDE=
TLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=
 RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-=
 AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDE=
TLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-=
 RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-=
 AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDE=
TLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonF=
atalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonF=
atalErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- EC=
RCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap=
-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [14c v1] Latency Tolerance Reporting
                Max snoop latency: 3145728ns
                Max no snoop latency: 3145728ns
        Capabilities: [154 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ =
L1_PM_Substates+
                          PortCommonModeRestoreTime=3D30us PortTPowerOnTim=
e=3D18us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
                L1SubCtl2: T_PwrOn=3D44us
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

Regards
	Stefan Lippers-Hollmann

