Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6B2F9D9C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbhARLH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389341AbhARLHa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 06:07:30 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01314C061757
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:06:50 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p18so10690411pgm.11
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 03:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hF8evVGI9RRZx1GF/hLvIc76/vJir8iUDvWkskLLhsk=;
        b=lJ3e3XxEk/NoFVfGOAf3oI9tdt+xgWhbiDi5MSGlQrRg6Al1V9IofzBSoJ93tJjeTg
         150RfvM9gZd7nhNhWMhjX5/lGqF+nj+vPbswtpE9PaCiLuXI/MQdVpqSoQIKfhUZlE1N
         ZK3LW519SgxPOgbI6WoUyLw2BcL6Aw99UVyU5NIcyEbqZsHGnClDRffN+4gAt2pncH2w
         J7uKv53TNcyDAhH71wlAwN/EyfgsbsYKP8KdS1q+6jf39vQB2suWkMPF/rgptk0jqB99
         d9z94vr3Glq+543VqetbxRrzyzB7oPmOx/zrU5tEYsOt1YLQYBINZ38LM4QvMAGT5PKh
         hGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hF8evVGI9RRZx1GF/hLvIc76/vJir8iUDvWkskLLhsk=;
        b=FBUwTyBIKSN7hQ7GPM/4iB/rm+46HxkAmpsoRHYw1ttxb64VZWnzY2aSCvusCdvggv
         pKFQrSaTPVFZLB5iUeL4Tk50SQtxrXc0GwlycSPMQChzzXZ/6LXgloSY5FStbbubeyPB
         kV8gKlqvbnmEMi9aZDlx93UW0S8PrygYhwcl0HZp+8we5+rXD3bqWPakV9W7cXIDrCVO
         oYv7pBtbnXVTjmN1OxIDIGPCa1U718MoEebNjImtpfyFseVbGocHHgBpwTSGuNj0BVA8
         jHgxnZ66ZjToaPRBRUB8bRVo33EBRmvAzUmlCiw+VdGoWKlP/QGwAgU7Km8Q/9PAP8yZ
         Bdow==
X-Gm-Message-State: AOAM533+ml40WS9HxJF0jmB7JRWYSQ7JBlZg/cDYM6ImI0C/JrtUt2vt
        muBdEgqbMBLN5pG4VjP8FwUSUw==
X-Google-Smtp-Source: ABdhPJwuLWRbz4a61aSCqABub+Be14J1PCrBXuBkLL43LPK8J4dcu4SD55H38N5RI7el+dvrZUeXYA==
X-Received: by 2002:a05:6a00:847:b029:1b3:b9c3:11fb with SMTP id q7-20020a056a000847b02901b3b9c311fbmr14956958pfk.44.1610968009522;
        Mon, 18 Jan 2021 03:06:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p9sm15682274pfq.136.2021.01.18.03.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:06:48 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:36:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 04/12] opp: Add dev_pm_opp_sync_regulators()
Message-ID: <20210118110647.msuo4r2nvq6sentc@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-5-digetx@gmail.com>
 <20210118110029.sjczugppsvrxd2tl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118110029.sjczugppsvrxd2tl@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 16:30, Viresh Kumar wrote:
> On 18-01-21, 03:55, Dmitry Osipenko wrote:
> > Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
> > voltage state of regulators.
> > 
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/opp/core.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  6 ++++++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 7b4d07279638..99d18befc209 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -2686,3 +2686,48 @@ void dev_pm_opp_remove_table(struct device *dev)
> >  	dev_pm_opp_put_opp_table(opp_table);
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
> > +
> > +/**
> > + * dev_pm_opp_sync_regulators() - Sync state of voltage regulators
> > + * @dev:	device for which we do this operation
> > + *
> > + * Sync voltage state of the OPP table regulators.
> > + *
> > + * Return: 0 on success or a negative error value.
> > + */
> > +int dev_pm_opp_sync_regulators(struct device *dev)
> > +{
> > +	struct opp_table *opp_table;
> > +	struct regulator *reg;
> > +	int i, ret = 0;
> > +
> > +	/* Device may not have OPP table */
> > +	opp_table = _find_opp_table(dev);
> > +	if (IS_ERR(opp_table))
> > +		return 0;
> > +
> > +	/* Regulator may not be required for the device */
> > +	if (!opp_table->regulators)
> > +		goto put_table;
> > +
> > +	mutex_lock(&opp_table->lock);
> > +
> > +	/* Nothing to sync if voltage wasn't changed */
> > +	if (!opp_table->enabled)
> > +		goto unlock;
> > +
> > +	for (i = 0; i < opp_table->regulator_count; i++) {
> > +		reg = opp_table->regulators[i];
> > +		ret = regulator_sync_voltage(reg);
> > +		if (ret)
> > +			break;
> > +	}
> > +unlock:
> > +	mutex_unlock(&opp_table->lock);
> > +put_table:
> > +	/* Drop reference taken by _find_opp_table() */
> > +	dev_pm_opp_put_opp_table(opp_table);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index c24bd34339d7..1c3a09cc8dcd 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -162,6 +162,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cp
> >  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> >  void dev_pm_opp_remove_table(struct device *dev);
> >  void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
> > +int dev_pm_opp_sync_regulators(struct device *dev);
> >  #else
> >  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
> >  {
> > @@ -398,6 +399,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
> >  {
> >  }
> >  
> > +static inline int dev_pm_opp_sync_regulators(struct device *dev)
> > +{
> > +	return -ENOTSUPP;
> > +}
> > +
> >  #endif		/* CONFIG_PM_OPP */
> >  
> >  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> 
> Applied. Thanks.
> 
> I had to apply it manually, please make sure it looks okay.

Sorry about this, I wanted to reply to
"opp: Add devm_pm_opp_register_set_opp_helper" and replied to this one
accidentally.

-- 
viresh
