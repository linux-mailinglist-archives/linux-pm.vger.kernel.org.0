Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5AC450B57
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhKORVk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhKORTv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 12:19:51 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2867C061208
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 09:13:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so22386512ioc.8
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2es5dbHXRJPkreWY9KX+HP22ehmWI1e8VyeSPUZii4=;
        b=oKeuZLodUAoDdRWVbHJJiXxXQNm2vFpXlYlgJwfX0fxFKVAkaq6H93Jm8MewHWtysM
         sdcA1kOK108oSD8naCwAfMuczfWMhTXGpka/jzUMOcCCxRp3o64hvduPw0YdNozz0H2/
         EeJlikZFNAg35BabEWnEAjtW5AC2cbAHWXZE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2es5dbHXRJPkreWY9KX+HP22ehmWI1e8VyeSPUZii4=;
        b=pG7q0eGpMdyS1lpMAj2q9Ccr04XS1jap4ec64sjvAZpGAMXz9U4DNPvbEt0qeC1iSu
         xn/DpUk6QrclH4ZqPxzOY9+TdMvMnEs9PneTGUwZmVWhfljaFdQ25X7nItqsKIFnHE4r
         11xK4uXctvUGoNTh/ZD4pY57C5MQcdhoEhErEO+9tCBhGbkMbEKH2cxVWxXnaqFFEpW5
         xMWWlAUDOWupljCspDw06HKaJq/6/mcNsHgRfIjqrnD2/KsGBngKQKli2k/ayDAw7ZtF
         h89f9SCHw/V6pQMkFAc5ltkSAcxu42kKulv/vBH0CGRIcZ1R93CL039LDtDQNnGy2ND+
         SNIw==
X-Gm-Message-State: AOAM533npf+2CBAHf4rwydMIW8Gq1W40fqv2/PbqklWgjI3mXIKhHd3V
        Myx7bn/lJh/4Se8qffeCSuz8QGTx8HlZ/A==
X-Google-Smtp-Source: ABdhPJxLAshAWAEXtQRLWMPlg/T8ZZOnc0vEYdBhbF5l1ZOm6iQ10C+K/zDZlsWLQRX4KAfzYQ8OqA==
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr295845iow.146.1636996403947;
        Mon, 15 Nov 2021 09:13:23 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id d137sm8201541iof.16.2021.11.15.09.13.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:13:23 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id s14so17453702ilv.10
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 09:13:23 -0800 (PST)
X-Received: by 2002:a92:6910:: with SMTP id e16mr313484ilc.190.1636996403030;
 Mon, 15 Nov 2021 09:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
In-Reply-To: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 15 Nov 2021 09:12:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
Message-ID: <CAE=gft4MRvq-VCBW4EX4dGfPi4s7Lco8h6Z_ejRH5A1e-K2-yA@mail.gmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix snapshot partial write lengths
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gentle bump.


On Fri, Oct 29, 2021 at 12:24 PM Evan Green <evgreen@chromium.org> wrote:
>
> snapshot_write() is inappropriately limiting the amount of data that can
> be written in cases where a partial page has already been written. For
> example, one would expect to be able to write 1 byte, then 4095 bytes to
> the snapshot device, and have both of those complete fully (since now
> we're aligned to a page again). But what ends up happening is we write 1
> byte, then 4094/4095 bytes complete successfully.
>
> The reason is that simple_write_to_buffer()'s second argument is the
> total size of the buffer, not the size of the buffer minus the offset.
> Since simple_write_to_buffer() accounts for the offset in its
> implementation, snapshot_write() can just pass the full page size
> directly down.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  kernel/power/user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 740723bb388524..ad241b4ff64c58 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>                 if (res <= 0)
>                         goto unlock;
>         } else {
> -               res = PAGE_SIZE - pg_offp;
> +               res = PAGE_SIZE;
>         }
>
>         if (!data_of(data->handle)) {
> --
> 2.31.0
>
