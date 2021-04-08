Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99382358B0C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDHRNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:13:40 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33647 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHRNk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:13:40 -0400
Received: by mail-oi1-f172.google.com with SMTP id w70so2974869oie.0;
        Thu, 08 Apr 2021 10:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFgF1kQL+q/ICXZmpkMf3biqXaU/I9rOmpQAkp2V9y8=;
        b=c9O0zlIiW66gahrajgbqilSRk7W3ry+q7nCD4zNtidekWPeWvHWsEyS0SnpWOCSrnP
         GNCsjO/UeDXre6bmNuBBhFw3yYuWc64ipzN8EikDDrRKcKI+UeZKppcf5fAOJVh3JiWh
         vyn9Fg0c4T9m3T7m7Qf262sLZZ8OJRwwRX9iWYuYe848JAlQZZv6kPmL9PgwyprDPJUs
         bQecpydonyFWIb1l9IPJhUSv8VFWAS9dh/1RJjs8aLPaKrEUgbq0cDp+PKwQh5zNC/FP
         QNBK6uXOnAE2ImIDDnRYZ5czT/ZIs1avvYxXnCD1KbVraWO1daBzmEUVChPZBIJn+K82
         CjRQ==
X-Gm-Message-State: AOAM533LLv1PF+2EhYieo0uSgL2KJZ7W9Yv3AZwktNfOfAH1F4LId9/u
        wdaPD8Xrdwp3nB1An0k1Bmpml/tChG9Yp9zXeHw=
X-Google-Smtp-Source: ABdhPJwrsHJCAJIQUvh2BBOfjhYFxJumtJtJJwU+szEyLnTBHtExkqFR+4sgQyPJaEQJ8b0DT3CJC/ZDZVen5bCat48=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6717583oib.69.1617902008463;
 Thu, 08 Apr 2021 10:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210401141537.21288-1-yuehaibing@huawei.com>
In-Reply-To: <20210401141537.21288-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:13:17 +0200
Message-ID: <CAJZ5v0j45q0hs28x1h-+AP1QHAu9Toa8dogmMGZRVgk-_-NMTg@mail.gmail.com>
Subject: Re: [PATCH -next] freezer: Remove unused inline function try_to_freeze_nowarn()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        zhe.he@windriver.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 1, 2021 at 7:58 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There is no caller in tree, so can remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/freezer.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index 27828145ca09..0621c5f86c39 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -279,7 +279,6 @@ static inline int freeze_kernel_threads(void) { return -ENOSYS; }
>  static inline void thaw_processes(void) {}
>  static inline void thaw_kernel_threads(void) {}
>
> -static inline bool try_to_freeze_nowarn(void) { return false; }
>  static inline bool try_to_freeze(void) { return false; }
>
>  static inline void freezer_do_not_count(void) {}
> --

Applied as 5.13 material, thanks!
