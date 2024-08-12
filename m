Return-Path: <linux-pm+bounces-12113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC994F8BA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 23:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3275C282501
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BB16BE01;
	Mon, 12 Aug 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LmX4tE4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518B1537C8;
	Mon, 12 Aug 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496693; cv=none; b=DbrojENuYAE+Eu5jcbf9NLdG/boE9TJeLIoXE1LZIo9Dvh3Ttj99r7MNdjlUTv95nCQsfwxa4+DVPI8t6aznwFQoFFZ62Wh6RvpxCtQ3E7WpuEoBsVkgzEbM+KhQ1JJU5ACBcwhfQcu3pZDDnNBP00A2PgqyDdJl0Q8zCKg9hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496693; c=relaxed/simple;
	bh=aJjNV6IIn0PKh4LM3C+bQDLs7Rb/XjDKH8mbgLDM39c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1OleRdZiVcigSmNwlYcgNJ6T0xp2LXx8TH/SVlJgFl1DVRuKCtKpTIiNe3D+B+42/QYyfM8ZBaITHRTs/Cp+39woeprDpzFh8Jf+FC6vbczIrnWWwCoqQXpb54dlxyXh85Tvytsaya3ggA6GiJ+Pqe15RAAca0m7BJLRtHkd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LmX4tE4j; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723496662; x=1724101462; i=wahrenst@gmx.net;
	bh=DKtjNhe7+nbF8JHA3vCW5OYYhp8tnoOSo7h0OpUJ9U4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LmX4tE4jw8yVX9Gap8ZeeTe6AdNlHl6Nw4asL7aV48MtaRxG0Feuk0top0/DB41E
	 TlicCV75pQQ4rG/s23JXqCIQrf5seUygl2wP/QDgn8vwLLUVTsgItO2AsVOlQRmnV
	 BeUS1TG0TI8uA5FhgnY6dFx5S3aoRaH3PO4e8gv/YVQkl0vFlHhkYmTq/hxx4CPHD
	 Z9IMLrHuFR5XWiRGVPCBFlguQzthOYrGlkiNnxdTb5PPrtI6p4MPBo99NxiFY2uOI
	 X4lu1LSWvrV3qhKVfCXP7gXU58dCG7SVmweWGbT1IMDnRbQz4VLYtX0B4RzxXrAS7
	 gq6M0rQQvn2MCv5xzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1stDG30Zuj-00KJ2j; Mon, 12
 Aug 2024 23:04:22 +0200
Message-ID: <19287be7-3136-4c75-be91-f3fb585954a9@gmx.net>
Date: Mon, 12 Aug 2024 23:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/16] pmdomain: raspberrypi-power: set flag
 GENPD_FLAG_ACTIVE_WAKEUP
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Minas Harutyunyan <hminas@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728114200.75559-6-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240728114200.75559-6-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d1gqw1yiMT8CmYwa+ZALyjX6ZixEUPMZTinZ8wEqTverOYCRAjk
 tFuXt33XZNSJdQi1QK/M0cF2UC3mLRcJL/JrRMAbSQ7Uzs/LLL/OdYdWAjDmR4Or+rlAtxI
 dssQxHgIVPc/JRBVDwR9/wse56Q+OI/5Z5i8s1dHlPCzOH8zKobEQ1lRg30XYJ8rypp1joF
 sURD4BAlt8ElWUsowAb6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0WKLVPnD5vU=;a6jv6C6lAtEo32uCXJC7ohdm6Ot
 ChB3zr7zIu++csE/YRwUf+3uzCorTCo+OgeXLt+F/GsOLHYPNmJu93SV61mjCpaKtaCAQ+eHG
 aicWvxs0jgOMHahuqUHjKmp2M5BaJvQfTEaxyWnXSBZUDoQ7meMOV+7zWwbcI7CWguhUY+4jh
 xcElR/IWxRl/x8BQTT4YGMkvKcJvCqmXmjsWAn3B3FQARFbwqp8wgrcpwbArzl1V6//ssp2ZM
 3Rf368IiVlbbDjL2zANv+xf3QmmwbFWkI6b7l+IFDjWB9S3dovZjNC77uITA8cjEHOg/ACsJX
 KGSh13aXM7xpumVIQFn0FlJ/9JRW9BF1BRBRENcrmV2cZmrmE5uQ4atbOK6PvdeGhk6skpxFf
 VO6U9EWCgaIbwDJfOAiyOEYkt7PsvyhSITyTnaeNfI9lZb6cvb2NNxqzUUHcVfPIBH/Y9DFKy
 DYvzPqxPCjsswEVm6+4A7BoNdxcegQT3r3fxN2RHQAv9CurqGBaJuwdVebNKGTmzVUqmN/oYd
 AU2t0OIWF9750oauBp7wbTyAVCDnzJRNqyJuT1vaP0R1tt0WpXG8Z/ZPivY5R+z3pB7Z6OshO
 27A9k8SDKU1KDzDpZKIHk9nlfyRgkRuWzlyO5O+y4rntwYGjQ8syNyie2V3drpPM+Beun/iMN
 kSoZbCF7gGYIrKhTrZURpePONGQsqXeUOi9b6VZ6yX5IImqPbIkjqq3WxkyDW9yEr0Vy/1qEw
 jysgE0wJ94YyR9cl6U/9XEKurryPpOOd4jlTpqIueohGuxwQSv/h0oJqWnIg/bGaicqYDp4Kb
 89MqcEhTmiUQCsAT9a8rk9pA==

Hi,

Am 28.07.24 um 13:41 schrieb Stefan Wahren:
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to rpi_power genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
I know a lot developer are in holidays, but it would be nice to get a
review for the new pmdomain parts before i send V3.

Best regards
> ---
>   drivers/pmdomain/bcm/raspberrypi-power.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain=
/bcm/raspberrypi-power.c
> index fadedfc9c645..b87ea7adb7be 100644
> --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> @@ -91,6 +91,7 @@ static void rpi_common_init_power_domain(struct rpi_po=
wer_domains *rpi_domains,
>   	dom->fw =3D rpi_domains->fw;
>
>   	dom->base.name =3D name;
> +	dom->base.flags =3D GENPD_FLAG_ACTIVE_WAKEUP;
>   	dom->base.power_on =3D rpi_domain_on;
>   	dom->base.power_off =3D rpi_domain_off;
>
> --
> 2.34.1
>


