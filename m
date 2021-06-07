Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF939E10B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGPoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 11:44:32 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45030 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFGPoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 11:44:32 -0400
Received: by mail-oi1-f173.google.com with SMTP id d21so18472242oic.11;
        Mon, 07 Jun 2021 08:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2v/PS6KigiW/mbDGu/R+ZGoP0WYsTOzVw7Gji4PkqQ=;
        b=NxdPzrD+h00jKr/tpBrZpJgrAylsmvx+VlMlj5r8pF1XMAU32QX+e3XDWsMJ1Drnzu
         Wb9yGYpPMOxv5MP85oVkbgsew9bUXZE8a92Kl4iHama5BG7E/1nxMxVWWixZXxrd/cop
         soweBmaIt4woDjwiBZeIpgqBzWDT4myXL50zqx/3lxUwXK41/F40Y6129OQjEJPE6HvA
         9xOIh4xrx3it65Eke+J+gTksEWGZZvcSAleAY6BDPyLeQELchDL7Q+LS6SN0eXVBNmJg
         NzpeUuJpj18vNYvZfbTSgg5j8IO1Hqe+tYoNxAi5zcK8fZfP78dTlVhKbsvaY8cZVtI0
         9aAA==
X-Gm-Message-State: AOAM531qHXmks0xKzbcr3v4uW3fTX5Uz6IPOO/KapMoyiaZeqHNZGLKM
        4WKrrnqs17gTnxnkEJzk1stSvOqcP25tb1mk5m4=
X-Google-Smtp-Source: ABdhPJxJIGgSJtzZADcWfEDSP+s7UDkDGWq7rB+YtEc2xtQS0yaQ8GBgNG7H/FpjruURK14aNIkN+f5S205LNM7pcTA=
X-Received: by 2002:aca:1910:: with SMTP id l16mr11149097oii.69.1623080545606;
 Mon, 07 Jun 2021 08:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210605063934.688763-1-libaokun1@huawei.com>
In-Reply-To: <20210605063934.688763-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 17:42:14 +0200
Message-ID: <CAJZ5v0izpTc-cMWxQ0f0mSNQQZUz855ceKFUC0_Z6kd1eNMaEw@mail.gmail.com>
Subject: Re: [PATCH -next] PM/sleep: fix doc warnings in main.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 5, 2021 at 8:30 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Add description for `state_show` to fix the W=1 warnings:
>
> kernel/power/main.c:593: warning:
>  Function parameter or member 'kobj' not described in 'state_show'
> kernel/power/main.c:593: warning:
>  Function parameter or member 'attr' not described in 'state_show'
> kernel/power/main.c:593: warning:
>  Function parameter or member 'buf' not described in 'state_show'
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  kernel/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 12c7e1bb442f..d508c8c582e0 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -579,7 +579,9 @@ struct kobject *power_kobj;
>
>  /**
>   * state - control system sleep states.
> - *
> + * @kobj: Pointer to the kernel object.
> + * @attr: Pointer to the kernel object attribute.
> + * @buf: buffer.

Please fix this properly or don't touch it.

This is not a kerneldoc comment of a function and so adding argument
descriptions to it is pointless.

>   * show() returns available sleep state labels, which may be "mem", "standby",
>   * "freeze" and "disk" (hibernation).
>   * See Documentation/admin-guide/pm/sleep-states.rst for a description of
> --
> 2.31.1
>
