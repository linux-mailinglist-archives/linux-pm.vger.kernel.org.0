Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705902074BC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390747AbgFXNlS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 09:41:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36759 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbgFXNlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 09:41:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id h17so1855358oie.3;
        Wed, 24 Jun 2020 06:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnmvcU92QXrUl04hjn7tGIeeKzAWp4LgoQtWHEM6agY=;
        b=MrAFHzbI+p/xTvCNrfOEJ40w0bciDtXomOOHbxaekJJcaGhz1/Hj/XLmwmhAunHgo5
         +U3RRREjBC1s/wG7+Uo3vvinxp9/Ox23Hd8eK/OzhbEM/2hurl8MBC/gpT7GFGuXNQjB
         rt9hDRquYl+rqY6oo4blIqXqivAjCB4KHE6rPThYa/GwY6j771mTk+IyCklyK+XYpbOK
         pCWHD9DzS34M6pSgWigif7NiYPdFSxkMEvKj6IHPNfcplTWX2H7Mj+97PFCM/nhnxfCW
         vgjRfwNoyyO5yzkee/EOKK7A6bScHN7M8qpn1kL5RIGAiH2P/juiMdZIR62Lw9ngP4Rp
         vb/Q==
X-Gm-Message-State: AOAM533Y2BuOlEbkkCT3QSjW4UqCdbnufLaHZYytlRU5Ey5f/W/9RiUk
        Stft8xzArwK5GohL7CDeROsf9l9uWFVcfEjH16k=
X-Google-Smtp-Source: ABdhPJxSlGoIqKLNW45g583557/XXC3OTh+ABBdRSnLX9Fo43Xbse5OldEuSiS+SD38hqKDFye99r8Tt/2cIOhX8NrU=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2415646oic.68.1593006076625;
 Wed, 24 Jun 2020 06:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200624131921.GB9972@mwanda>
In-Reply-To: <20200624131921.GB9972@mwanda>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Jun 2020 15:41:05 +0200
Message-ID: <CAJZ5v0hG2FL0VSeE+ind9MSMc_c7nA4KjKxFPdMhVOPrMdYJKQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Fix uninitialized variable bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 3:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "tick" variable isn't initialized if "lapic_timer_always_reliable"
> is true.

If lapic_timer_always_reliable is true, then
static_cpu_has(X86_FEATURE_ARAT) must also be true AFAICS.

So the lapic_timer_always_reliable check in there looks redundant.

> Fixes: 40ab82e08d78 ("intel_idle: Simplify LAPIC timer reliability checks")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/idle/intel_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index aae53e650638..6c9152f303a6 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -132,7 +132,7 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>         struct cpuidle_state *state = &drv->states[index];
>         unsigned long eax = flg2MWAIT(state->flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
> -       bool tick;
> +       bool tick = false;
>         int cpu = smp_processor_id();
>
>         /*
> --
