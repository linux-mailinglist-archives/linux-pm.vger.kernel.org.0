Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2E404630
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbhIIHbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 03:31:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:13419 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242799AbhIIHbe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 03:31:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="218853662"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="218853662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 00:30:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="431701628"
Received: from jax-mobl.gar.corp.intel.com ([10.213.103.124])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 00:30:22 -0700
Message-ID: <2c1a37bcf8cd55c4f9ebb16c876148d9b5ecc78f.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: fix tcc offset on resume
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Antoine Tenart <atenart@kernel.org>, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org
Date:   Thu, 09 Sep 2021 00:30:17 -0700
In-Reply-To: <163117137691.4442.5244464351443466921@kwain>
References: <20210908161632.15520-1-atenart@kernel.org>
         <8bd5406ed111aa3c4dc180a21600811c56c6b809.camel@linux.intel.com>
         <163117137691.4442.5244464351443466921@kwain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-09-09 at 09:09 +0200, Antoine Tenart wrote:
> Quoting Srinivas Pandruvada (2021-09-09 07:47:23)
> > 
> > We have to mark for stable. But It mayn't cleanly apply. So we have
> > to
> > submit for 5.12+ kernels.
> 
> If this can't be easily applied on stable kernels another approach
> could
> be to apply a simple fix (similar to the previous logic) for older
> kernels[1] and applying this patch only for 5.15+.
> 
> [1] Something like:
> 
>   -static unsigned int tcc_offset_save;
>   +static unsigned int tcc_offset_save = -1;
> 
>    int proc_thermal_resume(struct device *dev)
>    {
>           struct proc_thermal_device *proc_dev;
>   @@ -352,7 +371,9 @@ int proc_thermal_resume(struct device *dev)
>           proc_dev = dev_get_drvdata(dev);
>           proc_thermal_read_ppcc(proc_dev);
> 
>   -       tcc_offset_update(tcc_offset_save);
>   +       if (tcc_offset_save >= 0)
>   +               tcc_offset_update(tcc_offset_save);
> 
>           return 0;

This is a better approach. First submit this change with simple fix and
mark for stable and the other fix for 5.15 kernel.

Thanks,
Srinivas

>    }
> 
> Let me know if you prefer this approach.
> 
> Thanks,
> Antoine


