Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3AEA9B4F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfIEHLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 03:11:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37101 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbfIEHLw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 03:11:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id s28so1133906otd.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 00:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbehCZw0tfXlBPcCwyJ3AgjD06owLHnyHsT8jVPUCgs=;
        b=BMV1I8cspfmj3/+zlH5JQf78kfBEh1coFOwlcG95v1ZCW92pAxaPOnSbw07CUW7QL7
         r5OxW7+SWCHmTyHVtVMDHyTMnX/lkiMWvJ9gWW9Y7PV3nRj/yyuHlSs2k5BL7dvHG8uA
         L2LRdxLvo54/5Z1I+ONed92EfdKlLj4oFuHidE1Cnp/KiXtHNyncH6K48JyKpROUCTUp
         jCKbANwBintKwT7SieICJDC7oJxdT6K4Z00Ba2ZcSAHBRy2ScxyKBcIIWqk8iMpH4ZhM
         n+Ud5T+HssOr5DVuRE/7EXXPRiHDvLCXXqswkE1+c1n981fcNspnFvnKtCd/+abKlUJb
         3rsA==
X-Gm-Message-State: APjAAAUUKJMOyngAulOKN2z9oE4wd9cTlzr0idG7DUFdpWT448pBjgmD
        dCIYZET6Z6hB9JlY5yukhuvX4fRbvqdRRimnytQ=
X-Google-Smtp-Source: APXvYqylI0Qbs8HwGy3XSTcW4Fn1jaM9FP2MDH409cWRuwXcRVX4+FHKgXqz/dJWZkeeCoFkJNJmJL6uwDKGG9x72s0=
X-Received: by 2002:a9d:6d04:: with SMTP id o4mr1263601otp.189.1567667511510;
 Thu, 05 Sep 2019 00:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190905031120.ds7aic7txzuapleh@vireshk-i7>
In-Reply-To: <20190905031120.ds7aic7txzuapleh@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Sep 2019 09:11:36 +0200
Message-ID: <CAJZ5v0gtrt0QfWD1+u9Y5v==16vVwmKA66A9Hc-Wj+iTRkY4YA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.4
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 5, 2019 at 5:11 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Minor fixes for mediatek driver (Andrew-sh.Cheng and Fabien Parent).
> - Minor updates for imx driver (Anson Huang).
> - Minor fix for ti-cpufreq driver (Gustavo A. R. Silva).
> - Minor fix for ap806 driver (Hariprasad Kelam).
> - Significant updates to qcom cpufreq drivers, mostly to support CPR
>   stuff (Jorge Ramirez-Ortiz, Niklas Cassel, Sibi Sankar, Douglas
>   RAILLARD and Sricharan R).
> - New sun50i cpufreq driver (Yangtao Li).
>
> - This pull request also contains few OPP changes as well, which were
>   required because of dependencies for the qcom cpufreq changes. They
>   will be detailed in the OPP pull request.
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to f75d2accca7785657311653c125bb22f342dc5d9:
>
>   Merge branch 'cpufreq/qcom-updates' into cpufreq/arm/linux-next (2019-09-03 07:55:22 +0530)

Pulled and pushed out, thanks!
