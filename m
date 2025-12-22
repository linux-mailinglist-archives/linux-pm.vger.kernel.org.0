Return-Path: <linux-pm+bounces-39772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F55CD4DC0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 08:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96CD301B835
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6ED3054FE;
	Mon, 22 Dec 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atDLZ/lc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007761DF963
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387996; cv=none; b=coB8Qyd/nHbZcIolgnMwCwepMnwdbIb65k69WZpFMVGCjlEEYNobtSuVQjx358G1+UPOQFxEOh8NA4JjDtuPn7wc/xv4Pm5FLMYXbYg+TR7bOnY2Q30SMc4lUFUFelS8crY6dHk4lTgjuv8XQ5Hp22G54QWskkZ/yaVmeHqJLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387996; c=relaxed/simple;
	bh=Zd34aQUeIQgVRbcMiVY844XXfG2Y5YbKqClmyPhCpAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXYmm6PEnOYto+OSGbtUjf0NLYj9qgtpauifrIRBnr+Th5krEI/zzcSx07qy/C4Kt8aZPBMz3wC5O8Q2Bl/s99/F4Y8m87INNNK+IWeJSUmqLum54sZG2MdMWW6rGuGE3n2I4L7WOiv1BG623sqxwP/8PmnR56e7JtbAM2OCpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atDLZ/lc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5942b58ac81so3207904e87.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Dec 2025 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766387993; x=1766992793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9SkoxqsggcUODBXAaPnsyDyPpaZ8Ev8UfWiTov4h7M=;
        b=atDLZ/lchGcKkX+xPhFNU1eoSGGSjC9W4pcSfnSLu/j/kZr9gzJN2EJz+HXYj/x26d
         I7mDleNGGH3SZxgg7uz9lLqUzNyjHOSUQ4x3IhaY7cbuwoxi+Ncu2g0Hubvvfn8AqYbt
         TPtH8jx4JShHw1XydWvAryfqH3wjCnYO0XxRbXJJO5n/SDQiNx3HFsEiS1ZzmvYAc+TT
         bMEkV3XqMdxqLsDj/zemTA7TQhgJdJmgoyL06g+G8xpKcwOGSPMYrcgOUEgNNg8j3xZg
         /ypesUkU50RXnajeDrfDsHReNsHnbRqqZ6v9y0VmfXsmn+IwB4cQUAqqUdSdPxGNCjLL
         xucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766387993; x=1766992793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9SkoxqsggcUODBXAaPnsyDyPpaZ8Ev8UfWiTov4h7M=;
        b=tLAEJnN3Id6r97jWr1/SZkYxxk5jl8s4lgNfLQgmXFJ5VWpzN2nNg1b/BP8gqyE6Dh
         tS0Z1FyM2ttKzPGWKjHvjFi+njZYz234yQEDfY+G6HH3T7VHSODEBrzOsKUwcFlzXcbo
         9RAuLorocSz90fjsEDbvKFX5zN2gcMl8oI5iUL2cTGviTzbRPuGAFm53XO1YOx3meh4F
         MsIyJP341vLoTdS39cTHahtvnh32x3iiHP7gTbmPPhBxCtRt8sFR2fz8MB0usg16CCbJ
         rT+d76191m5kb2cY7Ttfbyh7J8+sHjXRloxDMckO07z8v06WtCogjDC3YhOcSK9rMZtH
         Y4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmlCNdqbAKr1PWLHse5rZsoo0jWwTIRWEgu/uMM7F9d4y5RL0llZ4RqjkOEhbQHOTZRrW7cW6BrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnF1x3anRuhcWS0/aK73y+s4iXGjLmJpQmnwxJ5qn0/2mp69Y
	THkps2UzgD/drfiWPEdVLcXpdY87AgVx3hk/bOreFjV2cegjRwos2AzN
X-Gm-Gg: AY/fxX4OnAu8/L9RxXA2tf5GZfCAhdl9sPWzan8t5P835nbdJhnDLT71GT/pNKTjlU5
	/xGeXUMRuAb/UNJhtZOQHAkdYlbk78+tMXOkMsU1ygTDB9r8ZwcUZRhNwH9PRTSDvdgFt1PANLY
	42fgohfSrBCeJxGXS2v4b2eVEhtir5+uSxET2c9u2QGpv8FgxNsDFLfeck8hZVOpAPi8NQTFxat
	EWIB3ePVK3ITu7SF0WnP87Tt5oo9o9RX4uz8CldT+Wqa7Cc8R/9M0Sl+WHtDI1/5NuuYyMh7j1b
	zAmt5slR1aPNZqJ20W0RhJcxRpJcNpvC1Xrs2u/vbFEfozq0zjlyxZ7OZyTWx92Ne73/vufpp/t
	s9uZcKDELXauH5D5ePUlaAa2f+Res/s3Y7GHgkYIzfN4df6tVurRhFGSvXVqUyeT9Ur56blp+P6
	jP5iavthr580vfGrjTNmebPWVQ9Iulv4LX4trCrT2OkfYC1TsaxnIAXQHOq+6x6xGPDsqa
X-Google-Smtp-Source: AGHT+IFIt4Am9hKgJz7fE6KzD3lx3O9u8TTZQbKJnuSGPWDfSn9VaIHtGi7avgstT9IAYPp6TRD6+Q==
X-Received: by 2002:a05:6512:3056:b0:599:cdb8:58b6 with SMTP id 2adb3069b0e04-59a17df2743mr3073051e87.47.1766387992696;
        Sun, 21 Dec 2025 23:19:52 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186170b4sm3031886e87.51.2025.12.21.23.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 23:19:52 -0800 (PST)
Message-ID: <56779ab3-6e04-48e6-bf1f-b05468668b94@gmail.com>
Date: Mon, 22 Dec 2025 09:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] power: supply: bd99954: Remove unused gpio include
 header
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1766266985.git.waqar.hameed@axis.com>
 <ee74b461a8b8f02093e0beb519a1f0b8de7b64bc.1766266985.git.waqar.hameed@axis.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ee74b461a8b8f02093e0beb519a1f0b8de7b64bc.1766266985.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2025 23:54, Waqar Hameed wrote:
> This header file is not used anywhere in the driver. Remove it.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Thanks!

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/bd99954-charger.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
> index d03a70cf84067..5c447b0882233 100644
> --- a/drivers/power/supply/bd99954-charger.c
> +++ b/drivers/power/supply/bd99954-charger.c
> @@ -56,7 +56,6 @@
>    */
>   
>   #include <linux/delay.h>
> -#include <linux/gpio/consumer.h>
>   #include <linux/interrupt.h>
>   #include <linux/i2c.h>
>   #include <linux/kernel.h>


Yours,
	-- Matti

