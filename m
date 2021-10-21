Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7367A435FF2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJULIx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:08:53 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:46997 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhJULIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 07:08:51 -0400
Received: by mail-oo1-f47.google.com with SMTP id c29-20020a4ad21d000000b002b6cf3f9aceso7609oos.13;
        Thu, 21 Oct 2021 04:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q001XmKkxSRKN0SshPrgK3z3VWsueEgGrFxooyBiLww=;
        b=dZjdDv97jHQ9n7Wd6EQ9yKKgPh5s3LrwNl+nZjS8dfI6RrHQzuq54g/Fe6jhbNrNDa
         yZQKUAVnrACoXrz6WoHWN/7wdRGTZ6Hj9UdUIb/DiMC0ljXxWc9iJ1F9cCdNkJBOVchI
         vbsBY4YhRwvGEU84dGdyDMIb9A3IoVeXifKrCG+j7FOXdLokMN9dNsd4ZffIv0vcDJ+9
         aeXoeN6rCZYBNIfD2sYcbZyh44WMD1oNX8+32pOhtcRiCkzdQlV9OiVScDQSYy+sY1uz
         9YLVdMkRYzn+zQQSBrlgNa+07DSei45VEQt7t+WSH8dctNX6wQ2Hv7Y0fCtyFnmSAuSg
         y6xQ==
X-Gm-Message-State: AOAM530lNfqoUIVfNfw4xqLytjqgYdYltAeOmC/Y9EWRxr798fMq1ncZ
        0EDsiF9ptBN5i/PNBJWdGhS4RJ98L7VGsH4Fiiu0mzNE
X-Google-Smtp-Source: ABdhPJyUM7NyBi2m4J1dqTh+VcC2e8xTxvNRDGmdOMsLZu4QLlz583Njh3oozfB0QwTvTJP88nBVSQ2CFzKDl2ZF1m0=
X-Received: by 2002:a4a:eb12:: with SMTP id f18mr3752150ooj.91.1634814395699;
 Thu, 21 Oct 2021 04:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211018131622.275-1-caihuoqing@baidu.com>
In-Reply-To: <20211018131622.275-1-caihuoqing@baidu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 13:06:24 +0200
Message-ID: <CAJZ5v0ib934QhO=Mos6q1OX0ghbm14h-xWBMtuAQ=QEJvaU8Dg@mail.gmail.com>
Subject: Re: [PATCH] kernel: power: swap: Make use of vzalloc() and kzalloc()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 18, 2021 at 3:16 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Replacing vmalloc()/memset() with vzalloc() and replacing
> kmalloc()/memset() with kzalloc() to simplify the code.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  kernel/power/swap.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 9ec418955556..5e8368fa348c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -705,22 +705,19 @@ static int save_image_lzo(struct swap_map_handle *handle,
>                 goto out_clean;
>         }
>
> -       data = vmalloc(array_size(nr_threads, sizeof(*data)));
> +       data = vzalloc(array_size(nr_threads, sizeof(*data)));
>         if (!data) {
>                 pr_err("Failed to allocate LZO data\n");
>                 ret = -ENOMEM;
>                 goto out_clean;
>         }
> -       for (thr = 0; thr < nr_threads; thr++)
> -               memset(&data[thr], 0, offsetof(struct cmp_data, go));
>
> -       crc = kmalloc(sizeof(*crc), GFP_KERNEL);
> +       crc = kzalloc(sizeof(*crc), GFP_KERNEL);
>         if (!crc) {
>                 pr_err("Failed to allocate crc\n");
>                 ret = -ENOMEM;
>                 goto out_clean;
>         }
> -       memset(crc, 0, offsetof(struct crc_data, go));
>
>         /*
>          * Start the compression threads.
> @@ -1198,22 +1195,19 @@ static int load_image_lzo(struct swap_map_handle *handle,
>                 goto out_clean;
>         }
>
> -       data = vmalloc(array_size(nr_threads, sizeof(*data)));
> +       data = vzalloc(array_size(nr_threads, sizeof(*data)));
>         if (!data) {
>                 pr_err("Failed to allocate LZO data\n");
>                 ret = -ENOMEM;
>                 goto out_clean;
>         }
> -       for (thr = 0; thr < nr_threads; thr++)
> -               memset(&data[thr], 0, offsetof(struct dec_data, go));
>
> -       crc = kmalloc(sizeof(*crc), GFP_KERNEL);
> +       crc = kzalloc(sizeof(*crc), GFP_KERNEL);
>         if (!crc) {
>                 pr_err("Failed to allocate crc\n");
>                 ret = -ENOMEM;
>                 goto out_clean;
>         }
> -       memset(crc, 0, offsetof(struct crc_data, go));
>
>         clean_pages_on_decompress = true;
>
> --

Applied as 5.16 material with some edits in the subject and changelog, thanks!
