Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22645EFDE5
	for <lists+linux-pm@lfdr.de>; Thu, 29 Sep 2022 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiI2TZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiI2TZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 15:25:17 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A13520B6
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 12:25:16 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 3so1505974qka.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 12:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=N4NVBv3/A4SsPXdzJa+oEXCquAmnLx2QR4QbpRjugXc=;
        b=BhMBaxvJrUtGtQ8Hos21KGtyUHzqCEWhhjUjM97hmjI/QI1r5GIOYepA0jyMR1z3jQ
         ABEi03ti5pKZHV8D138fLbA9sY5hw/1SU9SmGU4ktULqjhnZVO1kJwC6eVG0BMf3ska5
         P2BJANTPiQ+FDcnfYsE7gMN2G+J2bJUYnN0NkuvGeHKiub100jTXL6ZUwfBn+ENaiHKB
         gHYoalP9/TqsL9g5xAm9Q9dvy2JYhyiiupyxFUqa73svAnWAYk6OJ3cEQ3PLUQ3cX9U6
         aa+0gnGjQDGY9QNDMF/gqevC/Vz8xWSHEM780jkKa6HoeQDYrxtbVTNCsjCdmgkETc7k
         ZYag==
X-Gm-Message-State: ACrzQf1IcFbVY6HjwdPMMO8G9X+MtictwqLRxzniGu9nfzE/144pPFP7
        4oQqu/QCbr9oCno6Vy1g6KIwLwpP209SX937FX0=
X-Google-Smtp-Source: AMsMyM4yZxBASYpRV1MbwZhpEbOG2FrNEqyeiY4nyD26MaoQZH/++tLQZpTwpd86mNqdzB/r4gxv/DEm7qMhMcFZ89A=
X-Received: by 2002:a05:620a:46ac:b0:6ce:3e55:fc21 with SMTP id
 bq44-20020a05620a46ac00b006ce3e55fc21mr3442039qkb.285.1664479516050; Thu, 29
 Sep 2022 12:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220926103520.jzqzjijbnfrr24yt@vireshk-i7>
In-Reply-To: <20220926103520.jzqzjijbnfrr24yt@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Sep 2022 21:25:05 +0200
Message-ID: <CAJZ5v0i+7aqm0Yx56Xa66Kt84REnhiYViLzSGaUg0F1stLpnnw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.1
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

On Mon, Sep 26, 2022 at 12:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
>
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.1
>
> for you to fetch changes up to c4c0efb06f17fa4a37ad99e7752b18a5405c76dc:
>
>   cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh (2022-09-26 14:05:45 +0530)
>
> ----------------------------------------------------------------
> cpufreq/arm updates for 6.1-rc1
>
> - Add SM6115 to cpufreq-dt blocklist (Adam Skladowski).
> - Add support for Tegra239 and minor cleanups (Sumit Gupta, ye xingchen,
>   and Yang Yingliang).
> - Add freq qos for qcom cpufreq driver and minor cleanups (Xuewen Yan,
>   and Viresh Kumar).
> - Minor cleanups around functions called at module_init() (Xiu Jianfeng).
> - Use module_init and add module_exit for bmips driver (Zhang Jianhua).
>
> ----------------------------------------------------------------
> Adam Skladowski (1):
>       cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
>
> Sumit Gupta (1):
>       cpufreq: tegra194: Add support for Tegra239
>
> Viresh Kumar (1):
>       cpufreq: qcom-cpufreq-hw: Fix uninitialized throttled_freq warning
>
> Xiu Jianfeng (1):
>       cpufreq: Add __init annotation to module init funcs
>
> Xuewen Yan (1):
>       cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh
>
> Yang Yingliang (1):
>       cpufreq: tegra194: change tegra239_cpufreq_soc to static
>
> Zhang Jianhua (1):
>       cpufreq: bmips-cpufreq: Use module_init and add module_exit
>
> ye xingchen (1):
>       cpufreq: tegra194: Remove the unneeded result variable
>
>  drivers/cpufreq/bmips-cpufreq.c      | 10 ++++++++--
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/highbank-cpufreq.c   |  2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c    | 24 +++++++++++++++++++-----
>  drivers/cpufreq/sti-cpufreq.c        |  2 +-
>  drivers/cpufreq/tegra194-cpufreq.c   | 35 ++++++++++++++++-------------------
>  drivers/cpufreq/ti-cpufreq.c         |  2 +-
>  7 files changed, 47 insertions(+), 29 deletions(-)
>
> --

Pulled, thanks!
