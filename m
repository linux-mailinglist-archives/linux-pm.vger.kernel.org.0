Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA71C7076
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgEFMjK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728113AbgEFMjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 08:39:09 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BF8C061A41
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 05:39:09 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id i185so461682vki.12
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2020 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jk2BARTLAgZL9Z1dR3KbfuvtdoJ3V9bQ1jv2jjnLH8E=;
        b=C4fCOVohLS2kPCD5qFz2dgOue6s94XhvkFpTCsrha1pcYweNjF+IaH6gRIdYmJqdqm
         oFgp+EDGp1FMsPCUrEo3ltTYWEoPSWIqbS9ayAQR69ak7Y+0fdpCj4xhzzsWBANxQYHy
         Lf+rFL+y9fxw2qfR9166c35tiHl+m4NraUF/1aejcq7nzecJqYKk9oiR2DEzqt9ExSkY
         KTXJ1/ltUftlp1HurqkUDnB4uF0yk7YH5lBAZV2tuzjt9fldDbYWU/UAKCReVqHSkL/x
         4UzaeL1ygRqYcDPDkaSN8y88nDqRAo363pHInp7N0ypbCm1mJd3tQuJgl4t8W+HC2lpk
         ccCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jk2BARTLAgZL9Z1dR3KbfuvtdoJ3V9bQ1jv2jjnLH8E=;
        b=nX859lms4cHbH519nVKeFb6GOloPlV9WNHMg7JfoY0MiGCeQ5xlumQqhUgBecjsztP
         4yTTDAgqKXFQW5k9k1bbqXFczPWV5YrNMg1sLc9c6VOQauaMpXhBDS69eWqXPnuWbDf+
         z48+9WYZ2DdIm0LmR9D0Q7fOypgxeibBbrhMGZIBz2yCqSl0SiJRiF0CnwqZ2kEXtVZk
         nIenr69CmxWul9LQ+lK7eOPLCpIE7dvddZqQRAeUOWyQxUe6EfmZAAWeKn/oUmp5aA0C
         e62AFkLSoCLCl3KUUb+qAcdSajnwqP5NyjOVfTFma7A3TK5GiInuK1TtZLTIqKdPjL3d
         J7aA==
X-Gm-Message-State: AGi0PuZHV3PvPHD8hJNWPzpeYa3gvbgSxfrN18MgK3VxOVg/SSgylFl2
        YIqKK1zR4UZ4HW/bOmWY5QBTvCzgWIeu3ArbrmGDuA==
X-Google-Smtp-Source: APiQypJLk71XFPxOIJWwAizMUmAtKTR+K2mXUHbcP1wbAfkC3uIULbDNR6nha/+qS/WeZu7Io0k/dKD30Nke5CY6x+c=
X-Received: by 2002:a1f:2a13:: with SMTP id q19mr6528853vkq.73.1588768748823;
 Wed, 06 May 2020 05:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200504202243.5476-1-sibis@codeaurora.org>
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 6 May 2020 18:08:34 +0530
Message-ID: <CAHLCerM_wdHDwzEDN7YxU9pBdHo3KvNyJeRWMC6seTG6aCH7nw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 5, 2020 at 1:54 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This patch series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
>
> Patches [1-3] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [4-8] - Update bw levels based on cpu frequency change
> Patches [9-10] - Add tag setting support to OPP
> Patches [11-12] - Add the cpu opp tables for SDM845 and SC7180 SoCs.
>
> Depends on the following series:
> https://lore.kernel.org/patchwork/cover/1230626/

Are there any other dependencies for this series? I tried applying
this on top of Georgi's series on v5.7-rc3. Patch 12 didn't apply
cleanly and needed a manual fixup for the include change.

Compilation failed with:
Error: /home/amit/work/sources/worktree-review-pipeline/arch/arm64/boot/dts/qcom/sc7180.dtsi:101.30-31
syntax error
FATAL ERROR: Unable to parse input tree

I've been squinting at the offending lines with no success:
                        interconnects = <&gem_noc MASTER_APPSS_PROC
&mc_virt SLAVE_EBI1>,
                                        <&osm_l3 MASTER_OSM_L3_APPS
&osm_l3 SLAVE_OSM_L3>;

> Georgi,
>  Would it make sense to include tag support patches [9-10] in your next
>  re-spin?
>
> V4:
>  * Migrate to using Georgi's new bindings
>  * Misc fixups based on Matthias comments
>  * API fixups based on Bjorn's comments on v2
>  * Picked up a few R-bs from Matthias
>
> v3:
>  * Migrated to using Saravana's opp-kBps bindings [1]
>  * Fixed some misc comments from Rajendra
>  * Added support for SC7180
>
> v2:
>  * Incorporated Viresh's comments from:
>  https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>  https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
>  * Dropped cpufreq-map passive governor
>
> Sibi Sankar (12):
>   arm64: dts: qcom: sdm845: Add SoC compatible to MTP
>   cpufreq: blacklist SDM845 in cpufreq-dt-platdev
>   cpufreq: blacklist SC7180 in cpufreq-dt-platdev
>   OPP: Add and export helper to update voltage
>   OPP: Add and export helper to set bandwidth
>   cpufreq: qcom: Update the bandwidth levels on frequency change
>   OPP: Add and export helper to get icc path count
>   cpufreq: qcom: Disable fast switch when scaling ddr/l3
>   dt-bindings: interconnect: Add interconnect-tags bindings
>   OPP: Add support for setting interconnect-tags
>   arm64: dts: qcom: sdm845: Add cpu OPP tables
>   arm64: dts: qcom: sc7180: Add cpu OPP tables
>
>  .../bindings/interconnect/interconnect.txt    |   5 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 168 ++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 258 ++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
>  drivers/cpufreq/qcom-cpufreq-hw.c             |  89 +++++-
>  drivers/opp/core.c                            | 114 ++++++++
>  drivers/opp/of.c                              |  25 +-
>  include/linux/pm_opp.h                        |  22 ++
>  9 files changed, 675 insertions(+), 10 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
