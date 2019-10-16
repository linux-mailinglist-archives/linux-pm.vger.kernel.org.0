Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF452DA19D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391871AbfJPWiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:38:51 -0400
Received: from muru.com ([72.249.23.125]:37676 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfJPWiv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:38:51 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 155418107;
        Wed, 16 Oct 2019 22:39:24 +0000 (UTC)
Date:   Wed, 16 Oct 2019 15:38:47 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 2/2] power: supply: cpcap-charger: Allow changing
 constant charge voltage
Message-ID: <20191016223847.GI5610@atomide.com>
References: <20191009210141.10037-1-tony@atomide.com>
 <20191009210141.10037-3-tony@atomide.com>
 <20191013113111.GD5653@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013113111.GD5653@amd>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [191013 11:31]:
> Would it be better to return 0 for < 3.8V values?

No, it's setting the charge current to zero that
controls the charger.

> > +	case 4100000 ... 4120000 - 1: return 4120000;
> 
> I believe this should be 4100000.

Thanks for spotting that one.

Regards,

Tony
