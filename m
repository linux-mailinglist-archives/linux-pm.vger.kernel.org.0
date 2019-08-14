Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2668CEA0
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHNIkS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 04:40:18 -0400
Received: from muru.com ([72.249.23.125]:57480 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfHNIkS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 04:40:18 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9F1CE80C8;
        Wed, 14 Aug 2019 08:40:45 +0000 (UTC)
Date:   Wed, 14 Aug 2019 01:40:14 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot
 warnings
Message-ID: <20190814084014.GB52127@atomide.com>
References: <1565731976.8572.16.camel@lca.pw>
 <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> I also notice that device_set_wakeup_capable() has a check to see if the
> device is registered yet and it skips creating sysfs entries for the
> device if it isn't created in sysfs yet. Why? Just so it can be called
> before the device is created? I guess the same logic is handled by
> dpm_sysfs_add() if the device is registered after calling
> device_set_wakeup_*().

Hmm just guessing.. It's maybe because drivers can enable and disable
the wakeup capability at any point for example like driver/net drivers
do based on WOL etc?

> There's two approaches I see:
> 
> 	1) Do a similar check for device_set_wakeup_enable() and skip
> 	adding the wakeup class until dpm_sysfs_add().
> 
> 	2) Find each case where this happens and only call wakeup APIs
> 	on the device after the device is added.
> 
> I guess it's better to let devices have wakeup modified on them before
> they're registered with the device core?

I think we should at least initially handle case #1 above as multiple
places otherwise seem to break. Then maybe we could add a warning to
help fix all the #2 cases if needed?

Regards,

Tony
