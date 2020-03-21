Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5018E233
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCUOyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 10:54:09 -0400
Received: from muru.com ([72.249.23.125]:32892 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUOyJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 10:54:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 936DB810E;
        Sat, 21 Mar 2020 14:54:55 +0000 (UTC)
Date:   Sat, 21 Mar 2020 07:54:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arthur Demchenkov <spinal.by@gmail.com>
Cc:     Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/15] power: supply: cpcap-battery: Initialize with user
 provided data
Message-ID: <20200321145405.GW37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-6-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315151206.30909-6-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur Demchenkov <spinal.by@gmail.com> [200315 15:15]:
> If the user provides us with charge_full value (which it could save in a
> permanent storage between reboots), initialize low and high counter_uah
> with calculated values.

Hmm I'm getting -EINVAL when I do echo 1600000 > charge_now but yet the
value does get updated?

And I'm still not seeing capacity show up after that though even with full
battery.. I think we should be able to calculate it if either a high or
low value has been seen?

Also, we should have the driver default to using the charge_full_design
value if nothing is written from userspace and we see a high or low value.

Maybe some pessimistic estimate could be used instead of just using
charge_full_design if no value is initialized from the userspace?
Something like (charge_full_design / 4) * 3 maybe?

Yes it will be off, but the driver should work also without user
interaction :)

Regards,

Tony
