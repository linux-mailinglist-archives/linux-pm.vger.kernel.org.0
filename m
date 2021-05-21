Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0D38CB45
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 18:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhEUQv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 12:51:27 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34795 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhEUQv1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 12:51:27 -0400
Received: by mail-ot1-f42.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso18630692ote.1;
        Fri, 21 May 2021 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu2c8R8rAcRdvr46YEdFMMm/zuWUBJv9ZV4VQfyQuGI=;
        b=PmsFKjo3jf1x8RWiNUhjV1pPvWuzTI/mD+dLc6rPQzbrdGVvCaMJxgL14yZs5VdRxg
         aMtKhkmUzyQi1Z09KBp3EP9m+WRfxPVn4xq1F895AnugKP/aIfen4ogkltkc532Ex3pI
         JiV/mfSyPNMaLFcSxemjGsJvb5jK6UPgWpuqQMzd/1eckSTBja352MAoDAMK1fIozR7F
         +Cx5G5aT9BDzqNyfauyU1l/JyHhgDeUVBRNqRRgzX8CxcCZhxCcJbZbgzm3rl3IgOZmH
         FmrSyDx5zrg7g2UaG7QPVFF7H4rShgVrGktVyQYoQtc3F/8CV00JTOrSZvIljlQZZS3n
         ywCw==
X-Gm-Message-State: AOAM533vHSMOy96F7A8LaIPj2Pjt/n0+qk82V1pfdmx7Nf9yzfz21RJa
        lHTLCYdsW8cLzanN2MrOMZjiWiIL3fto3hFmfS8Av7vc
X-Google-Smtp-Source: ABdhPJwhVw09S4/pxSk9+f4JsR8j7oPIpFNtGkUdFfjGpIkucEPw1MXdJ7kKEH/bV3haJgCyGW91q9Wq+aw7GOw5poM=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr9515161otc.206.1621615803934;
 Fri, 21 May 2021 09:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com>
 <20210518123413.20670-1-ggherdovich@suse.cz>
In-Reply-To: <20210518123413.20670-1-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:49:52 +0200
Message-ID: <CAJZ5v0jtUbFOGSuf7e6QvW2Pu9M7k5cjhhmgHffi67tBV01QBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq: intel_pstate: Add Icelake servers support
 in no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 18, 2021 at 2:34 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't load
> unless the CPU model is explicitly supported.
>
> Add ICELAKE_X to the list of CPUs that can register intel_pstate while not
> advertising the HWP capability. Without this change, an ICELAKE_X in no-HWP
> mode could only use the acpi_cpufreq frequency scaling driver.
>
> See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
> support").
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
> This replaces https://lore.kernel.org/lkml/20210513132051.31465-1-ggherdovich@suse.cz
>
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0e69dffd5a76..9a93603acd3f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2087,6 +2087,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         X86_MATCH(ATOM_GOLDMONT,        core_funcs),
>         X86_MATCH(ATOM_GOLDMONT_PLUS,   core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
> +       X86_MATCH(ICELAKE_X,            core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --

Both patches in the series applied as 5.14 material, thanks!
