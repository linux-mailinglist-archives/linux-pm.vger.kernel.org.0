Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04654311649
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 00:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhBEXAU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 18:00:20 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:35113 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhBEMqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 07:46:10 -0500
Received: by mail-ot1-f49.google.com with SMTP id k10so4385057otl.2;
        Fri, 05 Feb 2021 04:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If0TqL6CkLzrzIa4DvHyDQweVwa1J6gEoFE5T6p/Q9o=;
        b=UJh1NENF9Oq51TrfKhC+OIxyoH9PXT5lNG0zLAhzNcZlGtUYdMqQ8xC7EayhpeLFpD
         4W+J5zWXE65lAc1fxzu8rMoAhU7Cwa+I+l1fgUCLuwKYNTsTv768gHMwxTS8NCfiQK4/
         mT+PGLGhPZPYM2e2Tw0adfxKzV3ndFEwY7YcRvnq1t4niO0iToAsBf12FTpVnINnpoLq
         Sih2uwkUYVoViWAqrTh0eik56Gws2NHRvEFUjM06Lv5LHW7ahfJCR/wNUtatN/fqbpEG
         o0cWubyuhmh0V9gdsuyhzXjOvQ4Oc9Xa/uzvihmGyN9Llj7g1+CumNK+oPDt5OQl9cvW
         qr/Q==
X-Gm-Message-State: AOAM532hx9cOd2TVr3dN+xwqsUJ7fxRoV8c0mgNolqF9w/EzyMEYVZoY
        X7tqgc9QsCTxYvDBboMItKKt/WdQ0fhXFTxWDaUWWs0j
X-Google-Smtp-Source: ABdhPJx0i2b/7r9ho85ytMSr2vJhkUTXpVWmOvabhY0LvB6NHl700f8pifQXxdsgC2URtsK/qZRbRIiFLJhH305vxoo=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr3237379otq.260.1612529129228;
 Fri, 05 Feb 2021 04:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20210123100608.2349629-1-yeyunfeng@huawei.com>
In-Reply-To: <20210123100608.2349629-1-yeyunfeng@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:45:15 +0100
Message-ID: <CAJZ5v0hNryYqKfTZfRjN+KJVgw973G+vi9SrT4mGTPz_TTT2ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap/intel_rapl: Use topology interface in rapl_add_package()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, hewenliang4@huawei.com, caihongda@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 23, 2021 at 11:07 AM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> It's not a good way to access phys_proc_id and cpu_die_id directly.
> So using topology_physical_package_id(cpu) and topology_die_id(cpu)
> instead.
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Srinivas, Rui, any concerns?

> ---
>  drivers/powercap/intel_rapl_common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index c9e57237d778..5f3d39b8212a 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1309,7 +1309,6 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
>  {
>         int id = topology_logical_die_id(cpu);
>         struct rapl_package *rp;
> -       struct cpuinfo_x86 *c = &cpu_data(cpu);
>         int ret;
>
>         if (!rapl_defaults)
> @@ -1326,10 +1325,11 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
>
>         if (topology_max_die_per_package() > 1)
>                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
> -                        "package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
> +                        "package-%d-die-%d",
> +                        topology_physical_package_id(cpu), topology_die_id(cpu));
>         else
>                 snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
> -                        c->phys_proc_id);
> +                        topology_physical_package_id(cpu));
>
>         /* check if the package contains valid domains */
>         if (rapl_detect_domains(rp, cpu) || rapl_defaults->check_unit(rp, cpu)) {
> --
> 2.27.0
>
