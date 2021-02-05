Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F51310B57
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhBEMto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 07:49:44 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:34062 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhBEMrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 07:47:22 -0500
Received: by mail-oi1-f170.google.com with SMTP id h192so7294713oib.1;
        Fri, 05 Feb 2021 04:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFMib/vjfNEkqTfv11MdHF7ZUPpB2VQALSNmPSYLPNo=;
        b=Neu82U3BJPv0f59kI0LrmBCYWNpRanwyAudRzfKwF44MrsJ0NPOLOtrxoj2CCVCUv1
         dhurUDiIk0cpIyOuIH/lAwIDfyYBreVYSoe6+kIwkLuZ0p9qlN2hYeIpK0IOboZzuDXx
         AWov51ER2s0EscElc5Lo0jSXb79GWVrLwWK+l7um61hbWd+sHYf4APIOGRcdtMyxGFbB
         pgyaJzX5syhWzayNojOuE0U6GbHtj04S6/M7ZF+JwlnYwtmODpS/Leb1IVaHi1zVS5OY
         jfcKl1cWgOGODyAmcY0w3oyMvdMzkHz5y+DYCBIHfJzO85baLmd5j7GUX3InCY8m4HNf
         Fq7w==
X-Gm-Message-State: AOAM533RyfR0ct2/dpZUnT4TiyxaUFqZhrOYS/exS4YsRVWhccmst6Va
        lIvXGm3Np4bnm4z7swwBaIQQIQnL1ww4hZJl9MM=
X-Google-Smtp-Source: ABdhPJwrb3QQdva4+X5ZA9ZHJlcHaC3InuEIWyrYuuMaudqh2iEjzq7tXh5kaTn2I2zK9OrSw5PzWU4pDuSL3fpyaP8=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr2881150oii.71.1612529200858;
 Fri, 05 Feb 2021 04:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20210123100608.2349629-1-yeyunfeng@huawei.com> <20210123100608.2349629-2-yeyunfeng@huawei.com>
In-Reply-To: <20210123100608.2349629-2-yeyunfeng@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Feb 2021 13:46:26 +0100
Message-ID: <CAJZ5v0jOwfau2dPVnrAjv01dOGY+8i8o-2gr72fNa0Fug1CV=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] powercap/intel_rapl: Use topology interface in rapl_init_domains()
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
> It's not a good way to access the phys_proc_id of cpuinfo directly.
> So using topology_physical_package_id(cpu) instead.
>
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Srinivas, Rui, any concerns?

> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 5f3d39b8212a..8888adcb3927 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -547,7 +547,7 @@ static void rapl_init_domains(struct rapl_package *rp)
>
>                 if (i == RAPL_DOMAIN_PLATFORM && rp->id > 0) {
>                         snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "psys-%d",
> -                               cpu_data(rp->lead_cpu).phys_proc_id);
> +                               topology_physical_package_id(rp->lead_cpu));
>                 } else
>                         snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "%s",
>                                 rapl_domain_names[i]);
> --
> 2.27.0
>
