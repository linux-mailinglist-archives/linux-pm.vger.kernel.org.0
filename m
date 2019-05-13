Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372791B6E9
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfEMNSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 09:18:37 -0400
Received: from shell.v3.sk ([90.176.6.54]:60017 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfEMNSg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 09:18:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D963F100BF4;
        Mon, 13 May 2019 15:18:32 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DH0RDO6CeMZS; Mon, 13 May 2019 15:18:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E29410420A;
        Mon, 13 May 2019 15:18:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uk-CuN7IHR_n; Mon, 13 May 2019 15:18:28 +0200 (CEST)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BC4CE100BF4;
        Mon, 13 May 2019 15:18:27 +0200 (CEST)
Message-ID: <5e814f2a3b1282da53d0f828dd9276ca91952f75.camel@v3.sk>
Subject: Re: [PATCH v7 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
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
Date:   Mon, 13 May 2019 15:18:26 +0200
In-Reply-To: <20190513090743.GA19319@amd>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
         <20190513075641.1277716-2-lkundrak@v3.sk> <20190513090743.GA19319@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-05-13 at 11:07 +0200, Pavel Machek wrote:
> On Mon 2019-05-13 09:56:32, Lubomir Rintel wrote:
> > The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> > signals for handshaking. It needs to know when is the slave (Linux)
> > side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> > controller node) and when does it wish to respond with a command (the
> > cmd-gpio property).
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Who is expected to apply this? I don't think more iterations will make
> it better... it seems pretty good already :-).

The whole set is meant to go in through platform/x86; it just missed
5.2 due to some issues discovered by the kbuild bot when it entered
Andy's review queue.

> 
> 								Pavel
> 								

