Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F531D6B2D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfJNVXQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 17:23:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:21982 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbfJNVXQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Oct 2019 17:23:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 14:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="194328026"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2019 14:23:15 -0700
Message-ID: <e7e89cd85fb5d367338491651b36cc912967edab.camel@linux.intel.com>
Subject: Re: Frequency not returning to fixed value after AVX workload
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Hernandez Lopez, Fabiola" <fabiola.hernandez.lopez@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Mon, 14 Oct 2019 14:23:15 -0700
In-Reply-To: <67737C20FC7E4D44B44817ABFA5B1DCE6EC020E9@CRSMSX104.amr.corp.intel.com>
References: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
         <3340378.NBreQbsDsf@kreacher>
         <67737C20FC7E4D44B44817ABFA5B1DCE6EC020E9@CRSMSX104.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-10-14 at 21:11 +0000, Hernandez Lopez, Fabiola wrote:
> How do you measure the frequency?
Do whatever you are doing to get to your problem state and while doing
the test run in another window:

#turbostat

Attach the output.

Thanks,
Srinivas

> With lscpu.
> 
> What exactly do you do to get the expected frequency back?
> A script is used that sets the frequency with
> /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed
> 
> Is the target frequency in the turbo range?
> No, the target frequency is the same as the base processor frequency:
> 2.4GHz. The max turbo frequency for this CPU si 3.9 GHz.
> This has been tested with turbo boost enabled and disabled. 
> 
> This behavior is very sporadic: < 10%
> 
> Thanks,
> Fabiola
> 
> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net] 
> Sent: Monday, October 14, 2019 4:45 AM
> To: Hernandez Lopez, Fabiola <fabiola.hernandez.lopez@intel.com>
> Cc: linux-pm@vger.kernel.org; Srinivas Pandruvada <
> srinivas.pandruvada@linux.intel.com>
> Subject: Re: Frequency not returning to fixed value after AVX
> workload
> 
> On Friday, October 11, 2019 7:45:55 PM CEST Hernandez Lopez, Fabiola
> wrote:
> > Hi,
> > 
> > We are seeing an unexpected behavior after applying AVX workloads. 
> > After setting the CPU frequency to a fixed value with CPU Freq - 
> > userspace governor and applying heavy AVX workloads, the CPU
> > frequency 
> > is decreased (as expected) but it never returns to the previously
> > established value.
> 
> How do you measure the frequency?
> 
> > This does not happen on all cores, only on a single core. The only
> > way 
> > to return to the desired frequency is by setting it through the 
> > command line again.
> 
> What exactly do you do to get the expected frequency back?
> 
> > We are wondering how can this change in frequency happen.
> 
> Is the target frequency in the turbo range?
> 
> 
> 

