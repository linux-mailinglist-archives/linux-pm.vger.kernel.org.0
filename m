Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2488AC7F2
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436551AbfIGRJR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 13:09:17 -0400
Received: from muru.com ([72.249.23.125]:60226 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbfIGRJQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Sep 2019 13:09:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6BF00805C;
        Sat,  7 Sep 2019 17:09:44 +0000 (UTC)
Date:   Sat, 7 Sep 2019 10:09:11 -0700
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
        Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pyra-handheld.com,
        letux-kernel@openphoenux.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] DTS: bindings: omap: update bindings documentation
Message-ID: <20190907170911.GK52127@atomide.com>
References: <cover.1567839375.git.hns@goldelico.com>
 <3063019699f21e161221897e14c124a4e5366fa0.1567839375.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3063019699f21e161221897e14c124a4e5366fa0.1567839375.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190907 06:57]:
> * clarify that we now need either "ti,omap3430" or "ti,omap3630" or "ti,am3517" for omap3 chips
> * clarify that "ti,omap3" has no default
> * clarify that AM33x is not an "ti,omap3"
> * clarify that the list of boards is incomplete
> * remove some "ti,am33xx", "ti,omap3"
> * add some missing "ti,omap4"

Acked-by: Tony Lindgren <tony@atomide.com>
