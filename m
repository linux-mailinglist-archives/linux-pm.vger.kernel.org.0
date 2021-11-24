Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED6545BF02
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbhKXMy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 07:54:27 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33502 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbhKXMuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 07:50:04 -0500
Received: by mail-oi1-f181.google.com with SMTP id q25so5191009oiw.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 04:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k26ka+ta0i6Z36o9g6Jqd2rUtmGaINBaEUhwAYTxLl4=;
        b=TfjvJjEIhboAw10vBgw280mooUvKmgGdQRERTB4rRZakeWGnF/8bpCiYKIrM9ZAACm
         xRhioJvKCA//8CubSJ52lxu9lgIz3wjcxcD4IentQwgKb7ZEcs4c8eirChj+8/lK2lbu
         oWmv+Nr82dKfDEXTUPT+gCHNpMCAJ2HknrRQGS1xbEwxM4Qyy3IJwsqXha05HtJiT4uD
         oOQMQh1bcQzxKRRIFrxyU77NmErtvy19rLwXteJrizmPMlEMIIqkOF/C75ZfuxOUEBIi
         Av+IEn0uu6nLyO9w50kpFoWLShz/gFfT5v8aIOc38Ird+52r5pv4qXRYvthcD5Wx48oR
         qefA==
X-Gm-Message-State: AOAM530qp8vcusRapG4VIY+DkuC1561maKYOpD6VKXp0fqGpwf5hjTwc
        PgV/Gd8wUdpT7RSHVTdLzmGB8L3jKeUE5iVYZw0=
X-Google-Smtp-Source: ABdhPJzTA8an93y5Is8AqpgnW5UhxsmpDLn+Z8l8vRIz466/W34jtrJRMlULSuXX9MNspBJlHfcEFkCSOTl+WnOyNvI=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr5557585oil.166.1637758013129;
 Wed, 24 Nov 2021 04:46:53 -0800 (PST)
MIME-Version: 1.0
References: <YZ0+k4Vy7SJ1D8kH@x1.ze-it.at>
In-Reply-To: <YZ0+k4Vy7SJ1D8kH@x1.ze-it.at>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 13:46:42 +0100
Message-ID: <CAJZ5v0i9RR2wEx2ktKLzt2ZaAWTVqWJwf+tO0c99CzcLD9Th0g@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: use correct mode for swsusp_close()
To:     thomas.zeitlhofer+lkml@ze-it.at
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 23, 2021 at 8:18 PM Thomas Zeitlhofer
<thomas.zeitlhofer+lkml@ze-it.at> wrote:
>
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
> swsusp_check()") changed the opening mode of the block device to
> (FMODE_READ | FMODE_EXCL).
>
> In the corresponding calls to swsusp_close(), the mode is still just
> FMODE_READ which triggers the warning in blkdev_flush_mapping() on resume
> from hibernate.
>
> So, use the mode (FMODE_READ | FMODE_EXCL) also when closing the device.
>
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 559acef3fddb..b0888e9224da 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -691,7 +691,7 @@ static int load_image_and_restore(void)
>                 goto Unlock;
>
>         error = swsusp_read(&flags);
> -       swsusp_close(FMODE_READ);
> +       swsusp_close(FMODE_READ | FMODE_EXCL);
>         if (!error)
>                 error = hibernation_restore(flags & SF_PLATFORM_MODE);
>
> @@ -981,7 +981,7 @@ static int software_resume(void)
>         /* The snapshot device should not be opened while we're running */
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> -               swsusp_close(FMODE_READ);
> +               swsusp_close(FMODE_READ | FMODE_EXCL);
>                 goto Unlock;
>         }
>
> @@ -1016,7 +1016,7 @@ static int software_resume(void)
>         pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
>         return error;
>   Close_Finish:
> -       swsusp_close(FMODE_READ);
> +       swsusp_close(FMODE_READ | FMODE_EXCL);
>         goto Finish;
>  }

Applied as 5.16-rc material, thanks!
