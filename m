Return-Path: <linux-pm+bounces-16372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E29AE338
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB971C223D9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FF1C75EB;
	Thu, 24 Oct 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzjmslN1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4E1C4A31
	for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767703; cv=none; b=Ll0pctn8Gi/60OWZzCXxQc5+kq5kyVnaNW/sSLX4iGO3ThQW3rz7iNSPvYA0ED8ZaQlngwTWc4z0A2SIA9l7q/yJVKZDCyag4taDqiA2nLRFbFTM3FliaSAQC0Vu5fHjfnsDYVdhD8c7KdQpt86FZ9UQqj5jmElg2F66pQnGiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767703; c=relaxed/simple;
	bh=VutudFr9zY//7J/PXnT8bxN8MBRmcfwzso5mMadLBYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWNYsPyBVw64bCvYX8K6M22Vh3akCK1EwdhQ++hNSjYuLsgfxdGqBRJEFFWoFgW/cqo86h/9tpbh5eieSChcwA8I0LQT0hvZWgj8EYXYa1qeUN8w2ZCM0SRJyQiNUaKm9A1+wW1b/8wkYCAkUt9Hk3htmqU4I6FMj5afcLmW4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RzjmslN1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so7915755e9.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729767700; x=1730372500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ4ebqt+oLX28XDc2rVqdBFwEEpG0bsffz6Hu6+liXE=;
        b=RzjmslN185RaHAO+DzdSalyck4L0JkUW43JNAxmOOFQeDYx4D4QokFz0VSnHbpspOo
         Y3RmbWKtKQ5UPGnapsxgtQUTqn4GCJWw8SFvsR/VzXdgQVhGC7wC9+CWGF4veKNj72LB
         iRSlZizSlsgM3ewgkxbUBlev194gB8D/iAsowsbzzT5VKnYBP8Fho0rFNsVaAE/LhSKJ
         pm+SL+QlCe3euNdrr2/jdbrs3Jz2HeQFJ4wtrAtn/ufsOAq1R9awIbyMccMPTfSyvPiL
         KK9O/JaRf9Tv8SeCMWCnJDeudlJoy8j6S7dQWjy+nkkTX27i/O0Tp+sOADLKIteRQrlv
         Sp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767700; x=1730372500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ4ebqt+oLX28XDc2rVqdBFwEEpG0bsffz6Hu6+liXE=;
        b=cemr05zpG2TaorVtoAr6xYNi7tG3jYdVYJZhjfk4jFZ41lOv3mts4+pwoGiAVnuXat
         WO5hwQm1sA8H/rhTROW1c5bfYcifIS5qTwpMi5FlDKysurzNxSGGUUOnvuKI1t5DjJ2x
         EF2igYZ6r+lFucrOnGkYipFAPREBg85q8HpnFlko/T3YVVbvqZ2YsDizh6Tox3+KFANd
         H8CczuwiW0L5sR0yChRaTF105rSEE8U28PAD5Zm4govZj29Tpg1Y6UXHEepIHVW/w52b
         G2DpZZY2cWQV6lwu99EV/G+90DeXfOoyd2Li68RDb1YFNQ1jx5Yfc+x8soPuXP9xmtQo
         r6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJHsA1UwI+LiTmZ4Q6Ac3QzWVp5xbmMb2nf7V5Xm+bZNItLEWESgnhuVPTsVM7j+FMQF83eZeLgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx47IsZSGn84AER+Sz6q+xLB0So/gWWhUiQw1am82JWJnbR4tJ
	Q0MJrvVyqH+KF+nyXNxF98+azFohr9IGVgjw9EAs/UEyLtOGcg+phxYv+sGSyWY=
X-Google-Smtp-Source: AGHT+IGYhqgppfT2SUjiBQTjCtjFfE0FYvEGk7LYqfQMZaXD/zn3smBYrGPAMie229Rz15qEV7jZMQ==
X-Received: by 2002:a05:600c:4ed4:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4318415f81emr52886575e9.16.1729767699624;
        Thu, 24 Oct 2024 04:01:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c1eccesm41285115e9.46.2024.10.24.04.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 04:01:39 -0700 (PDT)
Message-ID: <5d2e4f29-5745-4f3a-9e4d-43ab5b91947b@linaro.org>
Date: Thu, 24 Oct 2024 13:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: rafael@kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2024 12:59, Daniel Lezcano wrote:
> The function thermal_genl_auto() does not free the allocated message
> in the error path. Fix that by putting a out label and jump to it
> which will free the message instead of directly returning an error.

Please note this patch applies on top of the thresholds series.

If nobody complains about the change, I'll take care of applying this 
patch after the thermal thresholds series appears in the linux-pm branch

Thanks

   -- D.

> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   tools/lib/thermal/commands.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
> index bcf0f14d035a..b0d4c8aca21c 100644
> --- a/tools/lib/thermal/commands.c
> +++ b/tools/lib/thermal/commands.c
> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
>   					 struct cmd_param *param,
>   					 int cmd, int flags, void *arg)
>   {
> +	thermal_error_t ret = THERMAL_ERROR;
>   	struct nl_msg *msg;
>   	void *hdr;
>   
>   	msg = nlmsg_alloc();
>   	if (!msg)
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
>   			  0, flags, cmd, THERMAL_GENL_VERSION);
>   	if (!hdr)
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	if (cmd_cb && cmd_cb(msg, param))
> -		return THERMAL_ERROR;
> +		goto out;
>   
>   	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
> -		return THERMAL_ERROR;
> +		goto out;
>   
> +	ret = THERMAL_SUCCESS;
> +out:
>   	nlmsg_free(msg);
>   
> -	return THERMAL_SUCCESS;
> +	return ret;
>   }
>   
>   thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

