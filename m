Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD54255D4F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1PGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgH1PGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 11:06:17 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3EEC061264
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 08:06:17 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id h19so464224ual.10
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP81KhbFfFMLjt/9HZBr2wWZSwrB3/aa9mKjEXE/AKE=;
        b=G8e1hSdWLuYEJPV3B0RaF3rvGxxGkCTIF80d31pPr9iF136sww25RkRnSUV+j1AcVv
         H9OJX1KXsDnaVLCtVvW7DPjEh69HZSR8Wupn9bRJ83yTG9C9qa0dn2v0dqy+eonTsPmp
         MohmqV0MA4Mfl9vG7cBkhQAXWLoMyULgQUxkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP81KhbFfFMLjt/9HZBr2wWZSwrB3/aa9mKjEXE/AKE=;
        b=ipZXVF/z1SOc4J0bxnQ1EK6TWT00cG8QIJMUxvBifwy+on7qcYkajiuVE40a1zsV/i
         4Kdj+j7xIvlviDxtiCtcGVibVFS7LKdTS+xLoR5oOvBi4dKbPd38pZUTlqKz81jnarE7
         NB9L+H7sminMTwZfvJO8tiwvTapfTLo8XMzqTsgdIco74tjaGeygJOVSAHMgvOETebJ1
         LfFqS0v0DawkeWWXn48x2tkbZsE4wcOK3nXFPq/PYjk3yxIKkunnnj3qRwAluUoQeim6
         SLTdUes5eew8t3sR3bFJtCShgniCH3ipRG6CjtXDPqqJnt9OvxmvKJa1QBUTg2YUNGkV
         6CZg==
X-Gm-Message-State: AOAM533/j+z99+ce2gZTTKlG1ZBNwZtVBUscsQJZqye6jDnIpJRi3q9X
        DWfGSXH51Q1lDhzHewewffzgl6WKQAQjyQ==
X-Google-Smtp-Source: ABdhPJys0PPLY9jZbfACZBrBavj3xPjFYCddAf7HHluDmyEJtDLIJe7YzLHxmlBmNxZMEaocQ8xZXA==
X-Received: by 2002:ab0:40a6:: with SMTP id i35mr1470447uad.105.1598627176308;
        Fri, 28 Aug 2020 08:06:16 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 23sm156449vkw.25.2020.08.28.08.06.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id y140so429663vsc.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
X-Received: by 2002:a05:6102:10de:: with SMTP id t30mr1312397vsr.13.1598627175058;
 Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598594714.git.viresh.kumar@linaro.org> <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
 <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
In-Reply-To: <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Aug 2020 08:06:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UP2ZA_GB8nzrpFNP3VzB6AZtEZaagVO5qggW+8EQ0THQ@mail.gmail.com>
Message-ID: <CAD=FV=UP2ZA_GB8nzrpFNP3VzB6AZtEZaagVO5qggW+8EQ0THQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 1:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 28 Aug 2020 at 08:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> > find the OPP table with error -ENODEV (i.e. OPP table not present for
> > the device). And we can call dev_pm_opp_of_remove_table()
> > unconditionally here.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Replaced v1 with v2 on my next branch, thanks!

Actually, I don't see it on there yet, but at least the old broken v1
isn't there anymore.  ;-)

I picked v2 and tried it on my sc7180-based device (which does have
OPP tables).  It worked fine.  Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I looked at the code and it looks right to me.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> Just to be sure, this patch doesn't depend on any changes for the opp
> core that are queued for v5.10?

Running atop mmc-next, I see the check for -ENODEV, so I'm gonna
assume that the required change is there.

$ git grep -A10 'void _dev_pm_opp_find_and_remove_table' -- drivers/opp/core.c
drivers/opp/core.c:void _dev_pm_opp_find_and_remove_table(struct device *dev)
drivers/opp/core.c-{
drivers/opp/core.c-     struct opp_table *opp_table;
drivers/opp/core.c-
drivers/opp/core.c-     /* Check for existing table for 'dev' */
drivers/opp/core.c-     opp_table = _find_opp_table(dev);
drivers/opp/core.c-     if (IS_ERR(opp_table)) {
drivers/opp/core.c-             int error = PTR_ERR(opp_table);
drivers/opp/core.c-
drivers/opp/core.c-             if (error != -ENODEV)
drivers/opp/core.c-                     WARN(1, "%s: opp_table: %d\n",
