Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7925D358B31
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhDHRTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:19:17 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39580 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhDHRTQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:19:16 -0400
Received: by mail-oi1-f178.google.com with SMTP id i81so2933731oif.6
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 10:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcftDPdGrkkXwmvSH2630pmgKSk3/2oq6+DxLdC0zms=;
        b=g7Cbi5MCWZNOoPeyr8JSUe/NH59xoAnKYuLzFX1zCWArMNpwRX5F+cYFsBVq62zJ4t
         PTO93IEch2kqba61gJW2ITegMIQIt+GBgrZqfEEuwiUbmrzbYoEjan4gv3dFf1nua3m1
         02yRsM5/oMCbDSYEIvmIlbccPWTGgS6q0p26bnogSwNGzDPPN7wButz8OhatS+PwtvjW
         EUK5f7mqXwjji7aPLV9v1GaF6BErEgt6OSjDc2FENDXYXx4zwjx+rRYvuu26Y6vmwjsj
         B3SoH6smxmorRi5eO1KEmAk2aRcK9amyp1Q0LSPx+rO5bJw4QjduHzTlD/Ka2x5TlJQQ
         +K7Q==
X-Gm-Message-State: AOAM532JokTCD23gNVu4eZ9jtOVsed+NXiK+4ULzantIRA3iFgONTMTS
        zAKZIpeYBMmZ+qIPAH5OeSZ0JcRG9C8SSqcT7vCkEgQh
X-Google-Smtp-Source: ABdhPJyf1agS3DxNR3aiexPveZLP0Y6ekzDNOxHRVsmJorYT2g0Lx7r0bRoRlxlSWglCa2z6gglzXM/eQdtZWIWEB0A=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr7025917oie.157.1617902344739;
 Thu, 08 Apr 2021 10:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210407061028.3072316-1-dedekind1@gmail.com>
In-Reply-To: <20210407061028.3072316-1-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:18:53 +0200
Message-ID: <CAJZ5v0hyuiG8Pfz6oyVMMuG0VHtOdtHdnUZRn8C-=6p1_DRoMg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Iclelake-D support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 7, 2021 at 8:10 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> This patch adds Icelake Xeon D support to 'intel_idle' driver. Since Icelake D
> and Icelake SP C-state characteristics the same, we use Icelake SP C-states
> table for Icelake D as well.
>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Acked-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/idle/intel_idle.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 3273360f30f7..3c2cdc766203 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1156,6 +1156,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &idle_cpu_bxt),
> --

Applied as 5.13 material, thanks!
