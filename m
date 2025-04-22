Return-Path: <linux-pm+bounces-25902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C6A96D02
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE8A3BFF1E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 13:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA961283CA4;
	Tue, 22 Apr 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpeggOs4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B7283C8D
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328839; cv=none; b=ixzBA+pOmJholg3JpkrqBPZpu8dN/6fMrL+UBh/eR/Egpsv40jsC+3AE+D2M/W5xWmoWrevmAaONw2KgCm6uPlQmSS4Fh3R2F/+zMQrkAaOlhh2gBm6mbqsm6R5UnYzbGukuOQMRzN2ZezTKuluIOAN5WPV6J+Rt7lWs/Kg1Uyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328839; c=relaxed/simple;
	bh=A3nvuiXOKYmcBoSdVozYUsuS9YtnZk6NJfCqb1EOxq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWbIgYQ7BCb0jjZokcSoREjxrb97lXBde3CYx3RZEXyB9jo//WNG0TPXZBH/9ZvRVRNV5TctxhnzkeFL9HfONphCen/uAffQYY7lJ702PlDFiuH7zhN1wp84QqolrJIaw8VdBmRYNNYXh9SE3O3hXYSvJsWlkvufnQWANRa9OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gpeggOs4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso7335506a12.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745328836; x=1745933636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znQWSnBTb9MK20iC93XcIJPZPEInkl0W50tUjysy1uw=;
        b=gpeggOs4fEbnDrKg7IkN2wU9yFFUamhVSEyn9gahOTUxoUd4HJcVrjgv6fP0brwNZd
         usXtqS9l7zRWGvjt/cuLFSYJC0ezoVHmik2Ew8u/bhqaM4E1L3OWgm+zuq9kGTtvTcap
         5aV+dNkYGL07Gm65WiX9apISdHuPQLHjbRMkavekK3tEwOL9177i4ZoQuZplFAzDuWff
         RvrvH6zs8rzQAy5e1VU6ZXXMafUUxfn+UxeAg64/YU8TtW1iGl5E2majsNCWqABIJk3B
         Vd/uw4c4Pk07E19s/28HNlbqwIZjolnn3Nj0j6dWAUTzUo3b1tmTiN9UmA72YMFONIvj
         7Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328836; x=1745933636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znQWSnBTb9MK20iC93XcIJPZPEInkl0W50tUjysy1uw=;
        b=qIlY+d0U6bOpq+v1+Z41pz3WDT6IEP1F0cYt5AJ1T2HdhluOwQ7eIAYQYSBO2z9hhi
         Xgbgbb9af2qDF1g6qVgavteY76ZgP4GVtihBrlbFETGD4jhWh4MTOxt2pQDfynONgScK
         0BtVLKG2LWuLH8BoBEr1j/ILTj3Q1gEBU/f4ZIsKn0S/6uoZ96+u0jUfHG870gdIUaza
         sj768/kAGAzndvkR1IIO19Y8F1dy27sTeqqOFPmxoPi+ty9JlzSRPqtjo7dXQJAqVA5X
         6+vB1cLPLwt8JQyKRO+xH6d+DTJ1AGRiVHtjhRruuVmmP9X15dVRO2ep4nfCScgeHgbf
         U/nA==
X-Forwarded-Encrypted: i=1; AJvYcCXsnKDkiaVnrlhXEZpQBA2K/a3MphMfjKpNtYwRbCxnAkiLDf6vBAuK4pIznW0jsOYdCsCHljFY1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9uFFGtn4IIM5Mhtls1pqYpHsJQBbRWCbHQ9VpSnRi6YxgNRL
	gOOVu/WRDBhPYWfe6FVoigh6TvQ1nygfsg4dPOuyiij+aOAEe3TzY+cIxuHQmx8=
X-Gm-Gg: ASbGncuycz3UjdmWd6D1uRi+mslrWTwHT6d1C2GtBnQFWwjN1kxm9+1+Ekm8yy/cNR9
	7hia3NgUkvRwu3TuDEkTPErKjNdNO4nvk9a8d/et2PYPxqpppDXXEkup66iTZKpPvNirWHQhDCJ
	/nkvyWYGRMowaf4SFyjNAznaEpm8nUS7nfWc4uaXXnl9cPlBxG4iPWh6h499roGZtbsLEXT+u98
	asbWTt4+2SxpMS43CoM2A6etRPx8Wgk03StAxnjnW1FAHgZ6xoEokmF8L0e8Rn5TcKNvcoEySxd
	ujv47P+YMN6T4KlZ+eDjvFku4XzhI7hnQP1QWg==
X-Google-Smtp-Source: AGHT+IE1EtI1OOrrlbCcIfrU7oXR5x9XYZy6CrWuNjgB3jJjWKKJ4o/3rgwpzceFXX9Gk9S9IWierA==
X-Received: by 2002:a05:6402:4404:b0:5f3:f04b:b5d7 with SMTP id 4fb4d7f45d1cf-5f628578024mr14149274a12.18.1745328836222;
        Tue, 22 Apr 2025 06:33:56 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a3f7dfsm5892419a12.79.2025.04.22.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:33:55 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:33:53 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] pmdomain: core: Use genpd->opp_table to simplify
 error/remove path
Message-ID: <aAeawWlODYM2w+xm@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-4-ulf.hansson@linaro.org>

On 25-04-17 16:25:01, Ulf Hansson wrote:
> While we add an OF-provider we may, based upon a specific condition, also
> assign genpd->opp_table. Rather using the same specific condition in the
> error/remove path, let's check genpd->opp_table instead as it makes the
> code easier.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/pmdomain/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 34a85bf347ad..035b65563947 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2343,6 +2343,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	genpd->provider = NULL;
>  	genpd->device_id = -ENXIO;
>  	genpd->has_provider = false;
> +	genpd->opp_table = NULL;
>  	genpd->accounting_time = ktime_get_mono_fast_ns();
>  	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>  	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
> @@ -2617,7 +2618,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
>  
>  	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
>  	if (ret) {
> -		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
> +		if (genpd->opp_table) {
>  			dev_pm_opp_put_opp_table(genpd->opp_table);
>  			dev_pm_opp_of_remove_table(&genpd->dev);
>  		}
> @@ -2697,7 +2698,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>  		genpd->provider = NULL;
>  		genpd->has_provider = false;
>  
> -		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
> +		if (genpd->opp_table) {
>  			dev_pm_opp_put_opp_table(genpd->opp_table);
>  			dev_pm_opp_of_remove_table(&genpd->dev);
>  		}
> @@ -2729,11 +2730,10 @@ void of_genpd_del_provider(struct device_node *np)
>  				if (gpd->provider == &np->fwnode) {
>  					gpd->has_provider = false;
>  
> -					if (genpd_is_opp_table_fw(gpd) || !gpd->set_performance_state)
> -						continue;
> -
> -					dev_pm_opp_put_opp_table(gpd->opp_table);
> -					dev_pm_opp_of_remove_table(&gpd->dev);
> +					if (gpd->opp_table) {
> +						dev_pm_opp_put_opp_table(gpd->opp_table);
> +						dev_pm_opp_of_remove_table(&gpd->dev);
> +					}
>  				}
>  			}
>  
> -- 
> 2.43.0
> 

