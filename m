Return-Path: <linux-pm+bounces-17643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CD9CF283
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1358028E039
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F71D5AB7;
	Fri, 15 Nov 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iffTzbMl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB70163;
	Fri, 15 Nov 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731690839; cv=none; b=txHL6axjgk9MAQkyucGMwIQQ6veHOjK62RnpGcpVdQIGmXmBbeCwNJGZ2gUtSDbViomdAN1CFHlBxn8EH5c6CEn7EL+8xfNWv6TqTV0X+Us3LK5TrSFkH5jlRDQ+rQ/ASothSiS5tB5H74N288jlZdmjWPtrn/j1OqhXv71hXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731690839; c=relaxed/simple;
	bh=0z1mF/1NHd3wdiKvL4L1tW4GpD6v8naqZm8qcI93dGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKbqH4r0sf1XG8WKLQzJFvdXtxULblHUMgSWg37izX7iv0aFBkZb02CN3A+ZeaO4JoYiqbP3Fzy2w6PXEmFwtOGfuJ8QQSz/1qdDquW9PYIQHsYwyHxdPbo8JJ8cI9/Jcmc4u0to9gC79JUcQ6PKjye2W/hI3iiHgemZNfsAmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iffTzbMl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f450f7f11dso1496104a12.2;
        Fri, 15 Nov 2024 09:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731690837; x=1732295637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T//y6ht+AK212gbhxd1iydMgot9/1wRHpQK0kjk9x3g=;
        b=iffTzbMl2+W8/yQ1Q2YO0yHtdy2TovfWt9PNxdMxS/CmZg5iC+oO3D+WeZ0LZEb0Nk
         jhGTfuaHpuK9vDI9j7bot8VvtHuuQN78GEHWi0qQbnttAESfhgZO6dfgzqrFEL2K4AWG
         Lxq/M6BFF0B0anpjOsrGW3fIJEeffWHYkI+IMr7Vm6fE79LzWHKl9VRlKMt/9k5sseKU
         YxKSoys4CLUHJFSTPdITsjbjsVM2elu8Vx3fBnqXVASaLD2+8oxxu2QL3k1BiptIWrtY
         PEkriseeVx5cmDhoFyDVkLMF4HpOCFUKDrh70eFXaEw629CQyTlf6zOB4JrOzivtj+xc
         3pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731690837; x=1732295637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T//y6ht+AK212gbhxd1iydMgot9/1wRHpQK0kjk9x3g=;
        b=AQUkfeU7jkMKeo57WdgXwH61Fd7rxiuHL1VOnzps7Vle0LOsa+D4G4tXMcUNtCHdrc
         MQteG49J9VyFPDIkq3JqtoLjQpFOTPiAEPF1YP2UQYrCGpKfPsfRNLgMwJLRF7DqWToN
         2sHy/dBv+1k1KZBUkojc++dxVmI9pdB/u/azj9rYGZBH6KZhZ2qElCpLKSCvjUha/LD8
         twBbYemDXjVpuxcRhurTEsgXaRFhSROykN/kM55MlhtdphOn0s/lqF6zGkoIGh7X0WIo
         v9WtMBE8zr/AIhOoZK+B/a5j5Adp/oIGTh8x7kAXVXmSkSROoF6ulS17kOrOMvzkTzNN
         GPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvt55+so4zWW4xK0BuaHJQIv269aIrdM0omWI/vFJjAYRAYu/eFm6/pjj64cG3PokzIO+JspHMU18=@vger.kernel.org, AJvYcCXMGJEgfqsCHsOJw67Xueq7SwdrZXBrrVAHO10TgJRY4diV8C5mSDHyApFoMdLm343sucxWp11N6MjvfLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMjqW90XokV2TpG/6zGsPVee7yIE7KXhwl41jI0ZRXRCzuFRU
	eVk+usvE/7MaTaTuzX5tmQVotn1ldcpVQ2VtqQ1hlpXOMfDLGS8F
X-Google-Smtp-Source: AGHT+IH3/nlA0Lyjzqo5vfWHA7E97ZtO+KkfyIThm40zZbmimBXBGTHv5RxW0DC9wZAohU6fLlF9RA==
X-Received: by 2002:a05:6a20:9c91:b0:1dc:32a:d409 with SMTP id adf61e73a8af0-1dc90bf4683mr4437109637.39.1731690837392;
        Fri, 15 Nov 2024 09:13:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dac1f1sm1491489a12.68.2024.11.15.09.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:13:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d6a79e0e-50e6-4b2d-952a-fa408c11893e@roeck-us.net>
Date: Fri, 15 Nov 2024 09:13:54 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Add stub for
 thermal_zone_device_update()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20241115-hwmon-thermal-v2-0-c96f0c0984b2@weissschuh.net>
 <20241115-hwmon-thermal-v2-1-c96f0c0984b2@weissschuh.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241115-hwmon-thermal-v2-1-c96f0c0984b2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/24 08:40, Thomas Weißschuh wrote:
> To simplify the !CONFIG_THERMAL case in the hwmon core,
> add a !CONFIG_THERMAL stub for thermal_zone_device_update().
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/thermal.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 25ea8fe2313e6d0a53192974a80d92f50f0ff03e..93880b7bd7d92df5a631f297664b9ba37146fd6a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -289,6 +289,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
>   static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>   { }
>   
> +static inline void thermal_zone_device_update(struct thermal_zone_device *,
> +					      enum thermal_notify_event)
> +{ }
> +
>   static inline struct thermal_cooling_device *
>   thermal_cooling_device_register(const char *type, void *devdata,
>   	const struct thermal_cooling_device_ops *ops)
> 


