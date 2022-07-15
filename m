Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB648576108
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiGOMA1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiGOMA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 08:00:27 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6E7BE0C
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 05:00:26 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ef5380669cso44548817b3.9
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 05:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nijEymS4YNW8RpPL8kWLJ0t7tbSQdoXb7j4hInSSjF4=;
        b=zIsh8DDorr05m9CBypiLWrNKpSeFTxcOgkTSRdZiuzCB+Duuu+DkC/WJaEJFGkTWV2
         ecDLxmK8Eb2rawoJW27ZiKfyYNZEkqUS1+2lak+685Tns03l5s1zA0iACxWiZarBNoZJ
         vgHH20QJ2q6sEvt5rlvYq7a6obQb+5TdiD40DpMuxGjW+6K+wQRIW2djmn5JbtdTRYXw
         U1utdKpPJTq3N6EMYDQ+ZjqjkA9dCHrBDwDIhrKnfA/wv5/dDtRj16bnk7Rdrb2nK0RO
         mEAO0zdSNzpRB74Yxu0lpL1JM/AnJ087sRjL0UG+FbjduNW0oCfGqlP98BQNQCuJVTIo
         ewxA==
X-Gm-Message-State: AJIora8A2vGtGoSceLnx188dvkJZ0coDtcypWU6cGr9lgfx/6fMsNHAj
        kUXs5zt1MXpyFV0Ovl4uZgxYlEYnKdTr5XdOK+hnWAzP
X-Google-Smtp-Source: AGRyM1u0dH3uBrLu36el6ygG5haeH3d79KQoePJqaaVNw5Pjuc0Q/ZFdbJRBBQZLXJgMI6JqBR4Ie48mTu37yOctsX8=
X-Received: by 2002:a81:5957:0:b0:31c:f620:17ef with SMTP id
 n84-20020a815957000000b0031cf62017efmr14928765ywb.19.1657886425340; Fri, 15
 Jul 2022 05:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220715045936.xsrxduwit4beijzi@vireshk-i7>
In-Reply-To: <20220715045936.xsrxduwit4beijzi@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 14:00:13 +0200
Message-ID: <CAJZ5v0ioZCPLXOOFxeNOV_OKHS1fe-foaSkVj+Ta_u+j9mS=YQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.19-rc7
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

On Fri, Jul 15, 2022 at 6:59 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The following changes since commit be4b61ec45b3efe5e9077525fc92d544305eb2a6:
>
>   cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist (2022-06-28 13:34:56 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-5.19-rc7
>
> for you to fetch changes up to d2394860b45c3c1484e4b0a5d09909a1e3f6569e:
>
>   cpufreq: mediatek: Handle sram regulator probe deferral (2022-07-13 16:51:32 +0530)
>
> ----------------------------------------------------------------
> cpufreq arm fixes for 5.19-rc6
>
> - mediatek: Handle sram regulator probe deferral
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       cpufreq: mediatek: Handle sram regulator probe deferral
>
>  drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Pulled and pushed out, but I would appreciate getting pull requests
somewhat earlier before the -rc I'm supposed to be pushing them for.

Thanks!
