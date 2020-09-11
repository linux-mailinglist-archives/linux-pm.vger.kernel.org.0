Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D671265917
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 08:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIKGGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgIKGGF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 02:06:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FAC061756
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 23:06:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so1176766pjb.5
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZ9NlTPXuI2Am9m0oyaQQxWYWGAvJGrwB78FmdPA/YQ=;
        b=grM+6+ehump200enzCYQ+cfpFFoc+xFRZ2+AaHHBYlWdBcw6SD2lSadOVBsuQ5aSOQ
         ERrVqzhTzk8KLJmeTvTo0tj3/rp1/W9L0C2Cx1GrPJovwz/A9gtWezyY6yOo4Qwzm0kv
         iUe0vsbCowSaHIX7tv2bnGW8ZvdJCfUQ/qavr7KUIEzNtXy6bJsTTV2DUac49UeuTGwC
         wVVOgVqUgy+bdikJ5epRzcXl3Lb9C2hv6tBpGBY6tlL5MC4LUMZvdE+gQy6fzWRak5jE
         YqblgHop/kSzaAyGv52QCCzKmzcKr4HxMNtBb4rUS3oggu+xz8eH4MhV3B8ZCuzPiTJg
         bFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZ9NlTPXuI2Am9m0oyaQQxWYWGAvJGrwB78FmdPA/YQ=;
        b=KVgJLLPmScihllYGZM1P5jJVY+frhJQa8WT0A/lm4RpGDXh0tIByolMv4BRi1TzR5W
         8qAsSNwtyISAQ+4AW93K2cl/xzLaXwb36Bk5XhnuuZfaQUVNxMQxNowh7uzLPvIlIbLZ
         J06gFph4WMlFM/oAKJDCGVIKPgpDaOJsNrHQxVc5xO8fe0/e7+dMSnkwXL3QX15JWb5v
         53fKVM/4QbuI9WiLbzTKKg0bYD5mHeiNSIXUKg986zIrI//bM7x2C4aBEWs+zJg7EoHT
         LbrmouyuHa5eO5GjW0qGA1ALtbHi/8T9VSOraKY+dbfXRN04FYEPJUrldCqepQ2dmWD5
         5MAg==
X-Gm-Message-State: AOAM533pKFcJ1oZvriKxx1UHXJoW5GqiMCLU/Nmoftjj3/gTa7nhlOSV
        iDiEdRDzugHFchTwmSaSSOyrqQ==
X-Google-Smtp-Source: ABdhPJzzw6ZzMTz787ZCseKKfOz/2AMn3F5BXVvPc9iZo0oBivKhBFrC8qY55CiiKLcRjiwnoZpFfA==
X-Received: by 2002:a17:90a:4043:: with SMTP id k3mr783014pjg.141.1599804364011;
        Thu, 10 Sep 2020 23:06:04 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id u62sm988667pfb.4.2020.09.10.23.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 23:06:03 -0700 (PDT)
Date:   Fri, 11 Sep 2020 11:35:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: Qcom clock performance votes on mainline
Message-ID: <20200911060556.bntj3s74je75orel@vireshk-i7>
References: <20200910162610.GA7008@gerhold.net>
 <159977328190.2295844.1029544710226353839@swboyd.mtv.corp.google.com>
 <20200911054844.GA1193@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911054844.GA1193@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-09-20, 07:48, Stephan Gerhold wrote:
> On Thu, Sep 10, 2020 at 02:28:01PM -0700, Stephen Boyd wrote:
> > Quoting Stephan Gerhold (2020-09-10 09:26:10)
> > > Hi Stephen, Hi Rajendra,
> > > 
> > > while working on some MSM8916 things I've been staring at the downstream
> > > clock-gcc-8916.c [1] driver a bit. One thing that confuses me are the
> > > voltage/performance state votes that are made for certain clocks within
> > > the driver. Specifically lines like
> > > 
> > >     VDD_DIG_FMAX_MAP2(LOW, 32000000, NOMINAL, 64000000),
> > > 
> > > on certain clocks like UART, I2C or SPI. There does not seem to be
> > > anything equivalent in the mainline clock driver at the moment.
> > > 
> > > As far as I understand from related discussions on mailing lists [2],
> > > these performance votes are not supposed to be added to the clock
> > > driver(s), but rather as required-opps within OPP tables of all the
> > > consumers. Is that correct?
> > 
> > Yes.
> > 
> > > 
> > > As a second question, I'm wondering about one particular case:
> > > I've been trying to get CPR / all the CPU frequencies working on MSM8916.
> > > For that, I already added performance state votes for VDDMX and CPR as
> > > required-opps to the CPU OPP table.
> > > 
> > > After a recent discussion [3] with Viresh about where to enable power
> > > domains managed by the OPP core, I've been looking at all the
> > > performance state votes made in the downstream kernel again.
> > > 
> > > Actually, the A53 PLL used for the higher CPU frequencies also has such
> > > voltage/performance state votes. The downstream driver declares the
> > > clock like [4]:
> > > 
> > >                 .vdd_class = &vdd_sr2_pll,
> > >                 .fmax = (unsigned long [VDD_SR2_PLL_NUM]) {
> > >                         [VDD_SR2_PLL_SVS] = 1000000000,
> > >                         [VDD_SR2_PLL_NOM] = 1900000000,
> > >                 },
> > >                 .num_fmax = VDD_SR2_PLL_NUM,
> > > 
> > > which ends up as votes for the VDDCX power domain.
> > > 
> > > Now I'm wondering: Where should I make these votes on mainline?
> > > Should I add it as yet another required-opps to the CPU OPP table?
> > 
> > Sounds like the right approach.
> > 
> 
> Thanks for the quick reply!
> 
> > > 
> > > It would be a bit of a special case because these votes are only done
> > > for the A53 PLL (which is only used for the higher CPU frequencies, not
> > > the lower ones)...
> > 
> > Can that be put into the OPP table somehow for only the high
> > frequencies? The OPP tables for CPUs sometimes cover the CPU PLL voltage
> > requirements too so it doesn't seem like a totally bad idea.

Maybe we can allow the vote value to be 0 somehow ?

> I don't think it's possible at the moment, but actually Viresh mentioned
> that use case (scaling a power domain only for some of the OPPs) when we
> discussed where to enable the power domains listed in the OPP table [1].
> 
> Problem back then was that we didn't have a real example where this
> would be needed. It seems like such an example exists now, so I will
> discuss ways to implement that with Viresh.
> 
> I just wanted to be sure that adding the additional power domain to the
> CPU OPP table is the right approach.
> 
> Thanks again!
> Stephan
> 
> [1]: https://lore.kernel.org/linux-pm/20200828063511.y47ofywtu5qo57bq@vireshk-i7/

-- 
viresh
