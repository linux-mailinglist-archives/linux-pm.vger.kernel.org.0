Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128F377B794
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbjHNL2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjHNL21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 07:28:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E38127
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 04:28:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4293696276.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692012505; x=1692617305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zV7e4uqCOZfFxUomsrlciPWk9Fd/IJUmKy5w/Bnb3o0=;
        b=hOuVghxDpW00pxzb5dzoUPvu+bMfT+myG9WRxGoIkKOK1x4kzwy+0gTqN6gkGlcSQC
         WTgLmNAoH87AxbTzpjzbUyvoQKuvVsuPGvofRsogfLe0foUruUjpIHaQaR3VRc1ripik
         V4swmeIgAiSpr18UvxsG16sTKF80yC6bmtzmOneCvuLZICL+dAtkmclKH/rkjQQMSJep
         fpm0wbwIF2WNlU1VGC7WYAYcexXXFrpgMPWhBUrgRj2fUKqMpXo/GGBl6P9p6JSokRIJ
         b5b8cyMMkMnQgFGXB4rnbu4gubZzOOpsFjAnsA6tfu5GZPQtp1lhI2snVhHu1YKan758
         4rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012505; x=1692617305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zV7e4uqCOZfFxUomsrlciPWk9Fd/IJUmKy5w/Bnb3o0=;
        b=lY6/P/T9gXkfdkmObBLsa76w2NHK/jEHNY2fxTs+Km85zwvysguW3kJbtzoEcYi/H+
         z84lEcXFeqbK8ot3lEtvbJIH0Fm7OymdeAOJhC3mWNRgXMcM/7YX7h8jDpMuzYfCfIpO
         DDP03wVao/6qW7K7FLdDhSm51+oCGjTuu1WDG/hgRFmmBnySZh1y4GlUSuE72SPWzSgJ
         ZLfjj9kkJUd6a2kMG2Y0EnJg+b3YgS56+bpjCeLr6322Kr6Mb8U8x+3ItaFbrAAso8lc
         /v/LPKoObb3VOfvx7hiiDXlHkU3qSsrE71/7KjW0gKCgdECV1lvb4PdL0jZKNrXIsnZF
         F+wg==
X-Gm-Message-State: AOJu0YyTgizF5900KdIsxVn70/+n+GDnc1NXK0ePTQFsuZzp374BDlXM
        QaF8bfHFHSRvaWhCgPUbHo4b7ej/eCyWIt2G2e0MDQ==
X-Google-Smtp-Source: AGHT+IGnQJT82CyRJQHGhUeBgoe4lkdDdYbjacPwBMd98HAzPlLW3y5rC5ORU5ANElco5nbwuNNBY+6yI+wNMWRcDkQ=
X-Received: by 2002:a25:bcc4:0:b0:d21:ef87:c1be with SMTP id
 l4-20020a25bcc4000000b00d21ef87c1bemr9876239ybm.27.1692012505512; Mon, 14 Aug
 2023 04:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Aug 2023 13:27:49 +0200
Message-ID: <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
To:     shawnguo@kernel.org, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 14 Aug 2023 at 12:36, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V4:
>  Update commit message in patch 4
>
> V3:
>  return -EBUSY instead of return 0 in patch 4
>
> V2:
> Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx
>
> This patchset is to upstream NXP downstream scu-pd driver patches.
> patch is to relocate scu-pd to genpd
> patch 2,3 is to support more PDs
> patch 4 is to not power off console when no console suspend
> patch 5 is to suppress bind
> patch 6 is to make genpd align with HW state
> patch 7 is to support LP mode in runtime suspend, OFF mode in system suspend.
> patch 8 is to change init level to avoid uneccessary defer probe
>
> V1:
> This patchset is to upstream NXP downstream scu-pd driver patches.
> patch 1,2 is to support more PDs
> patch 3 is to not power off console when no console suspend
> patch 4 is to suppress bind
> patch 5 is to make genpd align with HW state
> patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
> patch 7 is to change init level to avoid uneccessary defer probe
>
>
> Dong Aisheng (1):
>   genpd: imx: scu-pd: change init level to subsys_initcall
>
> Peng Fan (7):
>   genpd: imx: relocate scu-pd under genpd
>   genpd: imx: scu-pd: enlarge PD range
>   genpd: imx: scu-pd: add more PDs
>   genpd: imx: scu-pd: do not power off console if no_console_suspend
>   genpd: imx: scu-pd: Suppress bind attrs
>   genpd: imx: scu-pd: initialize is_off according to HW state
>   genpd: imx: scu-pd: add multi states support
>
>  drivers/firmware/imx/Makefile            |   1 -
>  drivers/genpd/imx/Makefile               |   1 +
>  drivers/{firmware => genpd}/imx/scu-pd.c | 193 +++++++++++++++++++++--
>  3 files changed, 183 insertions(+), 12 deletions(-)
>  rename drivers/{firmware => genpd}/imx/scu-pd.c (70%)
>

I am fine to pick up patch 1 -> patch 6, to let them go in for v6.6.
Should we do that or defer until the complete series is ready?

Kind regards
Uffe
