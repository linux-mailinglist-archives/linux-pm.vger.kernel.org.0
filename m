Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279C013B57D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 23:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgANWvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 17:51:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51809 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgANWvG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 17:51:06 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id c1cb78ac0f69600f; Tue, 14 Jan 2020 23:51:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] cpuidle: arm: Enable compile testing for some of drivers
Date:   Tue, 14 Jan 2020 23:51:03 +0100
Message-ID: <4692219.51FEeoGIeG@kreacher>
In-Reply-To: <92592736-fa55-8fe8-c893-e9e7129fe910@linaro.org>
References: <20191229180912.17100-1-krzk@kernel.org> <a4fa3f89-e792-aeee-b9ea-9af244ace04a@linaro.org> <92592736-fa55-8fe8-c893-e9e7129fe910@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, January 13, 2020 1:24:00 PM CET Daniel Lezcano wrote:
> On 13/01/2020 12:58, Daniel Lezcano wrote:
> > On 13/01/2020 12:51, Rafael J. Wysocki wrote:
> >> On Sunday, December 29, 2019 7:09:12 PM CET Krzysztof Kozlowski wrote:
> >>> Some of cpuidle drivers for ARMv7 can be compile tested on this
> >>> architecture because they do not depend on mach-specific bits.  Enable
> >>> compile testing for big.LITTLE, Kirkwood, Zynq, AT91, Exynos and mvebu
> >>> cpuidle drivers.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> ---
> 
> [ ... ]
> 
> >> Daniel, any concerns regarding this one?
> > 
> > Yes, I have a doubt about this patch. I'll double check before commenting.
> 
> Actually it is fine.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

OK, patch applied.

Thanks!



