Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8353F233BFD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgG3XSL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 19:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgG3XSL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 19:18:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F4C061575
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 16:18:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m15so15206897lfp.7
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcsWvrkJmkldNkR7Og1fU1p0Fe8lfIhMHe3883Sw5AQ=;
        b=Nm909XrN/coCOGd8NKEDwC2r1wN5HlmeeTd4TLu/lY7lxYEtvV8l3/MWkw25JWkeuz
         vwzFtNUPds+t9fEMHzEjWnOEgSL5KC4oxjOVwt2XDRCd6jcpauyB0qIQBwHI7GUnOnjP
         XPJEVJpi3F1oie4huDR1BAOZdqzlmzioLtKDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcsWvrkJmkldNkR7Og1fU1p0Fe8lfIhMHe3883Sw5AQ=;
        b=SzZo3GtaL1wx5TTalk4bZcXojiXmI3qfGcipapPCVf0KvM04Be1IZQgxtOPXqKFkTA
         CTCAgg/GsAgZA6o8cAqbn6ralVSuLJQgvZoQOVD4kKrsBeGtQHIXSVe6Pvkb3Wsb9uCQ
         1EARP8+VuMUgtfmLxdRjDUOpRU0JBnxGhhosqUgkyBwbGPlIusKhIZ5KrfbehPPzvu4y
         0LhOu9smrD13dCWqgelBgq6SE0gpYzjYBTZv2PLbIzNdfXsz0GK0W/AmXhYY4QUGtNKX
         oe/jmdVmwIwwPfeurf/uZ3RBKrPKi98Y40d1h8j0T2y6xFIDbqUlJGsYCf4w5aFHqKk2
         1P0A==
X-Gm-Message-State: AOAM532PpwMCcyW3e0owyMfaMAJcIxUlwuJggEGgOWGvw8kiGIvsnePq
        ZtZ3e9gn3qPffmk9MVpV9FBHPhiDvoo=
X-Google-Smtp-Source: ABdhPJzTSZP7B45NStZxPnyQtNKB5Md/1GuAD1pxUXmBMejvHVII/g2aKbRLpqltUkBgKvKdG4Sd6A==
X-Received: by 2002:ac2:5e3a:: with SMTP id o26mr476328lfg.78.1596151088597;
        Thu, 30 Jul 2020 16:18:08 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n205sm1495122lfd.59.2020.07.30.16.18.07
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 16:18:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id i19so15872705lfj.8
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 16:18:07 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr459435lfc.152.1596151086728;
 Thu, 30 Jul 2020 16:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
 <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
 <878sf16t34.fsf@x220.int.ebiederm.org> <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 16:17:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
Message-ID: <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
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

On Thu, Jul 30, 2020 at 4:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The key is the function make_task_wakekill which could probably
> benefit from a little more review and refinement but appears to
> be basically correct.

You really need to explain a lot more why you think this is all a good idea.

For example, what if one of those other threads is waiting in line for
a critical lock, and the wait-queue you basically disabled was the
exclusive wait after lock handoff?

That means that the lock will now effectively be held by that thread.
No, it wasn't woken up, but it had the lock handed to it, and it's now
entirely unresponsive until it is killed.

How is that different from the deadlocks you're actually trying to fix?

These are the kinds of problems that the freezer() code had too, with
freezing things that held locks etc.

This approach does seem better than the freezer thing, and if I read
it right it will gather things in the signal handler code, but it's
not obvious that gathering them in random places where they sleep for
random reasons is safe or a good idea.

I can imagine _so_ many dead systems if you just basically froze
something that holds the mmap lock and is sleeping on a page fault,
for example.

Maybe I'm missing something, but I really think your "let's freeze
things" is seriously misguided. You're concentrating on some small
problem and trying to solve that, and not seeign the HUGE HONKING
problems that your approach is fundamentally introducing.

              Linus
