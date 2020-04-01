Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF49919A8BB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgDAJhp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 05:37:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgDAJho (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 05:37:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id f52so25228250otf.8;
        Wed, 01 Apr 2020 02:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7FYiSC7chEEgx3CNQ8a2NbFdzSKSvDwTgv1YpBUVP0=;
        b=U9OhkD1KsACu9RTMq+Dn93FVxrdQIjAHwtYKQaDpvD3pa9p+xvvAydekoR39p6tUhg
         h+692NDD2ulHwKwWiJDOOsaKuhu1n3KhYlVkMavLpNp0bT4FlLz70hBBbktN9cEbKrwg
         gvq/xsp2lz4oZ/wgjJj5Hk4UzfYQUizYDYwqKe0WwjGLoa5D8jFLGl3SIKb9TAeHtEPi
         WMUcpe0VCdXxJk/lKAyW2KhLSBdcShvBZKGfLuu5ySbPD20yiqxIfEhQ5hrIa+gh4Znr
         bH/OE6xCIZYk6UBul+9SP/dtATIWX3UC7rnml2TVBnzpIKXp6pTyV5HKvsDEPuOqUT2g
         vFcA==
X-Gm-Message-State: ANhLgQ0MUJ/z4kKaw1t8MbVxeVcAuG40zeJ7eej6r1EB84SD61uD1Mnx
        Hu9n7sMiHjf2Ux/KJDzr84emIgOA6jnsvozkZw4=
X-Google-Smtp-Source: ADFU+vsbXgO7cUlq4NWlNLviAvtT6GXBALW9CVJiqCLwIpBGn87lAQkIkBpdW86gWYY98wkXVhVYjYHm9MhM8Ops5KU=
X-Received: by 2002:a9d:7402:: with SMTP id n2mr16640011otk.262.1585733863976;
 Wed, 01 Apr 2020 02:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <1585670125-45987-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1585670125-45987-1-git-send-email-decui@microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Apr 2020 11:37:32 +0200
Message-ID: <CAJZ5v0ijmuZ6GPpnrRoBbbYGiqDbu5HpPcSRD-bdfko7SeJ+mQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Propagate the return value of hibernation_restore()
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 31, 2020 at 5:56 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> If hibernation_restore() fails, the 'error' should not be zero.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 6dbeedb..86aba87 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -678,7 +678,7 @@ static int load_image_and_restore(void)
>         error = swsusp_read(&flags);
>         swsusp_close(FMODE_READ);
>         if (!error)
> -               hibernation_restore(flags & SF_PLATFORM_MODE);
> +               error = hibernation_restore(flags & SF_PLATFORM_MODE);
>
>         pr_err("Failed to load image, recovering.\n");
>         swsusp_free();
> --

Applied as 5.7-rc material, thanks!
