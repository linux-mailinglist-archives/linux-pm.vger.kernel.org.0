Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF8AA5F3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfIEOdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 10:33:53 -0400
Received: from muru.com ([72.249.23.125]:59814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfIEOdw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Sep 2019 10:33:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 20DD5810D;
        Thu,  5 Sep 2019 14:34:21 +0000 (UTC)
Date:   Thu, 5 Sep 2019 07:33:47 -0700
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
Subject: Re: [RFC v2 0/3] OMAP3: convert opp-v1 to opp-v2 and read speed
 binned / 720MHz grade bits
Message-ID: <20190905143347.GX52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <20190905050302.t7dsmyl7xa25umjg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905050302.t7dsmyl7xa25umjg@vireshk-i7>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [190905 05:03]:
> Most of the stuff looks fine to me here. I will pick the patches when
> the SoC maintainers provide an Ack.

I noticed few issues with the dts changes but other than that
looks good to me.

Regards,

Tony
