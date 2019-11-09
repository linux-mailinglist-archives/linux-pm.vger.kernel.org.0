Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F8F5DB7
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 07:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfKIGiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 01:38:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41434 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIGiI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Nov 2019 01:38:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so7143778oty.8;
        Fri, 08 Nov 2019 22:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3p9u/rgJKjdWlnTta3AnL5lSarpdkzH2Rhh1WsuSRDc=;
        b=MFttT4THlZtozWagsc4+QSdNgHFKOkE1ZvGLdF6W7gspneIg6f9AsPW9JHNXOII2bh
         6JkuvCZtDIWbeS7jWvfx0FtAkkgm6osAjXTdTDNE6Oe3pWr0zmOyc9wcz+aJ3x59NbAi
         SwZCt7xs99GAh68RIQ/yS2Ei0W6ECnegR8/TboEYn5hKJgKXRK8L4ifgb/EmMuLNtcl/
         B0FDefzSfqEnkZyR7Q1CAiZa8v81NS2sDn0YmADNCQZ5gHqkuuVmd3itEdcFjV6lWgwN
         wpyaGvHhrw0srKWN9dztuFw2LPthPFTME0XPDL0m1gQpE7+c7mDbtNP8NMr5d458iIW7
         CwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3p9u/rgJKjdWlnTta3AnL5lSarpdkzH2Rhh1WsuSRDc=;
        b=f6XWtyUMo8Gg9Mi+7MCVvaRcYecsFJB1IjU45WWqPF8K0g6v7YMETNo9v1pVkQFSfe
         Eivnve1I5w9woXlzlabkBnxJA1jVfmCaNmMHmXmDFlAAnkqUBwd5IGdf65bMqkvkgRAw
         lJavch0VO0Ws0VKbqTLji7GzfKy51zkIuaRHqnpDFxEevZfsj765pCtRm2u6sWDjn6ea
         CN0ZlWw3ewdVS2EFpzL0k7u4AlgSyBgjgKwhf6BC1RrN3FGPp62lQuZSUfF66IZVVWqc
         WnWku+ToKZCA9TwpyV51T9Z4L0gQINvBhKfGclRqu6MSSKIkPsAlIOm4YtN7VKRm3OJt
         q3Vg==
X-Gm-Message-State: APjAAAVI/TbSwN9UZeiKKq8a46YRtZKXbcdo4q8IEiHgy41oJ7efYsbt
        B4J3blTV8a0mylUBPVqLFllcbLpgyYt/9GIP7AE=
X-Google-Smtp-Source: APXvYqxdBeoDNGbfL+9tGNN8sgRNd1dCEsZrG0MBuTCVqIMx/mOlOpFLie0rSvHapyosbh89Nvj/M01mflEPNxflAaQ=
X-Received: by 2002:a9d:313:: with SMTP id 19mr3033692otv.197.1573281485657;
 Fri, 08 Nov 2019 22:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20191021085140.14030-1-zhuguangqing83@gmail.com> <2538968.KVf98yYfh7@kreacher>
In-Reply-To: <2538968.KVf98yYfh7@kreacher>
From:   guangqing zhu <zhuguangqing83@gmail.com>
Date:   Sat, 9 Nov 2019 14:37:54 +0800
Message-ID: <CAGRspPPz2g8GJrF9ZhUeCZnN2K0pZCg4SDiG3hHVV8R0Ub8QXA@mail.gmail.com>
Subject: Re: [PATCH] PM/wakeup: Add print_wakeup_sour_stats(m, &deleted_ws)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rafael J. Wysocki <rjw@rjwysocki.net> =E4=BA=8E2019=E5=B9=B411=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Monday, October 21, 2019 10:51:40 AM CET zhuguangqing83@gmail.com wrot=
e:
> > From: zhuguangqing <zhuguangqing@xiaomi.com>
> >
> > After commit 00ee22c28915 (PM / wakeup: Use seq_open()
> > to show wakeup stats), print_wakeup_source_stats(m, &deleted_ws)
> > is deleted in function wakeup_sources_stats_seq_show().
> >
> > Because deleted_ws is one of wakeup sources, so it should
> > also be showed. This patch add it to the end of all other
> > wakeup sources.
> >
> > Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > ---
> >  drivers/base/power/wakeup.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index 5817b51d2b15..29e9434ccaaa 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -1071,6 +1071,9 @@ static void *wakeup_sources_stats_seq_next(struct=
 seq_file *m,
> >               break;
> >       }
> >
> > +     if (&ws->entry =3D=3D &wakeup_sources)
> > +             print_wakeup_source_stats(m, &deleted_ws);
> > +
>
> That would be when NULL is about to be returned, right?
>
> Why not to check for !next_ws instead, then?
>

Yes, that would be when NULL is about to be returned, so check for
!next_ws instead is ok,
and it's more suitable.

> Moreover, why to call print_wakeup_source_stats() directly instead of ret=
urning
> &deleted_ws?
>
> Also it looks like you need a similar change in wakeup_sources_stats_seq_=
start(),
> in case n is greater than the number of list entries, don't you?
>

There are three reasons that I think calling
print_wakeup_source_stats() directly is better.
1, Although deleted_ws is a wakeup_source, it is not in
LIST_HEAD(wakeup_sources), it's
a special wakeup_source. The intial design (before commit
00ee22c28915) is also using two
seperated print_wakeup_source_stats() for LIST_HEAD(wakeup_sources)
and deleted_ws.
2, If returning &deleted_ws, then wakeup_sources_stats_seq_show() and
wakeup_sources_stats_seq_next() will run one more time.
3, If ++(*pos); in wakeup_sources_stats_seq_next() runs one more time, then=
 n in
wakeup_sources_stats_seq_start() may be greater than the number of list ent=
ries,
and it needs some more change.

Thanks for your comments.

> >       return next_ws;
> >  }
> >
> >
>
>
>
>
