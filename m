Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77B3B33BF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFXQVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 12:21:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:37546 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhFXQVX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Jun 2021 12:21:23 -0400
IronPort-SDR: L9H8Japx4MClQzIbuFtqsNumOCztbtMt0vrQT8yGYVeEKzd4FVKFo6nOaSA2+43vGIR29fORNx
 Xf4co734olXA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207544641"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="207544641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 09:19:03 -0700
IronPort-SDR: KdToM5ZjiXgnuiLMq43eEtV0dL7a42+xPBuVSzux+3Xcrw1jRbDOVL/7dSBXUBDNId+4EBwBpu
 H0ueOgbrGwbA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="455122744"
Received: from cpgateho-mobl.amr.corp.intel.com ([10.209.60.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 09:19:03 -0700
Message-ID: <1244a17de6b1e48131d7cf23fc10b7e085cffc6f.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] thermal: int340x: processor_thermal: Add new PCI
 MMIO based thermal driver
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Jun 2021 09:19:02 -0700
In-Reply-To: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
References: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-05-25 at 13:48 -0700, Srinivas Pandruvada wrote:
> This series adds a new thermal driver, which uses PCI MMIO for
> temperature and trips. To reuse
> the code the first patch just reorganizes the existing code.
> 
Any comments on this series?

Thanks,
Srinivas

> This series needs the following patch to cleanly apply:
> [PATCH 1/2] thermal: int340x: processor_thermal: Export mailbox
> interface
> sent on 16th May, 21.
> 
> Srinivas Pandruvada (2):
>   thermal: int340x: processor_thermal: Split enumeration and
> processing
>     part
>   thermal: int340x: processor_thermal: Add PCI MMIO based thermal
> driver
> 
>  .../thermal/intel/int340x_thermal/Makefile    |   3 +
>  .../intel/int340x_thermal/int3401_thermal.c   |  82 ++++
>  .../processor_thermal_device.c                | 289 ++------------
>  .../processor_thermal_device.h                |   9 +-
>  .../processor_thermal_device_pci.c            | 371
> ++++++++++++++++++
>  .../processor_thermal_device_pci_legacy.c     | 163 ++++++++
>  6 files changed, 658 insertions(+), 259 deletions(-)
>  create mode 100644
> drivers/thermal/intel/int340x_thermal/int3401_thermal.c
>  create mode 100644
> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
>  create mode 100644
> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_le
> gacy.c
> 

