Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242B7FAF32
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKMLAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 06:00:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44265 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMLAl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 06:00:41 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 38730b92ce82b988; Wed, 13 Nov 2019 12:00:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] cpufreq/arm changes for 5.5
Date:   Wed, 13 Nov 2019 12:00:38 +0100
Message-ID: <5450817.5uEZGhPr0H@kreacher>
In-Reply-To: <20191111065213.zorc3mk6pz73xfl2@vireshk-i7>
References: <20191111065213.zorc3mk6pz73xfl2@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, November 11, 2019 7:52:13 AM CET Viresh Kumar wrote:
> Hi Rafael,
> 
> This pull request contains:
> 
> - Updates to ti-cpufreq driver and DT files to support new platforms
>   and migrate from opp-v1 bindings to opp-v2 bindings (H. Nikolaus
>   Schaller and Adam Ford).
> 
> - Merging of arm_big_little and vexpress-spc drivers and related
>   cleanup (Sudeep Holla).
> 
> - Fix for imx's default speed grade value (Anson Huang).
> 
> - Minor cleanup patch for s3c64xx (Nathan Chancellor).
> 
> - Fix CPU speed bin detection for sun50i (Ondrej Jirman).
> 
> --
> viresh
> 
> -------------------------8<-------------------------
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> 
> for you to fetch changes up to c23734487fb44ee16c1b007ba72d793c085e4ec4:
> 
>   cpufreq: sun50i: Fix CPU speed bin detection (2019-11-05 15:06:49 +0530)
> 
> ----------------------------------------------------------------
> Adam Ford (2):
>       cpufreq: ti-cpufreq: Add support for AM3517
>       ARM: dts: Add OPP-V2 table for AM3517
> 
> Anson Huang (1):
>       cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default speed grade value
> 
> H. Nikolaus Schaller (6):
>       cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
>       ARM: dts: omap34xx & omap36xx: replace opp-v1 tables by opp-v2 for
>       DTS: bindings: omap: update bindings documentation
>       ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap3630 or ti,am3517
>       cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if run in multi_regulator mode
>       ARM: dts: omap36xx: using OPP1G needs to control the abb_ldo
> 
> Nathan Chancellor (1):
>       cpufreq: s3c64xx: Remove pointless NULL check in s3c64xx_cpufreq_driver_init
> 
> Ondrej Jirman (1):
>       cpufreq: sun50i: Fix CPU speed bin detection
> 
> Sudeep Holla (7):
>       cpufreq: scpi: remove stale/outdated comment about the driver
>       cpufreq: merge arm_big_little and vexpress-spc
>       cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
>       cpufreq: vexpress-spc: remove lots of debug messages
>       cpufreq: vexpress-spc: fix some coding style issues
>       cpufreq: vexpress-spc: use macros instead of hardcoded values for cluster ids
>       cpufreq: vexpress-spc: find and skip duplicates when merging frequencies

Pulled, thanks!



