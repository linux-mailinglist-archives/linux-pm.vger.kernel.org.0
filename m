Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B710E2E345D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 06:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgL1FiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 00:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgL1FiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 00:38:22 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A7BC061796
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 21:37:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v3so5110541plz.13
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 21:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zegu0X9sZDxNvLaLEb6B1P2y6YF1mpAuGwZH8pLcUFA=;
        b=kGu4z+nkVQp+gc3xdhla18BclFTp67yzoxD+9RMY/GNIXQuJexMdOsKGqMSyUf1E/l
         5CB7kIpM6JGNNbciDg+zesEBaWdz1pBhFlY7EJdHT1T+liJT84FxCNu+mMoBZeWEkzJ6
         Q52JQkCXPH4rhP8Y3QYUtl/ZOCyEeePFYh74dpzixQjAYGJzhX0cD3gFD3E4Eid1d7Cx
         dbWFydxsZnVIzQxYWP6sy6nbUdVlaeyP3LjdaasrPTmMxEQNIXRasuR6qjl9MS/p7E33
         gSVdelpIQSxrGGuumL9cdg5LYxRoRR5Z2A6zoM3Tu5mCXTZu/cfiGCDdoolQJxZB1rfa
         axIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zegu0X9sZDxNvLaLEb6B1P2y6YF1mpAuGwZH8pLcUFA=;
        b=Ex+9WAE65wtXsYrIqGHXG7lcsXuZAxrTcv38Z4JSzM109YnBZq9apa9ETozFKr7rd5
         qEJn9z/bYLNbqIM0OyG1pfXGTfisMUmxzhUEcxvKQdPQq/VORJfCBufR8dS6V0uE/8zB
         rw1UfRBOPpEXJk6z790eAYGjqUIy/ajpmCeQAphlh48ALFiaiSHfbP1XPusgOgIkpSPV
         ACOq7hh2b8ABilVpElLUhTq+DsMoygRvxrezvK+9X+ZCpiHt8liS7iUV0lD1UVSEism8
         YBYsOSn/QP4bnSCQb9WYsN0HJlqNMahbZxs7g5KpztxuCP1NJsp419pW66nlI6CHmv9s
         1YLw==
X-Gm-Message-State: AOAM530W0Oio3bTgVCnVm9erHPQRT9+NvcTJIeNheYkn82QKMRGJUaJO
        Ryk8uqbXzKy+uHrNo/pez2eCZA==
X-Google-Smtp-Source: ABdhPJxZONjSIasQCRp/1pDOfNWPBn0hTvHIEA8MIs0tOmtvQDHZvqlafaqvzNUcqKO4wHrWxx/3HA==
X-Received: by 2002:a17:90a:ee8e:: with SMTP id i14mr19562217pjz.190.1609133861327;
        Sun, 27 Dec 2020 21:37:41 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id d124sm36711730pgc.68.2020.12.27.21.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 21:37:40 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:07:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: Fix some resource leaks in
 the error handling path of the probe function
Message-ID: <20201228053738.6b6uaz2ipzjpwzet@vireshk-i7>
References: <20201219101751.181783-1-christophe.jaillet@wanadoo.fr>
 <20201222043505.rq3cmajc3mxv3p2z@vireshk-i7>
 <a7e1f78c-b4c9-4ef5-7ca4-94a65fefd299@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e1f78c-b4c9-4ef5-7ca4-94a65fefd299@wanadoo.fr>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-12-20, 18:22, Christophe JAILLET wrote:
> Le 22/12/2020 à 05:35, Viresh Kumar a écrit :
> > On 19-12-20, 11:17, Christophe JAILLET wrote:
> > > If 'cpufreq_register_driver()' fails, we must release the resources
> > > allocated in 'brcm_avs_prepare_init()' as already done in the remove
> > > function.
> > > 
> > > To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
> > > to avoid code duplication. This also makes the code more readable (IMHO).
> > > 
> > > Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > I'm not sure that the existing error handling in the remove function is
> > > correct and/or needed.
> > > ---
> > >   drivers/cpufreq/brcmstb-avs-cpufreq.c | 25 ++++++++++++++++++++-----
> > >   1 file changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > index 3e31e5d28b79..750ca7cfccb0 100644
> > > --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> > > @@ -597,6 +597,16 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
> > >   	return ret;
> > >   }
> > > +static void brcm_avs_prepare_uninit(struct platform_device *pdev)
> > > +{
> > > +	struct private_data *priv;
> > > +
> > > +	priv = platform_get_drvdata(pdev);
> > > +
> > > +	iounmap(priv->avs_intr_base);
> > > +	iounmap(priv->base);
> > > +}
> > > +
> > >   static int brcm_avs_cpufreq_init(struct cpufreq_policy *policy)
> > >   {
> > >   	struct cpufreq_frequency_table *freq_table;
> > > @@ -732,21 +742,26 @@ static int brcm_avs_cpufreq_probe(struct platform_device *pdev)
> > >   	brcm_avs_driver.driver_data = pdev;
> > > -	return cpufreq_register_driver(&brcm_avs_driver);
> > > +	ret = cpufreq_register_driver(&brcm_avs_driver);
> > > +	if (ret)
> > > +		goto err_uninit;
> > > +
> > > +	return 0;
> > > +
> > > +err_uninit:
> > > +	brcm_avs_prepare_uninit(pdev);
> > > +	return ret;
> > 
> > Maybe rewrite as:
> > 
> > 	ret = cpufreq_register_driver(&brcm_avs_driver);
> > 	if (ret)
> >                  brcm_avs_prepare_uninit(pdev);
> > 	return ret;
> > 
> 
> Personlaly, I prefer what I have proposed. Having a clear and dedicated
> error handling path is more future proff, IMHO.

I would have agreed to that if there were other things we were handling in the
error path, but right now we are adding an extra label, goto, etc without any
need. If in future this needs a change, we can always come back to it and update
with a label. But right now I would suggest to keep it simple.

> > >   }
> > >   static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
> > >   {
> > > -	struct private_data *priv;
> > >   	int ret;
> > >   	ret = cpufreq_unregister_driver(&brcm_avs_driver);
> > >   	if (ret)
> > >   		return ret;
> > 
> > Instead of returning here, it can be just WARN_ON(ret); and then go on and free
> > the resources and this needs to be done in a separate patch.
> 
> Ok, I agree (see my comment below the --- in my patch).
> I'll send a patch for it when the first patch will be applied, unless you
> prefer if I resend as a serie.

Based on the above comment from me, I am expecting another version from you for
this patch. So you can fix both the issues in the same patchset.

-- 
viresh
