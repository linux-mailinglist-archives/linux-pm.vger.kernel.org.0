Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C510236500D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhDTCAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 22:00:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:30085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhDTCAV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Apr 2021 22:00:21 -0400
IronPort-SDR: 59E1uVoB9z/0HEL4cbwnaDI0/IGO2FKxgccl0ymz5u4PCwR4+h8ZsnCFLJ/eokhV1nePzax2xm
 fQQsBNi1FcYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195541832"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="195541832"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 18:59:50 -0700
IronPort-SDR: ftmXhnYEFk2x+ACtl8Op7mLBGHcxaCOv0Us0O3Vp5K0UUXkxaRXAHmYPe1y4El8Gy44CQxp1Ul
 0DuHOU/R73rQ==
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="426730850"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 18:59:48 -0700
Date:   Tue, 20 Apr 2021 10:03:36 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     lenb@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, calvin.walton@kepstin.ca,
        wei.huang2@amd.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210420020336.GA386151@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419195812.147710-1-terry.bowman@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 19, 2021 at 02:58:12PM -0500, Terry Bowman wrote:
> Turbostat fails to correctly collect and display RAPL summary information
> on Family 17h and 19h AMD processors. Running turbostat on these processors
> returns immediately. If turbostat is working correctly then RAPL summary
> data is displayed until the user provided command completes. If a command
> is not provided by the user then turbostat is designed to continuously
> display RAPL information until interrupted.
> 
> The issue is due to offset_to_idx() and idx_to_offset() missing support for
> AMD MSR addresses/offsets. offset_to_idx()'s switch statement is missing
> cases for AMD MSRs and idx_to_offset() does not include a path to return
> AMD MSR(s) for any idx.
> 
> The solution is add AMD MSR support to offset_to_idx() and idx_to_offset().
> These functions are split-out and renamed along architecture vendor lines
> for supporting both AMD and Intel MSRs.
> 
> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Thanks for fixing, Terry, and previously there was a patch for this from Bas Nieuwenhuizen:
https://lkml.org/lkml/2021/3/12/682
and it is expected to have been merged in Len's branch already.

thanks,
Chenyu
