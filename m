Return-Path: <linux-pm+bounces-9247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC1909CC9
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 11:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0AC01C20839
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD7180A82;
	Sun, 16 Jun 2024 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MJ3SBBHS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944ED33C0
	for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718530055; cv=none; b=YlGwP4FBa2p2IkqOd/Mr7BQdV7O1XvT4G83DI7l7uVMGzEh3oCjP69cvKp5c8agtxG/xj3nisA+RPZWqZNNzohM0PESGEQJMjMR7eASNfAMGRw0P+xDyULN+QzycmdGv4+r3wDK0McUph6laS3HL0FtUZyVUCHkzrNE5l8EAFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718530055; c=relaxed/simple;
	bh=jdTT8hu9rQLpWA+eFXlOY28ke9gQzvnm57iQazE/Cng=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EUMtA0jYpOT03HMStJXnoNTGo8Dh1jh+v8IQN5KB2Grbg33CaoeNSltfNXG8fVqoHh921vpsCHdXOuoteGYwxCagcTywDNmnFN+xpkM5iPrqMw01mGr7pP6ptTahw4RWYLbVG/yc97W2Vs2P8qv+IOK93hlvHonA2nza+3Jr/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MJ3SBBHS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718530031; x=1719134831; i=wahrenst@gmx.net;
	bh=jdTT8hu9rQLpWA+eFXlOY28ke9gQzvnm57iQazE/Cng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MJ3SBBHSF2U81XU8LLLrlRTMl8CWjAQRSLkYC42v03IoR9lh7J+MD0Gj0ybw13V7
	 qkoV/JsZIHTYlp7jivr/rtW9quZH0166sS+0UtBEzcQKh3Oj+jAYKeNN8WOOx3vOp
	 76lSvojZW3K3BsSopwzXnMyjNoWWCABmXYLdI+YlMa4d/LLHruZkMhm7K40FC3uK3
	 JnZo6EC4Xr8r/2J5V1QV/HHb2rE9vta1pr/CzM1TZMKm640SgV8J8qY0v9WFQhvtk
	 BYXKod3wlS5zK1KFptMKy7IvUZ26umz6Z1Qhy+8vR2bAxfJQ/fua8a/c/x7X60svW
	 7eJktQb+R1UwTykIGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1sBs8a2215-001YRR; Sun, 16
 Jun 2024 11:27:11 +0200
Message-ID: <7003512d-7303-4f41-b0d6-a8af5bf8e497@gmx.net>
Date: Sun, 16 Jun 2024 11:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Melissa Wen <mwen@igalia.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
 linux-pm@vger.kernel.org
From: Stefan Wahren <wahrenst@gmx.net>
Subject: vc4: WARNING during suspend to idle of Raspberry Pi 3 Plus
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nX6/9/QGkk+AZe7sdvEhhUpOfHHBgkJQXCnOP7UytZrwLSWmytt
 ZytdEuu+bt24ktwhk9FxOZrLAU70mHNNOkZ2wl59t3XT7ycb7ude2UVpR9RhPd+mS+dvMvB
 LkuXcK/sZTipZXBcK+ST6XRT/odpchKL4FwFDLjekS/kvQqcYzEa49zpD/SCiNO7p81mG5w
 aE0CHnx1F7y+oZ7BJCqdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WpniU2e6DFY=;TjERHRWPnIURUpygtye3DL46g6N
 ro5lvsU+HOKkPZm8gZjuqWWbO8gX7Ye/eDGaDDaaHujQdFW478PNa7vFDiqVVBafsEtIExPIK
 Zq5bWTdM4kHaNJrjekOm+YrXGMMXKEhTGBI+2+7JrRiTWGeNVlzLK89riSAUVTbbq2rP4jswW
 6t0W4/MQJamjEETSkti9oyg+aV2SzwK/UtH4/xUN0WB8PZCKIO3tOZgo0qIGX5iVnX3x8WIPS
 QOFgK8D2Niqe6v2rYt9IMwV/SOzJPFCkfoR/C290qe1UeeLDjL4fBQEmwHjUXZ8zcGfFK4DB8
 LiQVuI2YjjqLS+2LWdmeBdxO6Loy/y3grW5hguqOMDlyRZ25ygqidkrkKAc4SOVYLD3hbJ+06
 F1JazcsThZTivA2SnXg8rbij0OJapBJ28dGiFnP3XJnYBdG4BUre0VC0qM7ryjARrdJ23Bcyc
 90bb4RLCTfjh6E3pW6xU9kNP7GWNpfgw6HavhUF2vnweWbyqK0YsNlUorgN5bJxvPlEnTK3fF
 jklA77zIwyl788+4igReE7Jvh7hMUwHlRnYeFSS721BhKSySbcp1RbbpJC01bixXGdJ88d05s
 gIc2bzIl8UP7fyVcfTjiyCYNmY0ePe1LwHFOkDmsnSUL1coJZwkUYDGW5of0kH78Z+iX43dct
 UwqWy1vrq8bt1CQoapVngEWjCiYoXRNIxlWmHrm9wokgbT07RuiuM3K2TEY+4z1KH76SYAFqy
 2/JOnlCgznXnYR1Og/+VJ1ZUrDp4oQEzGT878MD/V9pWpsHWATG4872izgWl4LiDBE0SQVvkt
 iOQoT9PgOzDjyPKU0/FP9Te1sujtLLu3lhrT5NJiTl324=

