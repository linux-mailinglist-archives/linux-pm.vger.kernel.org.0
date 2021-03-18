Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62430340D70
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 19:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCRSoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 14:44:15 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38833 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhCRSno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 14:43:44 -0400
Received: by mail-ot1-f44.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6144162otk.5;
        Thu, 18 Mar 2021 11:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqEcB6ngMG+rhQNdezmhzbR2taShoU63AwDd2h6CSxk=;
        b=olo4xVDr1u8EYLeWdykfPIKt1WehFXf1Q6dw5uxxWVOzPe87le6pdneq4EQjl2+Jax
         /P8Y0g3WR1Zu7adAdZgfu88l0/YQSMIA4PIkWcutVfJGRTJvq/oQA11VQXPofgZGeDiO
         +dXdGNh3pKMO5rEoKRzGqxt2+ZleIHFbkddCn5pbR2hpu0kEC+8M4otVJ6h7HclPwsbX
         R+TVSw5OZWRhVFSZrONU8CzTAFGnY9VlHigqjMn47WYDNRoT8rFTDK7BNEAjgboy77ac
         gS7mVMndzxHZ/ffXgEb7L4ii++yAPswRa6hpxhkNY52Fcq+u9syyEcbG/1aQAmOH7KjN
         ys7Q==
X-Gm-Message-State: AOAM531C4yN8rddf/d7nS5MdIVOBVBLS5xIrD18FzjnrkdsSHA1Ek9Xl
        EeON+RzCPwOEAGWtkQuk3Wvx/hRaUnvpVyKAvP8=
X-Google-Smtp-Source: ABdhPJwISNTVggsrc7Wy84g+bHARcjq+UJvVTTMk9hiKhOyFlkckConrQiPmeBp8IiKeziaud/UEovXnmxT/WaCp6s0=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr5969126otq.260.1616093023349;
 Thu, 18 Mar 2021 11:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210302020108.1777-1-puwen@hygon.cn>
In-Reply-To: <20210302020108.1777-1-puwen@hygon.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Mar 2021 19:43:32 +0100
Message-ID: <CAJZ5v0gxbKNvm7K7d4bbFnrH8nwcCA1c8+m4OBTKu39D11epqA@mail.gmail.com>
Subject: Re: [PATCH] powercap: Add Hygon Fam18h RAPL support
To:     Pu Wen <puwen@hygon.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Victor Ding <victording@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 2, 2021 at 3:05 AM Pu Wen <puwen@hygon.cn> wrote:
>
> Enable Hygon Fam18h RAPL support for the power capping framework.
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  drivers/powercap/intel_rapl_msr.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index fdda2a737186..73cf68af9770 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1069,6 +1069,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>
>         X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
>         X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
> +       X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 78213d4b5b16..cc3b22881bfe 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -150,6 +150,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
>         case X86_VENDOR_INTEL:
>                 rapl_msr_priv = &rapl_msr_priv_intel;
>                 break;
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>                 rapl_msr_priv = &rapl_msr_priv_amd;
>                 break;
> --

Applied as 5.13 material, thanks!
