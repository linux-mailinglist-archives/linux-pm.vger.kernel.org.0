Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1A170AC9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 22:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgBZVrs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 16:47:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46079 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVrr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 16:47:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so896477otp.12;
        Wed, 26 Feb 2020 13:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTmslN9q8kSwBcWhEIJNY/U1Xxha6MDPKoxaq0risEc=;
        b=EgXxqWgs+A9N0rf2PIRtzYHF1ZTCV+YCqrB9t7MZM1YwMa34/KHbPBXx9+9Kkl3W+Q
         lklNApFkILb2hmfppRDf6a3MJvDh3DpvZBj+rpM3puCjQ6CzxF4DvEYm/CQ7Bc0RZ9vQ
         /rHEB1owPeVEeY/cqEHJaf+Hu6mK2nNvJGKWjKekWrfwpPqzfKHNDRIEPOPnMNGfzI1O
         ntGeUngZfn8mSCE+iaasYS23sSuFUT8oifqQ8aIMiP5XV6Y1vX4kKCP4R7rMuDSKnpWU
         5i/ftI28oECfpOIf+lPuNl/6TCgGmN9+SJg5T3XuQocx9dDH0ZOLfqgAJ6+WVf9V2Rgh
         bkMg==
X-Gm-Message-State: APjAAAXwIkjVN5gEv3NLVL0VDRcVf1l8TUarH560SyPvWhvmAyw03r6D
        oP3jKJMqCPEy2Ln+Y3oqCUCiU7JC8M/vmTkL8F8=
X-Google-Smtp-Source: APXvYqwbzFXeIj/jl4xZ31G9VSia8iaKygXmbc/nxomxgNxKOm738/8bVAuBII2Eqj6ZLhW5V3sEXoKtU4J1YvG9Le4=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr657127otr.167.1582753666933;
 Wed, 26 Feb 2020 13:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
In-Reply-To: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Feb 2020 22:47:35 +0100
Message-ID: <CAJZ5v0hX-DVLPQmjVAZkQUJy8gCBPTneJvaFHmjqqbCe66F_6w@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Comet Lake support
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 26, 2020 at 6:34 PM Harry Pan <harry.pan@intel.com> wrote:
>
> Add Comet Lake ID to enable intel_idle driver support.
> This is required for PC10 and S0ix.

That shouldn't be the case for Linux 5.6-rc as long as the ACPI tables
expose C10 in _CST, so have you checked that?

> Signed-off-by: Harry Pan <harry.pan@intel.com>
>
> ---
>
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 347b08b56042..3cf292b2b7f1 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1086,6 +1086,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         INTEL_CPU_FAM6(KABYLAKE_L,              idle_cpu_skl),
>         INTEL_CPU_FAM6(KABYLAKE,                idle_cpu_skl),
>         INTEL_CPU_FAM6(SKYLAKE_X,               idle_cpu_skx),
> +       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_skl),
> +       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_skl),
>         INTEL_CPU_FAM6(XEON_PHI_KNL,            idle_cpu_knl),
>         INTEL_CPU_FAM6(XEON_PHI_KNM,            idle_cpu_knl),
>         INTEL_CPU_FAM6(ATOM_GOLDMONT,           idle_cpu_bxt),
> --
> 2.24.1
>
