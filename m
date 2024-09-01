Return-Path: <linux-pm+bounces-13310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06789967C42
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37E028188E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A98174E;
	Sun,  1 Sep 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hYyDFNEd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D674D8AF;
	Sun,  1 Sep 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224309; cv=none; b=GO9rSYZjtVMdigblvY3sQSFABejJud6+UW5bSYrMdL6QlYbcMYdZMrMLtqWb9pW/+Jlw59Qx+EV7th1ziTCHaCa2fCHwuZSXGoS4Vw7haf4ZLsDxBH+qOdPzwJam+xCwW2YWK/3qm1dfO0iLik9p5/DGR5ujjyWkSxpaJfI8hR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224309; c=relaxed/simple;
	bh=DDJEyEHc1AyA0ekYw2Uk0thrqJ7aFGl0BA/6aFGQJ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XH1VqTf8doBbYKnbdrTP1r0HqRl4xSQ7zKrMULxPJzLZcoSrPBiHXrQr1E9b53FuzlgfQiZ/it4qCjG9oD7Xz7z74WuOw+zV/NnkBwvSjae83KNHuzqyEDZmow+yzdXMH0YLC7lYkRopJoYgbiP0dZQsdt/oYVXK8v19q5jAiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hYyDFNEd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725224269; x=1725829069; i=wahrenst@gmx.net;
	bh=bGCy0KWFrbS3RM769BUfD63uKrTNw6zmGzCkzsxXqko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hYyDFNEdiPXLf146BNTvvu/0Xn7bkbZuduRDjTFmsKvjYfaHcgZUTY+fiPn1yWwj
	 fIL5jU4HCL3sMsNk/EtSuAg5I9lbkaHqQSRDJj0PD+vMix8Ou6Xj4vbdVArdrKTLc
	 9UN+8CUykY2LIJQVMsLTQPdvBWNwv5DTVZC/HKUreNIApcuT2qNdY0Z8KPv28PXjW
	 f+nxs+MG3yLV4HGQpalTwhkwjqeWyGPgVyeNbpN1Fy+cH0Bbm8NyTQ7SAZbIHKMzs
	 5tk/Nzyalb8dNakUMgPNWSjLuxj24je37igpR/eY9Lup9DawxtigOneNEAjd9WIS5
	 7M3Pig9JQQw23W8gZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1sYiYL2a8C-00QnVj; Sun, 01
 Sep 2024 22:57:49 +0200
Message-ID: <4e211aaf-3380-4039-a1ca-ea800bb30a82@gmx.net>
Date: Sun, 1 Sep 2024 22:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] mailbox: bcm2835: Fix timeout during suspend mode
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Doug Anderson <dianders@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Russell King <linux@armlinux.org.uk>,
 Minas Harutyunyan <hminas@synopsys.com>, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240821214052.6800-1-wahrenst@gmx.net>
 <20240821214052.6800-2-wahrenst@gmx.net>
 <7ba14fe2-38e0-414c-bc3d-62c1e70741ad@gmx.net>
 <CABb+yY2ay47mNzMQB0DasvnP-_EZJ7VTSoJFHtiKUySGRCXvWA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CABb+yY2ay47mNzMQB0DasvnP-_EZJ7VTSoJFHtiKUySGRCXvWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bh/buYHNIBiGCz0TONsKXhoxCMEqwPL9rLjnseV8VMfIiEU0XgF
 gmDWhFBRx/a3ps/BLIcL6rlGcTown/Gau/vOJIhG+PIKbdX1SRW4sFEQGKTBLqaZIlL98Gn
 Zqy2dQPYGHtUtXAiR3QqmuzQ6xkOoKwvIvmDe6d0XiIC7DtSQTfLU8+r2KDWE/2QOLJZ1dF
 9OO8dmQeHdH8MvrpnjCqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mcyVvPMkpeM=;pDQqNOMgE11z4dIVh5CWwkY9wJq
 VQGD7Cz2L4ShgfXaYgwC557mDZ82dBvvQ4ND5fO5wroaXwJgPWDQVFGk62+96Rt31MkBJe6sx
 DthF/irds0hQAGDjylcYhweepA+nMQC+oRVcrGm+5sVBQzWk/pv3Dr7VOQDTRaOQmjHXbofIq
 N+UJeJ52mnlibAmGVUDn+dDm49VBpI+bmTFqiy0a8Mzk9iJ7sWEVQNP+33Gdm6N8UFbzsKLMC
 e5hmCnRBtDoJvtwrzt6iRtLixhsmnqec8eTC2D1qi++HyDWPmXk3voTvMPIAp71i/vtfg+EUT
 I1nXtGjXAwTQis/+NfAENLkTJpqliuAl2aVmGnhDDl38WN9Dl7AsONxSg+gBJ7iOachQINXcC
 mk1/ScCa810ucSuFv5KZNwTXTXmtbi9KUTqejSX9OMe1DhGxnlmwcrnYQBBdCM8iBqMvjknDq
 W9p/hVwapEEMZci7qwssmRog3JUj5ZvILao1qmBYvqfPOUXZ9RN02+aNCUXW69VpkKzEZTgBz
 h1aR7kXc2TogxdkbhSJxPU4Zm56ydxOidF8FYyyEIB/QOWphdbD87SFOLJNeRUlJZwJ/dEIjm
 GjRqT7wZZiTBjCoTDABg7jrkM4KdGJEIpAG6+umqXA0E1yApZkuwCHX54JKCTbAwaHhSXD+8Z
 cq2MB633kIbwlbug96nBxw0Dy5xCdIT2nV97NWIDNUwR3FmUedGRVRTw1IjHZRanwaJipA4NH
 hOnnyq5P3ciQmjOr8DwiAtvWFjGzE14IQw3hSBMXkR1P8Vl1cF80p2Bg40GNNIwQZlmU8nWpb
 wNX5SNK3PqF295PNIduHkRzQ==

