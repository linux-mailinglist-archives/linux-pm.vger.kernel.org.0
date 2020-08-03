Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA223A167
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHCJC2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 05:02:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:55495 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgHCJC2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 05:02:28 -0400
IronPort-SDR: WseymalQQLn+TCMb+3b4yv89FV552M4gELyqzx881qXVKQGR2c085OCxuYAtCue7fSMbl8rYsw
 wk+cgEFb2hPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="149508927"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="149508927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 02:02:27 -0700
IronPort-SDR: ZbfLsu2QfmPiGD1wH7yl7RZlypZyer5EvXcdO/AikxzA1ibMyuyf65YvMHolALegIR2ItPyTW7
 kALHQhC3/p5Q==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="395992611"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 02:02:26 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 0A880206D6; Mon,  3 Aug 2020 12:02:25 +0300 (EEST)
Date:   Mon, 3 Aug 2020 12:02:24 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: runtime: Improve kerneldoc of
 pm_runtime_get_if_active()
Message-ID: <20200803090224.GW13316@paasikivi.fi.intel.com>
References: <3777183.7rZhd9hnLu@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3777183.7rZhd9hnLu@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Fri, Jul 31, 2020 at 07:04:11PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The kerneldoc comment of pm_runtime_get_if_active() doesn't list the
> second argument of the function properly, so fix that and while at it
> clarify that comment somewhat and add some markup to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
