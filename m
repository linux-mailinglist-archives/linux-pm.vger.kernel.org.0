Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689013FC718
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhHaMMK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 08:12:10 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42695 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbhHaMJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 08:09:15 -0400
Received: by mail-oi1-f182.google.com with SMTP id bi4so20265888oib.9
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 05:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wIn4VVmqEVSFZKpPg+VZ0U22VYwBxjFc1PBxHfoi94=;
        b=G4tlWF80Eo6lKn0gc0yaXVEoANtOBtsvosx2iZRMd+e6Co0tNFFa4s5OtKK1eZbPLR
         lk58A6hLB7u1cI6U7J9ekU3UKpFdkfQ1rr+Yxwcu/7Zi7Soi6N5fxJeZX1Ggdx3LppZJ
         GnKehG/U5cPGxKFMKKtg5XATXw1LEH30fQcyTNbOlNhOLdNZEWPY/hIeUz/yPOpoH6e8
         +VJFiW9Ngy4C5KXJgCYbp2cisB9NTiqydsMf2lIUQI7HIJCDrFxTiPwq14kyWnKGEp6y
         hdEtsExsA0qvigXjm6/9puz0eN0UNbv4Heota7GtCrkPMaDXspFJ8czwvJMA2jhfzdus
         KUJA==
X-Gm-Message-State: AOAM532QuNIGErYAOpjs8Kh/NIFtA+1tAJiXk0rIcPR5RFUvXmZ0M0Qg
        qLxyQT3mUNHSdMc8dOhnVOZUS02xDlCX3T0v0WY=
X-Google-Smtp-Source: ABdhPJywjqx9c6rKrL7RDzsvbKN2uZFsH1Ul5h6om+KsQBYr1CjsXwiZsT/5EbHgWF6F/wmLjVhEXYdr+wt/nfFPZuE=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr2876638oie.71.1630411697805;
 Tue, 31 Aug 2021 05:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210831055945.cnyi2qheipfv2q3q@vireshk-i7>
In-Reply-To: <20210831055945.cnyi2qheipfv2q3q@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Aug 2021 14:08:06 +0200
Message-ID: <CAJZ5v0hfFOJAa75Cwp=oH4OEy7yk97ri8LxpR==UOCxH7XM2Kw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.15-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 31, 2021 at 7:59 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Updates cpufreq-dt blocklist with more platforms (Bjorn Andersson).
>
> - Allow freq changes from any CPU for qcom-hw driver (Taniya Das).
>
> - Add DSVS interrupt's support for qcom-hw driver (Thara Gopinath).
>
> - A new callback (->register_em()) to register EM at a more convenient
>   point of time.
>
> Thanks.
>
> --
> Viresh
>
> -------------------------8<-------------------------
> The following changes since commit 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:
>
>   cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to f0712ace7fe0723b40733c3b98591d34c1b0bfb9:
>
>   cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag (2021-08-30 10:43:35 +0530)

Pulled, thanks!


> ----------------------------------------------------------------
> Bjorn Andersson (1):
>       cpufreq: blocklist more Qualcomm platforms in cpufreq-dt-platdev
>
> Taniya Das (1):
>       cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag
>
> Thara Gopinath (1):
>       cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
>
> Viresh Kumar (10):
>       cpufreq: vexpress: Set CPUFREQ_IS_COOLING_DEV flag
>       cpufreq: Add callback to register with energy model
>       cpufreq: dt: Use .register_em() to register with energy model
>       cpufreq: imx6q: Use .register_em() to register with energy model
>       cpufreq: mediatek: Use .register_em() to register with energy model
>       cpufreq: omap: Use .register_em() to register with energy model
>       cpufreq: qcom-cpufreq-hw: Use .register_em() to register with energy model
>       cpufreq: scpi: Use .register_em() to register with energy model
>       cpufreq: vexpress: Use .register_em() to register with energy model
>       cpufreq: scmi: Use .register_em() to register with energy model
>
>  drivers/base/arch_topology.c           |   2 +
>  drivers/cpufreq/cpufreq-dt-platdev.c   |   4 +
>  drivers/cpufreq/cpufreq-dt.c           |   3 +-
>  drivers/cpufreq/cpufreq.c              |  13 +++
>  drivers/cpufreq/imx6q-cpufreq.c        |   2 +-
>  drivers/cpufreq/mediatek-cpufreq.c     |   3 +-
>  drivers/cpufreq/omap-cpufreq.c         |   2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c      | 151 ++++++++++++++++++++++++++++++++-
>  drivers/cpufreq/scmi-cpufreq.c         |  65 +++++++++-----
>  drivers/cpufreq/scpi-cpufreq.c         |   3 +-
>  drivers/cpufreq/vexpress-spc-cpufreq.c |  25 +-----
>  include/linux/cpufreq.h                |  14 +++
>  12 files changed, 233 insertions(+), 54 deletions(-)
>
