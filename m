Return-Path: <linux-pm+bounces-12254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939489529E2
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 09:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A2E1C217F8
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4017AE05;
	Thu, 15 Aug 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ak1x0BR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7B42AB1
	for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706987; cv=none; b=nCUoATmaYSFp+gyF+F0UW3GI7gRR42Q7Ykr+nIvudQbGvPvwOvwVaUl6icHXlf8cBJn4qXHlpPvG59SBWqlE7Tko11CRIkm15d9zwXECFtGVeYnC7basVLjZR6ErDODiszo67j9aIyxvg+szhAYJgq912f3QYcJF8n21aZmTmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706987; c=relaxed/simple;
	bh=hPX1celK2r4ELG+EKPXeAClu4f8aV/KAzwDNQ2P/imE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQonF/Lt7n+QxeGr4vGkTEydtEvHbk4rsNWpfQpLoBcNYDcl5iyEmxOiFUyeGOrJ3JkWf7C2bog54+5R0T20vc0CBru3eT3NgmAt3y4l5xCjMK6W//sB47fmUq3eYe7H/bhsWeN0RRI+HUZh5Ty9PM5THSODJAvSdLSMRTfckoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ak1x0BR4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db51133978so395745b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2024 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723706984; x=1724311784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwP1Gv/Yx/xpl+pnVih7/w3vpScHL1lhIFF+Jyhxw7M=;
        b=Ak1x0BR4TtlYd5wFix/qt3t0aDEzhwxVLrirTJtyNmYzslnKpF+wdwpy9oXIe41w+6
         3/s6pKqsbl0c/SMYvRm2fPsiuQfWzl10JappVmN7TOTeUsfLRBUQo0XAJ3u9/qN/o5tv
         Hm9HjZ6ZGSj8myiJb+rktiFvw+Mq3U0S1pAnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706984; x=1724311784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwP1Gv/Yx/xpl+pnVih7/w3vpScHL1lhIFF+Jyhxw7M=;
        b=VScaQOw/OMj0k+IjgEwxDPFEWfZJBfFIQDbdqZc8plP5DUfzWfpBwKGQa+2TQxG/ri
         ukKoQfKJVmD6tkRKYqw3v0YWF9Sgb5DFH/fZ4C2yI7WunQqKXiugvZD9W9n+Et8YsJ34
         wgl1tzMQcA+wiRdGujysd5pv5/ig+ywlp/JoWW/3g4uqLeFKZhbbLzcSox+ZQfFfjH0d
         i/A/tKBwbSW8Si7aK6y72OpJrB8craV1ZA2iLhTFHVQDBt9Kdlo+mQQX8f2FDHD6M6Lu
         YdrFRYpIuFjRExECUleq9QF8pKEnkCBrOjOcHfUPJqbpcsN9XyM+tqTeDXKA+h8RVmOv
         2akQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaKjYAMqpyvK+U61N5asrk9p+jXoKm8yvSmE+sOEp35BC/0C9hceLbAUdpNzbCXtqbkgoVPrOLhkdBc2wXE78y62ZZ8/fZvHE=
X-Gm-Message-State: AOJu0YwC8u+6fljpIVnwc8mIqPDuipLi2gr82rmU/euz9JQ3AAzERCie
	Wmit4reEcEbiXYf4Tqg3iyxLIhoxHtdPlSWbyyjXWiE32kXGAmg1UvO7o9T4tQ==
X-Google-Smtp-Source: AGHT+IGmv5LKc/rdRpi8Ra9/RsIMunAWATmlN37PMZ/4ZdYVF8yC6fAOhJyK+4vfrUac1BNWQewwDg==
X-Received: by 2002:a05:6808:1821:b0:3da:aae9:717b with SMTP id 5614622812f47-3dd299929c7mr6326564b6e.45.1723706984412;
        Thu, 15 Aug 2024 00:29:44 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:745d:58f7:b3cd:901f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a6d98sm524661a12.11.2024.08.15.00.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:29:43 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:29:38 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/7] thermal: qcom-spmi-adc-tm5: Simplify with scoped for
 each OF child loop
Message-ID: <20240815072938.GE350960@google.com>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
 <20240814-b4-cleanup-h-of-node-put-thermal-v1-5-7a1381e1627e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-5-7a1381e1627e@linaro.org>

On Wed, Aug 14, 2024 at 10:17:51PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 7c9f4023babc..19cdb98c310e 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -938,7 +938,6 @@ static const struct adc_tm5_data adc_tm5_gen2_data_pmic = {
>  static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
>  {
>  	struct adc_tm5_channel *channels;
> -	struct device_node *child;
>  	u32 value;
>  	int ret;
>  	struct device *dev = adc_tm->dev;
> @@ -982,12 +981,10 @@ static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *
>  		adc_tm->avg_samples = VADC_DEF_AVG_SAMPLES;
>  	}
>  
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		ret = adc_tm5_get_dt_channel_data(adc_tm, channels, child);
> -		if (ret) {
> -			of_node_put(child);
> +		if (ret)
>  			return ret;
> -		}
>  
>  		channels++;
>  	}
> 
> -- 
> 2.43.0
> 

