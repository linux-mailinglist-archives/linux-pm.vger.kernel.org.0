Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137CA23B912
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgHDKt1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:49:27 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:43112 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgHDKtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 06:49:15 -0400
Received: by mail-oo1-f65.google.com with SMTP id z10so5034165ooi.10
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2020 03:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/On6ZgNYB8YxIH3yDaRVcVeBuh71uUEclmiTFe7MeX0=;
        b=t2s4W8KEZcjOENx9gfoBjtSj5PRbB4jZPo2U0rLC5SXYXqUdi9b+3tbvwgXNLe0s+N
         Q2fgi/PLetmFDmq4XyCezpFdj5hHA+BrDIK7xMFCfF2kq6jPT4+HfHdJhHgE7F4P0pyh
         1JYt9lJGv5opJHgvkNY1Fje6awCheynO1mT/2RQz1Zx8bdo3RTzT2wC2n4XBmIrQm1y6
         tlpei4B8qRI8fJczpcm//etL90pR0Y7Cl7BboUdOTTQKefJK5KFHLAKMvt98cIiUIb1Y
         g5mC8bNJ8uXBHBwX6By+4PJHXy2mTbwbBdq5qUDmy1Q/b9B6x1NMnDojpVEC6/vee/R7
         QZTA==
X-Gm-Message-State: AOAM530Xsaxg9YFoZJTIjPsRvBHsFT04TrZsdRb39EDpGJoHS8ChRPN6
        36D4ojZa1Et+yz2CXF+FcRb4DpzPcEUV1aJkPI7NIQ==
X-Google-Smtp-Source: ABdhPJwbjqVcvg+eKQh1fY0/2Uta22WlOND/HBp4+lykGXfQM5ifS13KNqREq62bm65xSZPjMgxcpDSVQkdXA9OiYvg=
X-Received: by 2002:a4a:e618:: with SMTP id f24mr17973085oot.75.1596538154120;
 Tue, 04 Aug 2020 03:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200804022822.raefjhxjvyqzrmho@vireshk-mac-ubuntu>
In-Reply-To: <20200804022822.raefjhxjvyqzrmho@vireshk-mac-ubuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Aug 2020 12:49:02 +0200
Message-ID: <CAJZ5v0g1SvcigeB6DioFk6A=cuHXD2CebXc1-Go2VAkjO_DsLw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.9
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Tue, Aug 4, 2020 at 4:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> I wanted to do this last week, but couldn't as some conflict came in
> for the OPP patch which multiple trees wanted for dependencies.

No worries, I have other PM changes for this merge window.

> Here are the details:
>
> - Adaptive voltage scaling (AVS) support and minor cleanups for
>   brcmstb driver (Florian Fainelli and Markus Mayer).
>
> - A new tegra driver and cleanup for the existing one (Sumit Gupta and
>   Jon Hunter).
>
> - Bandwidth level support for Qcom driver along with OPP changes (Sibi
>   Sankar).
>
> - Cleanups to sti, cpufreq-dt, ap806, CPPC drivers (Viresh Kumar, Lee
>   Jones, Ivan Kokshaysky, Sven Auhagen, and Xin Hao).
>
> - Make schedutil default governor for ARM (Valentin Schneider).
>
> - Fix dependency issues for imx (Walter Lozano).
>
> - Cleanup around cached_resolved_idx in cpufreq core (Viresh Kumar).
>
> --
> viresh
>
> -------------------------8<-------------------------
>
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
>
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to f259eab3ea0e7ed73db91f6358274dd3a9a27d79:
>
>   cpufreq: make schedutil the default for arm and arm64 (2020-07-30 11:40:29 +0530)

Pulled, thanks!
