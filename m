Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58230219C61
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGIJgb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 05:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGIJgb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 05:36:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF33C08C5CE
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 02:36:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so1277091edy.7
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2020 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eygZbTdlFFJ71jCLfCgJ+FFK+a7qNbIVolSlOz1F8GM=;
        b=WiAQr+CWI7AR7BcmGBUGWjPFNscJqLLdx51nc0bGW2Zjlly/I7bVYJKiNQ5FIK42gQ
         ztKZ39/kOKalWkN6N32n9+XcKyY2/UZpc0fDuRm0PCCb/Qq39LkHNF83Q1ad+4KSpgiV
         LTgltQyaJIT9ryfmqIqBqoTOuXUkDuBlRZqCb4KIGN39bAlxO6AKe1pry724NX4dMW6E
         Thw3IS52wTv26/tNSpIZ2OhuwOSW2kWMybtNxYwUWn+l1g1ADjvnStvay3TcV2Q2XIJY
         genZjiQMJwXx7fw8+JQ5Xk/LKkC57jVNSW8/UQ/LfFzmgNF9SBYB6Z7JaKK9wrAlePEW
         xRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eygZbTdlFFJ71jCLfCgJ+FFK+a7qNbIVolSlOz1F8GM=;
        b=fTv6AsIUOJq7wvla1tvBUvxalXUZWEhquNoD78LFEStpMQUE2b4u4nqVStcCr3MOSq
         L6LOMH0navOUbE3BQmsfV6mkSFH6/eG1VQMpUDEz9y8c9Cs81+p8JUnd6arFGs6kcA8Z
         D9S4n++2DOrobfDMzx+GJ9QeISfm0WY6hN1WtM6M8ndASldKSE3ZUIYaYpVe+tZBZElQ
         metz5VUQgap0KBsJqV6nR7EBjR0CQry6I0/HgJD9x81VIVN4ORGqdVN1JuA6st8uK91O
         3KHlm7XxrA1Ceb7nqSjUk2b6GI8vZ6zcURMKOR2hkYAwyou/m54kxcERodVWrdJvs0D0
         KcGQ==
X-Gm-Message-State: AOAM532Nx4Gt3jt+1hE8c4hxaVxHtkaWSBNRlF6F8rTSiqxL4xSqbuJs
        4youG5OVJl9QLAsMWCgj2zTpQ6yl9GlgjFOAEKwqEg==
X-Google-Smtp-Source: ABdhPJyBTmJWVm+jeRh/T397jZe1feymToc3uhaSUxFBG3KtVFCrNLA1lCw6fQ/UuGQVOizKlaB8ldlMBCqSg811i6s=
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr73921180edx.342.1594287389229;
 Thu, 09 Jul 2020 02:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200708134613.131555-1-bsz@semihalf.com>
In-Reply-To: <20200708134613.131555-1-bsz@semihalf.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 9 Jul 2020 11:36:18 +0200
Message-ID: <CABLO=+kwtYKdEHNsYS13+=LgFZ3L7Snym-aBthxe=vOsjiPTbg@mail.gmail.com>
Subject: Re: [PATCH] thermal/int340x_thermal: Prevent page fault on
 .set_mode() op
To:     Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Pandruvada Srinivas <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Alex Levin <levinale@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui, Matthew,

I think this regression should be corrected still in the 5.8 release
cycle. It may cause kernel panic if .set_mode() is called before
current_uuid_store(), and from what I see both operations can be
triggered from sysfs. What I'm not 100% sure about is if we should
apply the above fix, or rather revert the driver to its default
behaviour of using uuid=0 if it wasn't set from userspace (this is how
it was before Matthew's commit). What do you think?

Best regards,
Bartosz


On Wed, Jul 8, 2020 at 3:46 PM Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> Starting from commit "thermal/int340x_thermal: Don't require IDSP to
> exist", priv->current_uuid_index is initialized to -1. This value may
> be passed to int3400_thermal_run_osc() from int3400_thermal_set_mode,
> contributing to page fault when accessing int3400_thermal_uuids array
> at index -1.
>
> This commit adds a check on uuid value to int3400_thermal_run_osc.
>
> Signed-off-by: Bartosz Szczepanek <bsz@semihalf.com>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0b3a62655843..12448ccd27f1 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -216,11 +216,16 @@ static int int3400_thermal_run_osc(acpi_handle handle,
>         acpi_status status;
>         int result = 0;
>         struct acpi_osc_context context = {
> -               .uuid_str = int3400_thermal_uuids[uuid],
> +               .uuid_str = NULL,
>                 .rev = 1,
>                 .cap.length = 8,
>         };
>
> +       if (uuid < 0 || uuid >= INT3400_THERMAL_MAXIMUM_UUID)
> +               return -EINVAL;
> +
> +       context.uuid_str = int3400_thermal_uuids[uuid];
> +
>         buf[OSC_QUERY_DWORD] = 0;
>         buf[OSC_SUPPORT_DWORD] = enable;
>
> --
> 2.17.1
>
