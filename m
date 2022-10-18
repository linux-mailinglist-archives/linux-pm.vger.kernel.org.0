Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D78602C32
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJRMxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJRMxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 08:53:34 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAB6C34CD
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 05:53:33 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id de14so9204772qvb.5
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 05:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/71xEgCu9k6XZrQPgQ/3X/Oa2dhcLmjFgOgRm4PWVE=;
        b=wqaC6J4E0kKKiqU+JvgBMU+jDqlNJKza13NIYLhKhFjtGrZzhS2/S8XGHhamPvScOm
         hTdRD9Qn1kwubZHguF99XhgLfHW02Vek+y/1sVBh8vI0Smn+RaSwZHwQEt5dcuXeo9gR
         44T5FpouaSPZQ8o8tdXgIU59YGykzybEWqdR3Y9PrZG3F17hp3WdcZGasNs9qzGzt5au
         1+h7LB6wNyKsybOuZrUJcLqiHLQJLKT1fKFt0icDSSg/VsdP3uq1OCwVsV3iz1Ob5sKE
         sRDgKm4V1K24ClgMEZZfq1pS9ct44VDC7aPuJl3amt5SrkI3bkIUqNCNu8OXXORDYQib
         2ADA==
X-Gm-Message-State: ACrzQf3NbWIyEd+kWoQjF6FpFq2XljGXJNDJ1bFdCuU35J3UOb+7j2lt
        WvLacVLNgItHaayjLRdIQeBaBqmJ2+pt0OuLQYM=
X-Google-Smtp-Source: AMsMyM41i4DCLQyQaiAHUo5kBQjKNYboe24fBCXzuT/gMoBDwN8/srCShpWEdSmJdtVdnJV0g3E7GCyim2H0ECFWC9s=
X-Received: by 2002:a05:6214:f24:b0:4b3:efeb:d800 with SMTP id
 iw4-20020a0562140f2400b004b3efebd800mr1943822qvb.15.1666097612453; Tue, 18
 Oct 2022 05:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221018105904.ab3mtqgja5jk3twf@vireshk-i7>
In-Reply-To: <20221018105904.ab3mtqgja5jk3twf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Oct 2022 14:53:21 +0200
Message-ID: <CAJZ5v0jwvF4T_KKc9xLG++DKfkyJ3-kgmTmWJNVcvVAQCMEDMg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.1-rc
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 18, 2022 at 12:59 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:
>
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.1-rc
>
> for you to fetch changes up to 889a50aedcd216cc5f2b98bb2412f0498d417721:
>
>   cpufreq: sun50i: Switch to use dev_err_probe() helper (2022-10-18 16:22:26 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm fixes / cleanups for 6.1-rc
>
> - Fix module loading in Tegra124 driver (Jon Hunter).
> - Fix memory leak and update to read-only region in qcom driver (Fabien
>   Parent).
> - Miscellaneous minor cleanups to cpufreq drivers (Fabien Parent and
>   Yang Yingliang).
>
> ----------------------------------------------------------------
> Fabien Parent (3):
>       cpufreq: qcom: fix memory leak in error path
>       cpufreq: qcom: fix writes in read-only memory region
>       cpufreq: qcom: remove unused parameter in function definition
>
> Jon Hunter (1):
>       cpufreq: tegra194: Fix module loading
>
> Yang Yingliang (4):
>       cpufreq: dt: Switch to use dev_err_probe() helper
>       cpufreq: imx6q: Switch to use dev_err_probe() helper
>       cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
>       cpufreq: sun50i: Switch to use dev_err_probe() helper
>
>  drivers/cpufreq/cpufreq-dt.c           |  6 ++----
>  drivers/cpufreq/imx6q-cpufreq.c        |  4 +---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 25 +++++++++++++------------
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c |  9 +++------
>  drivers/cpufreq/tegra194-cpufreq.c     |  1 +
>  5 files changed, 20 insertions(+), 25 deletions(-)
>
> --

Pulled and pushed into my linux-next branch, thanks!
