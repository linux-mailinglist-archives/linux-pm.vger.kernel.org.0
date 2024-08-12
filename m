Return-Path: <linux-pm+bounces-12111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8794F89A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 22:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B481C22332
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F82195F04;
	Mon, 12 Aug 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Sjom9alj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110B1953B9;
	Mon, 12 Aug 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495954; cv=none; b=R+YLDByUQVHGbmAMUvRUtctodGsVRjKBUHPGTtotzs7dB5GBy+r6veGC7y2zW/P1YD4nFkEOL3w1rSsbJ6QWR4CK3o5PeTZIjYnHKYCpFPJtz4tM3brodlB2+wGiLj2gGzJwiF+KSKsoknK0nqCkV6dNM3aS7HZmXYpD88v8qLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495954; c=relaxed/simple;
	bh=5S3wsxJNYF65jYK51oDnSpWPl4BwJZWS6p0vqfXi54U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjHSJrWK5ueC8dXGs6IWsV1vv3mdASO4Du3YbGwN670JDeJDK8MxwCwpWiUIBI6eks5WdOxgO2sxmMwBYAs0GrOBPncgKEKrYTB96kpbAybucwrhTRTUvLfkw1W9XNVqpXpWGIkFBY0lKW9T8v5m51EzNpWQKgkG2/voECoYn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Sjom9alj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723495921; x=1724100721; i=wahrenst@gmx.net;
	bh=GvKCeLBsyOIB8oIBg+Q6t3zEGAuc8wQHMxIvLCTbwTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sjom9aljNiYSXt4/TV7FudxctU39/Tq2W74NPg4PYxF2kDjaU9OI+BC7xOiXlzzV
	 iWq0FxysnId4FFG9QWFS3sLEphqCHsr5P0z/rK9m+CugtuzzJJ3wdLKrj1pBW2Hcf
	 Wnf7psK+fYzNjkhxpFoQfCsBBFZ2jhVqOp0YPZ23aYjexU2FAEytCN8yxcoUlKf5H
	 X5Qog1k1BTvrflXb/Z9fhyJmhzNGBb49cHxfidzHPp+0F3mEGlVmLontiHMwRVfUs
	 b+D+Zx99UO5+VKpGPXstOevQd64Zod2frROPRigwsxPUDtEdl9HSOjesZzTvyORef
	 S6SUKDyfIS+4o4RuHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1sV3IW31Xt-009GBI; Mon, 12
 Aug 2024 22:52:01 +0200
Message-ID: <d4f111e2-9695-412d-9993-8f5d31c8a545@gmx.net>
Date: Mon, 12 Aug 2024 22:51:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/16] firmware: raspberrypi: Improve timeout warning
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Jiri Slaby <jirislaby@kernel.org>,
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728114200.75559-2-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240728114200.75559-2-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZfNPP2zjk2FxGLvWamEJ65EQOEHr/+kJILjZGfdpf87+gGx5/C3
 64V1HtPFKiFRkZVlVx5iVKl9HgMhRU2I9im9qQoG56Af8h70c4JuH5HOWxJGLmSGFl+fCuz
 3Oq0mxvwqX/IEB9L2w3qr0bc30x11suNvAUSsPhQGcw3O0Fdjl6x/svM5cPwcfnqLhU0k/C
 tDwrcWM2zA55RjyVtr1JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QxCy4izLLjY=;VF0kReEZPhZaLGTrfcaQty/QKj7
 UifCvvx+SLuDS3BGH/JKVmzvbgxjfYMTuiaoiGK5ryEFzhcYD1W4kxp0xttxQgmwC6L5cECWp
 YnjEvCvFvuhu0Fpq5G8NtGB+3IFsOiqQ5pz5Abbyvc2B0cRAHxl73b+A8UdKAz//PbdhqoMzi
 2UQhPxU3LgqZXXGGwwi6zYlsBsFv67U2ciIUB7iKcBWbwv0WK1XuAfmgIPjdDwS/p9mC48hEH
 ijEGD6bBKXmtUPUW0VHSMfPF3KcRskrHg5GFaztguP/XKg6lR8PVwhqJwwHwYDi4t0ZXTwc8B
 /WdDsOKDWrWrD0c8cQUYvghNckD5OTt5OsLZcewSOpQ6CiY80Mcjg8vZpkb/OICg9/z2TaIb7
 lLx+k/HnJZCG27LHhGw0KSH8ELFD3BsYRzn5/Cf+/2tZlSs0+PcIJBBfGLQACm1yjlmjGuYyU
 MGPkmbwyxnlHeCTgr9WGN0I2LP5n27BMQzr/nvmxbh6mrFpU6nDTiBiIj7rhOHn2v6E12rJ1H
 HPCLxP9TC5HfJyKg1nkinWxUuFvzr+FgXHyhV23C0JLw+SGKxF7QTcQVfrHE/yXTjoAMn9wxs
 5ehFhzAGR01x91r9GuJzTstArcoTP+uVGcwXxnUXAgpQC6ov14e70lhN5zydwcWo0bhsWiUBN
 sh8YsNcyrRGliwu3k9TfcgJQlvyFmT6b0viXzPSNIWaBecUWJOkdGXlO8nXq8Wf5SO4zgcqB6
 B18i0+SNEyXIdyKAPI0PmynEDFo3j7xspJvpav8uRCSm3ttxugQ3IpeCCgEuP9V3Q+9fTsC6y
 m76aGkNl/8GkkRbtl2mlunOQ==

Hi Florian,

Am 28.07.24 um 13:41 schrieb Stefan Wahren:
> Recent work on raspberry-power driver showed that even the
> stacktrace on firmware property timeout doesn't provide
> enough information. So add the first tag name to the warning
> to be in line with a status error.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Are there any concerns, because i assumed this patch would go via your tree?

Best regards
> ---
>   drivers/firmware/raspberrypi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index ac34876a97f8..18cc34987108 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -62,7 +62,6 @@ rpi_firmware_transaction(struct rpi_firmware *fw, u32 chan, u32 data)
>   			ret = 0;
>   		} else {
>   			ret = -ETIMEDOUT;
> -			WARN_ONCE(1, "Firmware transaction timeout");
>   		}
>   	} else {
>   		dev_err(fw->cl.dev, "mbox_send_message returned %d\n", ret);
> @@ -125,6 +124,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
>   		dev_err(fw->cl.dev, "Request 0x%08x returned status 0x%08x\n",
>   			buf[2], buf[1]);
>   		ret = -EINVAL;
> +	} else if (ret == -ETIMEDOUT) {
> +		WARN_ONCE(1, "Firmware transaction 0x%08x timeout", buf[2]);
>   	}
>
>   	dma_free_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size), buf, bus_addr);
> --
> 2.34.1
>


