Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093E8282715
	for <lists+linux-pm@lfdr.de>; Sun,  4 Oct 2020 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJCWPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 18:15:45 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:57676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgJCWPp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2020 18:15:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C13E718029120;
        Sat,  3 Oct 2020 22:15:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2689:2693:2828:3138:3139:3140:3141:3142:3352:3622:3870:3871:3872:3876:4321:5007:7576:7875:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13095:13255:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: land70_6101ae7271b0
X-Filterd-Recvd-Size: 1838
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Oct 2020 22:15:43 +0000 (UTC)
Message-ID: <ebafdf9c1647070c45124786e71a0112f86d10b8.camel@perches.com>
Subject: Re: [PATCH][next] power: supply: fix spelling mistake "unprecise"
 -> "imprecise"
From:   Joe Perches <joe@perches.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 03 Oct 2020 15:15:42 -0700
In-Reply-To: <20201003215102.5hl5lvidyki2xu7b@earth.universe>
References: <20200902101656.57676-1-colin.king@canonical.com>
         <20201003215102.5hl5lvidyki2xu7b@earth.universe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2020-10-03 at 23:51 +0200, Sebastian Reichel wrote:
> On Wed, Sep 02, 2020 at 11:16:56AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > There is a spelling mistake in a dev_info message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> 
> Thanks, queued.
[]
> > diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
[]
> > @@ -487,7 +487,7 @@ static int rn5t618_power_probe(struct platform_device *pdev)
> >  		 * gauge will get decalibrated.
> >  		 */
> >  		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now\n");
> > -		dev_info(&pdev->dev, "Expect unprecise results\n");
> > +		dev_info(&pdev->dev, "Expect imprecise results\n");

Might as well be a single line too

		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now - expect imprecise results\n");


