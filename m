Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE575EB70
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjGXGYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 02:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGXGYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 02:24:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3479AA9
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 23:24:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668704a5b5bso3797963b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Jul 2023 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690179852; x=1690784652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jkouq14sPdmGQQvWC5kBlWLgWyZpawCkQ1jaVdtMMQ=;
        b=f2JwT4ha9NCO8vL3mBbvXRXQKbgJlDLBjGAZhgBQfxJikohuoYFW0aUOZvS8AVuVTQ
         p8wCBFU+MgZFbzD2naZRWEh7Uyhoq8+7wTLt8A2sT1TRU1GfRovm/1JxgYovCrTt9NA8
         k+MT/B9EJWaHV2H24vfOhHUA1qES+DvsZ95SVXEjf0BZKlQ0Jj/XD+vv8X67b8BRmEMA
         UOyIRxiP/Ka1m4Mzw5yIkIMnkCUT6h0VMcZFcduq1NOb7wPi0RCxb3VYWZoEmEXbrLs+
         S6kDsilHDgMGzqXQR9tp6MAZ0sDbm4kwH7TyyPNfCa7A3LJMBqUtHrpOTsoTkJN9g9Wb
         QRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690179852; x=1690784652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jkouq14sPdmGQQvWC5kBlWLgWyZpawCkQ1jaVdtMMQ=;
        b=E7Wecj2qiqYhW/pWFskq/WWuHB0OmF0zew/KxAz8xqgJlHVQIwKSyVJZdcbKZA9S07
         JItSIeIyNXxWy+aMEHcqTfVNOrQ41mLEV47oesXMUjMb3vhqjpdivLfsDUCHrZQ1UOyT
         zSL1ZCZioZZtlzPDCZKYejiNiYwIM+5p9TSU7AA8uIkJRRMcC8+fGcrNqNwPzxmJFd8S
         dNXysdxn+l5jEEGwK9dvmlkOFuzcIrAPkPrrR15e31Ls4fbwrZGABsvWVm7ji+OCe00O
         gF0tjdLmfSG06qoBSiQ/T0fyatpeRxypiC/RHyIN/W9Vc/3W/t6oCcKuxnuV5KFqUhcA
         Yuug==
X-Gm-Message-State: ABy/qLbkme5S4tpLM5Vg3QeZBZoksm1eUkLEFaRq5zngF8uOTEg6KvIQ
        /VGW40GloXDnybMpmjkQ8v+/
X-Google-Smtp-Source: APBJJlH13Gw1fHZB+AAqMuyyMyM9oAgKDec9/Me49VbxsiI5EMWSH7cBioFbRyg5DCwoCWSNbCZyUw==
X-Received: by 2002:a05:6a20:1d0:b0:130:11e4:d693 with SMTP id 16-20020a056a2001d000b0013011e4d693mr10118305pzz.53.1690179852632;
        Sun, 23 Jul 2023 23:24:12 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id jm24-20020a17090304d800b001b9cdf11764sm7971573plb.31.2023.07.23.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 23:24:12 -0700 (PDT)
Date:   Mon, 24 Jul 2023 11:54:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] OPP: Add dev_pm_opp_find_freq_exact_indexed()
Message-ID: <20230724062405.GJ2370@thinkpad>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
 <852a47c0e7a795bdf6424519ab7fadfdeb5b4a3c.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <852a47c0e7a795bdf6424519ab7fadfdeb5b4a3c.1689932341.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 21, 2023 at 03:10:57PM +0530, Viresh Kumar wrote:
> The indexed version of the API is added for other floor and ceil, add
> the same for exact as well for completeness.
> 

Well, "completeness" makes sense to me but I always heard that you should add
an API when there is a user. That was the reason I didn't add it in my patch.

- Mani

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 11 +++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 00638d40353f..7b1d5724b3d8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -648,6 +648,34 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
>  
> +/**
> + * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
> + *					 clock corresponding to the index
> + * @dev:	Device for which we do this operation
> + * @freq:	frequency to search for
> + * @index:	Clock index
> + * @available:	true/false - match for available opp
> + *
> + * Search for the matching exact OPP for the clock corresponding to the
> + * specified index from a starting freq for a device.
> + *
> + * Return: matching *opp , else returns ERR_PTR in case of error and should be
> + * handled using IS_ERR. Error return values can be:
> + * EINVAL:	for bad pointer
> + * ERANGE:	no match found for search
> + * ENODEV:	if device not found in list of registered devices
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + */
> +struct dev_pm_opp *
> +dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
> +				   u32 index, bool available)
> +{
> +	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
> +
>  static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
>  						   unsigned long *freq)
>  {
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index a13a1705df57..23e4e4eaaa42 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -124,6 +124,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  					      unsigned long freq,
>  					      bool available);
>  
> +struct dev_pm_opp *
> +dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
> +				   u32 index, bool available);
> +
>  struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  					      unsigned long *freq);
>  
> @@ -268,6 +272,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline struct dev_pm_opp *
> +dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
> +				   u32 index, bool available)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  					unsigned long *freq)
>  {
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
மணிவண்ணன் சதாசிவம்
