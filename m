Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B63A470D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFKQze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 12:55:34 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:33387 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFKQzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 12:55:33 -0400
Received: by mail-oi1-f176.google.com with SMTP id t140so6486687oih.0;
        Fri, 11 Jun 2021 09:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl1dSh4z4GN3i6kJlKIfcte80/tetVQiVHWgzdotp00=;
        b=LSkPk2ScBiVEthb+iJVSvlFHHWptbg6tDGin4Hi396u8yrBF3Agwj4cXMB4q6/CQ/U
         uu8JxqXhpgp3yJxowA2StjMal8K1o59+Rl8G68eric9gliF+9wYY+M07FHd6hBP6/VCv
         bRLajOTythRcCRTkNfyEMoG+g8iessbyFDDdXICgwO4vUbjK0uXqO/J7kq9NvOZ31OCx
         J/NiafUHBFwXh8J3SHgsnOq9QxjxmK7LbxF7oEbqt6eDDMRs1rHswM+vjz8zFbvxGGpl
         8vBznPFzrcwVR9LIPOkIn9ZbOVCwnTftqNO3OdkSsmFDQWuVKEWWyIlMuDobxfRI319E
         JCng==
X-Gm-Message-State: AOAM531QbBHi84VK8W4TneWmws5xxSlJ4L1XRNMGDNdWlEzUx5TfGybU
        RXeOr8/UJna2AjrMySj2HqZtXvy6jjXYZVMawqE=
X-Google-Smtp-Source: ABdhPJxN8hScUGYs0MwN1bP9XMFcSnFXlGH16a4oyPUCiSDANjrnVSpZmkfpFlduEMB2D271E26+KwF7vUDUGONeeDE=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr967478oia.157.1623430402332;
 Fri, 11 Jun 2021 09:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210608081314.13435-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210608081314.13435-1-thunder.leizhen@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 18:53:11 +0200
Message-ID: <CAJZ5v0gZ0Jt_x7WGdRLdckORzRFs+ELzaDz9xaGKEtt51Nj65w@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: hibernate: remove leading spaces before tabs
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 8, 2021 at 10:13 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> 1) Run the following command to find and remove the leading spaces before
>    tabs:
>    find kernel/power/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> 2) Manually check and correct if necessary
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index af507c8c895b..f7a986078213 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1146,7 +1146,7 @@ int create_basic_memory_bitmaps(void)
>   Free_second_object:
>         kfree(bm2);
>   Free_first_bitmap:
> -       memory_bm_free(bm1, PG_UNSAFE_CLEAR);
> +       memory_bm_free(bm1, PG_UNSAFE_CLEAR);
>   Free_first_object:
>         kfree(bm1);
>         return -ENOMEM;
> --

Applied as 5.14 material, thanks!