Hi,
i'm currently experiment with suspend to idle on the Raspberry Pi [1].

During my tests, i noticed a WARNING of the vc4 during suspend incl.
Runtime PM usage count underflow. It would be nice if someone can look
at it. In case you want to reproduce it, i can prepare a branch with
some improvements/hacks. For example i disabled dwc2/USB because it
cause a lot of trouble during resume.

Here are the steps to trigger this issue:
- make sure necessary kernel options are enabled ( CONFIG_SUSPEND,
CONFIG_PM_DEBUG, CONFIG_PM_ADVANCED_DEBUG )
- make sure no HDMI cable is connected to Raspberry Pi 3 Plus
- Add "no_console_suspend" to cmdline.txt and reboot
- Connect via Debug UART:

echo 1 > /sys/power/pm_debug_messages
echo platform > /sys/power/pm_test
echo freeze > /sys/power/state

Here is the output:

[=C2=A0=C2=A0 75.538497] PM: suspend entry (s2idle)
[=C2=A0=C2=A0 76.915786] Filesystems sync: 1.377 seconds
[=C2=A0=C2=A0 79.678262] rpi_firmware_set_power: Set HDMI to 1
[=C2=A0=C2=A0 79.678634] rpi_firmware_set_power: Set HDMI to 0
[=C2=A0=C2=A0 79.850949] Freezing user space processes
[=C2=A0=C2=A0 79.852460] Freezing user space processes completed (elapsed =
0.001
seconds)
[=C2=A0=C2=A0 79.852484] OOM killer disabled.
[=C2=A0=C2=A0 79.852493] Freezing remaining freezable tasks
[=C2=A0=C2=A0 79.853684] Freezing remaining freezable tasks completed (ela=
psed
0.001 seconds)
[=C2=A0=C2=A0 80.892819] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. =
we have
nothing to do.
[=C2=A0=C2=A0 80.892843] ieee80211 phy0: brcmf_cfg80211_get_tx_power: erro=
r (-5)
[=C2=A0=C2=A0 81.514053] PM: suspend of devices complete after 1659.336 ms=
ecs
[=C2=A0=C2=A0 81.514089] PM: start suspend of devices complete after 1660.=
386 msecs
[=C2=A0=C2=A0 81.515616] PM: late suspend of devices complete after 1.509 =
msecs
[=C2=A0=C2=A0 81.515938] rpi_firmware_set_power: Set VEC to 0
[=C2=A0=C2=A0 81.516010] rpi_firmware_set_power: Set V3D to 0
[=C2=A0=C2=A0 81.516998] PM: noirq suspend of devices complete after 1.239=
 msecs
