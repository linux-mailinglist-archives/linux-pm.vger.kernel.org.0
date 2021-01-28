Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D853072C0
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhA1JaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhA1JWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 04:22:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050ABC0613D6
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:21:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 11so4452220ybl.21
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=oYgXl9L1NuQMmPwFJHZauMaZ3aglVOiQk6E5rY8VZ+7sDuvqU5XS8bo39C2cTCKUpr
         XYLQGqHJpfy+kJy3yOL1Pw2DabJM7QchG3qD3hiqyrM0Nu1OQE9444i0GOI5I14SJPNP
         CcJmpBGqJie+WuSQpjRaMGrEDk5xWDvlRyW/4q8iGS0/uCCNnelXvtwvx84g+vNeEJ+8
         6rRhvK2UxvKH0DNPYnAxNmg2g/zpvAaS9lNhHQSiIZGKCgIXF2Yg/gpdFB8qw+1jb7vr
         nitn/Vzf83uXjKx1XtIHhWvS3tD4GiBTk/XsG+ZZnKvfALHnJkZzG4nDQfa2y17uj8ES
         ++Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=KPDq8Qzbh6/Dyc0eipMGttHolke+OesPCfg2uUWKaRQ7donCVg91lYHb1GSwwlMfNs
         Lzfq1E0bAU/PMrgsRgqTO436NFGiYDpr1cXN9/XpfIcYdoTt4UGFhbBXcP/kfwKgyI7X
         7mi7VybJ988U/I1/a8l5nXuP11hJhkQyytt0QTImzC8hfUQhtVu0CAB/BuVYV6q8bBbT
         tCMoYjbLqYrctpq2/b/Y6Yusw7JPUQcW1A/70Nb+FE7gYJ4H2G0lbMYh9Iv1JaRUrCxG
         0BMqEpCrVoZMPR+kG9bdzo7x3uQ4UmpL+5LN+bUrKAK7Kb7gRYOiTZtDsXXYQV35q4Oa
         h0zQ==
X-Gm-Message-State: AOAM532w8Xjrl8xpOvmJUwsiCl8TQw6uZsD/pWBrZVCKgt1roXFVWRQ+
        8F8j/kDz2mXomD4l8Zn8ssOetjtXRhQofTYW
X-Google-Smtp-Source: ABdhPJySXiM69uvOnkpK2j2D4HX+QWmgqg6MD7iQEC+4H8MMXhJTem552VCGCX68HuZXc/Bq7t5i/3mefpqtdFWu
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:a5e2:e68a:ef67:8128])
 (user=josephjang job=sendgmr) by 2002:a25:3a04:: with SMTP id
 h4mr22140678yba.285.1611825712228; Thu, 28 Jan 2021 01:21:52 -0800 (PST)
Message-ID: <00000000000004f27505b9f26bca@google.com>
Date:   Thu, 28 Jan 2021 09:21:52 +0000
Subject: Re: [PATCH v4] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
From:   <josephjang@google.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 867157311dc8..ecd988b4a838 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7788,6 +7788,8 @@ F:        include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> The kernel/power/ file entry already covers all files in that
> directory, including suspend_watchdog.[ch].

> So, why do you think you need to add these two further entries explicitly  
> here?

> >  HID CORE LAYER
> >  M:     Jiri Kosina <jikos@kernel.org>
> > @@ -16630,6 +16632,8 @@ F:      include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> Same here.

> I think you can simply drop the changes in MAINTAINERS in this patch.

Sure~
I will drop the changes in MAINTAINERS and send PATCH#6 again.

Thank you,
Joseph.
