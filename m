Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F423117A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgG1SRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgG1SRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 14:17:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA40C061794
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 140so11530867lfi.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=hdBHy5JovDcVsPtQmmE+kOG+0bUdmbxHWwkGKho10lmXbEo1G9ahGg7SX5mCD+aqlW
         7usecoUhK45RaSad6rpfDN2jFykepxltPY0kSQC9Ax1Dvd9VtqnLvGoZA2JD/scAiTF+
         RuZ2jZslihKTU8Zs6p6GmQJvi4+8tJXvgSOCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=hCLtGgDjBBwgewjMzr0MY9ZXfXROUeD3i3fiIWdBOe/fnhE7cnUdkvVUbkS+6Frgf4
         E64Yjc1u9IjBSBSkSjBEEpM53bjRHUKS20zyLUyl4i3/Lkr2BK7nHCWFGD2S0zb3/CmS
         WMxdE1NqmKB5WdjFguJMLA70d7pfclIqp16OLZ0LZbkY+NbfzDmKBhBGVJcVcGiXZpmm
         7BX0dxk+2uvzlrKbs+zzRCXu79JGPL3u2h/u5Z0RPpIwgGT/IaeBN0jDjLG71DT7bYiG
         Eb22/woqbkLA0RaDGYAQXOy7+9rDDU+5/vzt+U8wj/dBnRmSgROoyyGQHTbyNhQa8ikk
         07gQ==
X-Gm-Message-State: AOAM530aiSg/INubQloJsOuQONHAUhc4bShJFTNWR46629FQH1v4Ua6W
        zUv+U3sFCiF+qjCODEDw1n9+0lsXzss=
X-Google-Smtp-Source: ABdhPJwv9v0vN6dR8DKQaQsKT8Zcf8i8d9fyQsal7xfZzcp+/rZAlwoyUs0Gmwdf1RW2WutRtuJ/0A==
X-Received: by 2002:a05:6512:281:: with SMTP id j1mr14973936lfp.214.1595960240718;
        Tue, 28 Jul 2020 11:17:20 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h18sm3087290lji.136.2020.07.28.11.17.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 185so11982417ljj.7
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr12506329ljj.314.1595960238862;
 Tue, 28 Jul 2020 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7trg4ie.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jul 2020 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 28, 2020 at 6:23 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> For exec all I care about are user space threads.  So it appears the
> freezer infrastructure adds very little.

Yeah. 99% of the freezer stuff is for just adding the magic notations
for kernel threads, and for any user space threads it seems the wrong
interface.

> Now to see if I can find another way to divert a task into a slow path
> as it wakes up, so I don't need to manually wrap all of the sleeping
> calls.  Something that plays nice with the scheduler.

The thing is, how many places really care?

Because I think there are like five of them. And they are all marked
by taking cred_guard_mutex, or the file table lock.

So it seems really excessive to then create some whole new "let's
serialize every thread", when you actually don't care about any of it,
except for a couple of very very special cases.

If you care about "thread count stable", you care about exit() and
clone().  You don't care about threads that are happily running - or
sleeping - doing their own thing.

So trying to catch those threads and freezing them really feels like
entirely the wrong interface.

             Linus
