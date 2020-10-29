Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2629E985
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 11:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgJ2Kva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 06:51:30 -0400
Received: from muru.com ([72.249.23.125]:47132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgJ2Kva (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:30 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2074C807E;
        Thu, 29 Oct 2020 10:51:33 +0000 (UTC)
Date:   Thu, 29 Oct 2020 12:51:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     edubezval@gmail.com, j-keerthy@ti.com, aford173@gmail.com,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, daniel.lezcano@linaro.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: Disable the CPU PM notifier for
 OMAP4430
Message-ID: <20201029105125.GJ5639@atomide.com>
References: <20201029100335.27665-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100335.27665-1-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [201029 10:03]:
> Disabling the notifier fixes the random shutdowns on OMAP4430 (ES2.0 and ES2.1)
> but it does not cause any issues on OMAP4460 (PandaES) or OMAP3630 (BeagleXM).
> Tony's duovero with OMAP4430 ES2.3 did not ninja-shutdown, but he also have
> constant and steady stream of:
> thermal thermal_zone0: failed to read out thermal zone (-5)

Works for me and I've verified duovero still keeps hitting core ret idle:

Tested-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
