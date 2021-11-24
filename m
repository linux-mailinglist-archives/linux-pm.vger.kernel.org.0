Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3945B5C9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 08:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhKXHt6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 02:49:58 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47564
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhKXHt5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 02:49:57 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6D403F1B1
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637740007;
        bh=41d8EvmewBk6qtYJvBs7XURC6hhNsnDFxi4IPnDanww=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UqR9c7oGNZXA0S+16xsqHErQy1ZBEAEVHTHa5iipMGhGydepEKgrltkMfiFJ+iULu
         3WwFkXuFlltxV7mF5mB/ghnwQ1ibIpIkZYiaqDIFNI3eDZjCzoyPsA8yqIVRYr6/gQ
         S9aKqCCf01HpcM1CeN/C/wP877wKklD5DgoBoTVXnsnYXH/Cb04gxJ3hchCy8VGyeC
         /BUG2geueraudw39g+cJjXiu8P1xas3QHJWP6pfzq+HnG++E4e9WMZ7njRmXMFtsM2
         wCR2UrJ1PRQaxUDSXG4GwMGDjAo0u6ntCqbX7jLKZ/2NXDByKT1ClkDP3K9uQ46/yY
         B7O3ON6JjpEMQ==
Received: by mail-oi1-f198.google.com with SMTP id bm27-20020a0568081a9b00b002bd445624cdso1064546oib.11
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 23:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41d8EvmewBk6qtYJvBs7XURC6hhNsnDFxi4IPnDanww=;
        b=TLUwY1ZZ5RJjf9XfCFKJx3qLxIc/Axm0s91azH4hhgvPfnoeEz38b8TkdYdnY7+rIi
         8VuJwE+bWpAVsCTGNjFX7wZQOtCxwxKYAO8Qoi79MGAH7yl2W8/5VMCMB6P0OpSG3wgH
         q/Om69ifiCss9sPuHtWRdD9ezJfJjkCZESUgt/ClmpNtc8ac/TcVcv8EeRpTLJe9vU92
         Jk+eemSJILU5HNvt8j6O6DSLSHwVqKtZx5J1N7F20WWTilXxoW9s846CB0lgadpPuT3J
         XjBkxNUxYq0Y0EAscrV1XRTQUOuZbTp8O0kClyNQ1M/8vgzMA77b4udI2MuLsY9RaKeE
         QVSg==
X-Gm-Message-State: AOAM530znkshi5UTEUPJRD0gxC9eqrR8oe+GkG0lhwNNlipgqhy5i5hs
        y9Y5IlW3zSFNPvHewL7D92L4PubM5hVVGTH+oXNY+ULDujD03nb1oUHL6JEm1frO0t/cYT4J80w
        1Dwwzst+qRE+XobofuscBoIh9qgTHBjsv8BYBuArO8J9ch3bSO6Gy
X-Received: by 2002:aca:1a05:: with SMTP id a5mr4000795oia.146.1637740006601;
        Tue, 23 Nov 2021 23:46:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyM4ycPL4qVHt0LnBtJ22sU+UsiSnwmlB+8bqOrZLqMNyA/ppy7P3eLlCPtz2s+/0I7M+uGLxfmwYchcLstLQ8=
X-Received: by 2002:aca:1a05:: with SMTP id a5mr4000767oia.146.1637740006367;
 Tue, 23 Nov 2021 23:46:46 -0800 (PST)
MIME-Version: 1.0
References: <2611837.mvXUDI8C0e@kreacher> <5521509.DvuYhMxLoT@kreacher>
In-Reply-To: <5521509.DvuYhMxLoT@kreacher>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 24 Nov 2021 15:46:34 +0800
Message-ID: <CAAd53p6dLkyafdzei-LTmfHtQw-hf6r5Sxx_Gw6FqmnfhQ0aLg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Add NULL pointer check to cppc_get_perf()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 18, 2021 at 9:37 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPI: CPPC: Add NULL pointer check to cppc_get_perf()
>
> Check cpc_desc against NULL in cppc_get_perf(), so it doesn't crash
> down the road if cpc_desc is NULL.
>
> Fixes: 0654cf05d17b ("ACPI: CPPC: Introduce cppc_get_nominal_perf()")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 5.15+ <stable@vger.kernel.org> # 5.15+

Sorry for the late test, I bricked my previous ADL rig.
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>
> -> v2: Check cpc_desc against NULL before using it to initialize reg.
>
> ---
>  drivers/acpi/cppc_acpi.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/acpi/cppc_acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/cppc_acpi.c
> +++ linux-pm/drivers/acpi/cppc_acpi.c
> @@ -998,7 +998,14 @@ static int cpc_write(int cpu, struct cpc
>  static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>  {
>         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> -       struct cpc_register_resource *reg = &cpc_desc->cpc_regs[reg_idx];
> +       struct cpc_register_resource *reg;
> +
> +       if (!cpc_desc) {
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +               return -ENODEV;
> +       }
> +
> +       reg = &cpc_desc->cpc_regs[reg_idx];
>
>         if (CPC_IN_PCC(reg)) {
>                 int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>
>
>
