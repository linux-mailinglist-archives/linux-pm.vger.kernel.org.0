Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124453C8AC1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhGNSZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 14:25:10 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43875 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhGNSZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 14:25:09 -0400
Received: by mail-ot1-f45.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso3442840otu.10;
        Wed, 14 Jul 2021 11:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDo0D3q6xI+9CA5bjocxngrcesl99uMobhkETI9ZjYY=;
        b=HPqbUtTtLkndlxKTFY9pIISApyxDY8WbF0ppzaRaKYy/uCKmDx9Xl3H0NZDHSqsk0Q
         Iyyj7BpwjFZiQJZAsCC38yxw8VT6wf9WXoJf2RDE9RLnf9N5SMsqMRmV2NCN39bISQn6
         sjJorQPTwCARL/dzMUyUonCROpYGSbbzyv6zQ0OtdAWf2odUO3ezjQz/2CPD/UIqGCPI
         g+KH9XQrFwcbdDps/y49VExjjitbI1uxHXoegvBJJDohZL36VvQT8LgwZTAoUtgVIWQe
         JTc4aXqfyQ7rTe0XeAkZjGPvDarhZ5YHz5D3nL108dAlTpBnshKZZEXaEkVNOf2chemp
         8G1w==
X-Gm-Message-State: AOAM5304HIbV7Qq/dTd3DH2syt4lYkkrrT/Y2eI1yG2MftieeQgOyxQd
        C9kzGXlvBmvQcr2hvnZV45SuNDYLeaD5faqCtJ4=
X-Google-Smtp-Source: ABdhPJy+D3OKfKUzHB57KwHRHXtNSntVyqMak4CtaepbVm1jZ0TzbPUFm4CL9SguFXdEWCNVKpMXbhZgjQyfB53V8Lk=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr9278938otj.260.1626286936835;
 Wed, 14 Jul 2021 11:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210710103819.12532-1-adrian.hunter@intel.com> <20210710103819.12532-2-adrian.hunter@intel.com>
In-Reply-To: <20210710103819.12532-2-adrian.hunter@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 20:22:06 +0200
Message-ID: <CAJZ5v0iPXYvmOPv-kQnzMbkqNZtaZ9TMgJht5=VNnx0t3gi1Dw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] driver core: Prevent warning when removing a
 device link from unregistered consumer
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 10, 2021 at 12:38 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> sysfs_remove_link() causes a warning if the parent directory does not
> exist. That can happen if the device link consumer has not been registered.
> So do not attempt sysfs_remove_link() in that case.
>
> Fixes: 287905e68dd29 ("driver core: Expose device link details in sysfs")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ea5b85354526..2de8f7d8cf54 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -575,8 +575,10 @@ static void devlink_remove_symlinks(struct device *dev,
>                 return;
>         }
>
> -       snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> -       sysfs_remove_link(&con->kobj, buf);
> +       if (device_is_registered(con)) {
> +               snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> +               sysfs_remove_link(&con->kobj, buf);
> +       }
>         snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
>         sysfs_remove_link(&sup->kobj, buf);
>         kfree(buf);
> --
> 2.17.1
>
