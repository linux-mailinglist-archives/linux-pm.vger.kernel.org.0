Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F66E608
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfGSNEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 09:04:02 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:52493 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSNEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 09:04:02 -0400
Received: from hp-x360 (173-8-203-89-Oregon.hfc.comcastbusiness.net [173.8.203.89])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 45qrmb0FNsz1Y8B;
        Fri, 19 Jul 2019 09:03:58 -0400 (EDT)
Date:   Fri, 19 Jul 2019 06:03:57 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
In-Reply-To: <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907190601580.2769@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563514893.2433.3.camel@intel.com> <alpine.DEB.2.21.1907182308321.2769@hp-x360> <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 19 Jul 2019, Rafael J. Wysocki wrote:

> So can you disable PROC_THERMAL_MMIO_RAPL in Kconfig and retest?

It can't be manually disabled, as it's auto-selected:

	Depends on: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] ||
	COMPILE_TEST [=n]) && INT340X_THERMAL [=y] && 64BIT [=y] && POWERCAP [=y]

so I just reverted the commit to get going again,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
