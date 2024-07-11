Return-Path: <linux-pm+bounces-11006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0579092EDB1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A8FB20BA0
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646316D9C1;
	Thu, 11 Jul 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fDuosmBV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DD16B72E;
	Thu, 11 Jul 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718735; cv=none; b=LQzcGZ/f3ZiZFZmFSIBFYsgZUuU+yUA7rkAswZ8P1f+MRpQzCQkYCW5siADwbHO2cO624hiHMONSZK0fMJf+/Xl8nPcZQh9xU9y/DaScrVcZbkkutTW4NmXXVf3kspeC46nmMWavipDfLbGuzjOUi92I9mHQLAHTGeoWLu6T22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718735; c=relaxed/simple;
	bh=RVKnjmoKRj8WBj5bV1RzrlCWMfrgmD6rum5FO5LOfuI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MbgZW7MoIZNw4SedirTF+6rm5hYNjWSYftkzBImqKVfu+Wig9/9zJ7Y+Oqmy1dvGvRridXfZFf+VCa5igHmEDuDRqZk4sZL6CSAfSf+oph92bn4JQWfA9CCvWcpk9OQB8YdwKlBZRVDddDM/YTs498u9DaMLHwSgUYOmogyuiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fDuosmBV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720718706; x=1721323506; i=wahrenst@gmx.net;
	bh=RVKnjmoKRj8WBj5bV1RzrlCWMfrgmD6rum5FO5LOfuI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fDuosmBV1hZjabBuWAajdVoMbQiSCaOqxjeuqlFdzXgEll8od9s6VUW6R//1UCG2
	 AxUiNCnzRQpHT55l4XmEpv9l1V4U1sgGwknz9tDwK9ylFFz0jLHljuVmb640Lk1bU
	 ylQwBhZLI/vZ4KLFtcbrARmbdRcEdDkBf8aeJTV9igBJfaRuQidXWoEBR4XP5Eqca
	 IlvknVQlZIS8rsZd777se8Wn0ok+K8b99Tlt07URan4HaZZUmHJCO36fmj1XIZ7a1
	 /eyCAxPkV0Fot54FJPgoHvw5dmTa1tU75yheV6CWg7iQJBcTNmVOrhga/jmoFtMx1
	 LAkKL9me6HKImL1A9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1ryxpk14JK-00f1WC; Thu, 11
 Jul 2024 19:25:06 +0200
Message-ID: <e4532055-c5d6-4ac9-8bbb-b9df18fa178b@gmx.net>
Date: Thu, 11 Jul 2024 19:25:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Subject: dwc2: Dealing with power domains
To: Florian Fainelli <f.fainelli@gmail.com>,
 Minas Harutyunyan <hminas@synopsys.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>
Cc: Heiko Stuebner <heiko@sntech.de>, Lukas Wunner <lukas@wunner.de>,
 Alexander Aring <alex.aring@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KEB/BiLWcVAWR1sdPduyNVcgb9ZJPvIbItnKPYj5J4koroZPSw1
 pcY9BQZfDl0RmRcuhVaa4bW9sjgHBPLFVIgHqGENs4zC91Y1aXavs9GSYPp1HhslYaoR0Nm
 RXpan4Ww/86QVN7d+EMmJHb12b79e+dWjPl/DTBY8De7VTz+Xg+QXFHg13lrJ+LStM3m90s
 2X8YpFfE23aReCKX+1f/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kEoIVS5MdqM=;SgGoqWyzS50N2VGsvC7FCNfdH7T
 ogdcHT44hWxdM7ulO0OJgwNjApL4Rymss9/O6T5kcKGRPg4Oe87QiGYQ7m1xKxggYpzjRX6CU
 IJPcKA/buPregShDEa+UrnT/OW682bOG/X1Y3VSi6ijkA7nRnSH3GaQVZfjekw3NyzWXHh4hS
 8t6xYGm64TXzvg+d5JkcvuUhQ5xknRWQGhFCLNYGLAD6iU5uJKKg2FOKdbI6SB+bvVGOAQ9Yh
 yCYiWAaMXbOek/nn3vwRGy2JcxF9lB3fAmGHz8VRD36xuo/m/7lbANHoX9CVAcmqII3KTYAxE
 HIi+wvyahlyCeqTtaDOCZhmBuzFCO7q8tu+DEU2RwcyfQVDRgGQZYVszpxB8Zu/lXnal5i/Q5
 MDhm+qgMbNSbZfDCUYlDHNi7TVVQ4R+5HlFP5Rgc/rRlK3vaTfZ92/ITAs2VxZ+CHUrGxCl46
 2zViVp75dYd3n/KvJwIoQJQqSsX43akRb9CxTJakmPOK/jA9yZQNAX3Bx8QGGmOF9JFF/2h7k
 hl+0CJSslwAfBPmTJfE3SeOAFp6HHKvrkEna2JUWDckaVVUYsIplBoc9fWNA/nTQLBM0ZOKJ2
 EvU8DVHlrGCjTGxj9ZXmCAVUUQDL7M0TeLzkhcB5WfahcR7CCQnr2bsu5n4hfOzYu+EA2E1n1
 J0ejW9DKW8jplQA3khNoEQWT9rPCW8g/zQB1U6SA/YWEJrZh9z5ZrGfw+BIKMz4Nba2g57Ruu
 byuE7GLG0PxeqIIOs6O5TzQPVqL1MBJo3pe41vmMwfU0+7PGhACn+kXgQ0E0a4Ji2gGkCEdxl
 J3ZonIwzHmX96EZ54mXvAjAQ==

