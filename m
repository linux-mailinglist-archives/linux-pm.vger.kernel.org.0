Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC881700
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHEK0d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 06:26:33 -0400
Received: from shell.v3.sk ([90.176.6.54]:60458 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbfHEK0d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Aug 2019 06:26:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D61D8D5DEB;
        Mon,  5 Aug 2019 12:26:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2Zcvwn24q6Uv; Mon,  5 Aug 2019 12:26:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 171F9D5DE6;
        Mon,  5 Aug 2019 12:26:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HZkQZEnNuYu7; Mon,  5 Aug 2019 12:26:15 +0200 (CEST)
Received: from zimbra.v3.sk (zimbra.v3.sk [10.13.37.31])
        by zimbra.v3.sk (Postfix) with ESMTP id 99217D5DEB;
        Mon,  5 Aug 2019 12:26:14 +0200 (CEST)
Date:   Mon, 5 Aug 2019 12:26:12 +0200 (CEST)
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
Message-ID: <42288023.4384.1565000772220.JavaMail.zimbra@v3.sk>
In-Reply-To: <20190803084755.GA8224@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk> <20190513075641.1277716-2-lkundrak@v3.sk> <20190513090743.GA19319@amd> <20190801192713.GA22373@amd> <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk> <20190803084755.GA8224@amd>
Subject: Re: OLPC in 5.3? was Re: [PATCH v7 01/10] dt-bindings:
 olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.13.37.1]
X-Mailer: Zimbra 8.6.0_GA_1153 (ZimbraWebClient - FF68 (Linux)/8.6.0_GA_1153)
Thread-Topic: OLPC in 5.3? was Re: [PATCH v7 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
Thread-Index: dT6Cyk1a7TWDiehHLbTTn6BCstY0sg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

----- On Aug 3, 2019, at 10:47 AM, Pavel Machek pavel@ucw.cz wrote:

> Hi!
> 
>> > What is status of OLPC-1.75 in v5.3? IIRC most of the patches went in,
>> > but I don't see suitable dts file in the tree. I tried porting one
>> > from working (4.19 or so) kernel, but it was not quite trivial.
>> > 
>> > Is there time for dts to be merged?
>> 
>> Short answer is that it's not absolutely necessary. With a new enough
>> OpenFirmware, the firmware will just construct a correct FDT.
> 
>> To upgrade your machine to the new firmware, just copy
>> http://dev.laptop.org/~quozl/q4e00ja.rom to a FAT partition on a USB
>> flash stick and run "flash u:\q4e00ja.rom" from the "ok" prompt.
>> Then you'll be able to run stock mainline kernels happily.
> 
> Aha, good, thanks. That went smoothly.
> 
>> That said, it might still be useful to have a DTS file in tree (for
>> reference, testing, machines with older firmware, etc.). I've now re-
>> sent the MMP2 devicetree update patch set with the DTS file included
>> and copied you on that one.
> 
> Yes: sometimes it is neccessary to modify the dts. I was changing the
> kernel command line, for example.

Well, you can do that from OFW too. E.g.:

  " console=ttyS2,115200" to boot-file

>> As usual, I'm thankful for testing, reviews and acks.
> 
> I'll take a look. I tried 5.2 with defconfig from one of the branches
> (olpc_xo175_defconfig), and that does not boot.

I'm using [1].

[1] https://raw.githubusercontent.com/hackerspace/olpc-xo175-linux/lr/olpc-xo175/arch/arm/configs/olpc_xo175_defconfig

I'm wondering if it would make sense to include this upstream?
My guess was that nowadays multi_v7_defconfig that just works
on any DT-based platform is preferred to machine specific ones.

However, this one would enable OLPC-specific drivers the
multi_v7_defconfig defconfig wouldn't.

I've sent out an update to multi_v7_defconfig [2]. Once it is applied,
it should work on the XO-1.75 (without fancy things like camera or
power button).

[2] https://lore.kernel.org/lkml/20190620114816.1387881-1-lkundrak@v3.sk/

> What config should I use? Is it enough to produce zImage and put it on
> the flashdisk with olpc.fth file?

Yes. OFW loads olpc.fth from the first active FAT or ext3 partition on
SD card or a USB flash drive. If you put the zImage in the same place,
the following script would work:
  
  \ OLPC boot script

  " last:\zImage" to boot-device
  visible unfreeze
  boot

Note that it has to start with a backslash. The "visible" and "unfreeze"
words enable the DCON pass-through mode. You would see the XO logo
instead of the actual screen output without it.

> Is there some kind of documentation somewhere? :-).

This is always a tough question. Short answer would be no.

I'm happy to answer questions though, if the above wouldn't be
sufficient to make the thing boot for you.

I'd prefer if things just worked to documenting how to hack things
to make them work. If you got a Fedora machine, you can already
just pick a nightly [1] armhfp image and install it with
fedora-arm-installer the same way as any other ARM machine. I hope
to make Debian work too. An image that already boots would then
hopefully be a good start for whoever wishes to run their own kernels.
That's my excuse for not documenting things...

[1] https://www.happyassassin.net/nightlies.html

> Thanks and best regards,
> Pavel

Take care
Lubo

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
