Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6066B252ED9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgHZMnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 08:43:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38905 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgHZMnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 08:43:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id j18so1379057oig.5;
        Wed, 26 Aug 2020 05:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jWLO2j2hSokMQqAAq5MjsBBKZAHqxrCpcReYcaXXrw=;
        b=Mcz6+U3/w8cW/Vgiz958eFOPBt2yXfQAd7Nz3I0duTykTDipAUNv3sTg1/yWXBhyo2
         kHoCZCKS7TpvSRqjLbwhFr/x0gzUYjIcqwbPOY7u47d9BUwSObrz3EnI1Ce1HGj108Kw
         2xwM7rijUZylnV2cezJkFrMz1lRBlKHvq7VJ7zl58RJhnuoAPfL4NWf/y+JythGGiYXZ
         trsHHjZcJzzD7IXpK+JovA2k8bbKMQbS7o+3etJmN9Fo01IvplY9tWp2G00NJWIgEyJQ
         D3n8vyJhCywn0M83kRQDJnaDplDY2n5jzjtVlrKlhfnpODo8VTOLQb+UGScQTb6lcYrW
         VRnw==
X-Gm-Message-State: AOAM530K15cAv46+KzzpPw5oDdPosBb0sFPAFBlMPyNNs4Mh9UYx/D9V
        OQVXoXapV3+IUo5QKKvzv88Qp/z6kvyIbRcwVeg=
X-Google-Smtp-Source: ABdhPJzh+4NWy+aygfsTXB+sZc3xqFQDWiDAEwrJgVnrZCAnnO4vxJs9SJt7NsukMkklb8/BI5D2JRsvOEJKv6bUaVg=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr3978983oiy.103.1598445810400;
 Wed, 26 Aug 2020 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200826120421.44356-1-guilhem@barpilot.io>
In-Reply-To: <20200826120421.44356-1-guilhem@barpilot.io>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 14:43:18 +0200
Message-ID: <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
To:     Guilhem Lettron <guilhem@barpilot.io>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 26, 2020 at 2:05 PM Guilhem Lettron <guilhem@barpilot.io> wrote:
>
> Use the same C-states as SKL

Why is this change needed?

> Signed-off-by: Guilhem Lettron <guilhem@barpilot.io>
> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 8e0fb1a5bdbd..1bb539f09a4f 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1145,6 +1145,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,             &idle_cpu_skl),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,        &idle_cpu_knl),
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &idle_cpu_knl),
> --
> 2.27.0
>
