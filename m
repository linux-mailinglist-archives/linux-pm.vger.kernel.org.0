Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA73691D2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhDWMPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:15:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:26442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhDWMPE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 08:15:04 -0400
IronPort-SDR: qXA82C8THFWPExuaimHARYy8gieYAFKKzyMzri2HLHpuRvHZ9mHupoVW4yS8t89ffp8ELaYin3
 OTnOwazRmbaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="175543230"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="175543230"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 05:14:28 -0700
IronPort-SDR: potLolWm2XGD5L1oDk90TDiuoMrhKIVfTbuF26xY8VyB6Ej5QUzG8MBZSlmSRdIcT7zKulrJVb
 v848oKwmza9A==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="617963255"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 05:14:26 -0700
Date:   Fri, 23 Apr 2021 20:18:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        calvin.walton@kepstin.ca, wei.huang2@amd.com, aros@gmx.com
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
Message-ID: <20210423121815.GB426003@chenyu-desktop>
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop>
 <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
 <20210420152521.GG2326@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420152521.GG2326@zn.tnic>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 05:25:21PM +0200, Borislav Petkov wrote:
> On Tue, Apr 20, 2021 at 09:15:41PM +0800, Chen Yu wrote:
> > This patch was sent to Len and it is not in public repo yet.
> 
> If that thing were in a public repo, you'd have the advantage of
> pointing people to it and they could be testing patches.
>
Okay, I think we'll put it in public repo once verified.

thanks,
Chenyu 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
