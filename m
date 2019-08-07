Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B084BD2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfHGMlx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 08:41:53 -0400
Received: from shell.v3.sk ([90.176.6.54]:41999 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGMlx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 08:41:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3410FCE77B;
        Wed,  7 Aug 2019 14:41:50 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R6DgF8v1_cEG; Wed,  7 Aug 2019 14:41:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3F0CECE900;
        Wed,  7 Aug 2019 14:41:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QWJZWYzxkIfU; Wed,  7 Aug 2019 14:41:43 +0200 (CEST)
Received: from nedofet.local (ip-37-188-233-8.eurotel.cz [37.188.233.8])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 68BA7CE77B;
        Wed,  7 Aug 2019 14:41:42 +0200 (CEST)
Message-ID: <a4a169eaece9cfb4ea849bbac13d2224c0964ac9.camel@v3.sk>
Subject: Re: OLPC in 5.3? was Re: [PATCH v7 01/10] dt-bindings:
 olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Date:   Wed, 07 Aug 2019 14:41:40 +0200
In-Reply-To: <20190807123134.GA10407@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
         <20190513075641.1277716-2-lkundrak@v3.sk> <20190513090743.GA19319@amd>
         <20190801192713.GA22373@amd>
         <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk>
         <20190803084755.GA8224@amd>
         <42288023.4384.1565000772220.JavaMail.zimbra@v3.sk>
         <20190807123134.GA10407@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-08-07 at 14:31 +0200, Pavel Machek wrote:
> Hi!
> 
> > I'm using [1].
> > 
> > [1] https://raw.githubusercontent.com/hackerspace/olpc-xo175-linux/lr/olpc-xo175/arch/arm/configs/olpc_xo175_defconfig
> > 
> 
> Thanks a lot. I got it to work with 5.2 and 5.3-rc. One thing I
> noticed...
> 
> "reboot: Restarting system", "Reboot failed --- System halted".

Yes. Another unhappy Russel issue, if it's fair to put it that way. :)
Ideas appreciated.

https://lore.kernel.org/lkml/20190108233137.GW11171@n2100.armlinux.org.uk/

> 
> > I'm wondering if it would make sense to include this upstream?
> > My guess was that nowadays multi_v7_defconfig that just works
> > on any DT-based platform is preferred to machine specific ones.
> > 
> > However, this one would enable OLPC-specific drivers the
> > multi_v7_defconfig defconfig wouldn't.
> 
> Yes, I believe that would be useful. Getting all the extras without
> that would be quite tricky.

Okay, I'll take a mental note to send it out eventually.

> > > Is there some kind of documentation somewhere? :-).
> > 
> > This is always a tough question. Short answer would be no.
> > 
> > I'm happy to answer questions though, if the above wouldn't be
> > sufficient to make the thing boot for you.
> 
> Ok, it seems to work now ;-). I'll make some notes...

That's cool.

> 
> Best regards,
> 
> 									Pavel

Take care
Lubo

