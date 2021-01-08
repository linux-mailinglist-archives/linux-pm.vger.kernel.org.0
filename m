Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4F2EEDA5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 08:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAHG72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 01:59:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:8569 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbhAHG72 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 01:59:28 -0500
IronPort-SDR: mOdLpJRLFJSo6cA/71PSx2Lq86IO6FZ554L5e8ofrw1P9YYh8QRrgo0Q41Hww1iiVKIYLaLu1b
 ADkUThRCtCoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="241627373"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="241627373"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:58:47 -0800
IronPort-SDR: hzQzZKKMtP2iQeWLJfjzb8EY2IrNOnvWkhGj8jilq4RCtJwTCNbhqDh9ehTeHDHqBv2JWbTiDI
 hlukkje3AmjQ==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="463305028"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 22:58:46 -0800
Date:   Fri, 8 Jan 2021 15:01:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 2/3] cpufreq: intel_pstate: Change
 intel_pstate_get_hwp_max() argument
Message-ID: <20210108070111.GB20383@chenyu-office.sh.intel.com>
References: <5701645.lOV4Wx5bFT@kreacher>
 <2241039.bdjsIDbar3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2241039.bdjsIDbar3@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 07:43:30PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> All of the callers of intel_pstate_get_hwp_max() access the struct
> cpudata object that corresponds to the given CPU already and the
> function itself needs to access that object (in order to update
> hwp_cap_cached), so modify the code to pass a struct cpudata pointer
> to it instead of the CPU number.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 Tested-by: Chen Yu <yu.c.chen@intel.com>


 thanks,
 Chenyu
