Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E887307C91
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 18:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhA1RdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 12:33:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:58567 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhA1Rcy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Jan 2021 12:32:54 -0500
IronPort-SDR: RDI3WuvztB9UwuoK9UZT6qokdJ3aKkPbMLDTqfvkEGMkiZQDOaiRX3YV6rRWQeUPVlMqIEh1uM
 1170uoFM2o0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="179495103"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="179495103"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:32:05 -0800
IronPort-SDR: QQpu1tuZ+x8ya38Svc1hj2fmuM9iB2gKak1TUHeCI57hEFdWp9ZHzypJOwpeIOYd5/sbHknYgh
 am/UCayS/vbA==
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="578700880"
Received: from chengpol-mobl1.ccr.corp.intel.com ([10.249.170.29])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 09:32:03 -0800
Message-ID: <cd2eeb0753dd3f60bd6031f0cb57b17ddb1030fa.camel@intel.com>
Subject: Re: [PATCH] thermal/intel: introduce tcc cooling driver
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Fri, 29 Jan 2021 01:32:00 +0800
In-Reply-To: <e04c36aae6eb4cbb9b99799290016d58@intel.com>
References: <20210115094744.21156-1-rui.zhang@intel.com>
         <002601d6ec2a$36663da0$a332b8e0$@net>
         <e04c36aae6eb4cbb9b99799290016d58@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > 
> > Rather than enter the actual TCC offset, I would rather enter the
> > desired trip
> > point, and have the driver do the math to convert it to the offset.
> 
> Hmmm, a writable trip point? I need to think about this.

I think this is a better idea, and I will export this as a writable
trip point of the x86_pkg_temp_thermal driver later, thanks for the
suggestion.

thanks,
rui

