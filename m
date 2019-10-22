Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287DDE08FF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfJVQfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 12:35:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37434 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJVQfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 12:35:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id 53so3139983otv.4;
        Tue, 22 Oct 2019 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZAk62VktTsx+Ob5O9T/IcWukBxIKCSIlZ2KMfpKjSc=;
        b=Tq4KtB0FuMuoXmcUzSundCvbSJdQdrRbgdQQQDuSY6CoyeUiVeFxew5RMZl1dEt7n4
         SOo27ORB/aukXzehw0h/Xof7eu/iBlt8LuspsyTaQO0gkzmmd8D3iEtBbAl6CkQjbCC/
         wm4Sfg35sZhYOXYLrXLKmGRQXSeTPfxSZhXmwveV8wOjt52DBjAulV1pJllMJ+6QHsqy
         mWLflW0VWNJHoTQhLs86iP4TJj2NKgqKAk5/q7MCtkKP6UbwpCaEGrdEYDVVbui8Ix6K
         r3YQ41reM9wVWZdVFAjBa2gTkti+IbBm5aefJFNRYp5jda1Kw2O1Tjy7OjsQHrpIAJlR
         AoSg==
X-Gm-Message-State: APjAAAUgkZX3ljNkwdCUc5bo76sp4dLNLeiCmzpJzpa7D7twD2qz1P9k
        VxBj2G/xH5G3EalSYYTwzzisYHi85bCzFl4nUMk=
X-Google-Smtp-Source: APXvYqyiUYppacOkbJofxp7QuUJl+cq2qZ0YPjnNVSiXTq67WvH+Mf7/GyLi7Db/N96lB5giKe21wKkj3mnO9yuE0Fc=
X-Received: by 2002:a9d:5907:: with SMTP id t7mr3368476oth.118.1571762142513;
 Tue, 22 Oct 2019 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1570927586-12023-1-git-send-email-zhenzhong.duan@oracle.com>
In-Reply-To: <1570927586-12023-1-git-send-email-zhenzhong.duan@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Oct 2019 18:35:31 +0200
Message-ID: <CAJZ5v0iaWxu1vL08zyEfx6_Eku9yK5kh-HK4ZdbBtqZvSVd6tw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: not unset the driver if it already exist
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 14, 2019 at 2:43 AM Zhenzhong Duan
<zhenzhong.duan@oracle.com> wrote:
>
> __cpuidle_set_driver() check if there is an already exist driver and
> unset it before return with -EBUSY. The next call will succeed as it's
> just unset. This is strange as we should either keep old driver and
> return -EBUSY or unset and set new driver and return 0.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  drivers/cpuidle/driver.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 80c1a83..a200304 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -74,7 +74,6 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>         for_each_cpu(cpu, drv->cpumask) {
>
>                 if (__cpuidle_get_cpu_driver(cpu)) {
> -                       __cpuidle_unset_driver(drv);
>                         return -EBUSY;
>                 }

There is a bug here, but it needs to be fixed differently.

The function should check if any of the CPUs in the mask have a driver
(which is different from drv) already and if so return -EBUSY before
updating any cpuidle_drivers per-CPU pointers.
