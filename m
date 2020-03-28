Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69564196633
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 13:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgC1M61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 08:58:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43443 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgC1M61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2020 08:58:27 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 54b4ded94d5d9511; Sat, 28 Mar 2020 13:58:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Run in the passive mode by default on systems without HWP
Date:   Sat, 28 Mar 2020 13:54:35 +0100
Message-ID: <2016232.ihCVsphvri@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

These two patches modify the intel_pstate driver to run in the passive mode by
default on systems without HWP (refer to the changelog of patch [2/2] for the
motivation part).

Internal testing of the system performance in 5.6-rc indicates that the
difference between the active mode with the powersave scaling algorithm and the
passive mode with the schedutil governor should be negligible for the majority
of users, so it should be safe to change the default behavior of the driver as
per the above.

Patch [1/2] makes changes to select the schedutil governor and set it as the
default one when intel_pstate is selected in Kconfig.

Patch [2/2] changes intel_pstate to start in the passive by default if HWP is
not supported (or if it is disabled via the kernel command line).

Please refer to the patch changelogs for more information.

Thanks!



