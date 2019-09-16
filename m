Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42162B3EEC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfIPQ0b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 12:26:31 -0400
Received: from muru.com ([72.249.23.125]:33340 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfIPQ0b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Sep 2019 12:26:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8365980EA;
        Mon, 16 Sep 2019 16:27:00 +0000 (UTC)
Date:   Mon, 16 Sep 2019 09:26:26 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/8] cpufreq: ti-cpufreq: Add support for AM3517
Message-ID: <20190916162626.GD52127@atomide.com>
References: <cover.1568224032.git.hns@goldelico.com>
 <beda9274922c0fdc293a974a707426fac7c77921.1568224033.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beda9274922c0fdc293a974a707426fac7c77921.1568224033.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
> From: Adam Ford <aford173@gmail.com>
> 
> The AM3517 only lists 600MHz @ 1.2V, but the register values for
> 0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
> of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
> (600 MHz).
> 
> This patch simply adds the am3517 to the compatible table
> similar to a mix of the omap3430 and omap3430 structure.

Acked-by: Tony Lindgren <tony@atomide.com>
