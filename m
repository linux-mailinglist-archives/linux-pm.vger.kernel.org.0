Return-Path: <linux-pm+bounces-5142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DBF880BEF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 08:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CF28590B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 07:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9231B20DCD;
	Wed, 20 Mar 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjWGYv1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88D1EEE7
	for <linux-pm@vger.kernel.org>; Wed, 20 Mar 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919260; cv=none; b=B4EGWWmXBH44IJNlTF1C1AFpuKU9RwMymUu8b8KR2ywVox/M7PN7HQiomtNBdBxrPnA3MRGNuT/NJ48H0SLuPrxXQhIx6ocTwKGMs1e3uw6oiV/4p9xTWo0x7y0j5PRmZAudYbMX9NVveN42Hr+4lc4IbJ1dMvtKX6owBYF3CZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919260; c=relaxed/simple;
	bh=/6CqZEV50/HDUpwdn3sQhk8AnOPHuffll7LzWFbRSPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW4OUVYe/x0NjVvPeV8FAmYhC3ECos26i2Gooq8DV4EuC6zF+esDRt+40AcOEW/+bmtFUNsXtZ1XDrag2MccD0t7N3jars6QncTMjrMTjL8AnccAXMKsdrwbVXflA5j+anNQQJjROXdjrb1BD5zT1iVrpVJiGXQpLqLNaeQetRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xjWGYv1Z; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a465ddc2c09so422333166b.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Mar 2024 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710919257; x=1711524057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kGGtH5pV+JgXK6yvZ/OzVX7sAz2a5zYCjHOqU+mGpgk=;
        b=xjWGYv1Z61nJJZ2KD+HxXcpt6xewYoczOT/a4ZDgQ7fuD+Kqw7ZZrt6JFwAVHMD/Ee
         iiW133V/a+BXXSj/+FwJPOhTPXkjoEAOOZrb9mpwGa7KQcedfCFZFuDjfcbTaKKFyGzg
         ZN7QY1k52y8ufMH1fkw/sFCaKswowIC3VQR9wX0NgNJeZZo0yT9Gz+Lti91tcnQGhCxI
         RujPIzp7890lUfgXcmy579BkzdHMxziybUfFJU5wksX2Q2gyfhgz8ihP6y4K5VY2ruio
         VwU9kayeTPfTKMZcA2hbntDu1ZEdASJ7430I0cztBPYgrP2lcnY1E9vqEzB96ovV3Dgr
         UkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710919257; x=1711524057;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGGtH5pV+JgXK6yvZ/OzVX7sAz2a5zYCjHOqU+mGpgk=;
        b=GJVfKGhweR1DIiPv5ZSTohXgow+GjiPo/kml7t/FiMDeu3vsmhSvakGXoaXWI40d9v
         NK8XLUfcD6WwQIE9E9YzUd36Byd41XAFRjsJmPXlJyRNHuWC9ig7LgvC8ua0i3YWkV3U
         /cGbD0ys6vA876mRKWsUgh+iGQ3JbiLUqkWI41hn52Y6D+k1EDYidz5xeLzOmKQa1R89
         O3bGTolea65GbpQ4UYD6fqioG/Uxp8VU3bRaqhWvbCaHnVuFXyR8T9qovkgkHgo0OjlP
         UW9DcYRr90VNXdTUGZS5baTCA4+bVbucnE/E0ZORjNSOVK3Pk5dWCM4yCbYrSo88REX5
         tb4A==
X-Forwarded-Encrypted: i=1; AJvYcCWC47GCsS5AvxTS9pYixxJP/3MoFjd8SvYz8J6wt+TYZgc9zlpUgN/YZxz8PiSXjZtHC5bymqqXrB1udzUWitY4PHmtyvF0CvY=
X-Gm-Message-State: AOJu0YwQe9bjKlGfPEtZLIvhdlhn+NeDcktMLNj2S2IvzBmgW+cyMBCY
	1N+cBWqSInJwd9mfk8ErPj28uyKvJmuLsdHjYBXasmZyyzNRXtlTlvuk/SF2xaE=
X-Google-Smtp-Source: AGHT+IGltDGgbVu9/Z4qmXvaw4FuZ+sqm0PFM+fJbYrxAAu+/Lm3xVjYmuqrMfUc4Qr5nINdaCb26A==
X-Received: by 2002:a05:6402:3712:b0:56b:a8ea:9642 with SMTP id ek18-20020a056402371200b0056ba8ea9642mr1306169edb.14.1710919256953;
        Wed, 20 Mar 2024 00:20:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906198e00b00a46d049ff63sm2317751ejd.21.2024.03.20.00.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:20:56 -0700 (PDT)
Message-ID: <4d5b2da7-2a45-4a9f-8a96-a6840d2751a2@linaro.org>
Date: Wed, 20 Mar 2024 08:20:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: reset: add new gs101-poweroff driver
To: Alexey Klimov <alexey.klimov@linaro.org>, sre@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 peter.griffin@linaro.org, robh+dt@kernel.org
Cc: conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
 semen.protsenko@linaro.org, linux-kernel@vger.kernel.org,
 klimov.linux@gmail.com, kernel-team@android.com, tudor.ambarus@linaro.org,
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com,
 alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 elder@linaro.org
References: <20240320020549.71810-1-alexey.klimov@linaro.org>
 <20240320020549.71810-3-alexey.klimov@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320020549.71810-3-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 03:05, Alexey Klimov wrote:
> +
> +	ret = devm_work_autocancel(dev, &gs101->shutdown_work,
> +				   gs101_shutdown_work_fn);
> +	if (ret) {
> +		dev_err(dev, "failed to register gs101 shutdown_work: %i\n", ret);
> +		unregister_keyboard_notifier(&gs101->keyboard_nb);
> +		return ret;
> +	}
> +
> +	gs101_poweroff_ctx = gs101;
> +	platform_set_drvdata(pdev, gs101);
> +
> +	/*
> +	 * At this point there is a chance that psci_sys_poweroff already
> +	 * registered as pm_power_off hook but unfortunately it cannot power
> +	 * off the gs101 SoC hence we are rewriting it here just as is.
> +	 */
> +	pm_power_off = gs101_poweroff;

So that's a duplicated syscon power off driver. Why syscon does not
work? syscon_node_to_regmap() does not return correct regmap? If so,
this should be fixed instead of copying the driver with basically only
one difference.

Best regards,
Krzysztof