[=C2=A0=C2=A0 81.517016] PM: suspend debug: Waiting for 5 second(s).
[=C2=A0=C2=A0 89.598310] rpi_firmware_set_power: Set V3D to 1
[=C2=A0=C2=A0 90.078228] ------------[ cut here ]------------
[=C2=A0=C2=A0 90.078240] WARNING: CPU: 1 PID: 216 at
drivers/gpu/drm/vc4/vc4_hdmi.c:477
vc4_hdmi_connector_detect_ctx+0x2e4/0x34c [vc4]
[=C2=A0=C2=A0 90.078344] Modules linked in: aes_arm aes_generic cbc crypto=
_simd
cryptd algif_skcipher af_alg brcmfmac_wcc brcmfmac vc4 brcmutil
snd_soc_hdmi_codec snd_soc_core ac97_bus sha256_generic
snd_pcm_dmaengine libsha256 snd_pcm sha256_arm snd_timer hci_uart
cfg80211 btbcm snd bluetooth soundcore drm_dma_helper crc32_arm_ce
ecdh_generic ecc raspberrypi_hwmon libaes bcm2835_thermal
[=C2=A0=C2=A0 90.078551] CPU: 1 PID: 216 Comm: kworker/1:2 Not tainted 6.9=
.3-dirty #30
[=C2=A0=C2=A0 90.078568] Hardware name: BCM2835
[=C2=A0=C2=A0 90.078580] Workqueue: events output_poll_execute
[=C2=A0=C2=A0 90.078610] Call trace:
[=C2=A0=C2=A0 90.078624]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0=C2=A0 90.078660]=C2=A0 show_stack from dump_stack_lvl+0x50/0x64
[=C2=A0=C2=A0 90.078688]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0=C2=A0 90.078723]=C2=A0 __warn from warn_slowpath_fmt+0x170/0x178
[=C2=A0=C2=A0 90.078760]=C2=A0 warn_slowpath_fmt from
vc4_hdmi_connector_detect_ctx+0x2e4/0x34c [vc4]
[=C2=A0=C2=A0 90.078862]=C2=A0 vc4_hdmi_connector_detect_ctx [vc4] from
drm_helper_probe_detect_ctx+0x40/0x120
[=C2=A0=C2=A0 90.078951]=C2=A0 drm_helper_probe_detect_ctx from
output_poll_execute+0x160/0x24c
[=C2=A0=C2=A0 90.078982]=C2=A0 output_poll_execute from process_one_work+0=
x16c/0x3b4
[=C2=A0=C2=A0 90.079012]=C2=A0 process_one_work from worker_thread+0x270/0=
x488
[=C2=A0=C2=A0 90.079036]=C2=A0 worker_thread from kthread+0xe0/0xfc
[=C2=A0=C2=A0 90.079060]=C2=A0 kthread from ret_from_fork+0x14/0x28
[=C2=A0=C2=A0 90.079080] Exception stack(0xf0af9fb0 to 0xf0af9ff8)
[=C2=A0=C2=A0 90.079096] 9fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
00000000 00000000 00000000
[=C2=A0=C2=A0 90.079113] 9fc0: 00000000 00000000 00000000 00000000 0000000=
0
00000000 00000000 00000000
[=C2=A0=C2=A0 90.079129] 9fe0: 00000000 00000000 00000000 00000000 0000001=
3 00000000
[=C2=A0=C2=A0 90.079141] ---[ end trace 0000000000000000 ]---
[=C2=A0=C2=A0 90.079155] vc4_hdmi 3f902000.hdmi: vc4_hdmi_connector_detect=
_ctx:
pm_runtime_resume_and_get failed: -13
[=C2=A0=C2=A0 92.638262] rpi_firmware_set_power: Set HDMI to 1
[=C2=A0=C2=A0 95.678251] rpi_firmware_set_power: Set VEC to 1
[=C2=A0=C2=A0 95.678380] PM: noirq resume of devices complete after 9160.9=
30 msecs
[=C2=A0=C2=A0 95.679604] PM: early resume of devices complete after 1.069 =
msecs
[=C2=A0=C2=A0 95.812230] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[=C2=A0=C2=A0 95.812282] PM: resume of devices complete after 132.657 msec=
s
[=C2=A0=C2=A0 95.813246] vc4_hdmi 3f902000.hdmi: Runtime PM usage count un=
derflow!
[=C2=A0=C2=A0 95.814456] OOM killer enabled.
[=C2=A0=C2=A0 95.814466] Restarting tasks ... done.
[=C2=A0=C2=A0 95.817193] random: crng reseeded on system resumption
[=C2=A0=C2=A0 95.819813] rpi_firmware_set_power: Set HDMI to 0
[=C2=A0=C2=A0 95.827808] PM: suspend exit

[1] - https://github.com/raspberrypi/firmware/issues/1894

