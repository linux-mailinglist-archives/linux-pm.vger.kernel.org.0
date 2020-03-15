Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3C185E8D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 17:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgCOQq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 12:46:27 -0400
Received: from muru.com ([72.249.23.125]:60506 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgCOQq1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 12:46:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4893F81D5;
        Sun, 15 Mar 2020 16:47:13 +0000 (UTC)
Date:   Sun, 15 Mar 2020 09:46:24 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Arthur Demchenkov <spinal.by@gmail.com>
Cc:     Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>,
        sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 02/15] power: supply: cpcap-battery: Improve battery full
 status detection
Message-ID: <20200315164624.GI37466@atomide.com>
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-2-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315151206.30909-2-spinal.by@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Arthur Demchenkov <spinal.by@gmail.com> [200315 15:15]:
> If the battery status is detected as full for the charging current that
> doesn't exceed 100 mA, it will then be reported as full for charging
> currents in the range of 100-150 mA. This is needed because
> charge_current value has a spread.
> 
> We don't use avg_current here because it can trigger wrong battery full
> status on charger connected event.

Hmm oh so this is against my earlier RFC patches. Care to respin
the series against v5.6-rc?

Feel free tweak my patches to leave out the unnecessary stuff as we
decided to do things in a better way :) Just add a note like:

[spinal: dropped out unusable foo and bar]

So we know what got changed compared to the RFC patches.

And then we might have a nice working set for merging in subject
to others approving this approach of course :)

Regards,

Tony
