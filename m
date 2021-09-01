Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EB53FD452
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhIAHRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 03:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbhIAHRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 03:17:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E15C061760
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 00:16:58 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x4so1882541pgh.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 00:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fK1hxzGPP+bRHVx+JgiIY9qnUBt2WSwxa8uxIoUSUjk=;
        b=rwa5g+l6jUuwr8ituGkSlLBoLGT07VYq2buj0bN8iLhrddET1atpcndaUqcz3llVYD
         Xn3c/EGkgR7lHBQ9vU4yOcVTisK6aL1Ytl7pjwiLrh3HC6Rlvx8RCnlydidOO1IzKBCe
         y5tkw3igDB+S1Kqu85tCapWzJsve6mopa5hy8bEGtveI55wxbQ/W4vd1I1ZrYR/Jm+dU
         R8B+V4RtFErDjwGlDZUX/xzlSLPY6GZojQGXxanC2o+iMlVbHYUYPpp2DnpHg2mxmrHS
         XaulLpTm7trS2CSdxakUTacmaWcEkXfEA61rX7L4T1dsfSGb4JyAyGApBhCgphtHbDRJ
         WSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fK1hxzGPP+bRHVx+JgiIY9qnUBt2WSwxa8uxIoUSUjk=;
        b=H2yQULAjsWdyflrk5qw+VKUcXg3lox3zgXaHUHXTbd4E8rM53IHU60ALuBW/0x4h0C
         EqIfIOU+Fml05Xz6k5JbDAqA415v92/acW0bY3XHsd/s2mnw6/Mexb6rXhOLIapoZUxE
         wXPUhDjQCdEneKsXIyw19R+ZQODOp7kfQcR47jRw/o60kJgH8mJxmre/ZEIu+MiG1XF2
         4IyU5uHuXyDk392hYXkyEOpCr2bEQ/6zXqStjjenb9dPBGdGyzB9CrZrhbree0DBFJn7
         pVJpFeXOv9/3Ij+ipvb0j/oe55uzZbCjBN/T9wcziArFDp4eE29gNnAvg5OlwEsEGERH
         aqzw==
X-Gm-Message-State: AOAM533iBVe7T01gnmFQDdAOJRA9SIuUzlyscJTEvJ1H9EVv9W70zVwq
        Ci7oo/QRemp57smkhGe6/mQMVw==
X-Google-Smtp-Source: ABdhPJymhkj8MgaZ1wwWze96evwPJrZV6MvOLCZbsHYlnr8SdHRIUnwaXQoRe8la8qscdqGhp/EICw==
X-Received: by 2002:a62:920b:0:b0:3ec:7912:82be with SMTP id o11-20020a62920b000000b003ec791282bemr32461929pfd.34.1630480618067;
        Wed, 01 Sep 2021 00:16:58 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j16sm20731066pfi.165.2021.09.01.00.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 00:16:57 -0700 (PDT)
Date:   Wed, 1 Sep 2021 12:46:55 +0530
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
Subject: Re: [PATCH v10 5/8] soc/tegra: pmc: Implement
 dev_get_performance_state() callback
Message-ID: <20210901071655.gf6qg7piisddg2a3@vireshk-i7>
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-6-digetx@gmail.com>
 <20210901061050.4x3t4cc434zdwx3a@vireshk-i7>
 <7f4f5ab0-cf23-3e27-211e-4dcd8903f96f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4f5ab0-cf23-3e27-211e-4dcd8903f96f@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-09-21, 09:57, Dmitry Osipenko wrote:
> 01.09.2021 09:10, Viresh Kumar пишет:
> > So you create the OPP table and just after that you remove it ? Just
> > to get the current OPP and pstate ? This doesn't look okay.
> > 
> > Moreover, this routine must be implemented with the expectation that
> > the genpd core can call it anytime it wants, not just at the
> > beginning. And so if the table is already setup by someone else then,
> > then this all will just fail.
> 
> This is not doable using the current OPP API, it doesn't allow to
> re-use initialized OPP table.

That isn't correct, you can call dev_pm_opp_of_add_table() as many
times as you want. It will just increase the refcount and return the
next time.

Yes, you can call the APIs like set-clk-name or supported-hw, since
they are supposed to be set only once.

> The current limitation is okay because genpd core doesn't call
> routine anytime.

Yeah, but is broken by design. People can make changes to genpd core
later on to call it as many times and they aren't required to have a
look at all the users to see who abused the API and who didn't.

> > Can you give the sequence in which the whole thing works out with
> > respect to the OPP core? who calls
> > devm_tegra_core_dev_init_opp_table() and when, and when exactly will
> > this routine get called, etc ?
> > 
> 
> gr3d_probe(struct platform_device *pdev)

Thanks for this.

> {
> 	gr3d_init_power(dev)
> 	{
> 		static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
> 
> 		devm_pm_opp_attach_genpd(dev, opp_genpd_names)
> 		{
> 			dev_pm_opp_attach_genpd(dev, names, virt_devs)
> 			{
> 				// takes and holds table reference
> 				opp_table = _add_opp_table(dev, false);
> 
> 				while (*name) {
> 					// first attachment succeeds, 
> 					// second fails with "tegra-gr3d 54180000.gr3d: failed to set OPP clk: -EBUSY"
> 					dev_pm_domain_attach_by_name(dev, *name)
> 					{
> 						tegra_pmc_pd_dev_get_performance_state(dev)
> 						{
> 							dev_pm_opp_set_clkname(dev, NULL);
> 							dev_pm_opp_of_add_table(dev);

What you end up doing here is pretty much like
devm_tegra_core_dev_init_opp_table_simple(), right ?

> 							opp = dev_pm_opp_get_current(dev);
> 							dev_pm_opp_of_remove_table(dev);
> 							dev_pm_opp_put_clkname(opp_table);

You shouldn't be required to do this at all.

> 							...
> 						}
> 						// opp_table->clk = ERR_PTR(-EINVAL) after the first attachment
> 					}
> 				}
> 			}
> 		}
> 	}
> 
> 	devm_tegra_core_dev_init_opp_table_simple(&pdev->dev);

Can we make the call at the beginning ? before calling
gr3d_init_power() ? I mean you should only be required to initialize
the OPP table just once.

If not, then what about calling
devm_tegra_core_dev_init_opp_table_simple() from here and from
tegra_pmc_pd_dev_get_performance_state() as well ?

And update devm_tegra_core_dev_init_opp_table_simple() to call
dev_pm_opp_get_opp_table() first and return early if the OPP table is
already initialized ?

-- 
viresh
