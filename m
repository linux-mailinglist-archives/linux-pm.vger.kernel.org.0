Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BE39A27F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFCNvo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 09:51:44 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:33706 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhFCNvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 09:51:44 -0400
Received: by mail-ua1-f51.google.com with SMTP id l12so3360759uai.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UjUIW9zbfUZ4RwOyiLkvVO/eF05W329MyzzFPGAFB4=;
        b=c44tayuwS2u8SQTEybCZAoA5xeWfvrXFKtD564C4jJwGB3LaCJpSsEtBNEMceN0G4x
         jW5niwBZvJjlupvPzD8zRa7VTqtAk4psSC0Iu/YBoZqCi42lxExp+oxniv/hRb+xOv6z
         76JcqI57DEpdlB7LFMgJxEL7ybPXqISHaBGY+O26Skt2Xl+JwpmpK+qS+lV1uGP4RiZg
         u5jdnki9BSJ/j5U/4yfaL/rHRzDRgubs68Simzrh2pytp5kDf4iGMfnT4R7rW3oSdDJJ
         dBWUIiZLJVJ+JX1Ea5OTd4EBt8on4u3QjLovQmzeroAkGOMKD7+yHceXHBN6cEgc8kzl
         Tx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UjUIW9zbfUZ4RwOyiLkvVO/eF05W329MyzzFPGAFB4=;
        b=aXAZl199N/DLTMwu0mTxctBdB7UiulUulvj5EVk94Ipk2/FAADlkdhBtujMiMaUdk+
         FFt23qe3Z2YdAkvEvULzyTFqS7SnQj18hg3jKSwhHlZpAqTItYNKl2k6qTI/mS0njwwX
         YmxIGXvqQ5dyLSCNPHQfRjbiD7txc/ORKsrO/wFEyPqFB5IlpwcY2aWPyDFDdfp0p+43
         JmV1MIEboH3C05r/HAew4MVc3rKxq1ImJsDQ7C5TrHOWWFEueNvtcuFT7r8ye4fnlmvA
         tyIvE59qoXbi5UWsxTRjVPqrPJBNmTOdfXHKZqvcIiSd/a+TJgKVPqs3IozKklmbCn1w
         BpHw==
X-Gm-Message-State: AOAM531Ub/N+5TKhg+TypomQCNl9Po87K4l5vyWVooe7P6fGacDIeue3
        P9bm9h9Lu3FzosJcQXSRVqjWCbf5jXrwUVOZu+SnHnWnc/R0xw==
X-Google-Smtp-Source: ABdhPJwXOmWBpw9TxY14OndWy9w9S1xWe5445oPP85ttLd+bbAgHrOOP7FzQCKwlHmMSuw2tXjl+JGJ8Kk8oe8fUYoc=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr24663046uak.104.1622728126477;
 Thu, 03 Jun 2021 06:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org> <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
 <20210603111529.GB4257@sirena.org.uk>
In-Reply-To: <20210603111529.GB4257@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 15:48:10 +0200
Message-ID: <CAPDyKFouMZeQ96XSV=-dfNKNtgxhMG=xGqPCNBV9bvzuXYJQtw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 at 13:15, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 03, 2021 at 12:20:57PM +0200, Ulf Hansson wrote:
> > On Thu, 3 Jun 2021 at 11:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > > Recent changes in genpd drops and restore performance state votes for
> > > devices during runtime PM.
>
> > After a second thought, it looks like we maybe should defer to apply
> > this final patch of the series. At least until we figured out how to
> > address the below issue:
>
> > So, I noticed that we have things like "regulator-fixed-domain", that
> > uses "required-opps" to enable/disable a regulator through the
> > dev_pm_set_performance_state() interface. We likely don't want to drop
> > the performance state internally in genpd when genpd_suspend_noirq()
> > gets called, for the corresponding struct device for the regulator.
>
> > I guess if genpd should drop performance states like $subject patch
> > suggest, we need some kind of additional coordination, that allows a
> > subsystem/driver to inform genpd when it should avoid it. Or something
> > along those lines.
>
> I'm not sure what you're looking for from me here - was there a concrete
> question or somehing?

Nope, not really, sorry if that was not clear.

I just wanted to loop you in, as to make sure that we don't change
something at the PM domain level, which may not fit well with the
regulator implementation.

Kind regards
Uffe
