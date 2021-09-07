Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDE402A02
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbhIGNpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 09:45:42 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42784 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbhIGNpl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 09:45:41 -0400
Received: by mail-ot1-f53.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so12779247otk.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 06:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAPBKOYhzV7jRm1mG5VVCuPsX4TO1sLalKxGJg79RkU=;
        b=qkQLA/6A76dVW0wuxjaNUCWnTp6uMtHgnj+cpN4QJzFiXyw+qPwwpAuOFeyiz8hq8h
         bfDI7HqPRA4PlyK1FHZdLl3Ks6Ykaoed7lqvpCbDFnTiYFgwQmWiapx+dnD/OKHLmg2q
         X4HtBV2YDOTb1krXH3qPKq4GQZV117Ge0KMrgnQaPt/b0QZTpCGCBQba6MlzQx06kuAN
         /Xpb/320QR8b5PGu00Odhm0I2czD+gdtw8s3WR3iO+EmG9FHPhpsbihwSswiRHiAwez9
         1uzlGgfFrACo6GlMEUbwJSHLslXoReUJziCqvOP0yEx1RqV2i87LaxQdQ3UFYqsPEgZM
         B7sA==
X-Gm-Message-State: AOAM531rmdjGAUiUQGSZrH+fkf/HUmefXnSaMDvn56870vc87YvRzT/Y
        WeeFbiRx79mL864prrDV/HvVnh7b5j0TiU8mQEoFL6SI
X-Google-Smtp-Source: ABdhPJzAeM4CpyzxDTx0rvqOebTK684lOuJig61SoxWfSRPFSpdzJNgOPXK6wg+V4SvmGrgWghwizeVHHhMkF9C5faY=
X-Received: by 2002:a9d:6945:: with SMTP id p5mr15466292oto.301.1631022275101;
 Tue, 07 Sep 2021 06:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210907035957.lczjqwtwmt4qomcm@vireshk-i7>
In-Reply-To: <20210907035957.lczjqwtwmt4qomcm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Sep 2021 15:44:24 +0200
Message-ID: <CAJZ5v0i9ip50Wc03XytA7Afp6-fxmSYO9qAA-ZcLHMtCpB0s4A@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.15-rc1 - part 2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 7, 2021 at 6:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request adds a new cpufreq driver for Mediatek, which had
> been going through reviews since last one year.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit f0712ace7fe0723b40733c3b98591d34c1b0bfb9:
>
>   cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag (2021-08-30 10:43:35 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to 4855e26bcf4d28956f3e33231b961610a0d4a72d:
>
>   cpufreq: mediatek-hw: Add support for CPUFREQ HW (2021-09-06 15:15:19 +0530)

Pulled, thanks!
