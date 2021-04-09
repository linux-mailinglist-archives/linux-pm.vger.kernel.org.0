Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D1359E15
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDIL6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 07:58:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:4320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233838AbhDIL6O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Apr 2021 07:58:14 -0400
IronPort-SDR: TZb+Kap/wx8uKo/oSuzcd6f/iOUDge2G6JCfLOovsGnfaioHTyg36q1b4QJikgfb7wgUAxfln7
 qHThbYdkxYXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190546815"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="190546815"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 04:58:01 -0700
IronPort-SDR: sExNdMNJgxTZOJB478Bjt/IzpOobnLLdAjfirJrL7gvmBwfQWc9rBSgrWDPGNM0aZfXT/A3tWh
 /OssJJVFcpRw==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="613694408"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 04:57:59 -0700
Date:   Fri, 9 Apr 2021 20:01:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Simplify
 intel_pstate_update_perf_limits()
Message-ID: <20210409120157.GA229488@chenyu-desktop>
References: <5450142.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5450142.DvuYhMxLoT@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 07, 2021 at 04:21:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because pstate.max_freq is always equal to the product of
> pstate.max_pstate and pstate.scaling and, analogously,
> pstate.turbo_freq is always equal to the product of
> pstate.turbo_pstate and pstate.scaling, the result of the
> max_policy_perf computation in intel_pstate_update_perf_limits() is
> always equal to the quotient of policy_max and pstate.scaling,
> regardless of whether or not turbo is disabled.  Analogously, the
> result of min_policy_perf in intel_pstate_update_perf_limits() is
> always equal to the quotient of policy_min and pstate.scaling.
> 
> Accordingly, intel_pstate_update_perf_limits() need not check
> whether or not turbo is enabled at all and in order to compute
> max_policy_perf and min_policy_perf it can always divide policy_max
> and policy_min, respectively, by pstate.scaling.  Make it do so.
> 
> While at it, move the definition and initialization of the
> turbo_max local variable to the code branch using it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Chen Yu <yu.c.chen@intel.com>
