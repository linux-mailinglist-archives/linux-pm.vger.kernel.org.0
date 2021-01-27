Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1E30634D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhA0S2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:28:22 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35840 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhA0S2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:28:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id d7so2651262otf.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 10:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbHD0SjRY6Ar6FdCWZA3SSqvjgH/I2o1u17gjcl2xuY=;
        b=hqt2PAj47aHZX94shGVjflHysw9yjRuvvMT7jh8u1E7/L4P8yavzfYnM/U56TxflwS
         jJbT14fOL79wDMSnPWL/2hYAVtxdX1WjoVb4oh8+nUXztntjOpfmWpBTorGKDyXy5aU2
         cSbCpNMcFkGPlRaCxbL3uwmTUIMVTnR2P7XUGfom1ujCEbv0H5eWjWhycACfBl01aEJD
         C0IW9rLTUaEbVgAkIIszTqfOtvOceufVB6baCF5HWkoMCGsP5jJmQ0ZU2ozLwnwJu5jy
         VmswqO3JgNuZLiESsnj1V9ZRhuPEKWlYEvawO6XEauScGNSFrKHTEKARB1i00h99aAW8
         6QGA==
X-Gm-Message-State: AOAM530FVETozLQr6yMuqCw9rZ/vVi+UAKYx5Y3xOWN5GXlKDvCsgh0l
        XqEfGF/od2jzttsVWSuB0HmDA6Nr3dtDStLrxGI=
X-Google-Smtp-Source: ABdhPJwnz/Z0vyfVtCTM/NT9eFm7A3+f6iDmsS7NOXYxr+hMJWOWhk6K2qxkxI90WwNvNtp2H5ti3M3nd6kVk8G3LLg=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr8869727otm.206.1611772055964;
 Wed, 27 Jan 2021 10:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20210127054227.15642-1-rui.zhang@intel.com>
In-Reply-To: <20210127054227.15642-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 19:27:24 +0100
Message-ID: <CAJZ5v0iE+KHipOd0W_GJDfnhyiZ659TPmC48zJCV4XodN++adQ@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: add support for AlderLake Mobile
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 6:46 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add intel_rapl support for the AlderLake Mobile platform.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index c9e57237d778..f0799837c2dd 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1049,6 +1049,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
> --

Applied as 5.12 material, thanks!
