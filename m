Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66EA36346E
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 11:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhDRJXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 05:23:06 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:34040 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229652AbhDRJXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Apr 2021 05:23:06 -0400
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B6506837F24A;
        Sun, 18 Apr 2021 09:22:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 7EF201E04D3;
        Sun, 18 Apr 2021 09:22:36 +0000 (UTC)
Message-ID: <3886b37dacd9fcf84d5211322807128e638a8222.camel@perches.com>
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
From:   Joe Perches <joe@perches.com>
To:     Sebastian Fricke <sebastian.fricke@posteo.net>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Date:   Sun, 18 Apr 2021 02:22:35 -0700
In-Reply-To: <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
         <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
         <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: jgsdes5bntddszuzbtw99cra7umjj1nx
X-Rspamd-Queue-Id: 7EF201E04D3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18SzM71Q7R3c8oA5j/PRmWppAoksvQ0KFY=
X-HE-Tag: 1618737756-628855
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2021-04-18 at 09:11 +0000, Sebastian Fricke wrote:
> Hey Joe,

Hi Sebastian.

> On 18.04.2021 00:09, Joe Perches wrote:
> > On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
> > > Remove a redundant space to improve the quality of the comment.
> > I think this patch is not useful.
> > It's not redundant.
> 
> Thank you, I actually found this pattern a few more times but I wanted
> to check first if this is a mistake or chosen consciously.
[]
> > For drivers/base/power/runtime.c, that 2 space after period style is used
> > dozens of times and changing a single instance of it isn't very useful.

Even in that single file it's not consistent.
It's something like 3:1 for 2 spaces over 1 space after period.

I believe it's done more by habit and author age than anything.
If you learned to type using a typewriter and not a keyboard, then
you likely still use 2 spaces after a period.

> True and if I understand you correctly you would rather keep it as is
> right?

Yes.  IMO: Whitespace in comments like this should not be changed
unless there's some other significant benefit like better alignment.

cheers, Joe

> > > ---
> > > Side-note:
> > > I found this while reading the code, I don't believe it is important but
> > > I thought it doesn't hurt to fix it.
[]
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
[]
> > > @@ -786,7 +786,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >  	}
> > > 
> > >  	/*
> > > -	 * See if we can skip waking up the parent.  This is safe only if
> > > +	 * See if we can skip waking up the parent. This is safe only if
> > >  	 * power.no_callbacks is set, because otherwise we don't know whether
> > >  	 * the resume will actually succeed.
> > >  	 */


