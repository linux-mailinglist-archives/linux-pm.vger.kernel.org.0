Return-Path: <linux-pm+bounces-8704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37218FE4CA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8E0284AE6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A90195397;
	Thu,  6 Jun 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRGQkBAH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4519538A
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671508; cv=none; b=Tj4SgFD0fugmcfBs9gNmQspX8kD6VbVSCzY3SaSuJ225cbldUyDgJLHSwAkF3T5x2yF6jPRUQ2MaGr5JXtysIBSCgmQGZVDtyOk1wCtUORjCJ3vla/x2N/MoPyLoA9ROjcOINFSGb4qtNl/cJ6ny19zESO5jN0uFcVAcbFir1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671508; c=relaxed/simple;
	bh=ZftVfaISYDUW/kUT3woHl6rH2FScfbgcr0GiyC6d54E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5erhno7X0XY5STs5aqY2RqxrpeOt1Hiy4yI0XfZgQzjT8/SboWU46frqUWlVFqLDJnSuIvOfQhQnBniZTqw5f011yZkDxDcY8DhYAP0MuL7E7U8ksjaADsjwXlfgdxbgli8gJwiaZj+O5greu5gJ5GaLukkmiAWxDsNyb/yx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRGQkBAH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70276322ad8so773538b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717671506; x=1718276306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ruAkQ6oEawGzBgH/lU0TOJn1AL8q+mkUlNk35sZfO0=;
        b=jRGQkBAHjSrNXcdphLyAvBTnMd+vrDF2dvNjoYFVsm4P8RruGAIvsMFI2+1XAGAo0t
         WiFiJJ2FeJ4xVQ+HtfpMGf6+uC4KbWRDhbuZIPDpgNtor9j96e6AJkwooV2T+U5E39eG
         xcoWtbXy1xkBY9ciBIsMChrg2sbPekTKzShPnwhrXsHqESYLbul9AzTbqyx7GhGrW7Jt
         R5T8z6XMt4JJUiZHISvExEcM2kyzSmKSkh8ErETz0uOaRo2dfwjQddrLGMEMige/5cmy
         J4prUhd2rF0YWbqUA7iZR7ads87bA2Ugf0dnJkApWI/+PjjK6cuAgTyYNFKckhMd0o7h
         4EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717671506; x=1718276306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ruAkQ6oEawGzBgH/lU0TOJn1AL8q+mkUlNk35sZfO0=;
        b=J4tKOl0xycQSy3oVnxWEsfW4UF9xuV5bwIHHtpGXGBNCOvixmYLzdIxJBm6/9a+1hq
         nyaF6WdFqH8ku8vh2agNts9Lrpa/bWK9oD1E/tL/Al8b6DpqH3qVoHhTShk+NVQGIAgY
         xcJw+ez3FVHI0d5kSytgGyp/G4HCuwzgdig9N5kupcJ2XX5tZ7lnQ+fnyRnwmXwweeJm
         HFUyCtZp/tRmOoy+Xcu6w8nmw1XgkWaSLHe1YC7ppvzOhY4I7REU2ZRFEOUH1raD5u8G
         6kJ2f+GZ+KIeKA/idBw+0sQBvx/KSIjfMaK7pzHmmKgMdayRWBedlCrP0HsfjZ9drmtK
         F7jw==
X-Forwarded-Encrypted: i=1; AJvYcCX/AHyyXnAyXlDZETwPwsP5lm9C0MuO5RMcHtqTR6/IHTspsXq3yKprdGLZuDaTvodpvPqtorVpOEyyGaHPn2tW7JpIHj0CErA=
X-Gm-Message-State: AOJu0YziKEcFsSMe3p7VuGaus4sIPZiUsEKb5N9x4i9SttCoImSzkChS
	y3DaHOT+Sq01Pa1UHu+qc948jXDDWqwEzsHNiTNcPvT+LVcaLxBMLz/albpYLDs=
X-Google-Smtp-Source: AGHT+IEyykOFtvqGDbkSW5sWldA9ne0lhoNR9r1NCjGXJVY06J2Fxl8+x7uCzXCMceSjSs/esbsRQQ==
X-Received: by 2002:a05:6a00:189f:b0:6f3:f970:9f2a with SMTP id d2e1a72fcca58-703e596472amr5682219b3a.10.1717671505861;
        Thu, 06 Jun 2024 03:58:25 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd396b0dsm887093b3a.74.2024.06.06.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:58:25 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:28:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
Message-ID: <20240606105822.a7giftun56dsnbgc@vireshk-i7>
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
 <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
 <ed06bac9-6396-426a-b0ea-4932bc5fa7ed@norik.com>
 <20240606094859.6yclnarvlrzl74bj@vireshk-i7>
 <81919640-b0c4-437c-a04f-1673e8189435@norik.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81919640-b0c4-437c-a04f-1673e8189435@norik.com>

On 06-06-24, 12:34, Primoz Fiser wrote:
> > Ah, I forgot about the token that is returned here. I think the driver
> > should be fixed properly once and for all here.
> > 
> > The token must be used to clean the module removal part. Else if you
> > try to insert this module, remove it, insert again, you will get some
> > errors as the resources aren't cleaned well.
> > 
> > So either provide a remove() callback to the driver, or use
> > devm_pm_opp_set_config() here.
> > 
> 
> So basically, you want v2 with:
> 
> > diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> > index e3b97cd1fbbf..8a4bcc5fb9dc 100644
> > --- a/drivers/opp/ti-opp-supply.c
> > +++ b/drivers/opp/ti-opp-supply.c
> > @@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
> >                         return ret;
> >         }
> >  
> > -       ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> > +       ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> >         if (ret < 0)
> >                 _free_optimized_voltages(dev, &opp_data);
> >  
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index dd7c8441af42..a2401878d1d9 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -654,14 +654,14 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
> >  }
> >  
> >  /* config-regulators helpers */
> > -static inline int dev_pm_opp_set_config_regulators(struct device *dev,

Don't remove this, add a new devm_ counterpart.

> > +static inline int devm_pm_opp_set_config_regulators(struct device *dev,
> >                                                    config_regulators_t helper)
> >  {
> >         struct dev_pm_opp_config config = {
> >                 .config_regulators = helper,
> >         };
> >  
> > -       return dev_pm_opp_set_config(dev, &config);
> > +       return devm_pm_opp_set_config(dev, &config);
> >  }

-- 
viresh

