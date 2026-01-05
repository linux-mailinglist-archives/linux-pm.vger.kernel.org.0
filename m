Return-Path: <linux-pm+bounces-40233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867BCF5D3D
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B786C301EA15
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0063126A3;
	Mon,  5 Jan 2026 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD7Ulzzb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F9283FC4
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652084; cv=none; b=AfYrkZ6sZA+DzLXo1ve22+wqm3i61peZmb4pumDLOKA39aHSMZ2zDSGCzl8oalrrpdthZLhvz6nvJvUXnkIAlvIishMEWGxL+T3r9QTEpYykK6hFThJPWkO4ZK4fa0W6XgzFM20MJpi3+TzJXuIoXdoJyiSIuHW6Kui3/CqQVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652084; c=relaxed/simple;
	bh=b7vj7AV2tixYlEJCK+3DYsd/jhWamA+HobSOptAlXGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmgSZe7KeDPNEB77VEJptHXGNcjNur65sOkAqKzz0sgZdwOi7V7mE6BgHX7Wruuj0d9dZW8jTtTWMqEXqrbV7G4gRxHqhI8NT/V+i4vbfmEpUo0DAroIdLt23Lk803wEDt9vLk4blK2+vUc/rvtWjse0Z4XSUb9gF49D0TeXZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD7Ulzzb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so3316825e9.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 14:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767652081; x=1768256881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP3TKn35fuKWSrYkUT4P8AjhyfJ/uEDWn4TeWwqGKdg=;
        b=OD7UlzzbXxyaL2uBvsKMc5+Aj/VPF/ssGP+b4rx/MpCIADf9PpvchPNVGfMOHV3Agm
         BTHnpz2q/mHRRjb0JbVLRUWgUxsCm4y8mxlT8AfsmKz4eEm+XSbRVxF3HiBNt4UO182Y
         LmyQDVE+tYpKrWVfE0VsBH8HBEvVsL0HfDoJai6QzQgdqqqEIBvOBPy3b3p0x69JIspB
         /ydzZAZy0EihjD5tGXVQbsCJsL2rXXy0awIjGOsoEhVsFV66gOmkW7fxeuNpfKJM5CzS
         B7opN81yX62x+2QqsZ7R++6J1O1pEELiW/D5i9AFiQLBWtXOhDTjV8fmUDltvlPtiDi8
         73zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767652081; x=1768256881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tP3TKn35fuKWSrYkUT4P8AjhyfJ/uEDWn4TeWwqGKdg=;
        b=SCNLg7ZzD4zjDB3AagDe5VQgKDhoWrUb7xd+iN3Qsy6RSksSpBOAEXqwLYVHRqtNrv
         0bil5CRftFDFbqaj1gw5uZ7zDt+pwJDCWekjmUhsXyyYYMNzv4ELY3AGdo/nsRD3AwuC
         Po/eTvWt3ptKnS5djMbCzxoRajTqrN9a14w7FyPyy7TTb50kOcKZ0wEocjj/hsEAvZhJ
         8eTCo+D1ty+1sGTXSiZoSpCZ4AKtfcU1T52PDveRB1itkjQyI+Q+BUF9v//IsWlfVCx4
         tB7SFAWY0rTlZ2NJ5e9iYkJh8rtz43F9P++wKIYasvxKqbRlRraYxE0HFaGsnvNXNkCa
         PAlg==
X-Forwarded-Encrypted: i=1; AJvYcCW+VKho+3bncOIZKdLDHqn2LoTH9KYZFa12iCrRK4tvxYdXLg2kHWJ0ymhLfyziERzX5rIFi3SOOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxnZ8NVajb65cIUH5JFswg+lNQdjRmw8T6sYiWkOxnFD9DIx3
	Q8vusDcIByiAB029YkdNxvyP4eJLcwRos7LWzo/QsFwj4JXwFkIYIC4t
X-Gm-Gg: AY/fxX5/Uv9c66tNJZLDZGkz7TD6i+3t0UTQk7z6fiY2HDO09jolzyxe871fYWvyzOy
	gA9DBtbHZWwT3tGSxMaJP7KdsfgkZxNChC9EbwoNBVr6lXh+5C1IFaFlEZWG8MxtJG6Vd5NskmT
	ONQVlsQN3JLqg+XvwdSpomOqY3jSCRL77Q3SJKBkfUGiHnWkww4n3JLVOFSYrPRtXNY1buC5ALa
	NsTIbEPBCdEEvkURm/Y1w3HjJK7epu+fPHoAO43pwB7swOQSrJn+i+bQBg0iFIbs32UXdicFveq
	m9S88nhLGN+j5v5w3H0e+hiAVhpf2v9NiQAOKehVZgJhwmgM9M8ab+YfE5yR9HqnLNu1LPBGiTg
	ExOHqs9j+vYjNqHqdjKRK80hO9rMcoEiDPv4mcnO00jLJ7EdhudcAE8LOTW8Dss0SGIbswvD2MV
	A2hvE2wpQnsZkuyVcUmHcy9uK2Lm01LbLNCO0L6UOgLwZlnVuuGshP
X-Google-Smtp-Source: AGHT+IHQ2jumI7ob3RSLeH/S99yo8OIt0/2N7w2n2pE1KCHuEJ1chMCDPXq93Nmz5uhJL4PGy4W++A==
X-Received: by 2002:a05:600c:848c:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47d7f075bb8mr12511695e9.16.1767652081057;
        Mon, 05 Jan 2026 14:28:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f661a03sm10123945e9.13.2026.01.05.14.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:28:00 -0800 (PST)
Date: Mon, 5 Jan 2026 22:27:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] thermal: broadcom: Use clamp to simplify
 bcm2835_thermal_temp2adc
Message-ID: <20260105222755.305787f7@pumpkin>
In-Reply-To: <20260105121308.1761-1-thorsten.blum@linux.dev>
References: <20260105121308.1761-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 13:13:03 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use clamp() to simplify bcm2835_thermal_temp2adc() and improve its
> readability. Explicitly cast BIT() to int to prevent a signedness error.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/broadcom/bcm2835_thermal.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
> index 685a5aee5e0d..c5105dfc6ec9 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -11,6 +11,7 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -80,12 +81,7 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
>  	temp -= offset;
>  	temp /= slope;
>  
> -	if (temp < 0)
> -		temp = 0;
> -	if (temp >= BIT(BCM2835_TS_TSENSSTAT_DATA_BITS))
> -		temp = BIT(BCM2835_TS_TSENSSTAT_DATA_BITS) - 1;
> -
> -	return temp;
> +	return clamp(temp, 0, (int)BIT(BCM2835_TS_TSENSSTAT_DATA_BITS) - 1);

Hmmm....
I wonder if I can get 'statically_true(lo >= 0)' into the type check so that
cast isn't necessary.
	signed_val < 0 ? 0 : signed_val > unsigned_val ? unsigned_val : signed_val
is fine.
Would mean swapping the order of the tests - which shouldn't break anything.
But will need a full audit - various bits of code have relied on the order
of the comparisons.

	David

>  }
>  
>  static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> 


