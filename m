Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D122CED3E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 12:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLDLjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 06:39:25 -0500
Received: from foss.arm.com ([217.140.110.172]:60996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgLDLjZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Dec 2020 06:39:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 348691063;
        Fri,  4 Dec 2020 03:38:39 -0800 (PST)
Received: from bogus (unknown [10.57.33.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558F03F66B;
        Fri,  4 Dec 2020 03:38:37 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:38:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: add COMMON_CLK dependency
Message-ID: <20201204113830.emyebwzeoas6trwy@bogus>
References: <20201203231809.1484631-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203231809.1484631-1-arnd@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 04, 2020 at 12:17:46AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Wtihout CONFIG_COMMON_CLK, the scmi driver fails to link:
>
> arm-linux-gnueabi-ld: drivers/cpufreq/scmi-cpufreq.o: in function `scmi_cpufreq_probe':
> scmi-cpufreq.c:(.text+0x20c): undefined reference to `devm_of_clk_add_hw_provider'
> arm-linux-gnueabi-ld: scmi-cpufreq.c:(.text+0x22c): undefined reference to `of_clk_hw_simple_get'
>
> Add a Kconfig dependency for it.
>

There is a fix already upstream in later -rc(rc6 IIRC), I assume you are
seeing this prior to that.

Commit f943849f7206 ("cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK")

Since the only dependency on CONFIG_COMMON_CLK is to satisfy OPP adding
dummy clock provider, I avoided adding dependency on CLK for this driver
as this works fine for !CONFIG_COMMON_CLK.

--
Regards,
Sudeep

P.S: There are 2 copies of this patch, I chose to reply on this, other
one is @[1]

[1] https://lore.kernel.org/lkml/20201203225550.1478195-1-arnd@kernel.org
