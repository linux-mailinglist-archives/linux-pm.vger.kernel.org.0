Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140D21A2232
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDHMjW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 08:39:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40273 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgDHMjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 08:39:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id a7so1624805oid.7
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 05:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LzDAJ2JFzqV5kaVsQfPnzZ6M0GP0zUjgVzXoUn3Lrc=;
        b=m4AKuuXSLH9v1r8tDjx4pYAeueg7iDRfp7xG7q652IiZ9XxkAFGpUlKJTbn+FF902t
         6k54t+KRVY9s6XzuxzQZT4RZr73/qih+k3KJ/G2u3V0jdwcO4QjD0QqjriNIwYxPwKtA
         Qawn2NeKBIQwpLWW4iUaEJCYQu5bpchc4mle2xBOofvfRE/d1btZLGMXJBcWzdVTnYJG
         SI0bGERDiKWaiGx8AK5LspQXyiCZhdRcKVTubd/HdaDPC+opRhUpv/ujnrZ6fl2pCR4t
         31JdRdS2RHxUWvo1Ti9upiYJloiAq5644Yzr5WI61j1L7gvn04CSVjyJ13dLYjO61NbD
         pbtQ==
X-Gm-Message-State: AGi0PubToysJbBv+cpIR0R4LcGW4W687iBJHJsHnc3PKP3wLokExH15U
        sZhLEn4ys7h1aByfTgtKyaWD5Kp38AXVD/G81NI=
X-Google-Smtp-Source: APiQypK+4wgTSL61YFGiIgOyz2UmixXbC8mmTNDK56huExUVTMgpCSp4kC4BvZCLIj9DcT4Kr5wpWxLCPSbUwCIWEAg=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr2349812oic.110.1586349561648;
 Wed, 08 Apr 2020 05:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <bb6be3ff924a6ade66a9c4be37a15adb315d47e1.1586340575.git.wuyihao@linux.alibaba.com>
In-Reply-To: <bb6be3ff924a6ade66a9c4be37a15adb315d47e1.1586340575.git.wuyihao@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Apr 2020 14:39:10 +0200
Message-ID: <CAJZ5v0g=as9hTGdUwNMdAdsH6AbGCozKSuz0gj2aU2s2K5B5LQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle-haltpoll: Fix a small typo of haltpoll
To:     Yihao Wu <wuyihao@linux.alibaba.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 8, 2020 at 12:11 PM Yihao Wu <wuyihao@linux.alibaba.com> wrote:
>
> This patch fix a spelling typo in cpuidle-haltpoll.c
>
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>  drivers/cpuidle/cpuidle-haltpoll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
> index db124bc1ca2c..fcc53215bac8 100644
> --- a/drivers/cpuidle/cpuidle-haltpoll.c
> +++ b/drivers/cpuidle/cpuidle-haltpoll.c
> @@ -94,7 +94,7 @@ static void haltpoll_uninit(void)
>         haltpoll_cpuidle_devices = NULL;
>  }
>
> -static bool haltpool_want(void)
> +static bool haltpoll_want(void)
>  {
>         return kvm_para_has_hint(KVM_HINTS_REALTIME) || force;
>  }
> @@ -110,7 +110,7 @@ static int __init haltpoll_init(void)
>
>         cpuidle_poll_state_init(drv);
>
> -       if (!kvm_para_available() || !haltpool_want())
> +       if (!kvm_para_available() || !haltpoll_want())
>                 return -ENODEV;
>
>         ret = cpuidle_register_driver(drv);
> --

Applied as 5.7-rc material, thanks!
