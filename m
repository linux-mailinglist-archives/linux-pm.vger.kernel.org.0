Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13129345709
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 05:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWE5P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 00:57:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:10073 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCWE5N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 00:57:13 -0400
IronPort-SDR: nkRkMg+gLmf6a+LD5MkIpMROqYkBFxt5/KWb3IhU87CyaIZMx2KlUnuJ3kyCpDj+iGsBeg9l3h
 /RFDEVVOB0gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254403205"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="254403205"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 21:57:11 -0700
IronPort-SDR: 9Uwt+JkCd93DYgfZWklvfVxffhh4zhcKqWMeoDeLt6wtqj6+6nE0JfZ/Fsd1R40PkPQhdVoIY0
 y12zaBanY7mw==
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; 
   d="scan'208";a="607590636"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 21:57:10 -0700
Date:   Tue, 23 Mar 2021 13:01:19 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Clean up frequency computations
Message-ID: <20210323050119.GB71586@chenyu-desktop>
References: <1662840.8zf6FDN98U@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662840.8zf6FDN98U@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 16, 2021 at 04:52:43PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that some computations related to frequency in intel_pstate
> can be simplified if (a) intel_pstate_get_hwp_max() updates the
> relevant members of struct cpudata by itself and (b) the "turbo
> disabled" check is moved from it to its callers, so modify the code
> accordingly and while at it rename intel_pstate_get_hwp_max() to
> intel_pstate_get_hwp_cap() which better reflects its purpose and
> provide a simplified variat of it, __intel_pstate_get_hwp_cap(),
> suitable for the initialization path.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
