Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223F42511F9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHYGUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:20:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:16543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHYGUg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 02:20:36 -0400
IronPort-SDR: 2SY5D2WdYCbC8VUEUoViwPQrr8PhXFqechQzgJQXYvqMO6fXQvXly0esxqBfVpjHo8pFwLVtzu
 qG6OlvhZ+c/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="155310052"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="155310052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 23:20:36 -0700
IronPort-SDR: euuB1noOm8pHoIwZaNBXb6cEr0hO6JaO7Xtvab0eeJ4IVKHJdNcFVXEUbTQCsT4/yDl6vz7790
 cs3BCf/K/O5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="336405671"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Aug 2020 23:20:35 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 656285805EB;
        Mon, 24 Aug 2020 23:20:34 -0700 (PDT)
Message-ID: <61ea43fce7dd8700d94f12236a86ffec6f76a898.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] cpufreq: intel_pstate: Always return last EPP
 value from sysfs
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Tue, 25 Aug 2020 09:20:33 +0300
In-Reply-To: <2064342.aRc67yb0pC@kreacher>
References: <4169555.5IIHXK4Dsd@kreacher> <2064342.aRc67yb0pC@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-08-24 at 19:42 +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Make the energy_performance_preference policy attribute in sysfs
> always return the last EPP value written to it instead of the one
> currently in the HWP Request MSR to avoid possible confusion when
> the performance scaling algorithm is used in the active mode with
> HWP enabled (in which case the EPP is forced to 0 regardless of
> what value it has been set to via sysfs).

Why is this a good idea, I wonder. If there was a prior discussion,
please, point to it.

The general approach to changing settings via sysfs is often like this:

1. Write new value.
2. Read it back and verify that it is the same. Because there is no
better way to verify that the kernel "accepted" the value.

Let's say I write 'balanced' to energy_performance_preference. I read
it back, and it contains 'balanced', so I am happy, I trust the kernel
changed EPP to "balanced".

If the kernel, in fact, uses something else, I want to know about it
and have my script fail. Why caching the value and making my script
_think_ it succeeded is a good idea.

In other words, in my usage scenarios at list, I prefer kernel telling
the true EPP value, not some "cached, but not used" value.

Artem.

