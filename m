Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60E9740310
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjF0SR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Jun 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjF0SRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 14:17:52 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7F107
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:17:51 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-94ea38c90ccso101700766b.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889870; x=1690481870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsENEjx/sGsoMo3b4hPV6hRin1hnzfHTpNFwJ9CgZ3w=;
        b=HYxKW3j2TL+kwDJGpSR9tBUosD0enExZnkZ9Y4PNtXKxeVCr5SD1e9a36GccjYBS2J
         NstzAAxtDLuZr0/fFcRV7MrVv3foDfhQEqwO8QoYJZQ9alI5S8dNvrUp+iRpgwXff7zk
         hShgKFx8kU0MZF72Iio/4/iPkR4ZFHFTvD1JExYc/SzWOHFYcdrOxnzS83acFi+L7fD6
         h42yNzv/AwmAjlli8MWHU1NdDaeu2ldZdcpazda2qu4nX/bsG6yMEGTeqjAspJvduFKb
         h+cCm5xSUe6WDGHy2zqzJC78KrXKG3o7GPMuhrHAegqo0S5CJud5lZIXnkTJeF/hK5AM
         KG6w==
X-Gm-Message-State: AC+VfDwGcrYvQdiZFAXIFTJd6y2zPUr3hsjGa+FvQ2z+xBC4M3C3d7Xh
        bHdwfPnD7rSCi7OeXDUEIKeC0xTZiChppL9wiu/Cqoun
X-Google-Smtp-Source: ACHHUZ532d9ZmGj+eS4tgMTvR8PXrum6ze0C4woDUKLLTIXF94E4g9ig5i3N8txCEPWXOOa8vWXDUbKwSs44+0OBsJg=
X-Received: by 2002:a17:906:73cc:b0:98d:b10f:f3cd with SMTP id
 n12-20020a17090673cc00b0098db10ff3cdmr7143681ejl.7.1687889869658; Tue, 27 Jun
 2023 11:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230627021646.evsp6e3capqxx6xn@vireshk-i7>
In-Reply-To: <20230627021646.evsp6e3capqxx6xn@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Jun 2023 20:17:38 +0200
Message-ID: <CAJZ5v0g=pAPzZBaucU0UPnbHuJppmP+R6gx=m9+Fj7UPuW5jMw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.5
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Tue, Jun 27, 2023 at 4:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
>
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.5
>
> for you to fetch changes up to 5fb2864cbd50a84a73af4fdd900b31f2daddea34:
>
>   OPP: Properly propagate error along when failing to get icc_path (2023-06-27 07:35:14 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.5
>
> - Simplify performance state related logic in the OPP core (Viresh
>   Kumar).
>
> - Fix use-after-free and improve locking around lazy_opp_tables (Viresh
>   Kumar and Stephan Gerhold).
>
> - Minor cleanups - using dev_err_probe() and rate-limiting debug
>   messages (Andrew Halaney and Adrián Larumbe).
>
> ----------------------------------------------------------------
> Adrián Larumbe (1):
>       OPP: rate-limit debug messages when no change in OPP is required
>
> Andrew Halaney (2):
>       OPP: Use dev_err_probe() when failing to get icc_path
>       OPP: Properly propagate error along when failing to get icc_path
>
> Stephan Gerhold (1):
>       opp: Fix use-after-free in lazy_opp_tables after probe deferral
>
> Viresh Kumar (5):
>       OPP: Staticize `lazy_opp_tables` in of.c
>       OPP: Protect `lazy_opp_tables` list with `opp_table_lock`
>       OPP: don't drop performance constraint on OPP table removal
>       OPP: pstate is only valid for genpd OPP tables
>       OPP: Simplify the over-designed pstate <-> level dance
>
>  drivers/opp/core.c    | 44 +++++++++++++++++++++++++-------------------
>  drivers/opp/debugfs.c |  1 -
>  drivers/opp/of.c      | 40 ++++++++++++++++++++++------------------
>  drivers/opp/opp.h     |  6 +-----
>  4 files changed, 48 insertions(+), 43 deletions(-)
>

Pulled and added to the linux-next branch of linux-pm.git, thanks!
