Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A85255A4F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgH1Mg5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 08:36:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:53245 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgH1Mg4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 08:36:56 -0400
IronPort-SDR: SJV83WcqkG7cljGzGBetsnM/XKMLj/RsclMvOj/jzuvMFpUMPmeyljBfvKGomIjkcV29cK7F7l
 vvlidoxQkiZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="174705239"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="174705239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 05:36:50 -0700
IronPort-SDR: oJzDwEnTq8R023bdDnDdlXS31C1qf40zcQm0YvSiTxEF78yBXxYiSwCCXIQNcsOqQeZHfSC2Nf
 nTNAe5+YITew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="332533699"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2020 05:36:50 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 251345803C5;
        Fri, 28 Aug 2020 05:36:48 -0700 (PDT)
Message-ID: <c2e0eb0e42024fab7202603574013904087c5695.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/5] cpufreq: intel_pstate: Tweak the EPP sysfs
 interface
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reply-To: artem.bityutskiy@linux.intel.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Fri, 28 Aug 2020 15:36:48 +0300
In-Reply-To: <9094016.kKgRgCK7kp@kreacher>
References: <2240881.fzTuzKk6Gz@kreacher> <9094016.kKgRgCK7kp@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-08-27 at 17:14 +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Modify the EPP sysfs interface to reject attempts to change the EPP
> to values different from 0 ("performance") in the active mode with
> the "performance" policy (ie. scaling_governor set to "performance"),
> to avoid situations in which the kernel appears to discard data
> passed to it via the EPP sysfs attribute.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This one looks good to me, thanks.

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

-- 
Best Regards,
Artem Bityutskiy

