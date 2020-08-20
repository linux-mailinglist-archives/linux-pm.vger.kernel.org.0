Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4BE24AD9C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 06:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgHTEOr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 00:14:47 -0400
Received: from muru.com ([72.249.23.125]:41188 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHTEOr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 00:14:47 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 99986807A;
        Thu, 20 Aug 2020 04:14:44 +0000 (UTC)
Date:   Thu, 20 Aug 2020 07:15:12 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        linux-pm@vger.kernel.org, "Arthur D." <spinal.by@gmail.com>
Subject: Re: [RFC] Limiting charge current on Droid 4 (and N900)
Message-ID: <20200820041512.GH2994@atomide.com>
References: <20200615140557.GA22781@duo.ucw.cz>
 <20200629155515.GR37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629155515.GR37466@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200629 18:46]:
> * Pavel Machek <pavel@ucw.cz> [200615 07:06]:
> > Hi!
> > 
> > Droid 4 has same problem as N900: it is often neccessary to manually
> > tweak current draw from USB, for example when using thin charging cable.
> > 
> > N900 creates unique attribute by hand, but I believe
> > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
> > converted?)
> > 
> > Comments? Would the patch be acceptable after fixing whitespace?
> 
> Looks OK to me. Until we have better charger vs host vs usb3 charging hub
> detection in place this seems like a good thing to do.

FYI, I'm cleaning up the pending charger and battery patches to send out
for review. So that includes my earlier RFC battery status patches, and
Spinal's additions, and this patch. It will likely be several days before
I have the series ready for posting though.

Regards,

Tony
