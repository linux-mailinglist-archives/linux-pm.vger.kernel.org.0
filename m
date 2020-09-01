Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBD259EF0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 21:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgIATHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 15:07:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:63806 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIATHQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 15:07:16 -0400
IronPort-SDR: PKw8KBYDoU8ZLUShZh7Wm8URCC04sN1rFEAmLYf/diilx5b7sKDFAeU5R/QPX8NmT6Rw0TdOVL
 6BMNfBIKc2gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="242076431"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="242076431"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:07:14 -0700
IronPort-SDR: Y0QpoXYKfjIAJWqzdi17Y3vk5+rA+zAu5vHVuWaXf0bYuO1wpbjNTy5TbTnVxh2ahy0BpyG7nV
 o8/m22Zl9uTQ==
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="446251312"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.231.183])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:07:14 -0700
Message-ID: <818b61c1375dabc60df770bbc462ce6728091dbc.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/5] cpufreq: intel_pstate: Address some HWP-related
 oddities
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Date:   Tue, 01 Sep 2020 12:07:11 -0700
In-Reply-To: <3748218.V0HrpZKF9g@kreacher>
References: <3748218.V0HrpZKF9g@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-01 at 19:23 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> The last two patches in the v3 needed to be updated to take re-
> enabling of HWP
> after an ACPI S3 suspend/resume cycle into account
> appropriately.  The first
> three patches are the same as before.
> 
> The purpose of this series is to address some peculiarities related
> to
> taking CPUs offline/online and switching between different operation
> modes with HWP enabled that have become visible after allowing the
> driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
> one that was there earlier, but can be addressed easily after the
> changes made in 5.9-rc1).
> 
> Please refer to the patch changelogs for details.
> 
> For easier testing/review, the series is available from the git
> branch at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  intel_pstate-testing
> 
> I've done my best to address all of the possible corner cases, but
> the test
> matrix is quite extensive and I may have missed something, so go
> ahead
> and test.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> 
> Thanks,
> Rafael
> 
> 
> 

