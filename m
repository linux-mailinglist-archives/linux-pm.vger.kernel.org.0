Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA697F53A
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfHBKjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 06:39:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:47610 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfHBKjp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Aug 2019 06:39:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 976D980536;
        Fri,  2 Aug 2019 12:39:41 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l3f8uPEHJigc; Fri,  2 Aug 2019 12:39:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2EBF88053A;
        Fri,  2 Aug 2019 12:39:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qTxvkqCPAoyF; Fri,  2 Aug 2019 12:39:36 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BB54380536;
        Fri,  2 Aug 2019 12:39:35 +0200 (CEST)
Message-ID: <390f31d2f85e8075d9b1e250a2ec093ac8769703.camel@v3.sk>
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
Date:   Fri, 02 Aug 2019 12:39:34 +0200
In-Reply-To: <20190801192713.GA22373@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
         <20190513075641.1277716-2-lkundrak@v3.sk> <20190513090743.GA19319@amd>
         <20190801192713.GA22373@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Pavel,

On Thu, 2019-08-01 at 21:27 +0200, Pavel Machek wrote:
> Hi!
> 
> What is status of OLPC-1.75 in v5.3? IIRC most of the patches went in,
> but I don't see suitable dts file in the tree. I tried porting one
> from working (4.19 or so) kernel, but it was not quite trivial.
> 
> Is there time for dts to be merged?

Short answer is that it's not absolutely necessary. With a new enough
OpenFirmware, the firmware will just construct a correct FDT.

To upgrade your machine to the new firmware, just copy 
http://dev.laptop.org/~quozl/q4e00ja.rom to a FAT partition on a USB
flash stick and run "flash u:\q4e00ja.rom" from the "ok" prompt.
Then you'll be able to run stock mainline kernels happily.

That said, it might still be useful to have a DTS file in tree (for
reference, testing, machines with older firmware, etc.). I've now re-
sent the MMP2 devicetree update patch set with the DTS file included
and copied you on that one.

As usual, I'm thankful for testing, reviews and acks.

Take care!

Lubo

