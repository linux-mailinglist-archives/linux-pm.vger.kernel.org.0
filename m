Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF947251EF4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYST7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 14:19:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38626 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYST5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 14:19:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A673A1C0BB9; Tue, 25 Aug 2020 20:19:55 +0200 (CEST)
Date:   Tue, 25 Aug 2020 20:19:54 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Qiwu Huang <yanziily@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200825181954.GB989@bug>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
 <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com>
 <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
 <20200818060707.GB1742213@kroah.com>
 <CAPtXDt26DdOi6JG7x3mTrR5YwArjkAeXY2TogRnK_xkSabhL2g@mail.gmail.com>
 <20200824074357.GB4133866@kroah.com>
 <CAPtXDt0yW7Kh6a9JGfXaha_wKVjae7U74m6K=631Ofh8_m4uvg@mail.gmail.com>
 <20200824085715.GB402243@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824085715.GB402243@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> > > > If we ported the full driver, we would break the existing driver
> > > > structure because we would introduce more Qualcomm code. I think
> > > > that's an unreasonable change.
> > >
> > > That doesn't make much sense.  You have a working driver for these apis,
> > > just submit it for inclusion, it should never break any existing
> > > drivers, otherwise your code wouldn't work either.
> > 
> > We're an Android device, we're working on a Qualcomm based code, and
> > from the current code tree, the current code tree is missing the QTI
> > Charger code
> 
> I don't know what that means, sorry.  Just submit your driver, and any
> needed dependencies as well.  There's no other way to evaluate this api
> addition without that, right?

Actually, there's a way to evaluate the API without the driver... if the API
is pretty obviously unacceptable.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
