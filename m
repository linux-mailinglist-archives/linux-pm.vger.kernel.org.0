Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844B113A88A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 12:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANLjH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 06:39:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 06:39:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so11819088wrm.11
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tgfw4WcAZhA82/kw+SEL3pFweCri8T0MlotixdbWMso=;
        b=VbYwHC4uJlDPmqvi/xXbfRLLq/0sf+oZcBXNGxIewa3VGSYHnVnNb12XfNnjSjBu1j
         ObcAVnNmVMLpB7h5daN49U7Un9kGIfoXxzNz2KewVNjE4meaEdcHaxGWm/egrjdJ+bUl
         +vaJg6MpISxTEg+I07orw1hZ1YnOygr5WWy+DF/fUy797aIDuBfrF3GzUfFkFgX8cDck
         UDJ+IHzIRHJOBBX4wU2u9VvSHokM+kT75n3KzHhjOEzalkwjvcjcF05H9bNnzvStuZ9b
         0MYSje4qr8YM5OesdwqZJcj3Ns6Og7005NGAY3wD/BhKxBGI1ezz8grl+uXQ6YgKMlGq
         nidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tgfw4WcAZhA82/kw+SEL3pFweCri8T0MlotixdbWMso=;
        b=Wzd6+9XrASPjCyE4oc2lKPhQm5UCMynAhICED6VuXXtfcrTtldBwuckG3TOMcHZaah
         Cyn8s5+IoC2XWuy8ABYK5FdNaqHX/VKwohdkppdlXMBOY1cROBYETKo7rqHu0d/w+iGs
         yklO8x3XLZJA0E6dWIeTOwwueHwiXyGxcX1wz+Rrl50FwgyrQ1vH9CTIp++uZG4IKV/7
         bmyyqul4/0gF2iGD1LqMoTY5Q42we3d/+uQkgPFmrAGVEIePXjfqwXLyuBXKPyJLMh2b
         ZNZzMP2I8x2FrPX1snntQh+0j6Lzjr1GvFalBI4iQjsDI9tET0gJ2kQ0+vrRPUpoVbuz
         DTkQ==
X-Gm-Message-State: APjAAAUuXH9o3L0eGDbS9Hj4E8tPUtP8uuhjAsFLKjy8cKr1rpOggwiY
        7knEzBmREVtmR1ApWMp6dadUbufZsIr6+BHDVffMBg==
X-Google-Smtp-Source: APXvYqw1RI7FSM88eJ2Vekj0L4T73CeOxZkK9xJzHtrwXY3+CkBEkFfgsmDhbRuneSucAmows+/eefFnSQn9r2Nsou4=
X-Received: by 2002:adf:f28c:: with SMTP id k12mr24176978wro.360.1579001945135;
 Tue, 14 Jan 2020 03:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20191223211309.GA4609@sig21.net> <20200113092604.GA26365@sig21.net>
 <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
 <CAG_fn=V0nTqsFxYAuH0K3cJxx3nWitG50VkYOQ8MHNO+H8hfKQ@mail.gmail.com>
 <20200113171557.GA8544@sig21.net> <CAG_fn=UgU3vibsaug6p35Xs1dzLgBecA48t-PqS9OtRTHNu54g@mail.gmail.com>
In-Reply-To: <CAG_fn=UgU3vibsaug6p35Xs1dzLgBecA48t-PqS9OtRTHNu54g@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Jan 2020 12:38:53 +0100
Message-ID: <CAG_fn=VjzJSguf4ZB2x8Xn=U9MCHyfyqd2DVwPPC36t5+S+VsQ@mail.gmail.com>
Subject: Re: init_on_free breaks hibernate
To:     Johannes Stezenbach <js@sig21.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > Strange about the resume=/dev/vda, it worked for me the way I described it.
> > Maybe device numbers are dynamic, 254:0 is what I got from ls -l /dev/vda.
> Indeed, for me it's 253:0, and resuming from console works with that number.
>
> > > The memory corruption is also reproducible for me, taking a look.
> >

I think I know what is causing the problem.
Upon resume the free pages may contain stale information from the
kernel that initiated the resume.
There's clear_free_pages()
(https://elixir.bootlin.com/linux/latest/source/kernel/power/snapshot.c#L1148)
that clears the pages in the case CONFIG_PAGE_POISONING_ZERO is
enabled, we just need to reuse it for init_on_free.
See the potential fix below.

Rafael, Pavel, I've noticed that in the setup suggested by Johannes
even the defconfig kernel with heap initialization cannot hibernate
more than twice, the third hibernate hangs.
Is that a known problem?

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..d65f2d5ab694 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1147,24 +1147,24 @@ void free_basic_memory_bitmaps(void)

 void clear_free_pages(void)
 {
-#ifdef CONFIG_PAGE_POISONING_ZERO
        struct memory_bitmap *bm = free_pages_map;
        unsigned long pfn;

        if (WARN_ON(!(free_pages_map)))
                return;

-       memory_bm_position_reset(bm);
-       pfn = memory_bm_next_pfn(bm);
-       while (pfn != BM_END_OF_MAP) {
-               if (pfn_valid(pfn))
-                       clear_highpage(pfn_to_page(pfn));
-
+       if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
+               memory_bm_position_reset(bm);
                pfn = memory_bm_next_pfn(bm);
+               while (pfn != BM_END_OF_MAP) {
+                       if (pfn_valid(pfn))
+                               clear_highpage(pfn_to_page(pfn));
+
+                       pfn = memory_bm_next_pfn(bm);
+               }
+               memory_bm_position_reset(bm);
+               pr_info("free pages cleared after restore\n");
        }
-       memory_bm_position_reset(bm);
-       pr_info("free pages cleared after restore\n");
-#endif /* PAGE_POISONING_ZERO */
 }
