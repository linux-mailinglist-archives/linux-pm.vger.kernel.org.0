Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0C774123
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjHHRPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjHHROa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 13:14:30 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125EB282
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 09:06:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56c685b7e91so3848646eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510761; x=1692115561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8Rz6JdKJggB+vk185UWqplO5cbUsTa+J+i5abU5jbw=;
        b=ALtfXmG51nWGbfUNslTGGR6rzuczL4oRMoWo8bZmP6AHBsyqY6E8syxf5BFvLsv+j8
         gJYN/rDAxURiAGARqT3zsbDIo252gQuMOJGXjq+rQTvwNCjZm8pS48+PK/Pf7EP+TFle
         myPpbKElIX+gX4lWA9fCiCXWg4ABrsSxLwFym6Z0QNQejez78rM4qEHXTFJAOSpzvZUu
         jKdCEFJR7B5QVavIPSS/EF0Ef7B00/CGYTZS52NzMznRJ54tKhAdr+kbItgbvgS++pi3
         hsCZsIGvfnSUrZcXTfNmprYPtBK0OjZCxruZOi7K0mZdhheyH4WGK9vDVgDC1KVwtFhn
         wZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510761; x=1692115561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8Rz6JdKJggB+vk185UWqplO5cbUsTa+J+i5abU5jbw=;
        b=NVPwsSwFconF3g+LIGw1qeMYO1Z8TkB7mMXo/PE+IoJRXUCeGF2SVmOIB6lK8z4tLv
         oHysIo7PHDOdot63iqEpi586oaxHm6QBoCxyJ6CswcBFjocVndCF7g6b6YEiRqlUoCqb
         qtyxqu+7N695Z1cXioJzr/h3GA53QyoLYdNfq+GtpCqKgRV8KHNh8lsD14n4kvEHNk7+
         GHHrzoRcArCBwhNjhlLFc/ufVErVoGzgIZn1YnNtPsqW2fzZ7I7SvlrW1QsPw4S8ivou
         l9JF0HFKwiZfcf1/a/JPg+pBrzufokpTqfqG7A3Rn6e9+93O6fzvyxVu1c2gNTo+EBxN
         hW8A==
X-Gm-Message-State: AOJu0Ywu1xQM+gz6TkcEZl+fwNVK8EFeUexXfV+JaBEv+IzlwG+Cy80s
        nZsikmtvUdpdGpJp2i4YZ6ugzLIapvqN4Kk7TKaOGv9q+05MHBSOFWHvZQ==
X-Google-Smtp-Source: AGHT+IHd0ipN+K4djTCXtDOyfu+VTZpMjc2BHQ17nfPiSRQDUouO0mBCgRT9q8s21lVndeT3Y2wJvRIbhS8rd5n7No0=
X-Received: by 2002:a25:8d8e:0:b0:d3c:58ef:ef7b with SMTP id
 o14-20020a258d8e000000b00d3c58efef7bmr11095979ybl.6.1691506710111; Tue, 08
 Aug 2023 07:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 16:57:54 +0200
Message-ID: <CAPDyKFqvP71ZDcamFo5AijhTXEJKHUPNE=-dOvXYw3pr4XxK6A@mail.gmail.com>
Subject: Re: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 31 Jul 2023 at 08:43, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
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

Moving this to the new genpd subsystem makes sense to me.

Even if we can't get the whole series ready for v6.6, we can certainly
pick patch1. Either we can funnel this via my new genpd tree [1] or if
Shawn picks it up. If the latter, Shawn needs to merge my immutable
branch [2] before applying. I am fine either way.

Kind regards
Uffe

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next

[2]
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git genpd_create_dir
