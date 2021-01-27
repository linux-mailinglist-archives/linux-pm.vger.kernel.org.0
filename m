Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9B306324
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhA0SX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:23:28 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:41410 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhA0SX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:23:27 -0500
Received: by mail-oo1-f51.google.com with SMTP id q6so769636ooo.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 10:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ST67nQdI5wRH8CqvlonVuOTDz2NikvzARu57CePeA1U=;
        b=d8PvLjiIEgUX92woQxkkPARCtITzR+cM/ighT5p/VlJPeV3appG/oBa7IrSuEDPvnc
         1+FjuVIpWxl26fUVBDoY1g+j2Lg/p8+Bythh3vlNMKE9U1U3tYzoRjd+psDuad0xLpLg
         q2342923G+C4lfmaHcCrzfexNOO5xg2ZRCYMXzEw20XjFy0dypVNlmezh08jV6sj8dUx
         KxdLoNbWevPAeSDUcN9ra0qBnP6EaCajrdlGAteALn4S4NfxcIROE5RWJCYWM7TP8cLd
         ZbeMXfnQE7np1wEjqNF5GE6h7iaZjPzfZlQ970khmSkO2fUgppR7fu46cCwaRlgECcZE
         hbjA==
X-Gm-Message-State: AOAM533WobTv2oZ1w+xjEDu8+syqNxhWmaakIY8tRnBGOa9JMiU5fQd+
        bUe0WWG+zmy1ihT9+CCqnjiah19COQ53+f1XWPI=
X-Google-Smtp-Source: ABdhPJwDA4MCFWs+YpQCIzHsjP2rQZdKhdA4jVwO9uaLyYtAnqIX9sI/+NIFzUk9JOXxHNVOJEw98iSO4tD0prsyCRg=
X-Received: by 2002:a4a:9873:: with SMTP id z48mr8661412ooi.44.1611771766463;
 Wed, 27 Jan 2021 10:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20210126212940.2922275-1-helgaas@kernel.org>
In-Reply-To: <20210126212940.2922275-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 19:22:35 +0100
Message-ID: <CAJZ5v0ix5KHpe4yX20ddp8JaFgBYfVT80mAe4XY2m0pe3_m9aQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Use dev_printk() when possible
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 8:23 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Use dev_printk() when possible to make messages more consistent with other
> device-related messages.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/base/power/main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 46793276598d..f893c3c5af07 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -16,6 +16,7 @@
>   */
>
>  #define pr_fmt(fmt) "PM: " fmt
> +#define dev_fmt pr_fmt
>
>  #include <linux/device.h>
>  #include <linux/export.h>
> @@ -449,8 +450,8 @@ static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
>  static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
>                         int error)
>  {
> -       pr_err("Device %s failed to %s%s: error %d\n",
> -              dev_name(dev), pm_verb(state.event), info, error);
> +       dev_err(dev, "failed to %s%s: error %d\n", pm_verb(state.event), info,
> +               error);
>  }
>
>  static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
> @@ -1897,8 +1898,8 @@ int dpm_prepare(pm_message_t state)
>                                 error = 0;
>                                 continue;
>                         }
> -                       pr_info("Device %s not prepared for power transition: code %d\n",
> -                               dev_name(dev), error);
> +                       dev_info(dev, "not prepared for power transition: code %d\n",
> +                                error);
>                         put_device(dev);
>                         break;
>                 }
> --

Applied as 5.12 material, thanks!
