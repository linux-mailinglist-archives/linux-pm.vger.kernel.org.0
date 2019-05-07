Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8015C31
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEGGBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 02:01:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46339 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfEGFgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 01:36:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id bi2so7552755plb.13
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VNKbTifGUbZh3N8J6baY/xLBerod0ycXdrW8mFrYBic=;
        b=RJP5OM5e/qylC4xqo8j9urmE6TsYX5ZOKM3NqnTvItYfi2QMaSofkf1+wzeHlH+2xx
         EZ9dVKXwTZhpaJgTB1WsOylNwwBB1Z/X02Z2KIXpb/OSoUVeIxFAjM3iJqGYZ7vIdVxX
         cHAUAWNr+BVH6alNGKX+AY5hSHMubw43q9gnuL4ccrN1QuUk63CrUHTRtEakfj4GGVy1
         a2aEgxTQaO1U4VhEYYC58idOWvzi5qIbe5Kf/4CSmks4+LFQBIC1aQdp3603/0QXevqL
         xlfvwjxxHNGc2IzHSaLxhiVAX0p1O69obOxKwz0eq564LT6UXntkBBr6NEHwg/vtvEVW
         Ijww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNKbTifGUbZh3N8J6baY/xLBerod0ycXdrW8mFrYBic=;
        b=GiTTYkCT1kgRyRJ15MT5jnaER4gJwGd0O1irIZPK2BhihXQnG2fJdVglF03f7THG7k
         HwrLqzaCj/9Oh8qJM5nMo5JZcRx0wIdpMrMZuqhsBYksMIxR1s+kCAr4nHnRpUWHudyL
         ngc9dcRmuVTe1oj5AgXk8Bk32KtB3lZfXT2VZm1XEeuuY6UuPo9lUOWvX/Vgz8OwwQYM
         3ah274ytydpJOdak9d8fmNTEd48KltrYnwqhbzhnDb2x2habq64MxRqArxHPxsCaXQds
         Mm7caKgdexnkZuDZlgworc+5/BTIHc8gEZgAlYUmAg87S7MY4MIq++V7RqEAie++HqC2
         j7YA==
X-Gm-Message-State: APjAAAVXYfpzixG41ffZBnH2ADKswziBZ6Xt1k5xbFM5A6bDCm09Ubvs
        mqjHc/K0cx9d2Sf5cxm0oAOO6g==
X-Google-Smtp-Source: APXvYqwDuFuf7s44xZ0+ugdb0iL0wlHswbYavlc/lX1z/63p4V4zDpqZIrXhkDiB+isPRs5T7shfjg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr36065678plo.32.1557207360104;
        Mon, 06 May 2019 22:36:00 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id k4sm28301976pgh.27.2019.05.06.22.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 22:35:57 -0700 (PDT)
Date:   Tue, 7 May 2019 11:05:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] cpufreq: Add imx-cpufreq-dt driver
Message-ID: <20190507053555.tse4q5y6wfbakhth@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <20190503065026.qwroewhu5lxckqgl@vireshk-i7>
 <AM0PR04MB64343A9439DF8FA943BFE2D4EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB64343A9439DF8FA943BFE2D4EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-05-19, 11:51, Leonard Crestez wrote:
> On 03.05.2019 09:50, Viresh Kumar wrote:
> > On 02-05-19, 22:44, Leonard Crestez wrote:
> >> Right now in upstream imx8m cpufreq support just lists a common subset
> >> of OPPs because the higher ones should only be attempted after checking
> >> speed grading in fuses.
> >>
> >> Add a small driver which checks speed grading from nvmem cells before
> >> registering cpufreq-dt.
> >>
> >> It seems that cpufreq-dt insists on adding the opp and regulator itself
> >> so can't actually call dev_pm_opp_of_add_table and then
> >> dev_pm_opp_disable
> > 
> > Well we can surely implement it someway if that is what you want, like we can
> > pass postinit() callback in platform data to cpufreq-dt which can get called
> > after OPP table is added, etc.
> > 
> > But disabling OPPs after they are added isn't a great way of handling it as
> > well.
> > 
> >> so implementation was switched to opp-supported-hw.
> > 
> > I will say that this is far better than disabling the OPPs after adding them. So
> > this is a good way of doing it.
> 
> The intention seems to be that dev_pm_opp_disable is used at run-time 
> for stuff like thermal issues while init-time opp selection should be 
> done in other ways.
> 
> Is this what you mean? It's not very obvious from API.

Well there are no hard and fast rules for using the API and what I was
talking about was as to which API makes more sense. I am less in favor
of using dev_pm_opp_disable() here as we will make the OPP available
first on the platform and then disable it. What if the cpufreq core
gets a chance to run in between and program the OPP which isn't
allowed on the SoC ? That may cause problems, right ? And so disable
should be used for things which are getting used just fine and at some
point of time we decide to disable them.

-- 
viresh
