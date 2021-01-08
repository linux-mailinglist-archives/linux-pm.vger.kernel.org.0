Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB12EEDCF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 08:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAHHXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 02:23:21 -0500
Received: from muru.com ([72.249.23.125]:41184 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbhAHHXV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 02:23:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1DE0580B4;
        Fri,  8 Jan 2021 07:23:00 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:22:35 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Adam Ford <aford173@gmail.com>, Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Fix stuck sensor with
 continuous mode for 4430
Message-ID: <X/gIO9Ta3JPDaeV3@atomide.com>
References: <20201230084338.19410-1-tony@atomide.com>
 <CAHCN7xJmwcUOpoza-LNxTAbRNb9ToERnBNuKboP86DSBdtS61A@mail.gmail.com>
 <7C9106E0-FC75-4056-AD5F-16CCFA9C24E5@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7C9106E0-FC75-4056-AD5F-16CCFA9C24E5@goldelico.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [201230 13:29]:
> > Am 30.12.2020 um 13:55 schrieb Adam Ford <aford173@gmail.com>:
> > On Wed, Dec 30, 2020 at 2:43 AM Tony Lindgren <tony@atomide.com> wrote:
> >> 
> >> At least for 4430, trying to use the single conversion mode eventually
> >> hangs the thermal sensor. This can be quite easily seen with errors:
> >> 
> >> thermal thermal_zone0: failed to read out thermal zone (-5)
...

> > I don't have an OMAP4, but if you want, I can test a DM3730.
> 
> Indeed I remember a similar discussion from the DM3730 [1]. temp values were
> always those from the last measurement. E.g. the first one was done
> during (cold) boot and the first request after 10 minutes did show a
> quite cold system... The next one did show a hot system independent
> of what had been between (suspend or high activity).
> 
> It seems as if it was even reproducible with a very old kernel on a BeagleBoard.
> So it is quite fundamental.
> 
> We tried to fix it but did not come to a solution [2]. So we opened an issue
> in our tracker [3] and decided to stay with continuous conversion although this
> raises idle mode processor load.

Hmm so maybe eocz high always times out in single mode since it also
triggers at least on dra7?

Yes it would be great if you guys can the $subject patch a try at
least on your omap36xx and omap5 boards and see if you see eocz
time out warnings in dmesg.

Regards,

Tony
