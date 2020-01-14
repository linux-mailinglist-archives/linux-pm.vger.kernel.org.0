Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342CB13B558
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANWgE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 17:36:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57416 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgANWgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 17:36:04 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 0a93bb85a3dfdab7; Tue, 14 Jan 2020 23:36:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alexander Potapenko <glider@google.com>
Cc:     Johannes Stezenbach <js@sig21.net>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>, linux-pm@vger.kernel.org
Subject: Re: init_on_free breaks hibernate
Date:   Tue, 14 Jan 2020 23:36:01 +0100
Message-ID: <38519837.OfHf9z5LDp@kreacher>
In-Reply-To: <CAG_fn=VjzJSguf4ZB2x8Xn=U9MCHyfyqd2DVwPPC36t5+S+VsQ@mail.gmail.com>
References: <20191223211309.GA4609@sig21.net> <CAG_fn=UgU3vibsaug6p35Xs1dzLgBecA48t-PqS9OtRTHNu54g@mail.gmail.com> <CAG_fn=VjzJSguf4ZB2x8Xn=U9MCHyfyqd2DVwPPC36t5+S+VsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, January 14, 2020 12:38:53 PM CET Alexander Potapenko wrote:
> > > Strange about the resume=/dev/vda, it worked for me the way I described it.
> > > Maybe device numbers are dynamic, 254:0 is what I got from ls -l /dev/vda.
> > Indeed, for me it's 253:0, and resuming from console works with that number.
> >
> > > > The memory corruption is also reproducible for me, taking a look.
> > >
> 
> I think I know what is causing the problem.
> Upon resume the free pages may contain stale information from the
> kernel that initiated the resume.
> There's clear_free_pages()
> (https://elixir.bootlin.com/linux/latest/source/kernel/power/snapshot.c#L1148)
> that clears the pages in the case CONFIG_PAGE_POISONING_ZERO is
> enabled, we just need to reuse it for init_on_free.
> See the potential fix below.
> 
> Rafael, Pavel, I've noticed that in the setup suggested by Johannes
> even the defconfig kernel with heap initialization cannot hibernate
> more than twice, the third hibernate hangs.
> Is that a known problem?

No, it is not.



