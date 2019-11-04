Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6257EDDC2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfKDLfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 06:35:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDLfF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:35:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so14064919otk.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2019 03:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T41h1XsLLHvSP9ZmI/zVvx/+EaAzjaN7MfLaCLo27o=;
        b=TY4uVgyzCjR8BbsAV3LUBCB9UgGPbPWXGI76amKa1hfMcp/4x83hT1gxLi7eze7Tzl
         vGEwTFskFkjoxh2FpQeuOmJz6zyD21TqZJmiDpN6J31oUZn47Ykuknm0wuxYO8iBZ/LB
         /YmiIgj+yxGP2C51euoGTToNvsDA64Vj1BBOubKKBvKgfc9WPNSAB90C5iAikhw0o9Eo
         E5fm5BeuGm/gMFBMAHI2lKp48uZSgiOXNGsH9796Eo8e7IznpBCaaGIUmMkJVnqmYu2W
         b/eSP/SqkawZfg+NG/aPa0HeO0lrE1VAT/6kv0KeXjb4q2yURCSlbFqUdTZyLT8nxXnl
         2w7A==
X-Gm-Message-State: APjAAAXDhzVlsvc4d5oSbDKlt73RCNbEgWSM9nt/FmgcZbGuZMobyPWi
        XALtwoTaB0DYYS5Tzp5Tv4Vp3xmNEhVpXJCkrBE=
X-Google-Smtp-Source: APXvYqwa6JpC+DIXPVUHbtmmviajaSllnandc7mgFqJ3C9Zc/bz42PIPeIAGmm3ayVQRTRhoFrO+ASrOkh6BG+B3Euc=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr7680211oth.118.1572867304724;
 Mon, 04 Nov 2019 03:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20191031131812.19427-1-rui.zhang@intel.com>
In-Reply-To: <20191031131812.19427-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Nov 2019 12:34:53 +0100
Message-ID: <CAJZ5v0hLmPqZYXO_8488X2Z3CSony5rMM6b9y=UnHCVUTaAsZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap/intel_rapl: add support for CometLake Mobile
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 2:18 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add CometLake Mobile support in intel_rapl driver
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 94ddd7d659c8..cc1e82d513a9 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -978,6 +978,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
>         INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
>         INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
> +       INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
>
>         INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
>         INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
> --

Applying this and the [2/2] as 5.5 material, thanks!
