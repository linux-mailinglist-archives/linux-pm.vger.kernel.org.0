Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853242F26A6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 04:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbhALDZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 22:25:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:60834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbhALDZn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 22:25:43 -0500
IronPort-SDR: EE0MKJ0qH3CoIuasbaO3Clo2vK474jpyRoy6VFZOFfW19Fno2ymWp6U4+/xA1eVQ2+vut1CbEg
 WGFA4XICN4sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="175395081"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="175395081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 19:25:03 -0800
IronPort-SDR: KcXMFxU0i8FJWdvqY2QcB8SnSv2fL6eqZK/yHiN36L6vswLw6RgUOK/EP1INLtmspZOiq5SYgi
 nAgf3yBLqx8Q==
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="381261929"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 19:25:00 -0800
Date:   Tue, 12 Jan 2021 11:28:22 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Subject: Re: [PATCH 2/2][v2] cpufreq: intel_pstate: Get percpu max freq via
 HWP MSR register if available
Message-ID: <20210112032822.GA28619@chenyu-office.sh.intel.com>
References: <cover.1610338353.git.yu.c.chen@intel.com>
 <0ca097c7bbf58415b1df150ea50cb37579f8f8ab.1610338353.git.yu.c.chen@intel.com>
 <7a7de1fedb49489fddf7eac791149f546adccad1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a7de1fedb49489fddf7eac791149f546adccad1.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 03:11:02AM -0800, Srinivas Pandruvada wrote:
> On Mon, 2021-01-11 at 15:43 +0800, Chen Yu wrote:
> > Currently when turbo is disabled(either by BIOS or by the user), the
> > intel_pstate
> > driver reads the max frequency from the package-wide
> > MSR_PLATFORM_INFO(0xce) register.
> > However on asymmetric platforms it is possible in theory that small
> > and big core with
> > HWP enabled might have different max cpu frequency
> max non-turbo frequency (although code call max_freq).
>
Okay, will change.

Thanks,
Chenyu
> Thanks,
> Srinivas
> 
