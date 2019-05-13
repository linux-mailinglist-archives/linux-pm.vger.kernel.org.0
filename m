Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6601B152
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEMHmJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 03:42:09 -0400
Received: from shell.v3.sk ([90.176.6.54]:58858 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfEMHmI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:42:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3AD5D104180;
        Mon, 13 May 2019 09:42:04 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0_8myHyVqd1z; Mon, 13 May 2019 09:41:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 46A9810415F;
        Mon, 13 May 2019 09:41:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qhsOcRBxAV4C; Mon, 13 May 2019 09:41:56 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3F35F103F43;
        Mon, 13 May 2019 09:41:56 +0200 (CEST)
Message-ID: <32ffdab7543f39dec48d2dafdb1c7a05624f633e.camel@v3.sk>
Subject: Re: [PATCH v6 0/10] Add support for OLPC XO 1.75 Embedded Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Mon, 13 May 2019 09:41:54 +0200
In-Reply-To: <CAHp75VezL3EainU04E7t=Qo+_mUCNJ2yc=HbEHY0vW-8eHpySA@mail.gmail.com>
References: <20190424074353.458446-1-lkundrak@v3.sk>
         <CAHp75VcXteqg200aB6w_6ngR7=cj3S7HQOELOTV4rYUmCe+dLw@mail.gmail.com>
         <267d992479dcdf8c0425407e131f112ece53f5c6.camel@v3.sk>
         <CAHp75VezL3EainU04E7t=Qo+_mUCNJ2yc=HbEHY0vW-8eHpySA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-05-10 at 17:28 +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 9:00 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > On Wed, 2019-05-08 at 18:07 +0300, Andy Shevchenko wrote:
> > > Pushed first 8 to my review and testing queue, thanks!
> > 
> > Thank you.
> > 
> > Looking at kbuild bot errors, it seems I managed to somehow mess up
> > again. It is not true that just the [08/10] patch relies on the
> > psy-olpc-1.75-battery-signed branch of power-supply tree (see above);
> > in fact [03/10] also does on x86.
> > 
> > Would it be possible to include that branch in your testing as well? It
> > is going to be included in the power-supply pull for 5.2.
> 
> Still some warnings.
> Unfortunately there is no time to push to this cycle and test, so,
> I'll withdraw them from my queue.
> 
> > Also, it seems patches [09/10] and [10/10] landed in your queue; they
> > are not ready.
> 
> I didn't pull them in the last attempt.

Thank you; even though this doesn't make 5.2 the tests that run against
your review branch were useful and uncovered bugs. Some are against the
olpc_battery branch -- I've sent the fix to power-supply maintainer and
pm-linux list already.

They're now being reported somewhat redundantly, please drop the
patches from your branch or replace it with ones I'll submit shortly.

> --
> With Best Regards,
> Andy Shevchenko

Thank you
Lubo

