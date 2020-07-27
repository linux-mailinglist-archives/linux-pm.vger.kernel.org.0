Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6432822F3A3
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgG0PRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 11:17:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65052 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgG0PRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 11:17:45 -0400
Received: from 89-64-87-33.dynamic.chello.pl (89.64.87.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 4db2cf9f0cabc8c9; Mon, 27 Jul 2020 17:17:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [PATCH v3 0/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Mon, 27 Jul 2020 17:13:40 +0200
Message-ID: <1709487.Bxjb1zNRZM@kreacher>
In-Reply-To: <4981405.3kqTVLv5tO@kreacher>
References: <4981405.3kqTVLv5tO@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki wrote:
>
> This really is a v2 of this patch:
> 
> https://patchwork.kernel.org/patch/11663271/
> 
> with an extra preceding cleanup patch to avoid making unrelated changes in the
> [2/2].

Almost the same as before, but the first patch has been reworked to handle
errors in store_energy_performance_preference() correctly and rebased on top
of the current linux-pm.git branch.

No functional changes otherwise.

Thanks!



