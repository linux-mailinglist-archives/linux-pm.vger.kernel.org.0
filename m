Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65B6A14D6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Feb 2023 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBXCRT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 21:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXCRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 21:17:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADB515FD
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 18:17:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u10so15016530pjc.5
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 18:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwQM5jDCnisoGK+9lg+DN9mXAFVodSsNBaIsTAFZ/HA=;
        b=U+6xJp4C4jhOSJawd+VDYS75rVNz161MGfLLnJrgNjnKmt8cBQdIR26gxPBeNPJ6qP
         m9AHc5m4KsZqNcMuZHDfheCR9byDTZvYiRj2fid6Io03+1lVcPVJfAT5x23GwMKbFBY5
         pCm+SzTK21aJFfV9MmyCrEU1cauAGOffKM7iN1UW08fUNsf/JRrDNHyedKZpq5scl9lS
         D61eeBFRipb4kA4c1lYrvE0M+dpq5mCIQQd2pndWwvF+bco0GDqcaPj8wic2IYeRlCgT
         Rp113bTu8exyqlSchWz4PZ17yx5XbqKGSJeg3WxjPNTq+TMbhfBFR8HpWsOcFO5fYC0K
         XKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwQM5jDCnisoGK+9lg+DN9mXAFVodSsNBaIsTAFZ/HA=;
        b=IAXb3xwcjJMTw9jSjwHN+rPNkAIwIHp96fs0T5bEev51nZXtoHq/JdU6uENxxI8m6N
         919flLIuKnjRmMWDFjksuIRM/0OHQSRlh3z61p9wlyrLGyU9ZdwdAUHfON/h6AFzO/WO
         AADectVVu4YwWyr40KojGFTWkJDMidYrut0ZgZb4CtLEZL/OOq07xFk3cXma2UZmkTqL
         aqD9KBEuWWHCdBeW2Pwxp69l8GkrTNuLEBSroOt6ywppg+GO1MZEzyXTs66IYYsnKzwR
         FrN0YBVC9t0lhhu7nDscrZobtXtrtOP0LVvHiBChWvVuCx3KVfe25pBMET7JmjUfbw9y
         /P8A==
X-Gm-Message-State: AO0yUKVSVQ/PERY3opO5XBxff74BoIYTPDRPZyTJMq0cr+uMgCiW+z5j
        yRQIoAmOfpFqYu0HlgDIyb1J2A==
X-Google-Smtp-Source: AK7set/CzIDjqcs+ex1tt/uuL6og7+c8sKGOmyeRSPakEVadCRP1/lhjq2n1ROS6VFu3TO3FZkeR9g==
X-Received: by 2002:a17:903:5c4:b0:19a:b9a8:3fbe with SMTP id kf4-20020a17090305c400b0019ab9a83fbemr10522949plb.48.1677205036904;
        Thu, 23 Feb 2023 18:17:16 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902761100b0019a8468cbedsm4440202pll.226.2023.02.23.18.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 18:17:16 -0800 (PST)
Date:   Fri, 24 Feb 2023 07:47:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-02-23, 17:56, Jun Nie wrote:
> It looks promising. The function get_target_freq_with_cpufreq() can be wrapped
> to act as set_required_opps() callback.

> But my case is a bit complicated. CPU opp depends on both genpd opp and
> devfreq opp.

I was wondering if we will have such a case soon enough or not :)
 
> So the genpd_virt_devs array need
> to be modified or add another array for devfreq case. While genpd_virt_devs is
> bounded with genpd directly and coupled with "power-domains" list in
> device tree.
> Current required-opp nodes are designed to be aligned with the list. I
> am considering
> what's the best way for back compatibility.

Please look at the top commit here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/propagate

Will this be enough for your use case ? I will post everything again once we are
settled on a solution.

-- 
viresh
