Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE31253CB2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 06:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgH0E05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 00:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgH0E05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 00:26:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDBEC0612A9
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 21:26:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so1963883pjv.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2020 21:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bn7ZvG4ybcooDrNm25U4C10jlmrGjFdQ/FaC/rxAetw=;
        b=JWGdadunye66WMfXu1P4p7JU12j51p8o/dw5xBp05k4WBlQSeSFjHzokSYn55bVV3o
         J4tcFBW+K0k9bbB0ds4GyUbQ9KAjULJVcytETxzcrQeP3yifDm/M/suCNnYmsgY5Qzlv
         bYLOwZvhvgDdXRldn4DmRvNGzykpHvQF1muP3pcCByHjEYtEHbeJDDqUjNpus61Fowov
         JyoN9QhOtYitibsWLrqe+FQ9q4BVoMTkmiVKZ/RQ8BzwYqbwxbkzyx1YBIYj6oYH/uoi
         E6OZ9hPBdCD4DEyRV0Y3/EiRxpSeNBUdMXvmYIiHxOPHTWp3rcwr9/3wHDVTWkLGz5kb
         6DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bn7ZvG4ybcooDrNm25U4C10jlmrGjFdQ/FaC/rxAetw=;
        b=dOrh2u7GAhGOwsgueLaQu2wX5tAogDco+1tTtL7v1A4rzZfE1OPDSNls9TJT8njTAy
         OXYOwwywXmQ7yK7PFafPc3ZBJGNiolzRs1xfmn+P4ma7GGU9u2q+QsjSLuvePMxEwAr6
         mipKYJqE7oAGz9nAkxixZIFE1bqAxCXwIX5yapyXuErxkG7bUeNjeROOhTDuLuaXubEO
         rLan87dqX+DXIJLvdZGMMByB9+A1I2VE8I/gf3ohvwkUue8QMMA3wwa1TaQryRlFhCtf
         qDX6WP0z5WW+KAlSnMU+c7QIlQMtMpZvPskWhxgnG0gShYy7ZKhGqVrH29CLKtMk0iYE
         a0TQ==
X-Gm-Message-State: AOAM533Ph73YXJQv1piUOh7nWsLy7XIvl3UFPc0wMHfukCumkB0eu4IH
        otkvZpwg/5cNzXt4xTgrIDgP1w==
X-Google-Smtp-Source: ABdhPJynFu/KaCKX/yeZQJO1i0iZEbs8inUUMkKE06wJFLYUgtfBDrVZ4/4+/uHiY6WLXxuxzu5BQQ==
X-Received: by 2002:a17:90a:f593:: with SMTP id ct19mr9163811pjb.36.1598502416374;
        Wed, 26 Aug 2020 21:26:56 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id nu14sm631975pjb.19.2020.08.26.21.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 21:26:55 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:56:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200827042653.5ttsxnjjhpslmrcv@vireshk-i7>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
 <1597302475-15484-2-git-send-email-hector.yuan@mediatek.com>
 <20200824100619.o6uwnlsaxdgc3l7r@vireshk-i7>
 <1598446624.24220.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598446624.24220.10.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-20, 20:57, Hector Yuan wrote:
> On Mon, 2020-08-24 at 15:36 +0530, Viresh Kumar wrote:
> > On 13-08-20, 15:07, Hector Yuan wrote:
> > >  CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=m
> > >  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
> > > +CONFIG_ARM_MEDIATEK_CPUFREQ_HW=m
> > 
> > What about a 'default m' in Kconfig itself ?
> > OK, will update in V3.

Hector, you need to remove (or not add) the right bracket (>) before the
beginning of your lines. This makes it incredibly difficult to read.

> > > +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > +		data = readl_relaxed(base + (i * LUT_ROW_SIZE));
> > > +		freq = FIELD_GET(LUT_FREQ, data) * 1000;
> > > +		volt = FIELD_GET(LUT_VOLT, data);
> > > +		if (freq != prev_freq) {
> > > +			table[i].frequency = freq;
> > > +			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> > 
> > Why are you adding OPPs here and rather why using OPP specific stuff
> > at all in the driver ?
> > yes, the opp information is read from CPU HW engine.Then add it to the CPU dev OPP one by one.  

I asked a different question, why are you adding OPPs ? You don't need the OPPs
at all in my opinion. You can just create the frequency table and that's it.

> > > +	for_each_possible_cpu(cpu) {
> > > +		cpu_np = of_cpu_device_node_get(cpu);
> > > +		if (!cpu_np)
> > > +			continue;
> > > +
> > > +		ret = of_parse_phandle_with_args(cpu_np, "mtk,freq-domain",
> > 
> > Where are bindings of this node and how does this look ?
> > Can refer to the same patch series, I split it to another patch.Each cpu will be group into one frequency domain for the CPU DVFS. 

That binding only defines "mediatek,cpufreq-hw" and not "mtk,freq-domain".

-- 
viresh
