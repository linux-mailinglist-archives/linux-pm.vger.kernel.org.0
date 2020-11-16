Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D012B3F3F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 09:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKPI5W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 03:57:22 -0500
Received: from muru.com ([72.249.23.125]:48348 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKPI5W (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Nov 2020 03:57:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2675480C8;
        Mon, 16 Nov 2020 08:57:25 +0000 (UTC)
Date:   Mon, 16 Nov 2020 10:57:16 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: omap2plus_defconfig: Enable OMAP3_THERMAL
Message-ID: <20201116085716.GZ26857@atomide.com>
References: <20200911123157.759379-1-aford173@gmail.com>
 <20200911123157.759379-2-aford173@gmail.com>
 <CAHCN7x+NxWbpaZ7j3=CTeVcvtLm5iMVymgTV=LWokZAx=wJA1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+NxWbpaZ7j3=CTeVcvtLm5iMVymgTV=LWokZAx=wJA1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Adam Ford <aford173@gmail.com> [201016 15:19]:
> On Fri, Sep 11, 2020 at 7:32 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > With the additional power management options enabled,
> > this patch enables OMAP3_THERMAL by default.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  No change
> > V2:  No change
> 
> Tony,
> 
> Can you apply [2/2] to the OMAP branch?

Sorry for the delay, applying into omap-for-v5.11/defconfig thanks.

Regards,

Tony
