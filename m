Return-Path: <linux-pm+bounces-13978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A60974707
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 01:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88E4288364
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D61AE868;
	Tue, 10 Sep 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xKqx0FvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6D1AC451
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012315; cv=none; b=Q6ub4lKef1aJkhecTvQuO2RHQr3WY5PnScGB28GHlaAwGF/oe+YWoESaTcXUD7mloeQ4OyE6UAM+4A7q4fxYfDWWOaVnuiuhAlEVI+jUzY9ro4JZF9FwFZ8lbE7vdN+MoxpA7ee3u/yjSJQfuV96VJoaXj2SORlyL57PhuJzwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012315; c=relaxed/simple;
	bh=TaA6LtOkaMdzDDJLahf0mqw/Pgw5pmUHh2JeHaA8+w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/od2jF7CoMmmrv+0c1KgBfk1UtDWn7A6YkrmZVLKZeNSks77P0+Kvpd2IKt55FBb6hn3XunrzSdfzOH8u3rs+QiryWVx+5k2fwkqUy6g2KTjxH+eH9D/iaC38iX8s9GGBKG9abj2CQYuJgUgadm/xlkjNSnQCacYSLgFVAIxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xKqx0FvM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718da0821cbso3853676b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726012312; x=1726617112; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObeoPBsB3Hucf4NtGoVRcxoG7r9sePIgIowfBO8T26o=;
        b=xKqx0FvMxRhYFL1GzrYUqNMCbtCNC3FSCMR+L3Y/hriipEyZcpJZvZ5GcOpczYDw+q
         6AMgc42hIq6VJPPx4ErRKbvpXWReP5/5NMlcMH0hGpbigiOAQbC/RKp/kIJxk/7goFMu
         px5a3NtlY/L19XZRvI8YUZuR6ArTM2bQlJsVojgPN7crHN01R0jrDNueuR+tFEq/tP8N
         m1NM6+b7r9itTEXRNC9hpfuX7x96f9gCsz9JgJMCu7+gzxw/OuSwtcTLE++EBMNtkWpO
         yvabSgzyJpDC8y1/owLaixCiltlhL59CaRDqHXE+pTrNr+jWuaiHpzJp2B0Fu9CUYL8a
         8HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012312; x=1726617112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObeoPBsB3Hucf4NtGoVRcxoG7r9sePIgIowfBO8T26o=;
        b=UCyTBHgKHdEsAxg/iZQXZ3JzM2jAWSQlxOpEmFgBWbAHfv8G7247JC4HBVszkbv7T6
         Q/8iP0FibuY4/RAnzuvpfATXZx2cpKMeivudQZiui1xaKT32xO0JcUS3rP5wRGaGu4LI
         UTtek/hDuzT9IVMrp1/OmkAFOvovFT8IaMYB1GCBTaT2GJaFzcuf8Zao51y9PZS+QIgr
         djckxvNI3v3xVa8eU1dShhmHNazmcJAE0eQgdzJ3dlpkBmDYseiwfELPuHMpGJM7y7pL
         OBCdCdXobgrwT7EbIcOXkVWH5NQne17RCN1lNoZC1uyyhu3OFyVb0fuIqaphZMuQvc1X
         ZlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzm8Y/LMzpqfDE6PbhwqJp1UcWdG75jqplxRSNvedZNophup2ISahLh2nX370q9px+slPxTOorcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdbnlGXLuU6IEELu0nS5YywsnT4vtyHRah+Pt8ElrBell6wPu
	jaKddANNy8HasG2ylozdP9P8br8UZR2x4hlBUzQVofHaUk8GdoGkWNw4nBa0VYM=
X-Google-Smtp-Source: AGHT+IHsS35HDIcTQPwf6dzkSG+kKpt/cCY7Dj6LN88U4ZX8TthbEYmUyeoH840rDgYNG9UCB07f7Q==
X-Received: by 2002:a05:6a00:2296:b0:717:d4e3:df21 with SMTP id d2e1a72fcca58-718e404ba5cmr19877655b3a.23.1726012311811;
        Tue, 10 Sep 2024 16:51:51 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909095124sm1896787b3a.103.2024.09.10.16.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 16:51:51 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v12 1/5] PM: QoS: Export dev_pm_qos_read_value
In-Reply-To: <20240904194229.109886-2-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
 <20240904194229.109886-2-msp@baylibre.com>
Date: Tue, 10 Sep 2024 16:51:51 -0700
Message-ID: <7hbk0vukx4.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> In the ti_sci driver we would like to pass the resume latencies set on
> devices to the firmware so it can decide which power mode is the best to
> choose. To be able to build a driver using this function as a module,
> this function should be exported.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Rafael, if there are no objects, feel free to take this one via your
tree.  Thanks!

Kevin

> ---
>  drivers/base/power/qos.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index bd77f6734f14..ff393cba7649 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -137,6 +137,7 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_qos_read_value);
>  
>  /**
>   * apply_constraint - Add/modify/remove device PM QoS request.
> -- 
> 2.45.2

