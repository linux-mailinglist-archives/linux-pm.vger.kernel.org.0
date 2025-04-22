Return-Path: <linux-pm+bounces-25904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50CFA96DCC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B4F16C8DC
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E3281535;
	Tue, 22 Apr 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4Nl9lbf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAE28135E
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330585; cv=none; b=CRiN43gkn/YR0vvCPnLwu05V71QuAhNh0r8sUMyp8n+gChWQHkyWdXvg+CZ5Elp+o85EmYhEVJGHej9Hpzo1s+FZDSnVbHp4rxJFtKLLaT2CGPciuFeroOKyl482pdBDdnoPGWpjBiZJ1WGqCvqwhD13lguWYh7vo/jfYV1eseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330585; c=relaxed/simple;
	bh=pTCnnE0WvBlnr+Qj0FbjHqO/pnVNVLaBdILZogWqmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wnxn3IiKurSmg0TblM6X1RvFEfMaxiirOsaw6GRjCE5VHkA/Q+eNZ4zlFuLHyDptbf1I5QPqw0TVXKiGBlB7nxwGQmJE9qDJqDGnbhrOobACI2Hmdm5q615fKGBQu+Fk5at1HBnkEsE27JPRB8v5K+TmMzT4RPmivTUmJaJA+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q4Nl9lbf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so891148766b.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745330582; x=1745935382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KGkwbFW8mc6saMp1e+KcFytRng7jGJzpGVkRT08ylU=;
        b=q4Nl9lbf6s0kTmZExW4LxTs9tPg9p2BwcXii+YbRetth2qIQfuvqCSj+oXQ3b9dkcq
         q297wnmCcJEser5zebgKlEfGd6+ui7zhcx5HJjmTC1+GR5eJ9VeKSiPlZAHLtRrBQZVL
         JvGY0z8JMeYeE1HcsZ1g3xwAAMWN/Tqsm4iI3Xrcpqvvb4W+DGgjlmySKIlxFxlGLdli
         vr89s6NPxOUfpcCbOSj6WbOovLtYKKCpJYl/+tdsPTHv92EemM7fzBBhuqIj8Q63xGJi
         e6Ocy7ENfriLmNiUbNhHeYGpC2kk//Zw5dZ0JpfjmcDvsxNPM48Mtn9EwqAv5xakcV7l
         RzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330582; x=1745935382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KGkwbFW8mc6saMp1e+KcFytRng7jGJzpGVkRT08ylU=;
        b=Vob76FqJ3hEUCZDFsE6faxpAnGFbybHWmmmBFJQninXsR9wW+C8aPtD/XOsP/Zmq5I
         8/Jphx+ea6TPbCqeuWUzUprgDq874826cRrWLYh0JBE81E9TZ7PFaMiLB7R2QWWedR/m
         9Qsi/RDQ5PjP6n1RfuqWEZsCfHzksXShnstR/IbNykhkmcNwUcN9PpZv0y2ueDQ+QhEY
         rOetiRxB9HdLpHRtk51dCaAUZI+DyhW4YlqpxYjHVwCUVJwAJU2rXcuBlhcSMsrNuvqm
         /r5+GAknAYDAa90ZNrDSp6lmBv+CC9QxTCJcakEgb6+l+gb/4xB7YMOsdFtHz1GFMM7e
         AIDA==
X-Forwarded-Encrypted: i=1; AJvYcCXNoGVdV4EUUebSN8fL01lhbbiMUDsPy3cNbDGfyWqKyGoINOFdilsQJRs6k8qWJrINvLGIOTyglQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WXWwN7y7/ycpeYuN4jFzNgrqBOVqeiedZNp2I+MCJr9YynRr
	93+WuzrwOCzN2bsBD7t/RWS50LDZ0Q4KRdMA8WzmExGactn/Z0PQVgONqPE50no=
X-Gm-Gg: ASbGnctA+9U106UZQCy3emQ7JVm9DYLzwRz1rAkxVaHnQN+U23TIYB7T9BDlZrSIntN
	8eMHcH7OF5kkxqxTu6lQwbLFF8Y63hI6DzExA4aQCtAtccgtjTI7Yel8QjPYzrd/KoWH4vP07WC
	U5LGcWIYz/13ygMzbQhu0dgf4VRyKqqkpOmtxjJNK2pDaWtOgPDq05CsLFgd0UKZU8HZ4Chmkjp
	bc/tGerICHogH9OoOGeDMesL9EEgq2y7W/H2gXuNhRcU6op8b+UHisAqscv4d1lHeva5jY1QCiB
	sRge3/OaIyRHgQ7UP9G44P6UcmebJzaKMjHDQg==
X-Google-Smtp-Source: AGHT+IGXA0LtNrq/q99iH88FAI+tkMr5/gDahnmnJo4DPlV9/CFoB+qZ83sOLLUpScdf873PzsLhew==
X-Received: by 2002:a17:907:c16:b0:abf:73ba:fd60 with SMTP id a640c23a62f3a-acb74b862famr1643280466b.29.1745330581391;
        Tue, 22 Apr 2025 07:03:01 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef9e7e6sm651907066b.162.2025.04.22.07.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:03:00 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:02:58 +0300
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
Subject: Re: [PATCH 04/11] pmdomain: core: Add a bus and a driver for genpd
 providers
Message-ID: <aAehkpXAxh3bI0WT@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-5-ulf.hansson@linaro.org>

On 25-04-17 16:25:02, Ulf Hansson wrote:
> When we create a genpd via pm_genpd_init() we are initializing a
> corresponding struct device for it, but we don't add the device to any
> bus_type. It has not really been needed as the device is used as cookie to
> help us manage OPP tables.
> 
> However, to prepare to make better use of the device let's add a new genpd
> provider bus_type and a corresponding genpd provider driver. Subsequent
> changes will make use of this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/core.c | 89 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 035b65563947..da51a61a974c 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -27,6 +27,11 @@
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>  
> +/* The parent for genpd_provider devices. */
> +static struct device genpd_provider_bus = {
> +	.init_name = "genpd_provider",
> +};
> +
>  #define GENPD_RETRY_MAX_MS	250		/* Approximate */
>  
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
> @@ -44,6 +49,14 @@ static DEFINE_IDA(genpd_ida);
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>  
> +#define to_genpd_provider_drv(d) container_of(d, struct genpd_provider_drv, drv)
> +
> +struct genpd_provider_drv {

I'd replace "provider" substring and expand drv to driver everywhere.

I think that's more in line with all other subsystems.

> +	struct device_driver drv;
> +	int (*probe)(struct device *dev);
> +	void (*remove)(struct device *dev);
> +};
> +
>  struct genpd_lock_ops {
>  	void (*lock)(struct generic_pm_domain *genpd);
>  	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
> @@ -2225,6 +2238,26 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
>  	return 0;
>  }
>  
> +static int genpd_provider_bus_probe(struct device *dev)

... and then here drop the "provider" as well.

Other than that, LGTM:

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

