Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5213B4813
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYRRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 13:17:32 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40915 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYRRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 13:17:32 -0400
Received: by mail-oi1-f174.google.com with SMTP id d19so12047252oic.7;
        Fri, 25 Jun 2021 10:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFasrYsFKAvywn6faqXn2vvEdZnYR9YwEezboB1Quws=;
        b=nLNcX1yv1zFEZQ++DYZdUsquyeDnRQ+PcLmYoKwwMdkDl/M6GPqHBp6f7pmGqI/rLb
         3MDSascO7qZa91YXQuX0OfteWFyqnnwUQjUVrdv3gXrumOPkXyDK212zJz7q0SsxOHul
         abgfGHrbM5oSjcSasrVhbYN1qTRdsjZE2EPjOb6PNOapUJoUfo8zgZcwxi/mbiOtSARH
         0cj33wCTqwhmuu+0PqATxrTi785O2xWbvylL45HK+O0oeBy+3aFbnj2oy36SimijqMNL
         lPd5JnDuf5Dxa+GSUbH0nFjBfrYN88SFJQi67ZCVTTd3KRetr9DMvtJ775O4f/D5CEYG
         glxg==
X-Gm-Message-State: AOAM530RH5SpKXrL3c0o+juuXbsIuupJ/AcsAWAZMu/0ftG4d0Z/otXa
        z1dOp0j/Un7tQUfbNlQcOAoIA/ipUxXdiY6KR+8=
X-Google-Smtp-Source: ABdhPJz3e/ZIkYVsF8SpYOwSc4i3w+5rC/iXH4mm2ml86brcbnPkozeJHRAx9+ZLF19XEDJ4ayGXz11eAWOVMZJIxVg=
X-Received: by 2002:aca:d11:: with SMTP id 17mr1504892oin.69.1624641311276;
 Fri, 25 Jun 2021 10:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210625110341epcas1p32171bda25f6020b090537e15e763d5eb@epcas1p3.samsung.com>
 <b020c243-3175-3e31-8b7c-e1b30572e6d9@samsung.com>
In-Reply-To: <b020c243-3175-3e31-8b7c-e1b30572e6d9@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jun 2021 19:15:00 +0200
Message-ID: <CAJZ5v0jqMXzcMdZx-P5_xp7_rJL1H_4FG+2HJRrG25+mWuv7BA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.14
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 25, 2021 at 1:03 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.14-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.

Pulled, thanks!


> The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:
>
>   Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.14
>
> for you to fetch changes up to 8c37d01e1a86073d15ea7084390fba58d9a1665f:
>
>   PM / devfreq: passive: Fix get_target_freq when not using required-opp (2021-06-24 10:37:35 +0900)
>
> ----------------------------------------------------------------
> Detailed description for this pull request:
>
> 1. Update devfreq core
> - Use DEVICE_ATTR_RW macro for devfreq userspace governor
>
> - Add missing error code in devfreq_add_device()
>
> - Fix get_target_freq when not using required-opp
>
> - The 86ad9a24f21e ("PM / devfreq: Add required OPPs support to passive governor")
> supported the required-opp property for using devfreq passive governor.
> But, 86ad9a24f21e has caused the problem on use-case when required-opp
> is not used. So that fix the passive governor for supporting the case of when
> required-opp is not used.
>
> 2. Update devfreq driver
> - Remove unneeded get_dev_status and polling_ms from imx-bus.c because
> imx-bus.c doesn't support simple_ondemand.
>
> - Remove unneeded DEVFREQ_GOV_SIMPLE_ONDEMAND dependecy from imx8m-ddrc.c
> because it doesn't support simple_ondemand governor.
>
> - Use tegra30-devfreq.c as thermal cooling device
> - Convert dt-binding doc style to yaml and add cooling-cells property
> information to dt-binding doc for tegra30-devfreq.c
> ----------------------------------------------------------------
>
> Chanwoo Choi (1):
>       PM / devfreq: passive: Fix get_target_freq when not using required-opp
>
> Dmitry Osipenko (3):
>       PM / devfreq: tegra30: Support thermal cooling
>       dt-bindings: devfreq: tegra30-actmon: Convert to schema
>       dt-bindings: devfreq: tegra30-actmon: Add cooling-cells
>
> Dong Aisheng (2):
>       PM / devfreq: imx-bus: Remove imx_bus_get_dev_status
>       PM / devfreq: imx8m-ddrc: Remove DEVFREQ_GOV_SIMPLE_ONDEMAND dependency
>
> YueHaibing (2):
>       PM / devfreq: Add missing error code in devfreq_add_device()
>       PM / devfreq: userspace: Use DEVICE_ATTR_RW macro
>
>  .../bindings/arm/tegra/nvidia,tegra30-actmon.txt   |  57 ----------
>  .../bindings/devfreq/nvidia,tegra30-actmon.yaml    | 126 +++++++++++++++++++++
>  drivers/devfreq/Kconfig                            |   1 -
>  drivers/devfreq/devfreq.c                          |   1 +
>  drivers/devfreq/governor_passive.c                 |   3 +-
>  drivers/devfreq/governor_userspace.c               |  10 +-
>  drivers/devfreq/imx-bus.c                          |  14 ---
>  drivers/devfreq/tegra30-devfreq.c                  |   1 +
>  8 files changed, 135 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
