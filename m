Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B11230D74
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 17:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgG1POi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jul 2020 11:14:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53496 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgG1POb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 11:14:31 -0400
Received: from 89-64-88-69.dynamic.chello.pl (89.64.88.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 680a78bb8b8347f8; Tue, 28 Jul 2020 17:14:29 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Francisco Jerez <francisco.jerez.plata@intel.com>
Subject: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Tue, 28 Jul 2020 17:09:35 +0200
Message-ID: <13207937.r2GEYrEf4f@kreacher>
In-Reply-To: <1709487.Bxjb1zNRZM@kreacher>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki wrote:
> 
> On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki wrote:
> >
> > This really is a v2 of this patch:
> > 
> > https://patchwork.kernel.org/patch/11663271/
> > 
> > with an extra preceding cleanup patch to avoid making unrelated changes in the
> > [2/2].
> 
> Almost the same as before, but the first patch has been reworked to handle
> errors in store_energy_performance_preference() correctly and rebased on top
> of the current linux-pm.git branch.
> 
> No functional changes otherwise.

One more update of the second patch.

Namely, I realized that the hwp_dynamic_boost sysfs switch was present in the
passive mode after the v3 (and the previous versions) of that patch which isn't
correct, so this modifies it to avoid exposing hwp_dynamic_boost in the passive
mode.

The first patch is the same as in the v2.

Thanks!



