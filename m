Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD2D6B19
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbfJNVMB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 14 Oct 2019 17:12:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:26571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbfJNVMB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:12:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 14:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="189143213"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2019 14:12:00 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 14 Oct 2019 14:12:00 -0700
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 14 Oct 2019 14:12:00 -0700
Received: from crsmsx104.amr.corp.intel.com ([169.254.6.181]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.114]) with mapi id 14.03.0439.000;
 Mon, 14 Oct 2019 15:11:58 -0600
From:   "Hernandez Lopez, Fabiola" <fabiola.hernandez.lopez@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: RE: Frequency not returning to fixed value after AVX workload
Thread-Topic: Frequency not returning to fixed value after AVX workload
Thread-Index: AdWAW7g0RYwhbvwkQrq2viRm3SLyeQCSpKyAAAtq94A=
Date:   Mon, 14 Oct 2019 21:11:57 +0000
Message-ID: <67737C20FC7E4D44B44817ABFA5B1DCE6EC020E9@CRSMSX104.amr.corp.intel.com>
References: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
 <3340378.NBreQbsDsf@kreacher>
In-Reply-To: <3340378.NBreQbsDsf@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTdhNThmOGItMmJhNy00NDM1LWE0ZGQtYmQxYzIxZjE4YWI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibWd2eFAxOXdIUUJ4OG1EVTFOVE40Vk1LbGhaN0VVYzVIZnBGVWpTRVZtZ2IydllnMzllczR3RnhOOFhET2l6SiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

How do you measure the frequency?
With lscpu.

What exactly do you do to get the expected frequency back?
A script is used that sets the frequency with /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed

Is the target frequency in the turbo range?
No, the target frequency is the same as the base processor frequency: 2.4GHz. The max turbo frequency for this CPU si 3.9 GHz.
This has been tested with turbo boost enabled and disabled. 

This behavior is very sporadic: < 10%

Thanks,
Fabiola

-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net] 
Sent: Monday, October 14, 2019 4:45 AM
To: Hernandez Lopez, Fabiola <fabiola.hernandez.lopez@intel.com>
Cc: linux-pm@vger.kernel.org; Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Frequency not returning to fixed value after AVX workload

On Friday, October 11, 2019 7:45:55 PM CEST Hernandez Lopez, Fabiola wrote:
> Hi,
> 
> We are seeing an unexpected behavior after applying AVX workloads. 
> After setting the CPU frequency to a fixed value with CPU Freq - 
> userspace governor and applying heavy AVX workloads, the CPU frequency 
> is decreased (as expected) but it never returns to the previously established value.

How do you measure the frequency?

> This does not happen on all cores, only on a single core. The only way 
> to return to the desired frequency is by setting it through the 
> command line again.

What exactly do you do to get the expected frequency back?

> We are wondering how can this change in frequency happen.

Is the target frequency in the turbo range?



