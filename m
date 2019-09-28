Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF74C10FD
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2019 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfI1OAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Sep 2019 10:00:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:53799 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfI1OAC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 28 Sep 2019 10:00:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2019 07:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,559,1559545200"; 
   d="scan'208";a="391492522"
Received: from baoyuyan-mobl.ccr.corp.intel.com ([10.255.31.72])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2019 07:00:01 -0700
Message-ID: <64052a03bf5af899574ad81dff9203cfc307901c.camel@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Sat, 28 Sep 2019 22:00:00 +0800
In-Reply-To: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
         <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Linus,

I'm really sorry about this.

I thought no code change could be a reason that a rebase can be
accepted, but didn't realize this is exactly the case we should avoid
it. I wish I could read Documentation/maintainer/rebasing-and-
merging.rst earlier so that I didn't make this mistake.
Sorry to bring this trouble.

thanks,
rui

On Fri, 2019-09-27 at 11:34 -0700, Linus Torvalds wrote:
> On Fri, Sep 27, 2019 at 6:08 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > One thing to mention is that, all the patches have been tested in
> > linux-next for weeks, but there is a conflict detected, because
> > upstream has took commit eaf7b46083a7e34 ("docs: thermal: add it to
> > the
> > driver API") from jc-docs tree while I'm keeping a wrong version of
> > the
> > patch, so I just rebased my tree to fix this.
> 
> Why do I have to say this EVERY single release?
> 
> A conflict is not a reason to rebase. Conflicts happen. They happen a
> lot. I deal with them, and it's usually trivial.
> 
> If you feel it's not trivial, just describe what the resolution is,
> rather than rebasing. Really.
> 
> Rebasing for a random conflict (particularly in documentation, for
> chrissake!) is like using an atomic bomb to swat a fly.  You have all
> those downsides, and there are basically _no_ upsides. It only makes
> for more work for me because I have to re-write this email for the
> millionth time, and that takes longer and is more aggravating than
> the
> conflict would have taken to just sort out.
> 
>                    Linus

