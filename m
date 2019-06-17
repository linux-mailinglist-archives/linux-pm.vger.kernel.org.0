Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCE488FD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQQc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 12:32:29 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:58774 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFQQc3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jun 2019 12:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yXBewa4Yf6BB+kYm+6dRgzZs9LYrqO+9cPd26nhSsxE=; b=cDXfbdggRiOU2Z1QGSx2uu5bIn
        aLaQyuEySdO9mvVyJId2oitvc++wLD9ODS54s4ccsU/GAp+/+M920xE5fFspUavL6/jUt2jWITds1
        v/fNByl3s/p08p7hCdhX7u2VtOTf0krJJld+5+qWDwap2aGfQTuQb0npIokirGWU3Xh8=;
Received: from p5dcc3c96.dip0.t-ipconnect.de ([93.204.60.150] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hcuYU-0003fF-Q4; Mon, 17 Jun 2019 18:32:26 +0200
Date:   Mon, 17 Jun 2019 18:32:25 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617183225.1210c91c@aktux>
In-Reply-To: <20190617114048.GN5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
        <20190617130357.41204ff7@kemnade.info>
        <20190617114048.GN5316@sirena.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Jun 2019 12:40:48 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:  
> 
> > > Why is this a good fix and not defining the supported voltages?  These
> > > look like fairly standard linear range regulators.  
> 
> > I am fixing the definition of the two regulators in the patch.
> > I am defining them as continuous. 
> > Voltage ranges are defined in
> > arch/arm/boot/dts/twl4030.dtsi
> > Only the continuous flag is missing.  
> 
> > Is there anything else do you want to be defined?  
> 
> These regulators are not continuous regulators as far as I can see, they
> are normal linear range regulators and so should have their voltages
> enumerable like any other linear range regulator.

another thing which might be misleading: The patch belongs to the
section after
#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf)

that might be easily misread (because of too less context in the diff),
or if line numbers change.
It is *not* for
#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf)

Regards,
Andreas
