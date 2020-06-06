Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18AF1F0805
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgFFRR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jun 2020 13:17:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:44122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgFFRR0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 6 Jun 2020 13:17:26 -0400
IronPort-SDR: 8Q6KPWq+seKknQelPUbgjuXiUpwYkzIio3C2QENmQEF1MqoblsXTuQfbmX8VkaUqtnQaPO646T
 1nasLXgkGRiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 10:17:24 -0700
IronPort-SDR: j5v0gMfuGTjpLcr+3dT2X/x/7FkneIpNZ+Q06w7AiHW57U44I1+haxyfwLkFnvCrITwArhsAhc
 FNXDJ8IXMbWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,481,1583222400"; 
   d="scan'208";a="472257243"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2020 10:17:22 -0700
Date:   Sun, 7 Jun 2020 01:18:23 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][RFC] PM-runtime: Move all runtime usage related
 function to runtime.c
Message-ID: <20200606171822.GA3705@chenyu-office.sh.intel.com>
References: <cover.1591380524.git.yu.c.chen@intel.com>
 <3e7c571eb9e444c6e326d5cbb1f6e2dce4bb52fe.1591380524.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7c571eb9e444c6e326d5cbb1f6e2dce4bb52fe.1591380524.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 06, 2020 at 03:05:35AM +0800, Chen Yu wrote:
> In order to track all the runtime usage count change, move the code
> related to runtime usage count change from pm_runtime.h to runtime.c,
> so that in runtime.c we can leverage trace event to do the tracking.
> Meanwhile export pm_runtime_get_noresume() and pm_runtime_put_noidle()
> so the module can use them.
> 
> No functional change.
>
There is a compile issue found by lkp, will send a
new version out.

Thanks,
Chenyu
