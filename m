Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6413F7C12
	for <lists+linux-pm@lfdr.de>; Wed, 25 Aug 2021 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhHYSOV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Aug 2021 14:14:21 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45999 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhHYSOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Aug 2021 14:14:18 -0400
Received: by mail-oi1-f177.google.com with SMTP id q39so529808oiw.12;
        Wed, 25 Aug 2021 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkPIXF51FfSkJbx5Q2Ca1hyHpTm5BestCxPXQa4Te4M=;
        b=RkdLqHFl4h0iuWfqsvrGLkN8IAXRXyokR5aZPbge3EsbcfOz0VifI3zeS0M7hAsZkP
         7aOmr4GXebCK24qv1XP4pRQ264ixhI6HTMAMAigkg4mm8266OfbXE6Fdf3n2oxF6VlLD
         0W4ImjkD9AVmNWAkM15AIG+76i5NUxGCgxtX1kxJSY5sjZ8VThfv4bZ3diV96L83GdId
         nVI0VRdYZFlb9VE7T/NvxQ4Ix+aCfguF0wmUwYzZS83oGdEvXLErzieC2h/x+xp1tLMq
         xGuwcs9gBTXzBQsg5QrC5Y2L6bM5pfX17ESrMlutRUQJykrkoBBQCFHEHuZOVIPEfA8+
         L11w==
X-Gm-Message-State: AOAM533bvPTFwyd/OLCgkjvj7UurtFSvlUBcn65yA5Cqf9c1yJ+VsWJ8
        jS/2ViXr3VX9p26iw/LXjczHIhDDXpzQbuTZH4tQ2PvwyU4=
X-Google-Smtp-Source: ABdhPJw0JJO/f8hNzUzFr/J+W5HTSMsUC6XF4ENBH/5W/nMIs44Ri2EbQzG9J1UE0ofvRbkrixLOOvR+ryYRWiWYRF0=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr8196055ois.157.1629915207707;
 Wed, 25 Aug 2021 11:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210820115233.5297-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20210820115233.5297-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 20:13:16 +0200
Message-ID: <CAJZ5v0jVWKOnzcsGkpEv84=EN4R+fgBg4B=28DyV_n7+hNUXcw@mail.gmail.com>
Subject: Re: [PATCH] powercap: Add Power Limit4 support for Alder Lake SoC
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 20, 2021 at 1:51 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Power Limit4 support for Alder Lake SoC.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index cc3b22881bfe..1be45f36ab6c 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -138,6 +138,8 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
>  /* List of verified CPUs. */
>  static const struct x86_cpu_id pl4_support_ids[] = {
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
>         {}
>  };
>
> --

Applied as 5.15 material, thankis!