Hi Jassi,

Am 01.09.24 um 22:26 schrieb Jassi Brar:
> On Sat, Aug 31, 2024 at 4:19=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net>=
 wrote:
>> Hi Jassi,
>>
>> Am 21.08.24 um 23:40 schrieb Stefan Wahren:
>>> During noirq suspend phase the Raspberry Pi power driver suffer of
>>> firmware property timeouts. The reason is that the IRQ of the underlyi=
ng
>>> BCM2835 mailbox is disabled and rpi_firmware_property_list() will alwa=
ys
>>> run into a timeout [1].
>>>
>>> Since the VideoCore side isn't consider as a wakeup source, set the
>>> IRQF_NO_SUSPEND flag for the mailbox IRQ in order to keep it enabled
>>> during suspend-resume cycle.
>>>
>>> [1]
>>> PM: late suspend of devices complete after 1.754 msecs
>>> WARNING: CPU: 0 PID: 438 at drivers/firmware/raspberrypi.c:128
>>>    rpi_firmware_property_list+0x204/0x22c
>>> Firmware transaction 0x00028001 timeout
>>> Modules linked in:
>>> CPU: 0 PID: 438 Comm: bash Tainted: G         C         6.9.3-dirty #1=
7
>>> Hardware name: BCM2835
>>> Call trace:
>>> unwind_backtrace from show_stack+0x18/0x1c
>>> show_stack from dump_stack_lvl+0x34/0x44
>>> dump_stack_lvl from __warn+0x88/0xec
>>> __warn from warn_slowpath_fmt+0x7c/0xb0
>>> warn_slowpath_fmt from rpi_firmware_property_list+0x204/0x22c
>>> rpi_firmware_property_list from rpi_firmware_property+0x68/0x8c
>>> rpi_firmware_property from rpi_firmware_set_power+0x54/0xc0
>>> rpi_firmware_set_power from _genpd_power_off+0xe4/0x148
>>> _genpd_power_off from genpd_sync_power_off+0x7c/0x11c
>>> genpd_sync_power_off from genpd_finish_suspend+0xcc/0xe0
>>> genpd_finish_suspend from dpm_run_callback+0x78/0xd0
>>> dpm_run_callback from device_suspend_noirq+0xc0/0x238
>>> device_suspend_noirq from dpm_suspend_noirq+0xb0/0x168
>>> dpm_suspend_noirq from suspend_devices_and_enter+0x1b8/0x5ac
>>> suspend_devices_and_enter from pm_suspend+0x254/0x2e4
>>> pm_suspend from state_store+0xa8/0xd4
>>> state_store from kernfs_fop_write_iter+0x154/0x1a0
>>> kernfs_fop_write_iter from vfs_write+0x12c/0x184
>>> vfs_write from ksys_write+0x78/0xc0
>>> ksys_write from ret_fast_syscall+0x0/0x54
>>> Exception stack(0xcc93dfa8 to 0xcc93dff0)
>>> [...]
>>> PM: noirq suspend of devices complete after 3095.584 msecs
>>>
>>> Link: https://github.com/raspberrypi/firmware/issues/1894
>>> Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")
>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> gentle ping
> This sounds like a fix but also a part of 9 patches update. Do you
> want this merged as a bugfix now or into the next window.
there is no dependency to the rest of the series. Since this is late in
the 6.11 cycle, i'm fine with merging it for the next window.

Thanks
>
> thanks


