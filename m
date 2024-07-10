Return-Path: <linux-pm+bounces-10931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331492D2EC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E051F23B0B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16B192B83;
	Wed, 10 Jul 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Yty8WZIB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45F12C530;
	Wed, 10 Jul 2024 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618481; cv=none; b=TAf/QT6dGlnECRNPkYG1jSp3gzA5ptXjPE0S81ww8La/sucqGjee3TJLy9BAtKrYcGBx//2XkWFfYzYbEhO24Mqby/26SUGvs/cVpDqh1GncCfLjvLVn23RQbBQ5Arhye+3dGhVka9wIZY6QeGI6QYAWIRuahA1pLdzfmlkyhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618481; c=relaxed/simple;
	bh=KHzmV6iQeN0ga/s2PWtC2cr6j5Xn1gW9AyxeuXWnzNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5XnRZT8dBTBu8NW+sWwUVPI0XIS/XQxG4OEnNhpYOL/9DS6cg0N7Rqocuhok0CohQ1dGl6PUb6BwUQCHtixOFlvDgDplMlxgbdyF1CaNmv2phZmBTHmvGCspDMRjFPQIP83wegjG19oH9dAVjJMcMyyi90lhm3prMky1bLJZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Yty8WZIB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720618442; x=1721223242; i=wahrenst@gmx.net;
	bh=+3tUuSexjnpG44HlEeCMDYkMDHwEt8wqzMLss58tItk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yty8WZIBncC6TRsiVPWwLLzEUluGlOV5HTyvD35ojHzE9TkvDt2+MJmwkODumCz4
	 MUEdwgdtylDqbUKZpDfbF4S1kfHUt6IdBEdzTJ8Fdhzr9bOMLyFFoc3fMeYugJnld
	 mnaTBBFOXKxnWqOjgVenbNf2/YnlhqygfDlhMSl8F4Km3xNYpo6Ilj/5LBZs5GSRZ
	 MbcLWB1zjIESTsc2F0c8r9xOUWv3qKPGpfmt/2oaqFc+wAk2UJjAQwAtMCwHxn/aZ
	 oGaDibQ+DCUK7l/TnenQ9AIUkorF3s1d+6LL9cvaZat610cNNKGEGSf8G1CXNrgmc
	 jWdhnkZD9UR4gwVmhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1ruPZ40HDk-00qV0p; Wed, 10
 Jul 2024 15:34:02 +0200
Message-ID: <8dd6def7-58b7-4578-b427-281aab70645a@gmx.net>
Date: Wed, 10 Jul 2024 15:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] usb: dwc2: Skip clock gating on Broadcom SoCs
To: Lukas Wunner <lukas@wunner.de>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jassi Brar <jassisinghbrar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Peter Robinson <pbrobinson@gmail.com>,
 dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-list@raspberrypi.com
