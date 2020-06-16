Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882731FAEA2
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgFPKwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 06:52:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53586 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgFPKwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 06:52:35 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7B9DD1C0BD2; Tue, 16 Jun 2020 12:52:33 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:52:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Pali Roh??r <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: bq27xxx_battery: Notify about all
 battery changes
Message-ID: <20200616105224.GF1718@bug>
References: <20200525141200.17199-1-krzk@kernel.org>
 <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc59bcd5-1868-8c7a-9fc9-67ad70b477f4@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 2020-05-26 21:24:39, Andrew F. Davis wrote:
> On 5/25/20 10:11 AM, Krzysztof Kozlowski wrote:
> > All battery related data could be important for user-space.  For example
> > time-to-full could be shown to user on the screen or health could be
> > monitored for any issues.  Instead of comparing few selected old/new
> > values, just check if anything changed in the cache.
> > 
> 
> 
> At least some value will change every time we poll the battery, are we
> okay with having power_supply_changed() called every time?

I believe that's very bad idea. AFAICT that would wake up userspace every
5 seconds, eating power in unexpected way, and without easy ability of opting
out. IOW a regression.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
