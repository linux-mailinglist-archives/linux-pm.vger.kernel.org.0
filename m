Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39B31A210
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhBLPtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 10:49:14 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36899 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBLPtJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 10:49:09 -0500
Received: by mail-ot1-f46.google.com with SMTP id a5so7607383otq.4;
        Fri, 12 Feb 2021 07:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7Yx2HgpxGuohS8+X/HdV90i/oCfgJPF66lnae8TlVg=;
        b=TdkK48cDzFKbjcTPJtJrhWU4jwFxBRrS0muPntZkhfUlOFaW4oKigU6mtaaqEzymOX
         mv4VLMK6H7EKgnUiZoC2U82NNyoR0UCDjeu5LW4AqLoRs9hv/aD5SETiLOgfdDNx5SzB
         TMC/PXyrbfYaAs/TYUj6PSOR0Hj1pJuXl5qaeO3UB8qacnKxLToq2rmLBQklgvrVKQl6
         vK90OpHvDj4Ubxl5TINeFBoueXXRJdu0zPNHVfbvB5T4rVjZWS+BQzQqnZN8anxTpLmh
         Meee1pFukICBLvXNM5kO3KILmMQ+D6wTkbRoTJgFl7e2bx92S7T47wyiw64E55D4CS1j
         C8Vg==
X-Gm-Message-State: AOAM531ah/GqfJs8+8oxC4b370qC9/B/4UGn+u+R4QSFWtonUFcQJM50
        AcikXiB2AKyoWyRKNEwazO7pl+uAfzCss6103iY=
X-Google-Smtp-Source: ABdhPJxRYMHbJ29b4Mmgtm4YHiryw9U7q16zRyp3E2Urkfy75iFOWc1H3RizG9sXnMozlxcxMBS7o0R/Ibu76anK5n0=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr2372860otc.260.1613144908266;
 Fri, 12 Feb 2021 07:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20210201225735.86163-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210201225735.86163-1-rikard.falkeborn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 16:48:17 +0100
Message-ID: <CAJZ5v0gKRRTzmXUbdcwNO1jTYnOFpioNQ2nK615QY5X84ULeYg@mail.gmail.com>
Subject: Re: [PATCH] PM: Constify static struct attribute_group
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 1, 2021 at 11:58 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of suspend_attr_group is to put its address in an array of
> pointers to const attribute_group structs. Make it const to allow the
> compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 0aefd6f57e0a..12c7e1bb442f 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -387,7 +387,7 @@ static struct attribute *suspend_attrs[] = {
>         NULL,
>  };
>
> -static struct attribute_group suspend_attr_group = {
> +static const struct attribute_group suspend_attr_group = {
>         .name = "suspend_stats",
>         .attrs = suspend_attrs,
>  };
> --

Applied as 5.12 material, thanks!
