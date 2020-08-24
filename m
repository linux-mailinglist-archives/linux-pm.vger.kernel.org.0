Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6931D2506D8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHXRsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 13:48:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63848 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgHXRsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 13:48:18 -0400
Received: from 89-64-88-199.dynamic.chello.pl (89.64.88.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id ad17e4b2a5b84ad0; Mon, 24 Aug 2020 19:48:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2 0/5] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Mon, 24 Aug 2020 19:39:51 +0200
Message-ID: <4169555.5IIHXK4Dsd@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

The v2 is here to address feedback from Doug and one issue found by me.

The purpose of this series is to address some peculiarities related to
taking CPUs offline/online and switching between different operation
modes with HWP enabled that have become visible after allowing the
driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
one that was there earlier, but can be addressed easily after the
changes madein 5.9-rc1).

Please refer to the patch changelogs for details.

For easier testing/review, the series is available from the git branch at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 intel_pstate-testing

Thanks,
Rafael



