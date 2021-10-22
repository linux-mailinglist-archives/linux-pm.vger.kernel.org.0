Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE61D437890
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJVOAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 10:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhJVOAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 10:00:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A9C061224
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 06:58:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so3816840lfu.5
        for <linux-pm@vger.kernel.org>; Fri, 22 Oct 2021 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXXjrgFD9GxycZP7psxdDamDNFUN7x5Wjjbi/hjihFg=;
        b=iK8wS2ZKDL+XOVbhiW7h++R+sR2QK02X8jWaX1Xr56UYrdIsKQI7oqjt/rn7Kzy6Vm
         kv5dNMoixvnYRQ56ojAX/RQKDZJi3gbD6WPcm8n7EICq3k22xVHN1Pnl5XHUGwXRf08i
         wynK09w/BRhN5+uW16FVE8Hj2bhLmhtwitMNoKxpMmzS+hEdH55dwQMR8jCKpDPla9wT
         GZkfDR3iXMsWD6vxCo1pZgZUDqierhl2C/e+WYEXJPbCQo924mwY6zOSaPA+gf6vBVpz
         j5rWcb4JJx0QxKh5tj14jXVkb728QMArDpHkwamllIq85la430YGW8K3q/zZX9mIr42I
         5URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXXjrgFD9GxycZP7psxdDamDNFUN7x5Wjjbi/hjihFg=;
        b=gw5fGxgwdXUSiedG0uwaR/MkbpwsHn94Dn4OOH0DxFgg5jqW1yiLeVPAE09nj3g/La
         MVEEVgUuPwrwgoX41/wTBdCE29nh0YgWj1L2tAsHwRpOMUzaGLdY5oFtg8psoLgbF7Ab
         V7FvpZ6gh8EpaexRAL3j5bqE/vZ449Lithg6Aeh5M2+qLRD03BV4RcN2YXKRHqhDN7J9
         qcQeDCDIhzn1FR6wUw0IkAswpEidRyXvJmo1vvV4+iE9k5WbgMeqO2q4gbQAMqFR9GT8
         OFRILuFUG7UzT2T8C6VTvu0FuAde6sYQsIUX6hkOLgHMWMYT+4HorslaMjOwgRP0sx45
         HFbg==
X-Gm-Message-State: AOAM532Obk7xgsq143rtgrY4MmQK650EAk46z9IjmqR9f1phzQFTJSGx
        qfm/uNmXiyws1JHohPyPbXBPfCDRaou4IsSZQyUkB0BxiP4=
X-Google-Smtp-Source: ABdhPJzDz4PMdhgbqAyGI0Nco6rp1BpNUsAvdub7hQ7KocotcyVYeX5QmW1BGnvEs+UrCtgsC+vmKHvfk7RmSlvTico=
X-Received: by 2002:a05:6512:3254:: with SMTP id c20mr10693589lfr.254.1634911085502;
 Fri, 22 Oct 2021 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <5773062.lOV4Wx5bFT@kreacher>
In-Reply-To: <5773062.lOV4Wx5bFT@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Oct 2021 15:57:29 +0200
Message-ID: <CAPDyKFpp5MjiD0MPd878HueXkZZH2vj_ddi-g3-ZL5rXODjdcA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Do not let "syscore" devices runtime-suspend
 during system transitions
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 Oct 2021 at 14:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is no reason to allow "syscore" devices to runtime-suspend
> during system-wide PM transitions, because they are subject to the
> same possible failure modes as any other devices in that respect.
>
> Accordingly, change device_prepare() and device_complete() to call
> pm_runtime_get_noresume() and pm_runtime_put(), respectively, for
> "syscore" devices too.
>
> Fixes: 057d51a1268f ("Merge branch 'pm-sleep'")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 3.10+ <stable@vger.kernel.org> # 3.10+

This makes perfect sense for me too.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1048,7 +1048,7 @@ static void device_complete(struct devic
>         const char *info = NULL;
>
>         if (dev->power.syscore)
> -               return;
> +               goto out;
>
>         device_lock(dev);
>
> @@ -1078,6 +1078,7 @@ static void device_complete(struct devic
>
>         device_unlock(dev);
>
> +out:
>         pm_runtime_put(dev);
>  }
>
> @@ -1789,9 +1790,6 @@ static int device_prepare(struct device
>         int (*callback)(struct device *) = NULL;
>         int ret = 0;
>
> -       if (dev->power.syscore)
> -               return 0;
> -
>         /*
>          * If a device's parent goes into runtime suspend at the wrong time,
>          * it won't be possible to resume the device.  To prevent this we
> @@ -1800,6 +1798,9 @@ static int device_prepare(struct device
>          */
>         pm_runtime_get_noresume(dev);
>
> +       if (dev->power.syscore)
> +               return 0;
> +
>         device_lock(dev);
>
>         dev->power.wakeup_path = false;
>
>
>
