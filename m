Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396493A1195
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhFIKxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 06:53:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:12342 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238251AbhFIKxg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:36 -0400
IronPort-SDR: kc28D1G2DRmP40BbuRSaXDgmNYQle83KJ8nigvfTMIwbiHnANi6Fyo536/Kw4yKimZpIiwhH8k
 VOiThl4ED5Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="205075087"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="205075087"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 03:51:42 -0700
IronPort-SDR: /8/VzLqSeyG0K2ay/hlKGzNyBq+zfQwNVDwj4tDzhq0J/VXPYYWkZFchHSnW2hERpaFEVGznH0
 T25XRsFtkEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="448241838"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2021 03:51:41 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 490AF5808BE;
        Wed,  9 Jun 2021 03:51:40 -0700 (PDT)
Message-ID: <29b8c8e6975dd9cda8cbe880fe727749f66ba1bf.camel@linux.intel.com>
Subject: Re: [PATCH][v2] intel_idle: Adjust the SKX C6 latency and residency
 if PC6 is disabled
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jun 2021 13:51:39 +0300
In-Reply-To: <20210528032054.7572-1-yu.c.chen@intel.com>
References: <20210528032054.7572-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-05-28 at 11:20 +0800, Chen Yu wrote:
> Currently cpuidle assumes worst-case C-state parameters, and so C6
> is described with PC6 parameters, which is worst case for requesting
> CC6. When PC6 is enabled, this is appropriate. But if PC6 is disabled
> in BIOS, the exit latency and target_residency should be adjusted
> accordingly.
> 
> Exit latency:
> Previously the C6 exit latency was measured when woken up from CC6/PC6.
> With PC6 disabled, the C6 exit latency should be CC6/PC0.
> 
> Target residency:
> With PC6 disabled, idle duration within [CC6, PC6) would make the
> idle governor choose C1E over C6. This would cause low energy-efficiency.
> We should lower the bar to request C6 when PC6 is disabled.
> 
> To fill this gap, check if PC6 is disabled in the BIOS in the
> MSR_PKG_CST_CONFIG_CONTROL(0xe2). If so, use CC6/PC0 parameters as the
> new exit latency. Meanwhile, update target_residency to 3 times of the new
> exit latency. This is consistent with how intel_idle driver uses _CST to
> calculate the target_residency. The consequence is that, the OS would
> be more offen to choose C6 over C1E when PC6 is disabled. This is reasonable
> because if the user is using C6, it implies that the user cares about energy,
> so choosing C6 more frequently is in accordance with user requirement.
> 
> The new exit latency of CC6/PC0 92us was from wult[1] result on SKX, which was
> measured via NIC wakeup from 99.99th latency. Besides SKX, the CLX and CPX
> both have the same CPU model number. And since they have similar CC6 exit latency
> to SKX, 96us and 89us respectively, reuse the value of SKX.
> 
> There is concern that if we should introduce a more generic solution
> rather than optimizing on each platforms. However consider the
> code complexity and different PC6 bit interpretation on different
> platforms, tune the code per platform seems to be an acceptable trade-off.
> 
> [1] https://intel.github.io/wult/
> 
> Suggested-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Simplify the commit log to not mention C3/PC3. (Artem)
>     Confirm the exit latency on CLX and CPX.(Artem)

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>


