Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08E535FFF2
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 04:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhDOCWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 22:22:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:29039 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhDOCWa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Apr 2021 22:22:30 -0400
IronPort-SDR: /yqU6CHvMnFWvvZIJ9TfUfxya1dmwgKDMLrPIC0Ww9S4mcjs3a1ebIsfqIbQvQvFKKhJddCwac
 TuFBTjs/bJTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="280090656"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="280090656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 19:22:08 -0700
IronPort-SDR: ggwZsxSbhGyBGUchl9E+OtB9B8VKWhqmkzuPbSU6GF6wDANuPymFEXZzxREtBtSQily6tuFsTU
 aJQG2fWdlUGw==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="418570192"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 19:22:07 -0700
Date:   Thu, 15 Apr 2021 10:26:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Fix turbostat exiting with an error when run on AMD CPUs
Message-ID: <20210415022600.GA341188@chenyu-desktop>
References: <88d11c19e662f67ae492eb4b93e12e1b24e68c1d.camel@kepstin.ca>
 <07f5e30a2af1674f0a2f8995641bbaaf64e47d34.camel@kepstin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f5e30a2af1674f0a2f8995641bbaaf64e47d34.camel@kepstin.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Calvin,
On Wed, Apr 14, 2021 at 10:08:07PM -0400, Calvin Walton wrote:
> On Wed, 2021-04-14 at 22:05 -0400, Calvin Walton wrote:
> > The current version of turbostat exits immediately upon entering the
> > main loop, with error code -13. This is a regression that was
> > introducted
> > in these commits:
> > 
> > 9972d5d84d76 tools/power turbostat: Enable accumulate RAPL display
> > 87e15da95775 tools/power turbostat: Introduce functions to accumulate
> > RAPL consumption
> 
> Ah, I failed to check the mailing list before sending this patch! Terry
> Bowman's fix here should probably be preferred:
> https://patchwork.kernel.org/project/linux-pm/patch/20210331155807.3838-1-terry.bowman@amd.com/
> 
> My patch was simply the minimum necessary to get turbostat working
> again.
Thanks for reporting this. We had a fix for this previously at
https://lkml.org/lkml/2021/3/12/682

I'll check with Len if this patch has been merged.

thanks,
Chenyu
> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
> 
