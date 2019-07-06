Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201A460F78
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGFIdy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 04:33:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33970 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGFIdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 04:33:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so11271056otk.1;
        Sat, 06 Jul 2019 01:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRif4tVUAoQ+cmBGM6m5EZtMQNrmtYEGlRUJt3z1Z/s=;
        b=ckDfirfvXIVHeDRJ+O29vUrFMP+ZJbGsfP9KRAoL6mq55KHhQY5XlTDYuyxzZFq+Vh
         o+3+8aFFGnxQv7JafCLmzuRHWFV/q+jastIYT4eZL8Y/VM7mWOixBSyVYH4tj/JO7skj
         j8MGRGhkPMzykFQVwuXb6eO0ZisjdXw4KeDT2EWjwCfJvCGZaBDjV5tuh3nBkKFSY0D3
         r3xID74+DbVUJq30FCCfu7x4CSq8ImAagF0V0n5+LEgCEo8yjZTejy2qS8Ehn357SQKl
         ZYk0gGmK1ONNoM/9sY2RJnRm9Zle1lyBJHHP1O1k9Ff5LPpeZH+Hpbz/v6A8uRy6l7UB
         B/2A==
X-Gm-Message-State: APjAAAUKQkS2Ph35nGbVZWTXLlT6gATkCuT31zm5df1xv+4/q6wqlhQl
        K2ASsJlQ4O/5YEPyZxotG+Mc9XkIm5SYIUtHdeUb4lan
X-Google-Smtp-Source: APXvYqwIsIAR/ZhdJkbwxeCK5mC05r8njTLVKCx4RZrUhrVY7yYsAmTUt7AbTYr0vSU/VVMnGDS/8whdavigarXnagg=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr5725964oto.167.1562402033198;
 Sat, 06 Jul 2019 01:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190704192020.GA3771@amd> <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
In-Reply-To: <20190705185001.GA4068@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 6 Jul 2019 10:33:42 +0200
Message-ID: <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
Subject: Re: suspend broken in next-20190704 on Thinkpad X60
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 8:50 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2019-07-05 00:59:35, Rafael J. Wysocki wrote:
> > On Thu, Jul 4, 2019 at 9:20 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > Suspend is broken in next-20190704 on Thinkpad X60.
> >
> > Broken in what way?  Any details?
> >
> > > It very very probably worked ok in 20190701.
> >
> > Well, please try the linux-next branch from linux-pm.git
> > (git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git)
> > alone and see if that fails.
>
> So... let me try this one?
>
> commit  1e2a4c9019eb53f62790fadf86c14a54f4cf4888 (patch)
> tree    cb5339fcaae2166832f91f4ce9f40575cc6cb6e5
> parent  3836c60c063581294c3a82f8cbccf3f702951358 (diff)
> parent  0a811974f3f79eea299af79c29595d8e1cb80a15 (diff)
> download
> linux-pm-1e2a4c9019eb53f62790fadf86c14a54f4cf4888.tar.gz
> Merge branch 'pm-cpufreq-new' into
> linux-nexttestinglinux-nextbleeding-edge
> * pm-cpufreq-new:
>
> That one is broken, too.
>
> pavel@amd:~$ sudo pm-suspend
>
> Machine suspends, resumes, but I don't get my prompt back.

I'm not sure what you mean here.  I'm guessing that you don't get back
to the console from which you ran the pm-suspend command, but is X
restored, for example?  Is there any way to get into the system in
that state?

Anyway, if 5.2-rc7 is OK, something in this branch causes the problem
to happen for you.

I would try

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=f012a132824fc870b90980540f727c76fc72e244

to narrow down the scope somewhat.
