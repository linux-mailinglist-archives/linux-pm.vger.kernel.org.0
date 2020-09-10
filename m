Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37903264B20
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIJRYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 13:24:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36783 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgIJRXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 13:23:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id x19so6672454oix.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 10:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyHp9dLhwEqu5uSE00MgEGnO20WmRujED0cXQoDFHK0=;
        b=avRXJ0CQI+kZNm7c4pgGwpkYGUrNeUl5n5qP2To8jQvkQUXHVc0G4/7bmFK7IERc5B
         RDIcRby4YPOHXvCsftSEIu2sgr0/2dHl0vWp08uMu0UGYO1lj4mXIHhEFxjNae2/ScSs
         5eyWMKSWb1Q40Bjrdhr2kdgmjXXFc/lgyxQd7vCqVpvg77XhRrymp+/4yylcRvVnw+LW
         8XLT6pnx68fXB4wH6Rn8g0Lcknroc1VrkSXpoKnFNSn4jxURU0qMyP0Bf5ZJUfkPbB0m
         Bn2kL3eSMMHFZboa6HXjeVcOL1vyPMpdJwPPp+05n6xGgf3zi/B40pojWKgMVprPDGhg
         wPTg==
X-Gm-Message-State: AOAM5303R3lgLXSdxHTY/mSvGiuk+FhR1E2/Ma6PE+5voFfyNCaNQykD
        0bkxNh5MAwZVtpMNMpJgUjLEzcsTuCL3U8tFq1w=
X-Google-Smtp-Source: ABdhPJy262f35zF8hIu/s+XiOfGDeJoyIVMIx7jUbw3K2zK4sgTNeGhi0VimK0seMEhMKsHQszzisbGxz5rmhRo7d9E=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr658419oii.68.1599758586223;
 Thu, 10 Sep 2020 10:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <6d3237551d3e9755a10f73698d102a63a9052bed.camel@intel.com>
In-Reply-To: <6d3237551d3e9755a10f73698d102a63a9052bed.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Sep 2020 19:22:55 +0200
Message-ID: <CAJZ5v0jz_6nE80vs=+Li8pEvOccHTwZ8CY7bGwCU9yi7ney_3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] powercap/intel_rapl: add support for TigerLake Desktop
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 10, 2020 at 9:49 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> From a6bca1219d998bd5505924ee2b67c5febb2e79d3 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Wed, 9 Sep 2020 22:37:08 +0800
> Subject: [PATCH 1/3] powercap/intel_rapl: add support for TigerLake Desktop
>
> Add intel_rapl support for TigerLake desktop platform.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 6f55aaef8afc..60dbe0e43dd4 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1035,6 +1035,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,         &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,           &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>
>         X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     &rapl_defaults_byt),
> --

Applied along with the rest of the series as 5.9-rc material, thanks!
