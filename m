Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6D132517
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 12:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAGLnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 06:43:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34422 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 06:43:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so76062126otf.1;
        Tue, 07 Jan 2020 03:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJ7Soe4Ipf76O97lFC/HUE2dza3yg3mUCQ8NQLtNlnw=;
        b=lkgZ8aa1AIVKUV2EGHcXkmkOU5S/2wz3ZW5rrb87BOb3AxAFphlRRcxrC3HpqO3l1q
         8/WNh/leB1S1V1de/kaAfmGAC0xYsn28nUU6EHUfe1NMxjcKAmiewE/TJWRLqztI6uWZ
         hMOlKMGV3mpnyskM4Hxu5abiwq8cSR8gl3566R1DHEhfg93KOYAEkXQX3vfbJhUtIsRC
         lQS0D425axUl3EmRKZFZeigpH5i0qbzWPeMBIwyqmhlXzHaUHftqS7p38GB+SU0oNmGZ
         PG9Uwpok6ux4/20izCbMb1domRr3vbtzvsDtdFNQGmNLG4VduzGYsFv3IkZpxuxVon5M
         tLnw==
X-Gm-Message-State: APjAAAWii/xo/5G34xH/DfjHW3k0+bUiJFNhAZQFOHbS5m+bvleRDDkj
        fgTeWACCbRahtGpSftaep6yv20HNYGSXx6RmQKBiUBYR
X-Google-Smtp-Source: APXvYqwJHuZIOtRj1OEJTcGQRETFctkZnZR8kHx+hRWaSra/ov5lEOtxzfZcq5CbtlubpiBfAtssc1Qokba+aMrab8I=
X-Received: by 2002:a05:6830:3003:: with SMTP id a3mr15682871otn.118.1578397432443;
 Tue, 07 Jan 2020 03:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20200103155458.21707-1-wenyang@linux.alibaba.com>
In-Reply-To: <20200103155458.21707-1-wenyang@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 12:43:41 +0100
Message-ID: <CAJZ5v0j_0iW5k2GJGZ=REYiR29W1BGmNi-7TiXz5jwZ80+FxpQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/snapshot.c: improve arithmetic divisions
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 3, 2020 at 4:55 PM Wen Yang <wenyang@linux.alibaba.com> wrote:
>
> do_div() does a 64-by-32 division. Use div64_u64() instead of
> do_div() if the divisor is u64, to avoid truncation to 32-bit.
> This change also cleans up code a tad.
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/power/snapshot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 26b9168..8a6eaf7 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1566,9 +1566,7 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
>   */
>  static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
>  {
> -       x *= multiplier;
> -       do_div(x, base);
> -       return (unsigned long)x;
> +       return div64_u64(x * multiplier, base);
>  }
>
>  static unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
> --

Applied as 5.6 material under a new subject ("PM: hibernate: improve
arithmetic division in preallocate_highmem_fraction()"), thanks!
