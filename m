Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217FF25B1D3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 18:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBQhe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 12:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBQhd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 12:37:33 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E87206E7;
        Wed,  2 Sep 2020 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599064652;
        bh=Wni3x+GYLltlmuMdPoBYORxVVeiXa3j+1KYJ4MzXN9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCqXUbtn8+j07T3SZla2H1AsOoHroyVvb//SzsI9m+cc21OlcAttpbm1t3jLtbgl8
         4YggRDJ6lvhZ4riGctIq6GUbyY3ncSoW3ny/T3BG7oRb0Wnfk1YlgkfsRefZ7xQ4ks
         ucrwKYsyDVqpArW9sIVvT8vj6aKq36VQqf8CdRlY=
Date:   Wed, 2 Sep 2020 11:43:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] power: supply: charger-manager: Fix info message in
 check_charging_duration()
Message-ID: <20200902164344.GC31464@embeddedor>
References: <20200902162315.GA11384@embeddedor>
 <f93c0fa0-51a1-291f-feda-fbd8d7397e88@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93c0fa0-51a1-291f-feda-fbd8d7397e88@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 02, 2020 at 09:29:31AM -0700, Randy Dunlap wrote:
> On 9/2/20 9:23 AM, Gustavo A. R. Silva wrote:
> > A few months ago, commit e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> > changed the expression in the if statement from "duration > desc->discharging_max_duration_ms"
> > to "duration > desc->charging_max_duration_ms", but the arguments for dev_info() were left unchanged.
> > Apparently, due to a copy-paste error.
> > 
> > Fix this by using the proper arguments for dev_info().
> > 
> > Also, while there, replace "exceed" with "exceeds", for both messages.
> > 
> > Addresses-Coverity-ID: 1496803 ("Copy-paste error")
> > Fixes: e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  -  Replace "exceed" with "exceeds"
> > 
> >  drivers/power/supply/charger-manager.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> > index 07992821e252..a6d5dbd55e37 100644
> > --- a/drivers/power/supply/charger-manager.c
> > +++ b/drivers/power/supply/charger-manager.c
> > @@ -464,7 +464,7 @@ static int check_charging_duration(struct charger_manager *cm)
> >  		duration = curr - cm->charging_start_time;
> >  
> >  		if (duration > desc->charging_max_duration_ms) {
> > -			dev_info(cm->dev, "Charging duration exceed %ums\n",
> > +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
> >  				 desc->charging_max_duration_ms);
> >  			ret = true;
> >  		}
> > @@ -472,8 +472,8 @@ static int check_charging_duration(struct charger_manager *cm)
> >  		duration = curr - cm->charging_end_time;
> >  
> >  		if (duration > desc->charging_max_duration_ms) {
> > -			dev_info(cm->dev, "Discharging duration exceed %ums\n",
> > -				 desc->discharging_max_duration_ms);
> > +			dev_info(cm->dev, "Charging duration exceeds %ums\n",
> > +				 desc->charging_max_duration_ms);
> >  			ret = true;
> >  		}
> >  	}
> > 
> 
> Hi,
> 
> It looks to me like the second block (else if) should be about discharging,
> not charging, more like Colin King's patch had it:
>

I had the same impression for a moment, but what makes me think this is
more about charging than discharging, is this line:

471         } else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {

which was introduced by the same commit:

e132fc6bb89b ("power: supply: charger-manager: Make decisions focussed on battery status")

let's find out... :)

Thanks
--
Gustavo
