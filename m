Return-Path: <linux-pm+bounces-11062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF49300C4
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 21:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BEF1F21487
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FA1CFBC;
	Fri, 12 Jul 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OpPcGz+h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE971FB4;
	Fri, 12 Jul 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811925; cv=none; b=qMQqqz/AG/Lsu2NVXpvy+JfqAV+6m0cSwbSK33B1xzbrvwu3g/bVOLSRWygySid/PurhpN+U9M32V+n/v4RqodmQ7I0buvwFNxH7t4KRQmx7eQnxA6lbWtDWlJ3BCik2DhjSWRHaDr1k+kKdmY20GHZ9At4FGcA/SpjO/+Gfr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811925; c=relaxed/simple;
	bh=B5CE1gwkpNkcVeNpaV2rSh/y6fbFp3ADnxLHWK8JDR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tujppFKQ9ROoJY7eMeRB627sPw3/pfGHBZ9Epny3tqpeohQ3XKGm9tJDxGbDop8F1tH10azqPCwdvwUB0UBPZYpffMm0EVxzRak2M9O3MoT8PpUKNEHwG8NnYSmPxaYswjGijj0Wf7qbW3O58yR2QFodLudCNyNozepFxt4qt0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=OpPcGz+h; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720811896; x=1721416696; i=wahrenst@gmx.net;
	bh=B5CE1gwkpNkcVeNpaV2rSh/y6fbFp3ADnxLHWK8JDR0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OpPcGz+hVlxRFHQRCf1EPz5xJKfqTzYMHYThgdHT0yG2mHM9Tf5UiyUrPuASl16D
	 hOWFUY7udY8ZhaqYlj5NU379iHTmbQv9xu6PDE3kvUt1uvKoBBWuWRWuA8cN7Npp4
	 5kCMmHYkvxI856dPzrY2iHCArMmSMGRSDeF2QEtP0PPWOqv5TMKvruD1SEO6epu4/
	 ATTcLR3qJJKJRkeCD7SEdqjRh/voYF272PulXQs/MxGoLbgp30nYj/DMKWwQwlU/0
	 V7A7dPS4zt428MoA0IApH71OZn/24bGz4NIwMRlHE6do1+JEKRRvpaUa/sDpYkUi9
	 M2VfI+RX7NFAvauC+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1smVCF1DPH-00So0H; Fri, 12
 Jul 2024 21:18:16 +0200
Message-ID: <f09fed06-cf38-466e-8c95-a1b98eb21ac2@gmx.net>
Date: Fri, 12 Jul 2024 21:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dwc2: Dealing with power domains
From: Stefan Wahren <wahrenst@gmx.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
 Minas Harutyunyan <hminas@synopsys.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>
Cc: Heiko Stuebner <heiko@sntech.de>, Lukas Wunner <lukas@wunner.de>,
 Alexander Aring <alex.aring@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <e4532055-c5d6-4ac9-8bbb-b9df18fa178b@gmx.net>
