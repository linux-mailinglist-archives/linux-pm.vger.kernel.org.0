Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04074047D9
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhIIJgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 05:36:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:34843 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232860AbhIIJgg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 05:36:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220417844"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="220417844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 02:35:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="466423222"
Received: from njani-mobl1.gar.corp.intel.com ([10.213.113.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 02:35:24 -0700
Message-ID: <3cb749ed8cd7dba9b7757a83e8b5ac871c5855f2.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] thermal: int340x: fix tcc offset on resume
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Antoine Tenart <atenart@kernel.org>, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org
Date:   Thu, 09 Sep 2021 02:35:20 -0700
In-Reply-To: <20210909085613.5577-1-atenart@kernel.org>
References: <20210909085613.5577-1-atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-09-09 at 10:56 +0200, Antoine Tenart wrote:
> Hi,
> 
> This is a follow-up of [1]. As discussed in the initial thread, the fix
> is now split into two commits: the two commits combined are fixing the
> issue in a nice way for 5.15, but only the first one is meant to be
> applied on stable kernels (to avoid conflicts).
> 
> The issue this is fixing is described in patch 1. Tl;dr: a
> suspend/resume cycle can end-up in setting a wrong tcc offset value,
> which can lead to machines shutting down because of overheating (when
> they should not).
> 
> I've stripped the Acked-by/Tested-by flags from v1 as the patch was
> split. But the end result for 5.15+ kernels should be the same.
> 
> Thanks,
> Antoine
> 
> [1] 
> https://lore.kernel.org/linux-pm/20210908161632.15520-1-atenart@kernel.org/T/
> 
> Antoine Tenart (2):
>   thermal: int340x: do not set a wrong tcc offset on resume
>   thermal: int340x: improve the tcc offset saving for suspend/resume
> 
>  .../intel/int340x_thermal/int3401_thermal.c   |  8 +++-
>  .../processor_thermal_device.c                | 39 ++++++++++++++-----
>  .../processor_thermal_device.h                |  1 +
>  .../processor_thermal_device_pci.c            | 18 ++++++++-
>  .../processor_thermal_device_pci_legacy.c     |  8 +++-
>  5 files changed, 62 insertions(+), 12 deletions(-)
> 
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pI andruvada@linux.intel.com>



