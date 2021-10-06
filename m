Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AA4242BD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJFQfh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:35:37 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:37545 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhJFQfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:35:37 -0400
Received: by mail-oi1-f182.google.com with SMTP id w206so4814214oiw.4;
        Wed, 06 Oct 2021 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1j54Hi+9SvvzYGXgri/LfJoVt95gHrji9h1JTTlfc8s=;
        b=M9CHYGE06Jari8MkqyipDI6K7KYl/ZRhwL7a8l3bAkfhAVNq7xVZJU1Uui6TWag6/7
         I1QMrzojKfg1XRxk9LU4MULpTAcW6VjHf/ejFf9hpgdegNmAU5FtEGGAuKBjKkToPthX
         YUWkrYY5tXc5P3KQ+uMYI3+LJw5hhqrL4qRNWD69qwg7bPB2GA9VLG3s3nkXMOqq4j7z
         n0ZSdhmrJl9zyCztXcdBSfz42YpFuAI44JlVZlgZplxIQiDOxCU/VY9SoZEOLWGoix8a
         BZww3/cPr5qGnvQ0voUxlgWtzNznkE7A7wGCEy0TT2Qy9yWgDW4lzK9HovP6ETS67Zfx
         JLfQ==
X-Gm-Message-State: AOAM533TbA5HzRmMHqrz5tn89ztLHnbRcQ/adj/VbarYUdivwfD9wY7m
        mnSMwyDPw3s6vS5JhhjdqFxYNGyClN175HYNW90=
X-Google-Smtp-Source: ABdhPJyaLmK0B69/hQ8esizcD0gT2ybEV86tgEHX/mOV9UzZvkZYkmgeEhLicEB//8w30lt7CiTv9YSyORGC69fSj0E=
X-Received: by 2002:aca:6009:: with SMTP id u9mr8226144oib.71.1633538024876;
 Wed, 06 Oct 2021 09:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <1633537640-15800-1-git-send-email-mojha@codeaurora.org>
In-Reply-To: <1633537640-15800-1-git-send-email-mojha@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Oct 2021 18:33:34 +0200
Message-ID: <CAJZ5v0iee_7fnrQsxBTg9A+GOtUqsK8c5RcEbYzQE=gd-Z3bRQ@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: Abort suspend if somebody holds wakelock
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 6, 2021 at 6:27 PM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
> There could be a scenario, where request_firmware() call results in
> user land process trying to load firmwares into memory and
> parallely one miscellaneous process is trying to invoke manual
> suspend and due to which user mode helper gets disabled during
> freezing of processes and that aborts loading of firmware even
> though request_firmware() thread has taken wakelock.
>
> Although, we are checking for any wakeup event inside
> try_to_freeze_tasks() but that could be too late for the
> above scenario.
>
> Let's add a check before freezing/disable user land process in
> suspend path.

If a laptop lid is closed and the system is expected to suspend, it
must suspend.

This takes precedence over the loading of firmware.  Sorry.

> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  kernel/power/process.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 37401c9..3e0d3d6 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -124,6 +124,9 @@ int freeze_processes(void)
>  {
>         int error;
>
> +       if (pm_wakeup_pending())
> +               return -EBUSY;
> +
>         error = __usermodehelper_disable(UMH_FREEZING);
>         if (error)
>                 return error;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
>
