Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE1296309
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898049AbgJVQsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 12:48:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36207 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898044AbgJVQsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 12:48:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id u17so2426887oie.3;
        Thu, 22 Oct 2020 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lvu53nwOmKW1a9CIVBFMcps6EWS89y5EclPDxC9nmh0=;
        b=AWISSvatpQRlrh3PzPaZPP6b1DWGwzTfz93WZnRJCK5PgkRczrCac4MDrPLwtjarc7
         tlJiIdUjOWVEzdv6g5jMhP/7mTyhOg4Xlo7xudlYOj3vGdH9twPaUydOHWxJWfmZXT0Y
         4T81UbXKLhj+Pr+vzPe8TPo9p/PXbPj4SaCusshStz6KQU/KXsxGHRWD36FxLi+gzj1H
         HJX/T58NzLoHIGuRLSwG8WpgW0Jd/MIiTSiQUhek4RvlFSiv5FMO5EaWl9c+0mcXbQ0Z
         o7iy8FJgOkJ/VzDv0RkfY+hA9N1jiJI9RGfv5B/q0H6MBMOZP7sro8wq967EVLegP7Ap
         PNoA==
X-Gm-Message-State: AOAM530U9pLQBVJi7Qu7sMaWPm0VJJ12EGprSMusd/Kcfxhi8hwXX+h5
        Bpv4z46AASMi5K9RK2GqRKyUhd/Vz5UH518TkuU=
X-Google-Smtp-Source: ABdhPJxhcIWseF3yHvWk8TdYgm957ZVABMLlalztBBNEBhcFWBGwcc0wbNMHAd+rBk4ySn8nYVYklgvsrFCkcQAIc8o=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2204257oii.69.1603385317918;
 Thu, 22 Oct 2020 09:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201019200330.16629-1-trix@redhat.com>
In-Reply-To: <20201019200330.16629-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 18:48:26 +0200
Message-ID: <CAJZ5v0ifnZb4p+EBeYdggVm_VB54fX-HaMJX7vgkY0UnHJOEYg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: remove unneeded break
To:     trix@redhat.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 10:03 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/base/power/main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 205a06752ca9..c7ac49042cee 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -363,7 +363,6 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
>         case PM_EVENT_THAW:
>         case PM_EVENT_RECOVER:
>                 return ops->thaw;
> -               break;
>         case PM_EVENT_RESTORE:
>                 return ops->restore;
>  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> --

Applied as 5.10-rc material with edits in the subject and changelog, thanks!
