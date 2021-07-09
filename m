Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CB3C26F9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhGIPnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 11:43:31 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:33464 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPna (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 11:43:30 -0400
Received: by mail-ot1-f43.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so9896250otl.0;
        Fri, 09 Jul 2021 08:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncf7zOhU65T4VQiognHrm7EoMLCmcDNC05EuerCbCYQ=;
        b=JlxNPjIQaKo6hL+4P/Qu9GESx+wsVJRPnAtFcj5DL0asiFXwckgS9E+TTX0sAFU9dE
         bHvWnjM5jwWuWlhPeCfNMz5lQDTYOa3W5Tkb+oHQYMzOEnLSYC93Picf5CVk2RDsX5jW
         3QF60aOa1cnJ2qQZAz/kqI2o3oWGzU/gH/S8RTmS+kgpZUDOkVgFG2oBh2vsT/EoMnB/
         1WNwfz/82aan8au4eBRJniD+LzRV2Wc85rFkiZ2NB/aWG6evSf6YmTBpQoU0zgQcN3ud
         6ZYbXGkR+Qms/Gohm+dp/HFsI7GjkuTa/vCziI40G48oiRmQtGv1vH5g1hT/UqDquTni
         xz8g==
X-Gm-Message-State: AOAM530VrAi4XjtJn6Yuolh4aI+CySKjznYlAspr4eS2CbuB1nSkpCHl
        mJhJ1S83QohdTnCVlW5mjZ/zMO0suYQfTAaCUorhXLpL
X-Google-Smtp-Source: ABdhPJx91i3Ekt/sXNn9pDxbH3hCLXoeaiuVi+KFL894kC4ssc4z/O06FVGuPuQqzl9APn6oa1iW9SiE49L/KD1kkrE=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr18522163ota.321.1625845246762;
 Fri, 09 Jul 2021 08:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210709003204.26944-1-win239@126.com>
In-Reply-To: <20210709003204.26944-1-win239@126.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jul 2021 17:40:35 +0200
Message-ID: <CAJZ5v0giqpTnJS_4D0LxfJpdk6-xjziNcu=xXkJo+KD12NYHgA@mail.gmail.com>
Subject: Re: [PATCH] PM / s2idle: Fix the failure of specifying
 "mem_sleep_default=" parameter
To:     xiongxin <win239@126.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xiongxin <xiongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 9, 2021 at 3:03 AM xiongxin <win239@126.com> wrote:
>
> From: xiongxin <xiongxin@kylinos.cn>
>
> On the arm64 platform, the psci driver is used by default to set the
> suspend_ops structure; but the psci_acpi_init() function is called
> before the command-line parameter "mem_sleep_default=" is specified;
> the user cannot set the desired suspend mode through the
> "mem_sleep_default=" parameter;
>
> In mem_sleep_default_setup(), judge whether suspend_ops is set, if it
> has been assigned, rewrite the value of mem_sleep_current variable; in
> order to complete the user setting;
>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>

It's the third submission of the same patch AFAICS.

Have you made any changes to it since the previous submissions?  If
not, it is not necessary (or even useful) to resend it.

>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index d8cae434f9eb..bef4b17de3f6 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -192,6 +192,21 @@ static int __init mem_sleep_default_setup(char *str)
>                         break;
>                 }
>
> +       /*
> +        * When the suspend_ops has been set, "mem_sleep_default=*" will
> +        * be invalid, here to fix this situation.
> +        */
> +       if (suspend_ops) {
> +               if (mem_sleep_default == PM_SUSPEND_TO_IDLE)
> +                       mem_sleep_current = PM_SUSPEND_TO_IDLE;
> +               else if ((mem_sleep_default == PM_SUSPEND_STANDBY) &&
> +                               valid_state(PM_SUSPEND_STANDBY))
> +                       mem_sleep_current = PM_SUSPEND_STANDBY;
> +               else if ((mem_sleep_default >= PM_SUSPEND_MEM) &&
> +                               valid_state(PM_SUSPEND_MEM))
> +                       mem_sleep_current = PM_SUSPEND_MEM;
> +       }
> +
>         return 1;
>  }
>  __setup("mem_sleep_default=", mem_sleep_default_setup);
> --
> 2.25.1
>
