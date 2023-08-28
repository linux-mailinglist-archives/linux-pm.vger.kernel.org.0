Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F478AFE1
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjH1MR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 28 Aug 2023 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjH1MRv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 08:17:51 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1FAB
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 05:17:49 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bc9353be9bso885274a34.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 05:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693225068; x=1693829868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up06LLsUHY6pDlZHYIUYAE8Jm+EV9igi4I9z7kRfRBQ=;
        b=Za8so1zcIrV+v/RovmNOtTUYR8qMDsaPwVxneA5PHWbc9wZrvOxZYB7AZN4qwWLdU3
         HtIoEEt2TMVvlpLwnsjsM7maseqoRgBpZerM7sejsmvPy46rnugBpJjkVnswl7ColSHM
         Cope72Vtsn9IVzGwcm8J17GjXbtXElbUjJIjskE1Bo6DEJC5CVIb+TvdFBsLIuqb4vOd
         XflrO259eRRtMHNdnNrScJxYYeH8aMjRHk3EigOSMKbpRP2w6mHEymV2TbC/EsOKejrE
         OLUD1SMsyFrYeVxEyaTa34fv71dhsrAefzsSs26WSDBycQ0S91Qkdl+cSxtFXCM2JBVe
         v3/w==
X-Gm-Message-State: AOJu0YzxGZcaRenbJKRiuCYkwWWllSooqhuBjVXh+AKMldiuOp1Ua6iX
        zes8sVjrye6Hzc5L8XHRO+TyNCiVnm8R68PHcTORQe45
X-Google-Smtp-Source: AGHT+IG01y6mofuG8HfF2wFqb79bA4CXzx1tB8X8KYvg1rTCRIzHti+DpM/x8oZ6HO5dLov+kQFnNi1OjPtJkFyURcY=
X-Received: by 2002:a4a:e699:0:b0:573:4a72:6ec with SMTP id
 u25-20020a4ae699000000b005734a7206ecmr7552428oot.1.1693225068314; Mon, 28 Aug
 2023 05:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230828102446.egoeuhxt3uwy7lr2@vireshk-i7>
In-Reply-To: <20230828102446.egoeuhxt3uwy7lr2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 14:17:33 +0200
Message-ID: <CAJZ5v0jLkBX2dnppfLKTGJ4phkKBCn-hFL=+x2duhS8MxuPc5A@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Aug 28, 2023 at 12:24 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.6
>
> for you to fetch changes up to e576a9a8603f7c6f8fed5159e2fe33f6d67a49e7:
>
>   dt-bindings: cpufreq: Convert ti-cpufreq to json schema (2023-08-21 11:23:34 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.6
>
> - Minor core cleanup and addition of new frequency related APIs (Viresh
>   Kumar and Manivannan Sadhasivam).
>
> - Convert ti cpufreq/opp bindings to json schema (Nishanth Menon).
>
> ----------------------------------------------------------------
> Manivannan Sadhasivam (5):
>       OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
>       OPP: Introduce dev_pm_opp_get_freq_indexed() API
>       OPP: Fix potential null ptr dereference in dev_pm_opp_get_required_pstate()
>       OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
>       dt-bindings: opp: Increase maxItems for opp-hz property
>
> Nishanth Menon (2):
>       dt-bindings: opp: Convert ti-omap5-opp-supply to json schema
>       dt-bindings: cpufreq: Convert ti-cpufreq to json schema
>
> Viresh Kumar (5):
>       OPP: Rearrange entries in pm_opp.h
>       OPP: Add dev_pm_opp_find_freq_exact_indexed()
>       OPP: Update _read_freq() to return the correct frequency
>       OPP: Reuse dev_pm_opp_get_freq_indexed()
>       OPP: Fix argument name in doc comment
>
>  Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt              | 132 ------------------------------------------------------------------------------------------------------------------------------------
>  Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml |  92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml                |   2 +-
>  Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml         | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt         |  63 ---------------------------------------------------------------
>  drivers/opp/core.c                                                    | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
>  drivers/opp/cpu.c                                                     |   4 ++--
>  include/linux/pm_opp.h                                                |  62 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
>  8 files changed, 344 insertions(+), 229 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
>
> --

Pulled, thanks!
