Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03CAA5E4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfIEOcb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 10:32:31 -0400
Received: from muru.com ([72.249.23.125]:59790 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIEOcb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Sep 2019 10:32:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 14301810D;
        Thu,  5 Sep 2019 14:32:59 +0000 (UTC)
Date:   Thu, 5 Sep 2019 07:32:26 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and
 omap36xx
Message-ID: <20190905143226.GW52127@atomide.com>
References: <cover.1567587220.git.hns@goldelico.com>
 <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
> This adds code and tables to read the silicon revision and
> eFuse (speed binned / 720 MHz grade) bits for selecting
> opp-v2 table entries.
> 
> Since these bits are not always part of the syscon register
> range (like for am33xx, am43, dra7), we add code to directly
> read the register values using ioremap() if syscon access fails.

This is nice :) Seems to work for me based on a quick test
on at least omap36xx.

Looks like n900 produces the following though:

core: _opp_supported_by_regulators: OPP minuV: 1270000 maxuV: 1270000, not supported by regulator
cpu cpu0: _opp_add: OPP not supported by regulators (550000000)

But presumably that can be further patched. So for this
patch:

Acked-by: Tony Lindgren <tony@atomide.com>
