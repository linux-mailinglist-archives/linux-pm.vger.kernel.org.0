Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE831BEBF7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2WOs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:14:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:33562 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2WOs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 18:14:48 -0400
IronPort-SDR: JtBZBYjBaAjK4loXlJYh4rDzWjpxZZtHCNCyYvemIkTOW8fT8Dtnvz09MrMOKvnz/c2u4PbkA9
 hYPTRgk9K+MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:14:47 -0700
IronPort-SDR: ++bFfEkStQHBAWlbsHtYzohMzF41O7NJZ1J0v/QYzTRMvr92sRwWH7UnOzkQujjl5vQXARfawY
 ytwYjMCD4Rjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="303109933"
Received: from rantogno-mobl4.jf.intel.com (HELO rantogno-mobl4.amr.corp.intel.com) ([10.54.72.142])
  by FMSMGA003.fm.intel.com with SMTP; 29 Apr 2020 15:14:47 -0700
Date:   Wed, 29 Apr 2020 15:14:47 -0700
From:   Rafael Antognolli <rafael.antognolli@intel.com>
To:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/1] Add new GFXAMHz field to turbostat.
Message-ID: <20200429221447.zsyd2gwc76zweum4@rantogno-mobl4.amr.corp.intel.com>
References: <20200422220207.17425-1-rafael.antognolli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422220207.17425-1-rafael.antognolli@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi again...

Does anyone feel like taking a look at this? Or maybe do their own
implementation?

Thank you,
Rafael

On Wed, Apr 22, 2020 at 03:02:06PM -0700, Rafael Antognolli wrote:
> Hi,
> 
> I work on the Mesa team at Intel and we have been using turbostat a lot
> to monitor CPU and GPU frequency. However, turbostat only displays the
> frequency read by
> /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz. We have been
> also manually printing the content from gt_act_freq_mhz, but would be
> nice if it was just another column in turbostat.
> 
> The following patch adds that, with a field name called "GFXAMHz" (open
> to better names, of course). Would it be reasonable to have such patch?
> 
> If not, would you propose something else instead?
> 
> Thank you!
> 
> Rafael Antognolli (1):
>   turbostat: Add a new GFXAMHz column that exposes gt_act_freq_mhz.
> 
>  tools/power/x86/turbostat/turbostat.c | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> -- 
> 2.26.2
> 
