Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5041349EB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAHR6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 12:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgAHR6h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jan 2020 12:58:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 797722067D;
        Wed,  8 Jan 2020 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578506316;
        bh=SdtmN8vMPYr6lvvcJ19d5FHoncte7Ipmo58T/30pIBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KahEnhp61ZYr9Kt8C5+kMPQ74X4OJW/0iqGXeJ3xTIyK7mqeMOzuAb/MC4MxIS22E
         HPP86YtIG54fmcXdabmpLcq7fn/79xIv0ZuyMCtQKTAInevdfFigJ4Y42NSSqa19DJ
         f/N51BQoshrnlRUZrqr78i/GNE+V7jIt/AtumAb8=
Date:   Wed, 8 Jan 2020 18:58:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register charger
Message-ID: <20200108175834.GC2546185@kroah.com>
References: <20200107002901.940297-1-paul@crapouillou.net>
 <20200108165323.GA2506374@kroah.com>
 <1578504370.3.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578504370.3.1@crapouillou.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 08, 2020 at 02:26:10PM -0300, Paul Cercueil wrote:
> Hi Greg,
> 
> 
> Le mer., janv. 8, 2020 at 17:53, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> a écrit :
> > On Tue, Jan 07, 2020 at 01:29:01AM +0100, Paul Cercueil wrote:
> > >  Register a power supply charger, whose online state depends on
> > > whether
> > >  the USB role is set to device or not.
> > 
> > That says _what_ you are doing, but I have no idea _why_ you want to do
> > this.
> > 
> > What is this going to cause to have happen?  What new userspace api is
> > going to result?  What will a user do with this?
> 
> This is useful when the USB role is the only way to know if the device is
> charging from USB.
> 
> The API is the standard power supply charger API, you get a
> /sys/class/power_supply/xxx/online node which tells you the state of the
> charger.
> 
> The sole purpose of this is to give userspace applications a way to know
> whether or not the charger is plugged.

Ok, this is all good info that should go into the changelog text for
when you resend this.

> > Is this going to always show up, no matter if the role is not even
> > relevant for a power supply?
> 
> I guess it'd always show up, yes. In which case would the role not be
> relevant for a power supply? Is gpio-b-connector not always used for OTG
> connectors?

I do not know, I thought OTG was dead :)

thanks,

greg k-h
