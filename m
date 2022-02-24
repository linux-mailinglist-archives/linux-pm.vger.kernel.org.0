Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5F4C2858
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiBXJm4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiBXJms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 04:42:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F4234006
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:42:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y11so1384323pfa.6
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SqjvQW2jhTbzsHtQa0pElGm7+Yso5ZysCjfi7TkmrzI=;
        b=hJMM0zh8CjsvV3EmHKZtwZhfRnXTzP5Pz5VXV+SpAHJKtISWv600UYEtrUjzWDSo+6
         OdkQ+K0uh5vtOQ6hKQTaVifpZCl5GR+OWqHTA2ljyjcXbIyQlYOXh7BeJdIb6WyImyH2
         sxob0Wf5qmxv8pGFU35qdKLHrG3z0WDHcH/HIB3yopleihgkInyHM5t562UcRlP3NlW4
         EIPZUjvgpOHt/2SAQdmGRGop9VU0hMofPUhx9JkmBqrCfksLHssOaAVtacSfmruhKHc6
         2sYWYFcT+vbxQexqcCtQf+N845X1mSIBTSNLdXNAEzijcMSeG3nSd+n6jpCLEcDbkzgM
         RkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqjvQW2jhTbzsHtQa0pElGm7+Yso5ZysCjfi7TkmrzI=;
        b=aaq3yegRkAKEevwQaE8ow0incW01y7ocIxK8pVgx1gZIqsja9fBv+uvsuCTTwO/9fS
         JlvqZ1flX8+XMbb/K/sjxGaT5rVNeZ/kYL0EQk6fAefFrdJZtp5b9CQPYDZsMHtFUAfI
         MEtn51mWAwefYh+TD9plalTbAh2jW71//ZONBMMoA7X/WhIUeCXBBeXNKBtFvPdwffY2
         OrJqYLlsGy+TTTWzjJ36FpXuMlzIbaO3Pj1byMWO9dgd09FtgA70SxoDdYBbKkYIQSej
         nchwtA2k/r1GYjUYbX+0SFja+nBFD5Lv3/IABZGGSDWSf2bkF0RGDJ8spVmXZvMmhED6
         6X2Q==
X-Gm-Message-State: AOAM5309+1viGVGIVQVzGJ2XUiVCFSBHed2uaOQXFPy86MXPSL5YyKjR
        NLMl4A/3LXCH4AVIgWvoSbBjew==
X-Google-Smtp-Source: ABdhPJysna4B+BW0VsmFKR2DXx04V+XqSL+8g6fOf9O+z2vFtv4cfo2+3t/peIf16QA7spH8ftG1qw==
X-Received: by 2002:a63:5a61:0:b0:373:3567:d8c5 with SMTP id k33-20020a635a61000000b003733567d8c5mr1639260pgm.291.1645695738860;
        Thu, 24 Feb 2022 01:42:18 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h15sm2950838pfh.143.2022.02.24.01.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:42:18 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:12:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <20220224094216.mtxjjx65bbjzalqx@vireshk-i7>
References: <20220224081131.27282-1-lukasz.luba@arm.com>
 <20220224081131.27282-4-lukasz.luba@arm.com>
 <20220224091346.xmnpj27vllpa4cuy@vireshk-i7>
 <9c8f15a3-563f-3bed-61a4-2f72b0c20e89@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8f15a3-563f-3bed-61a4-2f72b0c20e89@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-22, 09:33, Lukasz Luba wrote:
> On 2/24/22 09:13, Viresh Kumar wrote:
> > On 24-02-22, 08:11, Lukasz Luba wrote:
> > > diff --git a/drivers/opp/of.c b/drivers/opp/of.c

> > > +static bool _of_has_opp_microwatt_property(struct device *dev)
> > > +{
> > > +	unsigned long power, freq = 0;
> > > +	struct dev_pm_opp *opp;
> > > +
> > > +	/* Check if at least one OPP has needed property */
> > > +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> > > +	if (IS_ERR(opp))
> > > +		return false;
> > > +
> > > +	power = dev_pm_opp_get_power(opp);
> > > +	dev_pm_opp_put(opp);
> > > +	if (!power)
> > 
> > Instead of this heavy stuff, just pick the first OPP from the opp
> > table and see its power-value.
> 
> It is the first opp: freq=0.
> You mean by parsing the the DT node instead, like I had in v2 version?

No, I was thinking if you can simply do:

opp = list_first_entry(&opp_table->opp_list, struct dev_pm_opp, node);

But that requires locking, etc as well. So maybe this is fine.
 
-- 
viresh
