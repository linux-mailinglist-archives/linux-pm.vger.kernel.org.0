Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433C775CB82
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGUPVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGUPVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 11:21:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74124229
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 08:20:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bff89873d34so1814124276.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689952828; x=1690557628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BkukvvKdCrDQOFgIYreW11T9Rq9G1ZMbiEGMQtKJyG8=;
        b=e5kf0veFl/aobo/tJRQsav5pgDTz4PtmrUYkfINVokLF6Mt2pJYt9ls5Z+QTMDUpDB
         sD0raHqPRuYgXgERfy8zJ4EALIfO2eOR+94V18pCVkUHe/atb6/XEwntzs9OHPvwbo5M
         j5KWYp6mZlDJ6PwIZFT+En4r34NBjzAnmTs5dVby3/HErxaoeoWpL1fl5Wmfg2uYY0io
         vurBiTXH2OMc/jeYxPZKBh7ZkrcT66D3KB6PrKbrDwxirVpnb+h+y880sMvfr7y3WTOi
         fBgZxJjHUjZXJNtCXFtzr3Ffca9UZMMY0LBFspX375MPOl0WrcwzDgOWAdVKDC3hEhkE
         /dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952828; x=1690557628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkukvvKdCrDQOFgIYreW11T9Rq9G1ZMbiEGMQtKJyG8=;
        b=MOlPEaoAJ5Rj/aYN0quX9yVG0us0Y9h8ZuyT8CLyD4URm6uObrlJJbe8acWsiR1Yhq
         OqQ1MtDCh1TQftZHacpW1FogI80b6we2QhpxHtlCr02wb4gJ5oKYZBC1hSL04urjQA17
         yQu9JSUuPyZtFFkMIdAxK3GuyrSV4tEP8J4XMFqzCHSujL98eNEiO9wABq2qUlvu43er
         RuLmH2WLg6yiuKMnkKmrcx7Ve53tk4dnsMG9oqcKOc+iNTFc+F2Nx1AKERRcS1fhzVzk
         VyOoZKzGTC+ZnKgC5IVFqjlM9SBgcGR3wjXiobu7mHqlmrBji5+6pyMivhpCaa0zmqFl
         E5aw==
X-Gm-Message-State: ABy/qLauNo46CMB3oGn9rkc/EWLpr1vTTLDENohQMpu5qeC8MXY2TBNb
        ygo7bIdnnvAE4px44ABUy3r1Cmwc0LWrSJu3ooje/w==
X-Google-Smtp-Source: APBJJlFnc3KURsezFV4I7qr9IwPHnppofn+Q98ueID6M1Y3aQ2O4i/zWi1zZR+RkQ5OuO1Lm7f5+ob4jVZaMkDvDAVQ=
X-Received: by 2002:a25:d384:0:b0:c80:f701:7467 with SMTP id
 e126-20020a25d384000000b00c80f7017467mr2010871ybf.45.1689952828466; Fri, 21
 Jul 2023 08:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org> <ZLf4c7ejFBJLH7iN@e120937-lin>
In-Reply-To: <ZLf4c7ejFBJLH7iN@e120937-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jul 2023 17:19:51 +0200
Message-ID: <CAPDyKFr3ann52GAtOLfnLSGgsdF+EZBNz_apNo_OHzrQ-Hg55Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance domain
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

