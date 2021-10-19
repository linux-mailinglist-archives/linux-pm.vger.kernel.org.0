Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F7433CC0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJSQzC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:55:02 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44572 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJSQzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:55:02 -0400
Received: by mail-oi1-f170.google.com with SMTP id y207so5852192oia.11;
        Tue, 19 Oct 2021 09:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg0cCwJVHF76pIKAhe13PodfxRRyNCDHrc0ozMywzNw=;
        b=XJx3BHDQcRn5lHt5LTxkkaknh4Cv1c763/+wzPrzxcQkFAm2EL+1D8dRR8Pgo9EChA
         gxWU2VGe6Kg0Skq1M+lP+je25tuF2c7jH948Gpg4hx7RhkfSUr103wVWno9QLoaJg7yS
         rxkkgwWHz4b42+r0L3Rz3CmPwoiopfQm7uKZzRhHQdzoGKW2RjOlzD7m16SkIROJtYW9
         OC1EkFZMbMwUKFkdqwT+nZp/4i+uHuLSOJz/RmTeXDAY1qEQfExHjupblRY3QzAp5JjI
         WacMU84GnCQyCA9tTRcsQrfE9qleSz/37fm34NENDB7VCIachB4QfMZonoOYgk2oCNID
         DGcQ==
X-Gm-Message-State: AOAM531AG6YGZGdjwxYmdReflTb8Rfx7AipUlsVPdRIMVTJ5n4/CavVC
        Wb1M6Z5uBC4HqN7h7yQzcijLnCd5w3z81dt+REs=
X-Google-Smtp-Source: ABdhPJydRVGsHDP0DrSDIexcFoZ34NnYWweKqZKndMhsMWMgocVz7pqdpzE7bjQh6NXPOYcv/36RcFZk9gDH6wKkjRM=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr5151432oif.154.1634662368345;
 Tue, 19 Oct 2021 09:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210926090605.3556134-1-ray.huang@amd.com> <20210926090605.3556134-4-ray.huang@amd.com>
In-Reply-To: <20210926090605.3556134-4-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 18:52:37 +0200
Message-ID: <CAJZ5v0ivJk-cVv0kHUeF1M7aWBZ9ziuUF-9=M_eF+WQ1vQJfgQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] ACPI: CPPC: Check online CPUs for determining
 _CPC is valid
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 26, 2021 at 11:06 AM Huang Rui <ray.huang@amd.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> As this is a static check, it should be based upon what is currently
> present on the system. This makes probeing more deterministic.
>
> While local APIC flags field (lapic_flags) of cpu core in MADT table is
> 0, then the cpu core won't be enabled. In this case, _CPC won't be found
> in this core, and return back to _CPC invalid with walking through
> possible cpus (include disable cpus). This is not expected, so switch to
> check online CPUs instead.
>
> Reported-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..2efe2ba97d96 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -411,7 +411,7 @@ bool acpi_cpc_valid(void)
>         struct cpc_desc *cpc_ptr;
>         int cpu;
>
> -       for_each_possible_cpu(cpu) {
> +       for_each_online_cpu(cpu) {

Shouldn't this be for_each_present_cpu()?  In case a CPU is present,
but not online when cppc_cpufreq is loaded?

>                 cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
>                 if (!cpc_ptr)
>                         return false;
> --
