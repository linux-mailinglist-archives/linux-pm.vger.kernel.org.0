Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A622AAA4D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Nov 2020 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgKHJZj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 04:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgKHJZh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Nov 2020 04:25:37 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D0720719;
        Sun,  8 Nov 2020 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604827536;
        bh=0Re+BH04OjvQtiodOP0PAVO/kqbxE/PMUbtENeeHUCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T8aftoYJoOfJoY2D59wtyqCFPrcSPDuCqBe6z9Y88z18itxLZYrLQQoUiySYprX/w
         CeltL21788RGxrGqCPGHjUWJsuUW/aiyLgkfQF5xQteJWVIw4gGxwp93kbsT47/9ed
         KFVVrs14i0T/haKa/knwEHH/Xo7Crf9KJaPhdmXY=
Received: by mail-lj1-f171.google.com with SMTP id r17so693827ljg.5;
        Sun, 08 Nov 2020 01:25:35 -0800 (PST)
X-Gm-Message-State: AOAM5335wt3uT3SLq365qpcyGeMWT4K9imATGHktiEFQSWv9lqgxs+Pk
        re73Q0gs2V+w/MHHyiwkoNSjw5m3HQY3g0MvC+g=
X-Google-Smtp-Source: ABdhPJyddR8brDR4uTwLcrWRTsQ0eYz6SRGBrDUoAv5c7VKMt2AwiBlznvTTelNyXgQ/X1oyJ30XbCrkOlR4o4w9iyo=
X-Received: by 2002:a2e:b536:: with SMTP id z22mr4077018ljm.177.1604827534166;
 Sun, 08 Nov 2020 01:25:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604646059.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1604646059.git.viresh.kumar@linaro.org>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Sun, 8 Nov 2020 11:25:22 +0200
X-Gmail-Original-Message-ID: <CA+5LGR0UwGUeXPw3Jbd7=VkY7fY_rKV_YjLpWV4GbHnvP23Ejg@mail.gmail.com>
Message-ID: <CA+5LGR0UwGUeXPw3Jbd7=VkY7fY_rKV_YjLpWV4GbHnvP23Ejg@mail.gmail.com>
Subject: Re: [PATCH 0/7] opp: Allow dev_pm_opp_put_*() APIs to accept NULL opp_table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Ilia Lin <ilia.lin@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Qiang Yu <yuq825@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, digetx@gmail.com,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reviewed-by: Ilia Lin <ilia.lin@kernel.org>


On Fri, Nov 6, 2020 at 9:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hello,
>
> This patchset updates the dev_pm_opp_put_*() helpers to accept a NULL
> pointer for the OPP table, in order to allow the callers to drop the
> unnecessary checks they had to carry.
>
> All these must get merged upstream through the OPP tree as there is a
> hard dependency on the first patch here. Thanks.
>
> Viresh Kumar (7):
>   opp: Allow dev_pm_opp_put_*() APIs to accept NULL opp_table
>   cpufreq: dt: dev_pm_opp_put_regulators() accepts NULL argument
>   cpufreq: qcom-cpufreq-nvmem: dev_pm_opp_put_*() accepts NULL argument
>   devfreq: exynos: dev_pm_opp_put_*() accepts NULL argument
>   drm/lima: dev_pm_opp_put_*() accepts NULL argument
>   drm/panfrost: dev_pm_opp_put_*() accepts NULL argument
>   media: venus: dev_pm_opp_put_*() accepts NULL argument
>
>  drivers/cpufreq/cpufreq-dt.c                   |  6 ++----
>  drivers/cpufreq/qcom-cpufreq-nvmem.c           | 15 ++++++---------
>  drivers/devfreq/exynos-bus.c                   | 12 ++++--------
>  drivers/gpu/drm/lima/lima_devfreq.c            | 13 ++++---------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c    |  6 ++----
>  drivers/media/platform/qcom/venus/pm_helpers.c |  3 +--
>  drivers/opp/core.c                             | 18 ++++++++++++++++++
>  7 files changed, 37 insertions(+), 36 deletions(-)
>
> --
> 2.25.0.rc1.19.g042ed3e048af
>
