Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6211A8F3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfLKKdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Dec 2019 05:33:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:10005 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfLKKdL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Dec 2019 05:33:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 02:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="220421591"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2019 02:33:10 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 02:33:10 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Dec 2019 02:33:10 -0800
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.46]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.164]) with mapi id 14.03.0439.000;
 Wed, 11 Dec 2019 18:33:08 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: RE: [PATCH] cpuidle: Drop unnecessary type cast in
 cpuidle_poll_time()
Thread-Topic: [PATCH] cpuidle: Drop unnecessary type cast in
 cpuidle_poll_time()
Thread-Index: AQHVsA4SzXyZ814bMUGo9YuVyvCTvKe0vHWA
Date:   Wed, 11 Dec 2019 10:33:07 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926377677DF1@SHSMSX108.ccr.corp.intel.com>
References: <9680649.eAqxiQ8Vpk@kreacher>
In-Reply-To: <9680649.eAqxiQ8Vpk@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWM0MmMxZjItMGMyNS00MzQxLWIwZmYtNWIwMmMzZTFiOTVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV3ZjVUF2M25mQVpiUW1BYXpya3lRZGRQZDhLZXU2NGRZbnpRMU9GXC9RSDZGM2RPa1hUZVBSSE12RDlENTlMTmwifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Wednesday, December 11, 2019 6:31 PM
> To: Linux PM <linux-pm@vger.kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>; Daniel Lezcano
> <daniel.lezcano@linaro.org>
> Subject: [PATCH] cpuidle: Drop unnecessary type cast in cpuidle_poll_time()
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The data type of the target_residency_ns field in struct cpuidle_state is u64,
> so it does not need to be cast into u64.
> 
> Get read of the unnecessary type cast.

s/read/rid

thanks,
rui
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of the linux-next branch of linux-pm.git from today.
> 
> ---
>  drivers/cpuidle/cpuidle.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ==============================================================
> =====
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -381,7 +381,7 @@ u64 cpuidle_poll_time(struct cpuidle_dri
>  		if (dev->states_usage[i].disable)
>  			continue;
> 
> -		limit_ns = (u64)drv->states[i].target_residency_ns;
> +		limit_ns = drv->states[i].target_residency_ns;
>  		break;
>  	}
> 
> 
> 

