Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD984721F8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbfGWWGf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 18:06:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60540 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389193AbfGWWGf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 18:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E/LUBzLCJzpcb95mBekwKy8gZoYu7sAEuAiBQdoSSiA=; b=UDfC2FY/7QnEVtXmemf42irTpU
        wU+REj/7meBbBTKOigPdM0rK6mIj3oswO4Bdc7VYYvfx5qdrK5OpFJyfuxReqODGFI0trlm5EdvGr
        m42/sfxUKYVUo1HAOnCi5EjUPA9+2Ww25yW4X+SG4wGN1XWbm/QhPu4BR/KHE+CwXnPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hq2vU-0003aB-QJ; Wed, 24 Jul 2019 00:06:28 +0200
Date:   Wed, 24 Jul 2019 00:06:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile
 UART-based restart/poweroff drivers)
Message-ID: <20190723220628.GA13517@lunn.ch>
References: <cover.1563822216.git.evgenyz@gmail.com>
 <20190723015631.GI8972@lunn.ch>
 <c2ffe662-6975-351b-87b8-af760984ef4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ffe662-6975-351b-87b8-af760984ef4d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 07:48:49PM +0200, Evgeny Kolesnikov wrote:
> On 23/07/2019 03:56, Andrew Lunn wrote:
> >On Mon, Jul 22, 2019 at 09:53:00PM +0200, Evgeny Kolesnikov wrote:
> >>
> >>The difference between uart-poweroff and qnap-poweroff is small, but important:
> >>uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
> >>itself is defined in a DTS file for a specific device/board, thus making this driver
> >>applicable to wider range of devices.
> >
> >There is a lot of replicated code here, and in the original
> >qnap-poweroff.c driver. Please consolidate it by extending the current
> >driver. It should be easy to add a new compatible string, and turn
> >power_off_cfg.cmd into an array.
> 
> Hi, Andrew.
> 
> I've considered extending qnap driver, but I have some doubts about this
> approach.
> 
> First of all there is only a poweroff counterpart. As there is no
> qnap-restart driver, what should I do with uart-restart? Is it OK to have
> xxx-restart-poweroff driver (never saw anything like that)?

Hi Evgeny

There are a few options. You can refactor all the code into a library
and small drivers which wrap around the library. Or you can make the
driver handle both, using the compatible string to determine which it
should do.
 
> While I can add cmd as a parameter to qnap driver (having it converted
> into an array) it should be optional as original qnap relies on two
> hardcoded values for its devices.

That is not what i meant. You can make the current code more generic
by changing the single byte in power_off_cfg to an array. DT should
describe the hardware, not bytes you poke into registers. So it is
perfectly valid to have the bytes hard coded in the driver.

	  Andrew