Hi,
I currently work on suspend to idle support for Raspberry Pi (BCM2835)
[1]. Unfortunately properly powering down USB (dwc2) is currently not
supported for this platform. As soon as the USB power domain is powered
down and up (triggered by suspend to idle), the USB interface is
functionally dead (no devices available, no enumeration) and resume take
a lot of time:

Apr 24 16:14:08 raspberrypi kernel: [=C2=A0 271.494472] PM: suspend entry
(s2idle)
Apr 24 16:14:09 raspberrypi kernel: [=C2=A0 272.009042] Filesystems sync:
0.514 seconds
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.054081] Freezing user spac=
e
processes
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058478] Freezing user spac=
e
processes completed (elapsed 0.004 seconds)
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058574] OOM killer disable=
d.
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058594] Freezing remaining
freezable tasks
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.060095] Freezing remaining
freezable tasks completed (elapsed 0.001 seconds)
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.068302] smsc95xx 1-1.1:1.0
eth0: entering SUSPEND2 mode
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.123910] dwc2 20980000.usb:
dwc2_suspend
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.123973] dwc2 20980000.usb:
__dwc2_lowlevel_hw_disable()
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.126143] PM: suspend of
devices complete after 65.371 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.126221] PM: start suspend =
of
devices complete after 66.043 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.127886] PM: late suspend o=
f
devices complete after 1.625 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.129312] USB domain off
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.130636] PM: noirq suspend =
of
devices complete after 2.547 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.130714] PM: suspend debug:
Waiting for 5 second(s).
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.141198] USB domain on
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.669113] PM: noirq resume o=
f
devices complete after 533.149 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.670324] PM: early resume o=
f
devices complete after 0.994 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.672005] dwc2 20980000.usb:
dwc2_resume
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.672061] dwc2 20980000.usb:
__dwc2_lowlevel_hw_enable()
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 282.943909] usb 1-1: reset
high-speed USB device number 2 using dwc2
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 288.223658] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 303.663648] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 304.003656] usb 1-1: reset
high-speed USB device number 2 using dwc2
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 309.263662] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 324.703663] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 325.043664] usb 1-1: reset
high-speed USB device number 2 using dwc2
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 335.583640] usb 1-1: device no=
t
accepting address 2, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 335.803642] usb 1-1: reset
high-speed USB device number 2 using dwc2
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.383608] usb 1-1: device no=
t
accepting address 2, error -110
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.463987] PM: resume of devi=
ces
complete after 68793.584 msecs
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.464352] smsc95xx 1-1.1:1.0
eth0: Link is Down
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.465369] OOM killer enabled=
.
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.465417] Restarting tasks .=
..
done.
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500347] random: crng resee=
ded
on system resumption
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500928] usb 1-1: USB
disconnect, device number 2
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500993] usb 1-1.1: USB
disconnect, device number 3
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.501599] smsc95xx 1-1.1:1.0
eth0: unregister 'smsc95xx' usb-20980000.usb-1.1, smsc95xx USB 2.0 Etherne=
t
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.501808] smsc95xx 1-1.1:1.0
eth0: hardware isn't capable of remote wakeup
Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.508950] usb 1-1.2: USB
disconnect, device number 4
Apr 24 16:15:24 raspberrypi kernel: [=C2=A0 346.535846] PM: suspend exit
Apr 24 16:15:24 raspberrypi kernel: [=C2=A0 346.783703] usb 1-1: new
high-speed USB device number 5 using dwc2
Apr 24 16:15:29 raspberrypi kernel: [=C2=A0 352.063614] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:44 raspberrypi kernel: [=C2=A0 367.503622] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:15:45 raspberrypi kernel: [=C2=A0 367.843649] usb 1-1: new
high-speed USB device number 6 using dwc2
Apr 24 16:15:50 raspberrypi kernel: [=C2=A0 373.103627] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:16:06 raspberrypi kernel: [=C2=A0 388.543616] usb 1-1: device
descriptor read/64, error -110
Apr 24 16:16:06 raspberrypi kernel: [=C2=A0 388.663808] usb usb1-port1:
attempt power cycle

So I investigated a little bit about the current DWC2 implementation of
BCM2835:
- no real PHY driver, just NOP PHY
- fixed USB clock
- params.power_down =3D DWC2_POWER_DOWN_PARAM_NONE
- no clock gating [2]

As a result from DWC2 point of view there is no power down possible by
this driver and it doesn't support pm_runtime. But commit 5ec6f2cd8e
("ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.")
added a power domain to the DWC2 DT node on BCM2835.

domain=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 status
children=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 performance
 =C2=A0=C2=A0=C2=A0 /device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 runtime status
=2D-----------------------------------------------------------------------=
----------------------
...
USB on=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
 =C2=A0=C2=A0=C2=A0 /devices/platform/soc/20980000.usb unsupported=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0

This allows the system to power down the USB domain without
involving/notifying DWC2.

At least Rockchip PX30 did something similiar with commit bb5981333f
("arm64: dts: rockchip: add dwc2 otg controller on px30"). Not sure if
the power domain is actually powered down on that platform.

So my questions are:
How should we deal with it?
Should the DWC2 driver take control of this power domain?
How should we achieve this in the right way (tm)?

Best regards

[1] -
https://lore.kernel.org/linux-arm-kernel/20240630153652.318882-1-wahrenst@=
gmx.net/
[2] -
https://lore.kernel.org/linux-arm-kernel/20240630153652.318882-10-wahrenst=
@gmx.net/

