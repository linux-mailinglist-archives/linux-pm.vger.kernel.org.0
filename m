Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D03FD272
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 06:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbhIAEkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 00:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbhIAEkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 00:40:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92764C061760
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:39:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so3699373pjw.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvaBF9xrlfAeRbD51NELLwVWin4o3Iv3FXz6EIQpIrY=;
        b=WaA1AzODpdKHlt9or5QsSCmV6Svr0Lh51m4LHfeE9MHJFPM8ol1Tshar4EURAFjwcN
         UHny/pM4YZroosbRwESMY565MnwWmAdchphRtZ+QaNX785dr2kH01PuvRr584UyJ9RwB
         UNV2pZzI+j3QlkEYkb0yY+JBmof9TCH1537zxMZiLS2vRMHszQrMBfFDt15g83UKqgFp
         X8ed8VXo1Klg5hKA3mgZsEZPbA1PMrnOnHDCYpSc5J/ohzNyBXtQ9FSyEqSeVL3LfMEh
         ex/LJ+HLlCu31kevfzzrqflfkavGuuM4fVaD1874UEV85ZvmWEYaXOdpkLWveGdjbhtC
         W1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvaBF9xrlfAeRbD51NELLwVWin4o3Iv3FXz6EIQpIrY=;
        b=MUs8/n5kmHqQ26TAbD5KnLFjcIhvYY9D0ukdUNxkZWoHZQU/QYFdloemVf39o2b9aP
         76aIpMsE/g7rvbcEsYx+elK1tAVvY6dz6nQgQCgH04OiUKTSF3BLJs5m/VjbVbNdn7nK
         6QlPa/OjjEOfCXmY1dpwU819DMtqcysG1R8aq4yD3tRXyoj1vnOWB4g+w+ybINsxTIlp
         GaKfH84VfozxEjKKgdM5pcpdSXrdEkgL5P0/4RM+qEBQhq9K5AS2a7Ry8ASUkq/J3Ali
         cINZqY2eZ6F/nZoPD8hose25SvTp7mlB5y87JnRigZpzeS5hJ+XvdQz5YlcQD8uMQxJU
         gqag==
X-Gm-Message-State: AOAM531P63wbmnGOzAhhq/JrDGkQXs463Sdq1E9yhqXm1ne06+ovT+jN
        Rs5JNSMWJ7N0G+OppvkdgXkQMA==
X-Google-Smtp-Source: ABdhPJy3ys78m+AC28oPozK6NBJEFTf3SBJ1vEM4cQTRLcxia5ml0Rorw4u1yBx8gm8l8EtB3N0/ZQ==
X-Received: by 2002:a17:90a:6d47:: with SMTP id z65mr9457555pjj.62.1630471196057;
        Tue, 31 Aug 2021 21:39:56 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t15sm22028653pgk.13.2021.08.31.21.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:39:55 -0700 (PDT)
Date:   Wed, 1 Sep 2021 10:09:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 1/8] opp: Add dev_pm_opp_get_current()
Message-ID: <20210901043953.va4v3fwgs6ldtwar@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831135450.26070-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 16:54, Dmitry Osipenko wrote:
> Add dev_pm_opp_get_current() helper that returns OPP corresponding
> to the current clock rate of a device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 43 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 04b4691a8aac..dde8a5cc948c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -939,7 +939,7 @@ static int _set_required_opps(struct device *dev,
>  	return ret;
>  }
>  
> -static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
> +static struct dev_pm_opp *_find_current_opp(struct opp_table *opp_table)
>  {
>  	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
>  	unsigned long freq;
> @@ -949,6 +949,18 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
>  		opp = _find_freq_ceil(opp_table, &freq);
>  	}
>  
> +	return opp;
> +}
> +
> +static void _find_and_set_current_opp(struct opp_table *opp_table)
> +{
> +	struct dev_pm_opp *opp;
> +
> +	if (opp_table->current_opp)
> +		return;

Why move this from caller as well ?

> +
> +	opp = _find_current_opp(opp_table);
> +
>  	/*
>  	 * Unable to find the current OPP ? Pick the first from the list since
>  	 * it is in ascending order, otherwise rest of the code will need to

If we aren't able to find current OPP based on current freq, then this
picks the first value from the list. Why shouldn't this be done in
your case as well ?

> @@ -1002,8 +1014,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>  		return _disable_opp_table(dev, opp_table);
>  
>  	/* Find the currently set OPP if we don't know already */
> -	if (unlikely(!opp_table->current_opp))
> -		_find_current_opp(dev, opp_table);
> +	_find_and_set_current_opp(opp_table);
>  
>  	old_opp = opp_table->current_opp;
>  
> @@ -2931,3 +2942,29 @@ int dev_pm_opp_sync_regulators(struct device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
> +
> +/**
> + * dev_pm_opp_get_current() - Get current OPP
> + * @dev:	device for which we do this operation
> + *
> + * Get current OPP of a device based on current clock rate or by other means.
> + *
> + * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
> + */
> +struct dev_pm_opp *dev_pm_opp_get_current(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +	struct dev_pm_opp *opp;
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table))
> +		return ERR_CAST(opp_table);
> +
> +	opp = _find_current_opp(opp_table);

This should not just go find the OPP based on current freq. This first
needs to check if curret_opp is set or not. If set, then just return
it, else run the _find_current_opp() function and update the
current_opp pointer as well.

-- 
viresh
