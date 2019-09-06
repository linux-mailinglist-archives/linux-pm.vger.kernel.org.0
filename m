Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8EABCEF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfIFPtG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 11:49:06 -0400
Received: from muru.com ([72.249.23.125]:59988 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfIFPtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 11:49:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 42C2180CC;
        Fri,  6 Sep 2019 15:49:35 +0000 (UTC)
Date:   Fri, 6 Sep 2019 08:49:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Message-ID: <20190906154901.GD52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
 <20190905143226.GW52127@atomide.com>
 <20190906030444.lklvvpbdqesatohb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906030444.lklvvpbdqesatohb@vireshk-i7>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [190906 03:05]:
> On 05-09-19, 07:32, Tony Lindgren wrote:
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Do you want to pick the series instead as this has lots of DT changes
> ?

It unlikely these dts changes will conflict with anything so I
have no problem acking them for you for the next set of patches.

Regards,

Tony
