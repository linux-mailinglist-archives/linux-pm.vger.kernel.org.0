Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02261306315
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhA0SRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:17:13 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39896 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhA0SRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:17:13 -0500
Received: by mail-ot1-f51.google.com with SMTP id i30so2612790ota.6;
        Wed, 27 Jan 2021 10:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbNQtcm/JkhzFHAnum+Be39q9Ie6ZgOQAYSSeu9fom8=;
        b=pXQFTxUH4/SXqpTdGaUt6JfV0ZnBy+G3HDHk2NmdNwDxinbaSqQqO4y1FTekTdAEoh
         0E++PerIyh9EBjDO9AtWitMhdvQh22cjAcSup9ujColcwYn5CZ+KhDCt4FVVezE7xQLL
         KL/9d8ZEM1UTnYvxL5CWMu+ctkPttNsY/TZk67efvLFgS7XNILN0Te8VPwwAH4sg054s
         8VI+YoYN/EpbEPEWoQFa12F0kGkmOnXFbH/9548C63P2SoFC5uDdQwWdACpZZYQHOg5r
         p9Ta0YBtLv1P2+DQybP9UPRXW1Vgm6W8VRzKQWOjwb2WsfxuZfHos2OZwWa+lwcXJCFD
         l6jg==
X-Gm-Message-State: AOAM531mdbTJtElZ41Wjsi7MiM0j7aojGWQgcWwVDqP5csADcEdTso60
        yH6Z9KVKI4nwys6W9FbWZYMtl54Di/FNRRNMakw=
X-Google-Smtp-Source: ABdhPJyFdaT8YNU1wgDbJjvsPwemFycJ4Gk0IspheNLLpPxpwUVFcaUNJVpjRieRPLth5vI/cdtuYowBgW1dseW3Dkg=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr8783140ote.321.1611771392243;
 Wed, 27 Jan 2021 10:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20210125041828.20965-1-qiang.zhang@windriver.com>
In-Reply-To: <20210125041828.20965-1-qiang.zhang@windriver.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 19:16:21 +0100
Message-ID: <CAJZ5v0j-JxkPPdbUMiG3oqRs7O-35a0G2ryEHHKy-PagczizGA@mail.gmail.com>
Subject: Re: [PATCH] PM: remove PF_WQ_WORKER mask
To:     qiang.zhang@windriver.com
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 25, 2021 at 5:01 AM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> Due to kworker also is kernel thread, it's already included
> PF_KTHREAD mask, so remove PF_WQ_WORKER mask.

So you are saying that all threads having PF_WQ_WORKER set must also
have PF_KTHREAD set, right?

That sounds correct, so I'm going to rewrite the changelog and apply
the patch as 5.12 material, thanks!

> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/power/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 45b054b7b5ec..50cc63534486 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -235,7 +235,7 @@ void thaw_kernel_threads(void)
>
>         read_lock(&tasklist_lock);
>         for_each_process_thread(g, p) {
> -               if (p->flags & (PF_KTHREAD | PF_WQ_WORKER))
> +               if (p->flags & PF_KTHREAD)
>                         __thaw_task(p);
>         }
>         read_unlock(&tasklist_lock);
> --
> 2.17.1
>
