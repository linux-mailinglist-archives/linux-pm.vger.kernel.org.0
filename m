Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2427232D4B3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhCDN5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 08:57:07 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36263 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCDN4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 08:56:35 -0500
Received: by mail-ot1-f50.google.com with SMTP id t16so7752447ott.3;
        Thu, 04 Mar 2021 05:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHogkY4V5mONQFOtEdkCE541qP3bkZZgaaRz4f+IIx8=;
        b=NhwCvt7gE1SeLtH+ol0B9WPimMzeLbf3dsDzbpkYsJXhExfrefSL58ygkMv8PXBBCT
         y2ZybnjMONHMYjM6VoCpq/SMJWfkC9Mm2OOv/65JfDEsK21g2+LsBcAQp01Q4Qrp7eOv
         PKpIe2Ondnyx0mO1Wpa43QC+aZa8P0b9rJmcjege93u0nctTjByEckXLx7pto6cD28h8
         QaiLmZIQt/3oKapI/HYLpU2tKBH6UxI9PAWoIOmIOhWk6IKKscEEyVOspArR46Ci/pMa
         SOk+t6IPuuyFraKUC/OaOy8qs1Ua/3znpmTFEtI9pAFAyQSpw7pHkGVcDYI8UnG3j3PC
         kOIQ==
X-Gm-Message-State: AOAM5339gMrpGMcVAp4YWh3tinrVEEYtcxQvL+TRM67fP534N7NAeDbK
        0gqfXmG1r99lrxsh21V2ut1NanoBh5U72PuTmjE=
X-Google-Smtp-Source: ABdhPJyehjD92uivEn/olMcQk5flNsJYmnVCq679v2OVzwprVmaLdTaltkALxkqQdStBSD+MmF0V0VvnGKGc4//PIsA=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr3683936otp.206.1614866155283;
 Thu, 04 Mar 2021 05:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20210302095405.28453-1-digetx@gmail.com> <36f5d767-d021-d1cb-dfc1-7b9dd63d7d9f@linaro.org>
In-Reply-To: <36f5d767-d021-d1cb-dfc1-7b9dd63d7d9f@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Mar 2021 14:55:43 +0100
Message-ID: <CAJZ5v0hZKsTnFSrchxo_=jTv7qzoHgsq6W_5Gj4TWWjU5y71jQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on Tegra114
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 4, 2021 at 1:30 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 02/03/2021 10:54, Dmitry Osipenko wrote:
> > Trusted Foundation firmware doesn't implement the do_idle call and in
> > this case suspending should fall back to the common suspend path. In order
> > to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
> > firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
> > C7 idling, like it was done by the older Tegra114 cpuidle driver.
> >
> > Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
> > Cc: stable@vger.kernel.org # 5.7+
> > Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> > Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> > Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

So do I gather correctly that I am expected to pick up this series?
