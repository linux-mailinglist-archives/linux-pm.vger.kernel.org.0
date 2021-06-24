Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D90A3B352E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFXSGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 14:06:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:17515 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhFXSGh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Jun 2021 14:06:37 -0400
IronPort-SDR: OvGuxHQVjKOKFhUciHvgwGBDrGdVQVX5RythbuoxNNveNiG9YuZ6tlRlJtcdMOi4JaI0hcYhDa
 K4DiRJLNhcNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="187911763"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="187911763"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 11:04:02 -0700
IronPort-SDR: zffVzvWdqCMs1bXe8aGyR9dilVIlnnFSOPmeCp2584KMRMvAptv1WVqlnzbZsmbxL1DY4z9dSm
 kroADaaf5I7w==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="556578072"
Received: from cpgateho-mobl.amr.corp.intel.com ([10.209.60.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 11:04:00 -0700
Message-ID: <9b8a3ee6621d2412da4cb7574bc4275fe3180cf2.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] thermal: int340x: processor_thermal: Add new PCI
 MMIO based thermal driver
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Jun 2021 11:04:00 -0700
In-Reply-To: <9253d77e-cede-f4eb-46ed-2cfe8d488dff@linaro.org>
References: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
         <1244a17de6b1e48131d7cf23fc10b7e085cffc6f.camel@linux.intel.com>
         <9253d77e-cede-f4eb-46ed-2cfe8d488dff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-06-24 at 19:04 +0200, Daniel Lezcano wrote:
> On 24/06/2021 18:19, Srinivas Pandruvada wrote:
> > On Tue, 2021-05-25 at 13:48 -0700, Srinivas Pandruvada wrote:
> > > This series adds a new thermal driver, which uses PCI MMIO for
> > > temperature and trips. To reuse
> > > the code the first patch just reorganizes the existing code.
> > > 
> > Any comments on this series?
> 
> I've been through the series and it looks fine for me. Except a typo
> in
> the log 'anabled' but I fixed it.
Thanks Daniel.

-Srinivas

> 
> 
> 

