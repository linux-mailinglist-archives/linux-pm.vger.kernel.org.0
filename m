Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD812ED6E9
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbhAGSpW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 13:45:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44726 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbhAGSpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 13:45:15 -0500
Received: from 89-64-81-64.dynamic.chello.pl (89.64.81.64) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 4b1f4f3bf6ea13e3; Thu, 7 Jan 2021 19:44:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v1 0/3] cpufreq: intel_pstate: Assorted cleanups
Date:   Thu, 07 Jan 2021 19:40:56 +0100
Message-ID: <5701645.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

These three patches clean up intel_pstate a bit:

[1/3] makes it always use READ_ONCE() for reading hwp_cap_cached
[2/3] changes the first argument of intel_pstate_get_hwp_max()
[3/3] renames to functions (to avoid possible confusion).

Please see patch changelogs for details.

Thanks!



