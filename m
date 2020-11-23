Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F442C11EB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgKWR0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 12:26:48 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41791 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733189AbgKWR0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 12:26:48 -0500
Received: by mail-oo1-f67.google.com with SMTP id o20so1442670oor.8;
        Mon, 23 Nov 2020 09:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74gAAKrXGHCOv5Lu8fi+qsQUyGkmNSPiGNb1uC5KwBU=;
        b=eHUW5Lbq9b+qc+zWwfFWsOJywPXc7GS0Fr5k47oweBLIapTMEishqwdJ1VS5S8ZT34
         aStD1/3m6k+6NKqw9pp+kGN7HTfKHvzbEvrLkIv2EE7zREWbeEbXnFpi08PWag2Ux/u4
         FjeAz6OOSy2ENN2EoiVIT9zkFRhLibL6P+hlHD35WCnSSU7TdyEf0P0XR0+iHLy9buac
         85qdaRwJ3kBnZiPvNjxai4yc2nSf39U9Px9qYl6yHcRZFSpf3qQrg7GrPEFWOmO33bV+
         8GNt1MjSmMDGh0XYIyrIBaRXSX5jJceO8obW6SmosRjxs7EM6oWXQzcZib8U4aG+FdxF
         waIA==
X-Gm-Message-State: AOAM5330/wekNIKIiMtaVbLrfM/vp77aSiqSBLxFmXdEf6bydRdjwSpb
        OkG7Ijm1BnvCVtA/QCHvfHopu2zvMCFUSsUS0K7i7u8pU6Y=
X-Google-Smtp-Source: ABdhPJxcnGuNomevjJK6bWP7Z0/Y2PbUyMhXYG80JgzUvPiQZTzOSw5V+41Rng4uMxRi8H5UeauzCHAF6VlyKp7SOfE=
X-Received: by 2002:a4a:bb07:: with SMTP id f7mr306250oop.44.1606152407187;
 Mon, 23 Nov 2020 09:26:47 -0800 (PST)
MIME-Version: 1.0
References: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1605257895-5536-1-git-send-email-alex.shi@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:26:36 +0100
Message-ID: <CAJZ5v0iUfvn0=HbuowX=j0zxpiiEmBTb=QyQknViqGrc8WDW2w@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: fix kernel-doc markup
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 13, 2020 at 9:58 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Add parameter explanation to fix kernel-doc marks:
>
> kernel/power/suspend.c:233: warning: Function parameter or member
> 'state' not described in 'suspend_valid_only_mem'
> kernel/power/suspend.c:344: warning: Function parameter or member
> 'state' not described in 'suspend_prepare'
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/power/suspend.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 32391acc806b..502d86ed99c7 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -224,6 +224,7 @@ EXPORT_SYMBOL_GPL(suspend_set_ops);
>
>  /**
>   * suspend_valid_only_mem - Generic memory-only valid callback.
> + * @state: Suspend state to be set
>   *
>   * Platform drivers that implement mem suspend only and only need to check for
>   * that in their .valid() callback can use this instead of rolling their own
> @@ -335,6 +336,7 @@ static int suspend_test(int level)
>
>  /**
>   * suspend_prepare - Prepare for entering system sleep state.
> + * @state: suspend state which sleep from
>   *
>   * Common code run for every system sleep state that can be entered (except for
>   * hibernation).  Run suspend notifiers, allocate the "suspend" console and
> --

Applied as 5.11 material, but I've changed the originally proposed
parameter descriptions into "Target system sleep state" in both cases.

Thanks!
