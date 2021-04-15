Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8C7361116
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDOR1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 13:27:44 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33594 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhDOR1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 13:27:44 -0400
Received: by mail-oi1-f177.google.com with SMTP id l131so19994224oih.0;
        Thu, 15 Apr 2021 10:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2/MEuEeupn1XD91KEDFGEYCtTkhM9JUVIoa4Bmt8f4=;
        b=mYzoPbWaGjvn7I5bp74byIkNvGU2ekrUhiSJe18PRNwwA8iP1JYImBqO5A7wCVCAjI
         wBYRSjy0ZX8K7H6r6Ew8LHBFfa1HBLDhtQps91YTqzgGtrABTuRdfRz203w024BoE8za
         v+mUJa1BiPDfNO8h4zxBnMnk9Xa5XqOeBqWinnHh0xpSeKL0wvAuesDAj4Ak08od2ixs
         mBn33ckoTLQ6ARibHQbugaTJqfMCGkz0/+iRB4hnzABffIiyUp++ZnaC0+jk4Tefxngj
         CgzgIFkytbjC10zZ+G2ikw3Z0qwDEZsqk5vZTixHdOxhoSb59cD/DIfy8/tCuKeCy0zU
         kSzw==
X-Gm-Message-State: AOAM53273CaLHYIPhVyv2zDiGFiZDA+ueaemEeYMBDJkW55JKuLlKEMb
        Y6EhO75X7z09PhHVfxs5aaW3j8P9Rh9GdRFSTcA=
X-Google-Smtp-Source: ABdhPJxgA326n+N7CFVAqzzfojoEO53OiJQSFpTzUG+lLSA1dVG8mYtw0bJ4ptu0XATtq3jVw6DBDugUFaSjTaMtsJY=
X-Received: by 2002:aca:aa8f:: with SMTP id t137mr3355166oie.71.1618507640706;
 Thu, 15 Apr 2021 10:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210414125310.10900-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210414125310.10900-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Apr 2021 19:27:09 +0200
Message-ID: <CAJZ5v0ibmADGpSeuGJEBLwRwLx_WR-EkxsytdLB3LEd5DYMGKA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PM / wakeup: use dev_set_name() directly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 14, 2021 at 2:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We have open coded dev_set_name() implementation, replace that
> with a direct call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/wakeup_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> index d638259b829a..5ade7539ac02 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -154,7 +154,7 @@ static struct device *wakeup_source_device_create(struct device *parent,
>         dev_set_drvdata(dev, ws);
>         device_set_pm_not_required(dev);
>
> -       retval = kobject_set_name(&dev->kobj, "wakeup%d", ws->id);
> +       retval = dev_set_name(dev, "wakeup%d", ws->id);
>         if (retval)
>                 goto error;
>
> --

Applied as 5.13 material, thanks!
