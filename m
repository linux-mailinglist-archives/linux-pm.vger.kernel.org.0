Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063F8259D5B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgIARkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 13:40:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59394 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgIARj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:39:57 -0400
Received: from 89-64-88-247.dynamic.chello.pl (89.64.88.247) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id 17a99e8a40e6e1df; Tue, 1 Sep 2020 19:39:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v4 0/5] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Tue, 01 Sep 2020 19:23:06 +0200
Message-ID: <3748218.V0HrpZKF9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

The last two patches in the v3 needed to be updated to take re-enabling of HWP
after an ACPI S3 suspend/resume cycle into account appropriately.  The first
three patches are the same as before.

The purpose of this series is to address some peculiarities related to
taking CPUs offline/online and switching between different operation
modes with HWP enabled that have become visible after allowing the
driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
one that was there earlier, but can be addressed easily after the
changes made in 5.9-rc1).

Please refer to the patch changelogs for details.

For easier testing/review, the series is available from the git branch at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 intel_pstate-testing

I've done my best to address all of the possible corner cases, but the test
matrix is quite extensive and I may have missed something, so go ahead
and test.

Thanks,
Rafael



