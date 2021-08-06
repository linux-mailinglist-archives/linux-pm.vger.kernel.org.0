Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216CA3E2B08
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbhHFM7c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 08:59:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:41672 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243351AbhHFM7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 08:59:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="236343985"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="236343985"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 05:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="504016198"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2021 05:59:13 -0700
Subject: Re: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
 <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
 <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org>
 <yq1czqrguch.fsf@ca-mkp.ca.oracle.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <739a1abf-fca0-458e-5c8c-1d6ed90b56e0@intel.com>
Date:   Fri, 6 Aug 2021 15:59:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <yq1czqrguch.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/08/21 5:50 am, Martin K. Petersen wrote:
> 
>> Since patch 1/2 went in through Greg's tree, if patch 2/2 goes
>> upstream via Martin's tree, will the resulting kernel be bisectable if
>> Linus pulls Martin's tree before he pulls Greg's tree?
> 
> Also, this patch will need to be rebased on top of 5.15/scsi-staging due
> to all the UFS churn in this release.
> 

Patch "driver core: Prevent warning when removing a device link from
unregistered consumer" is already in Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e64daad660a0c9ace3acdc57099fffe5ed83f977


I will rebase on 5.15/scsi-staging
