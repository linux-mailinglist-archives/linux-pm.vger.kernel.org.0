Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252A31A227
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBLPzv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 10:55:51 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:32942 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhBLPzl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 10:55:41 -0500
Received: by mail-ot1-f54.google.com with SMTP id c16so8804875otp.0;
        Fri, 12 Feb 2021 07:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hkgvMeCL8KgFHrlSi+ZPMQoYcV+scrqJ+oH5o6Hh20=;
        b=XfsF+DfMdpAJvUJs/e2hyE46JPHbVXelp/iAK9yStBEQUKz8fVJcNn2+QuiqsxrdNn
         +KngmygnlgePT+XibX0IfQaXpCAkgnAW05fLt5b7xzL74gnpkYBavIU1qO9OIZNBWkHJ
         m+kE8hd3XUcb1/pd2S6LnBtfyhYP73ntj5j4WmH+mXZmckPHm2r18ShflqxKCtMUt0J8
         JUTvgJb4f35l4h7CWIE3N+lGW2cAESGyGdPtltRm7nplRVVQlmKaFMYcSJcpwJwYSoXU
         31hbSyjvbixvnFU+QRNlO1wP7Z5XoLY2t+3oGleYECRk3hVIza7jmMLl7LrDBvu9Ha6K
         QFNw==
X-Gm-Message-State: AOAM5312WWmsK4a+oSzq1zIycpkD8fKgOQSB3g7d2TUepzoWygbLq9Oc
        QHfbiVL+lsgCIXRJfs3oHUD8pVjXZHn3Kv8MRsc=
X-Google-Smtp-Source: ABdhPJzOJfXGfFsUz/Fb0COQlRSswtiNVGTbrpEk/PhfmqR4BOzKMlsXikSs77QgIyuUxuvU3KLcxX8527edD+oV2LU=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr2391390otc.260.1613145298025;
 Fri, 12 Feb 2021 07:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20210123100608.2349629-1-yeyunfeng@huawei.com>
In-Reply-To: <20210123100608.2349629-1-yeyunfeng@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 16:54:47 +0100
Message-ID: <CAJZ5v0jwpuhh75mV+JTFicjbguJu2VMCUzAZcomTeL13m2BR1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap/intel_rapl: Use topology interface in rapl_add_package()
To:     Yunfeng Ye <yeyunfeng@huawei.com>
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

Applied along with the [2/2] with some minor changelog edits as 5.12 material.

Thanks!