References: <20240630153652.318882-1-wahrenst@gmx.net>
 <20240630153652.318882-10-wahrenst@gmx.net>
 <95762956-b46a-4dfa-b22f-bccbfa39558d@broadcom.com>
 <ZoezRpXBgB1B5WjB@wunner.de> <4502d826-d80c-4a98-a889-da7badfa698e@gmx.net>
 <ZogLXYopViQO11ta@wunner.de> <43fa421c-5e5b-40a6-a546-d80e753586e3@gmx.net>
 <38e46b44-6248-45e8-bdf9-66008a2fe290@arm.com> <ZohiJgyaDwAoGtAx@wunner.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <ZohiJgyaDwAoGtAx@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dviN9n5mJNy5LcG+dhLGDfMtO1l0d0odq4AVYBIUuTcOGdBVkbZ
 CQP2qJF5WQHb8YNJbsitIYBk2IsAJNvaxAV+HpXanK0ElZtDncslaoxv3nMsMVLo0xNFhv3
 PwdDhrZ7r63ll9+Ag9kDc5oq8wPxguGNg3KKVs8+uJmCSRK3JZuyNUa+naUr+ufZvbDcGVM
 jlP1915LEhg8OB/OYByLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yq/sCgCsZM8=;BqY06MQMuRa21r/LEhc0tIsTBaf
 LAUQiaC9WWtNMVJhX5wq7hL9w6UQye8vO6Xe+hbggCrl69p/UIzBFApWQquDStybs17EE0Rb/
 pHcb+9tGC02gKSMxQkokQ5+V7+W3CtmS4I1hwSPPKQocEK4/WU08cWfjoYhAD0uxtWB5UQwDz
 yrG3nf1j/mLAg5h+hM6B3kfh1d+KMqyjg6EAtigDxOYIF4WgnZe79yuA1h09mYwIth39WKdTk
 LFiLNXkGG8bC+RnP+uablmhQhmHNkDlUW4JkuDPSlh47eWp6B6VHOxDT8CXLLmCTC1UolbKUR
 +w9gK2JXQ0p9jQk1VRcJKiW0SJm9ufJj/TJQAJS7JlJGlfr5joIDwUDSDFerUqCN6rXP1fk5C
 HlVeBWQcuDc6S//lOPDuYzf2PrBOurW22Rz1m0r18QkG9v8gKlhx6Ql/1vM3UMwalzUOVDYKA
 6L/aIpSiFF+4ks+7eq0Hrp9DUMaIwoUMIOpEOoyS2RoFQCmywgNDh/8UNhVLI6SFQTp/QgoO1
 YBibO7veRgglwLfJPv/3EyG4xg6AZ6WXYy5TQkRdMjhZy4rNm7yPake2vWSPEh/U3LsHQVqZM
 TPVmuQHqranmx3CSrR026vHSSd6trXeBtH0TZz/P5ge1b5J4SJrsWc5Spz589XuG6R8Y2sORZ
 meWmgNCSbucAkRij9VRovAFDQpCjL9RPQJfC8FtCbXpPeYi/oeF6vvZyGxwc9Fz0EJxgMmA+P
 Eg7syDNhbeQP0tU/5q48/SEdrlS2qau8EetjGry9xGWT+t3NgBzwwUwO17yLSYoCYzeL4tdx/
 F19utBxHvwa3tjHksyuhLX8A==

Am 05.07.24 um 23:14 schrieb Lukas Wunner:
> On Fri, Jul 05, 2024 at 12:16:14PM -0500, Jeremy Linton wrote:
>>> Am 05.07.24 um 17:03 schrieb Lukas Wunner:
>>>> Careful there, the patch vaguely says...
>>>>
>>>>      With that added and identified as "BCM2848",
>>>>      an id in use by other OSs for this device, the dw2
>>>>      controller on the BCM2711 will work.
>>>>
>>>> ...which sounds like they copy-pasted the BCM2848 id from somewhere e=
lse.
>>>> I would assume that BCM2848 is really a different SoC and not just
>>>> a different name for the BCM2835, but hopefully BroadCom folks will
>>>> be able to confirm or deny this (and thus the necessity of the quirk
>>>> on BCM2848 and not just on BCM2835).
>> This id comes from the edk2-platforms ACPI tables and is currently used=
 by
>> both the rpi3 and rpi4, and AFAIK nothing else as the rpi5-dev work is
>> currently only exposing XHCI.
>>
>> The ID is strictly the USB controller not the SoC. Its a bit confusingl=
y
>> named, but something we inherited from the much older windows/edk2 port=
,
>> where it appears that the peripheral HID's were just picked in numerica=
l
>> order.
>>
>> [0] https://github.com/tianocore/edk2-platforms/blob/12f68d29abdc9d703f=
67bd743fdec23ebb1e966e/Platform/RaspberryPi/AcpiTables/GpuDevs.asl#L15
> So BCM2848, BCM2849, BCM2850 and so on are just made-up IDs
> for a Windows/EDK2 port that got cargo-culted into the kernel?
> Yikes!
>
> Has anyone checked whether they collide with actual Broadcom products?
Using public available information like this [1], I wasn't able to find
any collision.

[1] - https://github.com/anholt/linux/wiki/Devices-with-Videocore-graphics