Content-Language: en-US
In-Reply-To: <e4532055-c5d6-4ac9-8bbb-b9df18fa178b@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yVmOnzfYjgRkyvfhCHmV2bQzsaVgAzWKiQbsoFVtlQwl44Tla8k
 YOXW8l1xG2XZIuw6cD7PefKvOQ5OwxPSKkW/Suo3pybaMmC1prrEc5/2hP+ynuhuAW6YHsP
 Z9VIc4/FASDwry8SR9zFodZFxPehbW/gXip1tnNO408NaDBN4Se0C5ynVpM+jWV8wV+Vxnu
 YQYcSMWb2VPO8hP2MMCKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QU0KLzzPSis=;rDcVHKkvqW3jJGilbu35sc5N/dh
 LJ6repWeUDWDHVBGzOJRppFf0+5LJb1u4oADsTVbQyAdKQj2jBPeRZvhheJ6FMrYTwQQDKQX6
 NhceP7I4fO7vBpqpORSmFm17oreBKu5+azsNpVyklFvO/TCBdMCMlUDtdE0sBbPChcBoh3ebY
 DbvvrAo+PAL+cv738kYYMcnbQBRTbndQuGKdf3EGATV1xrQen0XWPvTRkuFEuu+JrWSatq7k6
 K3B64NYmhkcp5ulrm5QRPG4rZQV1Xk9EYBPNSQdndywF4K4+ZxDJAsexw3Sg7yzRJhz/PeKip
 qLsL9kKaOIf3lWUBpZBkcXLor7CHnqolFeXy+KK2kevIna4kU2KYkeBA4hxE9bI6bcvX1r08c
 H8JKhwFNTeH93OC5aXsBov7X4FO+MszLK79y4Rk5jgmXeFtF9e0Pawh3qdCsCpjVqDHelZApv
 5HaUI4d0hutNqlVo5umQ7VBE2jabFMSymQxX12PdJZl6GpFnGqyPSh6FUBpFQ4OBZzF+dOK8B
 sthO+RJMM2470oU4La52Kvp79lI9dPlv93BzrZ6uZ8slp5jmmc604O2KwdUAPJK8RT/kKrctX
 H7ruNfRnH9DLajTlhV8nsnG1R+XWD3ykh2Nqw3Anok1b1lXAN+RXrG7oCBR6wg4Xj4tuiEo4j
 KOB/0VbjI2xhsoCJcHvVQw8qY5Ju6RRLwvmrTRWamRK+0yhnaXwCBmnqfHtHOvvha/MwWrVXO
 QfIeKVEDoSryQNJsjudxDxF30qmyWgWyelUh3sz+rFbvokOPiBe50ZHlkgIDFp5ppbXHkZBfn
 fWKF66rnCDD0Mr5Ym9xs7VMQ==

Hi,

Am 11.07.24 um 19:25 schrieb Stefan Wahren:
> Hi,
> I currently work on suspend to idle support for Raspberry Pi (BCM2835)
> [1]. Unfortunately properly powering down USB (dwc2) is currently not
> supported for this platform. As soon as the USB power domain is
> powered down and up (triggered by suspend to idle), the USB interface
> is functionally dead (no devices available, no enumeration) and resume
> take a lot of time:
>
> Apr 24 16:14:08 raspberrypi kernel: [=C2=A0 271.494472] PM: suspend entr=
y
> (s2idle)
> Apr 24 16:14:09 raspberrypi kernel: [=C2=A0 272.009042] Filesystems sync=
:
> 0.514 seconds
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.054081] Freezing user sp=
ace
> processes
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058478] Freezing user sp=
ace
> processes completed (elapsed 0.004 seconds)
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058574] OOM killer disab=
led.
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.058594] Freezing remaini=
ng
> freezable tasks
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.060095] Freezing remaini=
ng
> freezable tasks completed (elapsed 0.001 seconds)
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.068302] smsc95xx 1-1.1:1=
.0
> eth0: entering SUSPEND2 mode
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.123910] dwc2 20980000.us=
b:
> dwc2_suspend
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.123973] dwc2 20980000.us=
b:
> __dwc2_lowlevel_hw_disable()
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.126143] PM: suspend of
> devices complete after 65.371 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.126221] PM: start suspen=
d
> of devices complete after 66.043 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.127886] PM: late suspend=
 of
> devices complete after 1.625 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.129312] USB domain off
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.130636] PM: noirq suspen=
d
> of devices complete after 2.547 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 272.130714] PM: suspend debu=
g:
> Waiting for 5 second(s).
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.141198] USB domain on
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.669113] PM: noirq resume=
 of
> devices complete after 533.149 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.670324] PM: early resume=
 of
