Return-Path: <linux-pm+bounces-13889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757DB971B7C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC0288028
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CBF1BAEC6;
	Mon,  9 Sep 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="seVRIdNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF11BA27C
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889563; cv=none; b=GpWQ9OX7vEIuBGS418S3K1HwfhulDxRatIbtdvhd+PTrU6q7FP2e+BQ7WauoiTCSQ1qviLLucWppECv4cX/HuLIA5l+pD8Ecod5cbtRh/ex2DWxqzDZn/JqezM2xowKPupRKh6wVC9+iP5qI4a0WaA+V1suEYfkwv84hdH7N5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889563; c=relaxed/simple;
	bh=jzihi3AAHohMCS8Dgz06LgVPmIDnmeWhSRP3zVQyAG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bopT8mbSxx8Jsthm1Dz7MscEG4LhYRWdHBHLy1xwVwfOd4Vei/r1b+Z5sxV1TotcpiRa4KsWTlORnHxeEPFeOwEPgIgtBS9CQ1P9aCvOWxE+16XLX8Di+OHZrrSH6uEuuFuDQ6x/EIbqkpfYbJG+NDuocIf6vJiA/d2l2CHpEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=seVRIdNv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3cdbe4728so4197343a12.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725889558; x=1726494358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICHhUdve8YGyfEsZ3J3BPheEBsB760qWMEEBxUepSFk=;
        b=seVRIdNvLmKA0h7bIqZTZ0OrjfVDSdOaKIkLt2MYRdj3bh9YzwqsVN9NuneIiJ1mjc
         j1F0FtkC3PNqxChLIbnEbx8fCF0Qnu6L/1vVmz3kXnZyVmFxj8OWoSs1jc1lUhTB9tGU
         i6KC0/VxTH2nmZfcrvWFYkL+SlRHpA/uRqwbxbZRSeWexCn+8yoZyNo+mYVi5MBwW3iO
         JuIG6IfN8U5CKW2P6xI8ITaDRe5sAs9slIpOYi/fZfsLg2YVWtfOyg5w4DSp+QDwfy+m
         cvuQq3ORtWUsDpkkj43c+JQvfpF54GLe2Q3Or4/RD/iBo0SWzFriah0G+aHMhETq8G0W
         HA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889558; x=1726494358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICHhUdve8YGyfEsZ3J3BPheEBsB760qWMEEBxUepSFk=;
        b=D4sYDjXPCkqU9SGcXp4rmw9C1XHZJA5w/Ge8488PXIVl/FZ2xPtvHrSLm3xQmbrEaw
         0cDprdgO7QhDyuItcwE3+VB7yNcRY4r3caQrZDMgrFvID0JD7HzIpSU1OSQmCA0J+09Y
         zMWOcUuWVJbHq/wJr+Yh2ItvKsDnpMwuwws0bfQP1gB3Mb9DBoEEMiB4vpGtVJlTQfpo
         hn9HQ7vqeJi8nmzhYATUHBkHLcohT7hyt2j00w3BoGWTSUBCh3lEfcytfvJ70ZiYQdwV
         qD86GnUvNaLtqHESTCVNWd1l1Dnl5bca+gc1MrlYwqKhtShlMwFvKZ9Y6603s6VU3CTp
         St6w==
X-Forwarded-Encrypted: i=1; AJvYcCXfwpDSRWzjUlJGAlO7cJnWsqXey9m+suEV7AlXkfEPr5/1jXKe6eWWa05ip9WWTC0SLoR73wyh6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfz+NbG0/OvpVIz4568AGZn0PyXzzvCwlMx83ANWR8qCb2kkxF
	RS/oS+U7R5fTeLl6nn3FmmV1YNnkPruFpzADjIhAl8UVqErjrTZY7BW6CHtGpvVWcbop2myPmZF
	O
X-Google-Smtp-Source: AGHT+IFSoHDLd5CxoOPYrLPB59BFyKQbFAvz3qMC62eNkL9xiTGIxxXZg05l93GHxJb2ToC1z/SlNQ==
X-Received: by 2002:a17:907:2d9e:b0:a8a:91f4:fd30 with SMTP id a640c23a62f3a-a8d2494b9d8mr642973166b.56.1725889557837;
        Mon, 09 Sep 2024 06:45:57 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c80a24sm345022366b.137.2024.09.09.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:45:57 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:45:56 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] pmdomain: ti_sci: add wakeup constraint management
Message-ID: <rtdegcb5ypszuoqgc4rwcp4vo6wpkybfreo5of4pxxw3lr2qrk@uvhwbiq4mmmy>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <20240906-lpm-v6-10-constraints-pmdomain-v4-2-4055557fafbc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906-lpm-v6-10-constraints-pmdomain-v4-2-4055557fafbc@baylibre.com>

On Fri, Sep 06, 2024 at 09:14:50AM GMT, Kevin Hilman wrote:
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
> 
> Note: DM firmware clears all constraints on resume.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index bb95c40ab3ea..1ab1e46924ab 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -74,6 +74,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>  			pd->idx, val);
>  }
>  
> +static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	int ret;
> +
> +	if (device_may_wakeup(dev)) {
> +		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +							       TISCI_MSG_CONSTRAINT_SET);
> +		if (!ret)
> +			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +	}
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -115,6 +130,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>  	if (ti_sci_pd_is_valid_constraint(val))
>  		ti_sci_pd_set_lat_constraint(dev, val);
>  
> +	ti_sci_pd_set_wkup_constraint(dev);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.46.0
> 

