Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91221F86E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGNRoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 14 Jul 2020 13:44:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37795 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgGNRoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 13:44:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id w17so13677380otl.4;
        Tue, 14 Jul 2020 10:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mCgUl/KQDaKe/GhwnSeh5pmlX/T9coOehcI2bZOS1Jk=;
        b=uOrjmiE7wKSscSIAz0B1PlVuyP292iewqUn/98o00Nw502tLFFnpykONG6yRwY50O7
         EgSiNus9o84/U5We/DwdpgI+I8MUCQq8gRHHlmTSl0kRD+inxAi8/sC4HpVQTU10W2mb
         T2R7+tyaaXLgtWIwYH8Lq4tt0KrMe2SGXlcXxILZKnj8hIhc2hqQuhY/xf376RgQB/KR
         2LiwC+zuceAVS+iOM6NqCVTZPJrCrXSo2dKqwIcuBAI3bMV5rlgWZmxp2smCJpKCfm1p
         K81L95qJZfyJ7ld9W0ieyhpQefLMHo7FomCDJq0QiSq84OjauQmubiY1ub/9pZrTNiSl
         0Asw==
X-Gm-Message-State: AOAM532qtHPDAqjVPhZnQbSH7XbeQ73ffui6b0KY+sCh8c0bddkOyXw9
        sxIfvJBtRxWKWlMnHAJ8/tQdw+WqfkbQB8KvZAE=
X-Google-Smtp-Source: ABdhPJxVUqvpDTkyR25LySONRyXttnQKmWkzj+1B6BBCOjjV6Zu5+Jw6fDpJzP4RA3e63VtM/WPK0rpvrBWxEO0usQM=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr4975216ots.118.1594748640032;
 Tue, 14 Jul 2020 10:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-11-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-11-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 19:43:48 +0200
Message-ID: <CAJZ5v0jXjtZ0=ZnOZm2LNR32TwWSrq4C4bwhNh5tOOChfpWZxw@mail.gmail.com>
Subject: Re: [PATCH 10/13] cpufreq: powernow-k8: Make use of known set but not
 used variables
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> If we fail to use a variable, even a 'dummy' one, then the compiler
> complains that it is set but not used.  We know this is fine, so we
> set it to its own value here.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/cpufreq/powernow-k8.c: In function ‘pending_bit_stuck’:
>  drivers/cpufreq/powernow-k8.c:89:10: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
>  89 | u32 lo, hi;
>  | ^~
>  drivers/cpufreq/powernow-k8.c: In function ‘core_voltage_pre_transition’:
>  drivers/cpufreq/powernow-k8.c:285:14: warning: variable ‘lo’ set but not used [-Wunused-but-set-variable]
>  285 | u32 maxvid, lo, rvomult = 1;
>  | ^~
>
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> Cc: Dominik Brodowski <linux@brodo.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Paul Devriendt <paul.devriendt@amd.com>
> Cc: Mark Langsdorf <mark.langsdorf@amd.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/powernow-k8.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 3984959eed1d5..b76df81044c4f 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -89,6 +89,7 @@ static int pending_bit_stuck(void)
>         u32 lo, hi;
>
>         rdmsr(MSR_FIDVID_STATUS, lo, hi);
> +       hi &= hi; /* Silence set but not used warning */

Hmm.

What about using __always_unused for this?

>         return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
>  }
>
> @@ -292,6 +293,7 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
>                 rvomult = 2;
>         rvosteps *= rvomult;
>         rdmsr(MSR_FIDVID_STATUS, lo, maxvid);
> +       lo &= lo; /* Silence set but not used warning */
>         maxvid = 0x1f & (maxvid >> 16);
>         pr_debug("ph1 maxvid=0x%x\n", maxvid);
>         if (reqvid < maxvid) /* lower numbers are higher voltages */
> --
> 2.25.1
>