On Wed, 19 Jul 2023 at 16:51, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Thu, Jul 13, 2023 at 04:17:37PM +0200, Ulf Hansson wrote:
> > To enable support for performance scaling (DVFS) for generic devices with
> > the SCMI performance protocol, let's add an SCMI performance domain. This
> > is being modelled as a genpd provider, with support for performance scaling
> > through genpd's ->set_performance_state() callback.
> >
> > Note that, this adds the initial support that allows consumer drivers for
> > attached devices, to vote for a new performance state via calling the
> > dev_pm_genpd_set_performance_state(). However, this should be avoided as
> > it's in most cases preferred to use the OPP library to vote for a new OPP
> > instead. The support using the OPP library isn't part of this change, but
> > needs to be implemented from subsequent changes.
> >
>
> Hi Ulf,
>
> a couple of remarks down below.
>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Converted to use the new ->domain_info_get() callback.
> >
> > ---
> >  drivers/firmware/arm_scmi/Kconfig            |  12 ++
> >  drivers/firmware/arm_scmi/Makefile           |   1 +
> >  drivers/firmware/arm_scmi/scmi_perf_domain.c | 155 +++++++++++++++++++
> >  3 files changed, 168 insertions(+)
> >  create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c
>
> [snip]
>
> > +static int scmi_perf_domain_probe(struct scmi_device *sdev)
> > +{
> > +     struct device *dev = &sdev->dev;
> > +     const struct scmi_handle *handle = sdev->handle;
> > +     const struct scmi_perf_proto_ops *perf_ops;
> > +     struct scmi_protocol_handle *ph;
> > +     struct scmi_perf_domain *scmi_pd;
> > +     struct genpd_onecell_data *scmi_pd_data;
> > +     struct generic_pm_domain **domains;
> > +     int num_domains, i, ret = 0;
> > +     u32 perf_level;
> > +
> > +     if (!handle)
> > +             return -ENODEV;
> > +
> > +     /* The OF node must specify us as a power-domain provider. */
> > +     if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
> > +             return 0;
> > +
> > +     perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> > +     if (IS_ERR(perf_ops))
> > +             return PTR_ERR(perf_ops);
> > +
> > +     num_domains = perf_ops->num_domains_get(ph);
> > +     if (num_domains < 0) {
> > +             dev_warn(dev, "Failed with %d when getting num perf domains\n",
> > +                      num_domains);
> > +             return num_domains;
> > +     } else if (!num_domains) {
> > +             return 0;
> > +     }
> > +
> > +     scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
> > +     if (!scmi_pd)
> > +             return -ENOMEM;
> > +
> > +     scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
> > +     if (!scmi_pd_data)
> > +             return -ENOMEM;
> > +
> > +     domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> > +     if (!domains)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < num_domains; i++, scmi_pd++) {
> > +             scmi_pd->info = perf_ops->domain_info_get(ph, i);
>
> So here you are grabbing all the performance domains exposed by the
> platform via PERF protocol and then a few lines down below you are
> registering them with pm_genpd_init(), but the list of domains obtained
> from the platform will contain NOT only devices but also CPUs possibly,
> already managed by the SCMI CPUFreq driver.

Correct.

>
> In fact the SCMI CPUFreq driver, on his side, takes care to pick only
> domains that are bound in the DT to a CPU (via scmi_cpu_domain_id DT
> parsing) but here you are registering all domains with GenPD upfront.

Right, genpds are acting as providers, which need to be registered
upfront to allow consumer devices to be attached when they get probed.

This isn't specific to this case, but how the genpd infrastructure is
working per design.

>
> Is it not possible that, once registered, GenPD can decide, at some point
> in the future, to try act on some of these domains associated with a CPU ?
> (like Clock framework does at the end of boot trying to disable unused
>  clocks...not familiar with internals of GenPD, though)

The "magic" that exists in genpd is to save/restore the performance
state at genpd_runtime_suspend|resume().

That means the consumer device needs to be attached and runtime PM
enabled, otherwise genpd will just leave the performance level
unchanged. In other words, the control is entirely at the consumer
driver (scmi cpufreq driver).

>
> > +             scmi_pd->domain_id = i;
> > +             scmi_pd->perf_ops = perf_ops;
> > +             scmi_pd->ph = ph;
> > +             scmi_pd->genpd.name = scmi_pd->info->name;
> > +             scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> > +             scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> > +
> > +             ret = perf_ops->level_get(ph, i, &perf_level, false);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to get perf level for %s",
> > +                              scmi_pd->genpd.name);
> > +                     perf_level = 0;
> > +             }
> > +
> > +             /* Let the perf level indicate the power-state too. */
> > +             ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
>
> In SCMI world PERF levels should have nothing to do with the Power
> state of a domain: you have the POWER protocol for that, so you should
> not assume that perf level 0 means OFF, but you can use the POWER protocol
> operation .state_get() to lookup the power state. (and you can grab both
> perf and power ops from the same driver)

Well, I think this may be SCMI FW implementation specific, but
honestly I don't know exactly what the spec says about this. In any
case, I don't think it's a good idea to mix this with the POWER
domain, as that's something that is entirely different. We have no
clue of those relationships (domain IDs).

My main idea behind this, is just to give the genpd internals a
reasonably defined value for its power state.

>
> The tricky part would be to match the PERF domain at hand with the
> related POWER domain to query the state for, I suppose.
>
> Indeed, recently, while looking at SCMI v3.2 PERF evolutions, I was
> tempted to just start rejecting any level_set() or set_freq() request
> for ZERO since they really can be abused to power off a domain. (if the
> platform complies...)

I didn't know that this was against the spec, but in a way what you
say, seems reasonable.

>
> Apologize if I missed something about how GenPD behaviour...

Np, thanks a lot for reviewing! Much appreciated!

>
> Thanks,
> Cristian

Kind regards
Uffe