> devices complete after 0.994 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.672005] dwc2 20980000.us=
b:
> dwc2_resume
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 277.672061] dwc2 20980000.us=
b:
> __dwc2_lowlevel_hw_enable()
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 282.943909] usb 1-1: reset
> high-speed USB device number 2 using dwc2
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 288.223658] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 303.663648] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 304.003656] usb 1-1: reset
> high-speed USB device number 2 using dwc2
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 309.263662] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 324.703663] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 325.043664] usb 1-1: reset
> high-speed USB device number 2 using dwc2
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 335.583640] usb 1-1: device =
not
> accepting address 2, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 335.803642] usb 1-1: reset
> high-speed USB device number 2 using dwc2
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.383608] usb 1-1: device =
not
> accepting address 2, error -110
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.463987] PM: resume of
> devices complete after 68793.584 msecs
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.464352] smsc95xx 1-1.1:1=
.0
> eth0: Link is Down
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.465369] OOM killer enabl=
ed.
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.465417] Restarting tasks
> ... done.
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500347] random: crng
> reseeded on system resumption
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500928] usb 1-1: USB
> disconnect, device number 2
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.500993] usb 1-1.1: USB
> disconnect, device number 3
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.501599] smsc95xx 1-1.1:1=
.0
> eth0: unregister 'smsc95xx' usb-20980000.usb-1.1, smsc95xx USB 2.0
> Ethernet
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.501808] smsc95xx 1-1.1:1=
.0
> eth0: hardware isn't capable of remote wakeup
> Apr 24 16:15:23 raspberrypi kernel: [=C2=A0 346.508950] usb 1-1.2: USB
> disconnect, device number 4
> Apr 24 16:15:24 raspberrypi kernel: [=C2=A0 346.535846] PM: suspend exit
> Apr 24 16:15:24 raspberrypi kernel: [=C2=A0 346.783703] usb 1-1: new
> high-speed USB device number 5 using dwc2
> Apr 24 16:15:29 raspberrypi kernel: [=C2=A0 352.063614] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:44 raspberrypi kernel: [=C2=A0 367.503622] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:15:45 raspberrypi kernel: [=C2=A0 367.843649] usb 1-1: new
> high-speed USB device number 6 using dwc2
> Apr 24 16:15:50 raspberrypi kernel: [=C2=A0 373.103627] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:16:06 raspberrypi kernel: [=C2=A0 388.543616] usb 1-1: device
> descriptor read/64, error -110
> Apr 24 16:16:06 raspberrypi kernel: [=C2=A0 388.663808] usb usb1-port1:
> attempt power cycle
>
just some more information about the resume issue:

Regdump before suspend (working):
GOTGCTL =3D 0x001c0001
GOTGINT =3D 0x00000000
GAHBCFG =3D 0x00000031
GUSBCFG =3D 0x20001707
GRSTCTL =3D 0x80000000
GINTSTS =3D 0x04000021
GINTMSK =3D 0xf300080e
GRXSTSR =3D 0x41767c40
GRXFSIZ =3D 0x00000306
GNPTXFSIZ =3D 0x01000306
GNPTXSTS =3D 0x00080100
GI2CCTL =3D 0x00000000
GPVNDCTL =3D 0x00000000
GGPIO =3D 0x00000000
GUID =3D 0x2708a000
GSNPSID =3D 0x4f54280a

Regdump after resume (not working):
GOTGCTL =3D 0x001c0001
GOTGINT =3D 0x00000000
GAHBCFG =3D 0x0000001f
GUSBCFG =3D 0x20402700
GRSTCTL =3D 0x80000000
GINTSTS =3D 0x0400003b
GINTMSK =3D 0xf1000806
GRXSTSR =3D 0x000f0002
GRXFSIZ =3D 0x00000306
GNPTXFSIZ =3D 0x01000306
GNPTXSTS =3D 0x07080100
GI2CCTL =3D 0x00000000
GPVNDCTL =3D 0x00000000
GGPIO =3D 0x00000000
GUID =3D 0x2708a000
GSNPSID =3D 0x4f54280a

So after the power off of USB, the DWC2 is unable to restore the
register properly. In a naive attempt, made this change:

=2D-- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -704,6 +704,8 @@ static int __maybe_unused dwc2_resume(struct device
*dev)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc2->phy_off_for_suspend =3D =
false;

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dwc2_core_init(dwc2, true);
+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dwc2->params.activate_stm_=
id_vb_detection) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned long flags;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u32 ggpio, gotgctl;

This improved the situation a little bit because the console becomes
available from suspend much faster, but USB is still not functional.

Best regards


