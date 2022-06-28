Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAF55E7AA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbiF1QBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348207AbiF1QAw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 12:00:52 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FBE1A047
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 09:00:28 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31772f8495fso121921877b3.4
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 09:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwpLeCsURPmPplcj9Gkpo0p39waVrWsRPMxVBr86wQ0=;
        b=gcy9ekk1+MbjKhkSlAlP+gCKT/3NslSiPptHKmg/l+Hjg51NBs2i1Azv4El7cEgHW7
         nZ/kqz+CzpNe58LuTsnELwKhAz+TmOWeaZJIQbp5M5IxzN1mS/kq62sJNleTegY4FW8N
         zICTrkEsPJGSkwV66UlTI4/o9NLma3JG4YPLZCLBmaYjPnbijcN0d3MP5OyC/3WuLjTO
         FhttvsdtdYivECvyroyLnfLzdWjEwmVXz5zLOsaj5F82gU2oFJeiuj47KmCCWozraAjD
         XD4UB+gXmoXfkql6dzF6xXP2CzDAqneEMtKesI4iLF8bWIPjgSDNn0pf+dRuPpW81sRo
         UsDQ==
X-Gm-Message-State: AJIora+GO2DgluZmfwuIo2Hh+v8NmMriD0MQnQuP5xPELX5Okbi3jNyQ
        UnOtUGqm/9z3sudSd/M1PGjcULfnaxAGZoXUj24=
X-Google-Smtp-Source: AGRyM1vmKLTVyYqLHM2sxnlmkj2wEz4CmdumYak44KXY6Gvq8wZ5uQ9WSAC0mP+PCutxazt1FCFEBBgDPb+VBguYeJg=
X-Received: by 2002:a81:57d7:0:b0:317:b111:34d5 with SMTP id
 l206-20020a8157d7000000b00317b11134d5mr22455781ywb.7.1656432027521; Tue, 28
 Jun 2022 09:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220628080812.twfoo2tzot3m32i2@vireshk-i7>
In-Reply-To: <20220628080812.twfoo2tzot3m32i2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jun 2022 18:00:16 +0200
Message-ID: <CAJZ5v0iAiGF6tXJsrkBxh3A98vEpea9L=P3KcZAJwTDR5WZQCg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.19
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 28, 2022 at 10:08 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
>
>   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.19-rc5
>
> for you to fetch changes up to be4b61ec45b3efe5e9077525fc92d544305eb2a6:
>
>   cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist (2022-06-28 13:34:56 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm fixes for 5.19-rc5
>
> - Fix missing of_node_put for qoriq and pmac32 driver (Liang He).
> - Fix issues around throttle interrupt for qcom driver (Stephen Boyd).
> - Add MT8186 to cpufreq-dt-platdev blocklist (AngeloGioacchino Del Regno).
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist
>
> Liang He (2):
>       drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
>       cpufreq: pmac32-cpufreq: Fix refcount leak bug
>
> Stephen Boyd (1):
>       cpufreq: qcom-hw: Don't do lmh things without a throttle interrupt
>
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/pmac32-cpufreq.c     | 4 ++++
>  drivers/cpufreq/qcom-cpufreq-hw.c    | 6 ++++++
>  drivers/cpufreq/qoriq-cpufreq.c      | 1 +
>  4 files changed, 12 insertions(+)
>
> --

Pulled, thanks!
