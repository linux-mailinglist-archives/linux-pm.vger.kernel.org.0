Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8C3A1BCF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 19:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFIRdJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 13:33:09 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38459 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhFIRdI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 13:33:08 -0400
Received: by mail-ot1-f50.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so11098106otk.5;
        Wed, 09 Jun 2021 10:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFcJ7rQXnzhGAm63jAT5SpqjhtSTOISSCQfC1ETOR3w=;
        b=qvrqm6AokDjhT8iK0j9CVN7tRjmo+VJu7MCt8Y+EdCE6NO5JItI21qt0obvlhb516r
         EEQgD/xtwXty3y6ZzGEEtX346NdsZPaIRlom0la80cSh1hDGVLDMSMEsD+VF5V1yVK1m
         kkcPi2C4tlJGgpvu+NFN6KbGfyg64RAaMRAAlcxYq8MKJeLvXuXx0Ewc+SMCye4dPzDi
         iRmQV8dH/yvHQN1zNP87WuK5GY3r389VxnsO4QkaZCxyMInRhiWJgEaZTlwev/h6U64E
         +BMJBxypLjlUuMUGYjHmCXtManb5BQSxbSX03lEmHYs6rNhFLDQstjCrC+NHRj09UO8t
         XQtQ==
X-Gm-Message-State: AOAM5314rGuoOANOHmxIYafIPXhyIAZwd9KslwS3fp7v1GR+osVyhR7H
        koMWavfPNqa0uFy8KfuyIvsM6x9rzaglwQT7R9qRuRtI
X-Google-Smtp-Source: ABdhPJzQH4LkJfUDW3AILGfrSgUnDqTM6XhyjAUCmq3vRVPBEq7atuZi/f2UOt8kbQERruECPHLUlOKndmiROD2SwZ8=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr458727otb.206.1623259857222;
 Wed, 09 Jun 2021 10:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210528081417.31474-1-puwen@hygon.cn>
In-Reply-To: <20210528081417.31474-1-puwen@hygon.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 19:30:45 +0200
Message-ID: <CAJZ5v0j-9zZvuSyKtRYePHE6aSr824SZz=E6VS_Ysv3cByGZyQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems
To:     Pu Wen <puwen@hygon.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 28, 2021 at 10:44 AM Pu Wen <puwen@hygon.cn> wrote:
>
> Hygon systems support the Monitor/Mwait instructions and these can be used
> for ACPI C1 in the same way as on AMD and Intel systems.
>
> The BIOS declares a C1 state in _CST to use FFH and CPUID_Fn00000005_EDX
> is non-zero on Hygon systems.
>
> Allow ffh_cstate_init() to succeed on Hygon systems to default using FFH
> MWAIT instead of HALT for ACPI C1.
>
> Tested successfully on Hygon Fam18h systems.
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/acpi/cstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 49ae4e1ac9cd..7de599eba7f0 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -197,7 +197,8 @@ static int __init ffh_cstate_init(void)
>         struct cpuinfo_x86 *c = &boot_cpu_data;
>
>         if (c->x86_vendor != X86_VENDOR_INTEL &&
> -           c->x86_vendor != X86_VENDOR_AMD)
> +           c->x86_vendor != X86_VENDOR_AMD &&
> +           c->x86_vendor != X86_VENDOR_HYGON)
>                 return -1;
>
>         cpu_cstate_entry = alloc_percpu(struct cstate_entry);
> --

Applied as 5.14 material, thanks!
