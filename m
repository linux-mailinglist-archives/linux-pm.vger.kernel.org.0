Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52D306052
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbhA0Pzt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 10:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbhA0PyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 10:54:05 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B9C061573;
        Wed, 27 Jan 2021 07:53:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d13so2327231ioy.4;
        Wed, 27 Jan 2021 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/3KCfh3ZQYGELqM2bafW403qYpiQ4StvHwY6E9DasU=;
        b=XBDkQg4GBl0EqPbdNovnfjzPS97J7m+TBv3vjmugtE02zFJ3SDpq6fqg7OJuC9SSKZ
         Tw2Wy7IbfnGUdcZpJaIZ73020xPY4LQ3l9Uhcue8Ca2fxGfmj/1THCmOnEVp7GHBnZsb
         uAFFKAvV+XOdR2sHjAyvmwlWtdNpy7iO6+C0g7D8d1f3RAEvQSY6rAIomqK8EqrUBqfF
         u3uFQAaoLtzsG1rGdW3UYFLSDHmuhAZdQYltOFa+N+ixIFWvApKOl8LoWy3sVhCepD8U
         ce7URYOC6g4qPByC7q+AfFjAR0gQMxtjBrmm5k5Pe3beP1lxMLz0slcuJtGbsVKFQ0MI
         DVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/3KCfh3ZQYGELqM2bafW403qYpiQ4StvHwY6E9DasU=;
        b=hvca0b7s8kxJqKyBqf9GJQex5WyuodxA+Nu7PvtZTq2wT9B6CGdR4RlJRNTLEvDZE1
         6WlaDq9pn8sDLTepy/3+QsPKlm5aNqEJK6I3RkZ62F1JaDy18waxYaxgCbHZ43/37HZT
         AmNy6kA/hNbzjEL4OrjcmRvFB9rchCmyySU+6fGjPm3T6ikynV+/KvDydLyoUPLjvCmQ
         5xL680pz6NDrY83rwa0B5KI6ngy5fjnezwS4P/IrHy74n9f4p9EziceHzdPxnBffYOGM
         bQ3yB6pR/GX3a9fiWK+GAQKOW/yQoD5uZkrDoxkuC6QTR5ufXXz+6bH8+NbfnUKRb+HZ
         IO6A==
X-Gm-Message-State: AOAM533Tqtvjp7E5/pT8XtsDR4zZqe0nFPcT477da/UAik+MEQXh+1gW
        CgiDNE3MBwanrbrIECuj0yIXio58JgodZ/6XDhM=
X-Google-Smtp-Source: ABdhPJxjsu5yRI9VK8dNDuvc/g4DsGrryXfFim1qZ2xlA4uYIQytiNb5tm6Go9ruExvrz2wxxggEESTNNACZaHbzdM0=
X-Received: by 2002:a05:6638:329a:: with SMTP id f26mr5729376jav.12.1611762804768;
 Wed, 27 Jan 2021 07:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20210108044159.598669-1-josephjang@google.com>
In-Reply-To: <20210108044159.598669-1-josephjang@google.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 27 Jan 2021 16:53:13 +0100
Message-ID: <CAKXUXMxjerYP3TKgA4fP9w=S9=SF+zZ0hzaRZ9dqXMy7XBnWbA@mail.gmail.com>
Subject: Re: [PATCH v4] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
To:     Joseph Jang <josephjang@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 867157311dc8..ecd988b4a838 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7788,6 +7788,8 @@ F:        include/linux/freezer.h
>  F:     include/linux/pm.h
>  F:     include/linux/suspend.h
>  F:     kernel/power/
> +F:     kernel/power/suspend_watchdog.c
> +F:     kernel/power/suspend_watchdog.h
>

The kernel/power/ file entry already covers all files in that
directory, including suspend_watchdog.[ch].

So, why do you think you need to add these two further entries explicitly here?

>  HID CORE LAYER
>  M:     Jiri Kosina <jikos@kernel.org>
> @@ -16630,6 +16632,8 @@ F:      include/linux/freezer.h
>  F:     include/linux/pm.h
>  F:     include/linux/suspend.h
>  F:     kernel/power/
> +F:     kernel/power/suspend_watchdog.c
> +F:     kernel/power/suspend_watchdog.h
>

Same here.

I think you can simply drop the changes in MAINTAINERS in this patch.

Lukas
