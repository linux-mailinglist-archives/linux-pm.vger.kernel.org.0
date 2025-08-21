Return-Path: <linux-pm+bounces-32794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C9B2F399
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F594B61678
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362162EF66E;
	Thu, 21 Aug 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhKs4JyT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AB02EF647
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767844; cv=none; b=GIPku0CWL9tu2BTn15rXWNWC7eQHpJmXu4dB4Q6F9iDMSSB47ok2yxbrA+89idn3Y5EVXMRHxrbv0xKRwpvcti+kLxtfHzsIlz9sVptNDS6cBtobKDfG8o1iPSFpkcEng5IOflVnUOP0L57MABQ+HlgsanRkPCf7hoAMtGV5BXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767844; c=relaxed/simple;
	bh=f+A/i3bR5ISOezI/sppQsmMZuL47OcJ2YdUaWhHzuYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCwfTlBE8lZCziSOCc3SROAqKrYyh94D+hhxvpPdCRD2ntyNPdUPL3GxjCEi/vs106wqk3YzePE4rf/io2xbl2R7b9NKncv33Lb3A8EhxYj6Cu1Afd0+vGhG3x2NsxSx0/sgfPaM2zn1bqjo0iqOXrpd/AO6fd9XfDxLaRKjItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhKs4JyT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-246151aefaaso1806355ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755767840; x=1756372640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ1EY1hPDVOro5O3UrQaYb9eHNygUaCfbat5MCnKEpk=;
        b=JhKs4JyTusPMrTCcwkPJ1zECgKeY6X5o5Ij1hbPfGH4cH7letWw6eeDgJUrVKTRQQn
         HSa6MvVuEzjSDHEEIHBkuLgFMmQDwwqr2Afc9urjH4Fl7KGwVbzR4h9q/lkwOjftHFkJ
         9o/tibE/JPLs9LCnp+PXZsCA06rjfaAXrBMUYvwq93yubNXesse9PoEEncLHyDfrZp6F
         +31Djco5psW+HI+WoU7ptkd1g79RHjKy6C7K86URtfmD3SQbVuSlwjt9CnEEdkD9/5lK
         aWMGDHoBdLgTOP59VdnC5pfvj/7eA/UVblotMbzJNA2a4IhSW7og8cLYMjd9L+Rs+p57
         QGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767840; x=1756372640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ1EY1hPDVOro5O3UrQaYb9eHNygUaCfbat5MCnKEpk=;
        b=jh9yOZKIAOYIDw9/3v+hLV8qrGiwSIWwEPrVFyy6cItEMpV5+bGSVGOLbqUPsrd5qU
         CwZeTJBnXRtOxXQoOSbaSjuYTe+D8aw08Qd4IY6lU7MSXXdWQ5XwxmoHOQzfSpe+qsry
         AsD3+2hUqD16FQQ8JKj3vzQitDCnRGkIiBt3835ul7A4Uovz4WMYIpwiokdBSSUZlAF8
         PDOQt4mZSoM+JLb07n6X3pmNS1UepTtOZ/n8Wdel34p2rRKNu1bx9Z5OLtwDhUJpVa/h
         SnMcIQ+KZ6UeODG46V6YzQxKASF73jDsifkKFJhSFS4zu7dlTmJV89DvOTjCEy8Wejlf
         ye/w==
X-Forwarded-Encrypted: i=1; AJvYcCUNO17U5qziCWWTsCIgwS3vSmtyM5fCeuPHLYMfNooZQtbfRqXZjktbdFoiaynWxM4rmeie/+6Zhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqdj0zljI+0edHxvGhGFJ43WJUIvrxn1GPdcqlaLRz0tIyjECA
	v6snCzRf4Q5gNe/ZEXQAfydFf4CzG7TwMdHmf+ivu1cGYfwSb3NbOY5YyMefCaSGE0U=
X-Gm-Gg: ASbGncsgAAfqNQ2BAadCtFmTy+x4Gu08LtpJ8DtstOGrl0i0xQKtpCGKO/Wl9C5ClqN
	4kUO1c6nZiJLd7zl45YRI24jnlnlepG+DWS05a9M6u0wUiD3fP7xoGN2qMZ8cI9D/36+FYLTZ/i
	dumUYUdR4gcDBybnDXUtBSpJeWNwTKa4aMf1MWaSpXCYXo4JHCK1HGif/khjheZrMDjqz79/Pkn
	iLo3PfoDgtE6lwyN+zPQ0PPQrBs3lNpJYdcz1AacIU5iSVGn2HolRFGy/bGlvq30oKDeED4roRm
	4PXSj3UfDiwwUd3fCkCHObhZ8cSyS0BXHpte7xwlPe0rEZ2rOJUli3ev31mKmzVTtSSuE+opTTA
	bWBghHpV4WZ3RRCKcjkyfiFZcVAiKIMXIMhI=
X-Google-Smtp-Source: AGHT+IHMF3tjK6S0GPTNw3RdPrAfiT61SZT/HliL7uh12owm90LocC10fCZ2Chb6bAuDk+kOZRD8zg==
X-Received: by 2002:a17:902:f688:b0:242:fea2:8bf2 with SMTP id d9443c01a7336-2460238be3fmr24757025ad.5.1755767839877;
        Thu, 21 Aug 2025 02:17:19 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f38ab988sm39467585ad.124.2025.08.21.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:17:19 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:47:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821090020.167786-3-zhangzihuan@kylinos.cn>

On 21-08-25, 17:00, Zihuan Zhang wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a067b5447fe8..92633ff2c4f3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2908,6 +2908,8 @@ static int cpuhp_cpufreq_offline(unsigned int cpu)
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  {
>  	unsigned long flags;

driver_data can be NULL here. It is checked at a later point.

> +	bool has_setpolicy = driver_data->setpolicy;

This is a pointer and ..

> +	bool has_target = driver_data->target_index || driver_data->target;

.. this is bool.

Their comparison will always fail. Did you actually try this with both
setpolicy and target() set for a cpufreq driver to check if it really
fails ?

What you need is:

	bool has_setpolicy = !!driver_data->setpolicy;

>  	int ret;
>  
>  	if (cpufreq_disabled())
> @@ -2921,10 +2923,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		return -EPROBE_DEFER;
>  
>  	if (!driver_data || !driver_data->verify || !driver_data->init ||
> -	    !(driver_data->setpolicy || driver_data->target_index ||
> -		    driver_data->target) ||
> -	     (driver_data->setpolicy && (driver_data->target_index ||
> -		    driver_data->target)) ||
> +	     (has_setpolicy == has_target) ||

I would rather do:

	(!!driver_data->setpolicy == (driver_data->target_index || driver_data->target))

>  	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline) ||
>  		 (driver_data->adjust_perf && !driver_data->fast_switch))
> -- 
> 2.25.1

-- 
viresh

