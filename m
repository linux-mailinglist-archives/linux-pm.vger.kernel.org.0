Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8A533DAD
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiEYNU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 May 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbiEYNUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 May 2022 09:20:03 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00842ABF46
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 06:19:48 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ff90e0937aso139583717b3.4
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2022 06:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y214NlD86AqNSAMmmF9BtUGBzp1ZXCVDrH4I6u3j9Y0=;
        b=AhDScIBPQL13xZcEk6odRvJEDD26NVYb5RE0axtwuzih0DNX6D+tbZUmzZB7xL3WhR
         eqF01eVECUz0N+fUNHYwuk4PSWORlbWxB9ElvGYPewoGszDyoUa6CsF/3viwzsjNoIiY
         9ykH6aj0JiwOAOHdx3F7nEXyqmx9rJwotlnsV8CyOUHXS6Y9jevC0HZrtxbzedO8SUZF
         NRSeSc0/Bl36E0zX31mww449IFBaqcb/tOYtSMJwNhvw6k5P3ExPVe7KthXuR/DapRPg
         W3g0mLw/uuB5XPMoGiCavlhQPm6/K7XV+vNbQkYhXCEmek+rRPQPnM2t325yPrn2LkGj
         36rQ==
X-Gm-Message-State: AOAM530BbeGogH9Jh9ChyaCiAIOmMCqciileDFe0y33bfoj8Ba7ZsMWr
        /7XFVivmKDKty7c4wyiU1dXeaomIhtbb1IyrkLJSSp/H
X-Google-Smtp-Source: ABdhPJzVpaeQ+3CbxWuVtGsVQLe0WgrSiHsrwtcKRfp6LIq0sHCpSOHHRWiWNqGLeNPXJHQ1hqD7h0xLeA50IAYVwMU=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr34011597ywm.149.1653484786702; Wed, 25
 May 2022 06:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220524053013.ohb46jykdjmss75l@vireshk-i7>
In-Reply-To: <20220524053013.ohb46jykdjmss75l@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:19:35 +0200
Message-ID: <CAJZ5v0gxnrTkLPozQas6Dh5xT+8yk=rN9_92+hK+wVFcH2StvA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.19-rc1
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

On Tue, May 24, 2022 at 7:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
>
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-5.19-rc1
>
> for you to fetch changes up to 22079af7df5a5dfef1c4d160abfd43035211759e:
>
>   opp: Reorder definition of ceil/floor helpers (2022-05-04 15:40:22 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 5.19-rc1
>
> - Minor update to dt-binding for Qcom's opp-v2-kryo-cpu (Yassine Oudjana).
>
> - Use list iterator only inside the list_for_each_entry loop (Xiaomeng
>   Tong, and Jakob Koschel).
>
> - New APIs related to finding OPP based on interconnect bandwidth
>   (Krzysztof Kozlowski).
>
> - Fix the missing of_node_put() in _bandwidth_supported() (Dan Carpenter).
>
> - Cleanups (Krzysztof Kozlowski, and Viresh Kumar).
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       OPP: call of_node_put() on error path in _bandwidth_supported()
>
> Jakob Koschel (1):
>       opp: replace usage of found with dedicated list iterator variable
>
> Krzysztof Kozlowski (2):
>       PM: opp: simplify with dev_err_probe()
>       opp: Add apis to retrieve opps with interconnect bandwidth
>
> Viresh Kumar (1):
>       opp: Reorder definition of ceil/floor helpers
>
> Xiaomeng Tong (1):
>       opp: use list iterator only inside the loop
>
> Yassine Oudjana (1):
>       dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
>
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |  56 ++--
>  drivers/opp/core.c                                 | 339 ++++++++++++++-------
>  drivers/opp/debugfs.c                              |  10 +-
>  drivers/opp/of.c                                   |   2 +-
>  include/linux/pm_opp.h                             |  41 ++-
>  5 files changed, 291 insertions(+), 157 deletions(-)

Pulled, thanks!
