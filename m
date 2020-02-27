Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0685171288
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgB0I2x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 03:28:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:27621 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgB0I2w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 03:28:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 00:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="261376670"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 27 Feb 2020 00:28:47 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.148])
        by linux.intel.com (Postfix) with ESMTP id 4CCA6580107;
        Thu, 27 Feb 2020 00:28:45 -0800 (PST)
Message-ID: <b73cc46a633bac90b9538355b1befeb45814e84e.camel@gmail.com>
Subject: Re: [PATCH] cpufreq: Fix policy initialization for internal
 governor drivers
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Feb 2020 10:28:44 +0200
In-Reply-To: <3873122.F9s1CIEcb3@kreacher>
References: <3873122.F9s1CIEcb3@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-02-26 at 22:39 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Before commit 1e4f63aecb53 ("cpufreq: Avoid creating excessively
> large stack frames") the initial value of the policy field in struct
> cpufreq_policy set by the driver's ->init() callback was implicitly
> passed from cpufreq_init_policy() to cpufreq_set_policy() if the
> default governor was neither "performance" nor "powersave".  After
> that commit, however, cpufreq_init_policy() must take that case into
> consideration explicitly and handle it as appropriate, so make that
> happen.
> 
> Fixes: 1e4f63aecb53 ("cpufreq: Avoid creating excessively large stack frames")
> Link: https://lore.kernel.org/linux-pm/39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com/
> Reported-by: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Many thanks, fixes the issue.

Artem.

