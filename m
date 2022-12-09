Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA364868B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLIQhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 11:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLIQhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 11:37:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933077232
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670603826; x=1702139826;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rORKLOHOyteXx0dvKZTOtZky1LF0KwCiwhKjixq1jcY=;
  b=ObcGKFnWu0LxNCouCCXJ2L4bNCBJ9Rjc86KxoFkY7Ke9P+dcyf0mGDiB
   6QUiO6+DWzJj0Hg1Zaoyjcl0fOGmWNg70UVSNSo/MCzKGIY00aVJzOBKO
   GyV9pBzjuzFPZ+Ua6npaGk5liTAzBX7m+uR/3Ms32zbNyNacAT9X+aSf9
   5fkIKwSu1cZtp8o8XAP6d7IzG6Rg2yWRJhyDhwkkKauh171ayWmJgCi86
   O1F6Bl4WK1tKmuB1gIPQEJw5WZc0qEnRHUDqy9z9ai1hoDJGNVpC9KuSN
   f7tpXvxPHB9ofVWu2cqY6wxuVX/kbAmvSbmYsOS3acFOfWl9AiiNjfojb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300914729"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="300914729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:28:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="679976984"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="679976984"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:28:36 -0800
Message-ID: <fd4b11f8f9ce4b592c6fdfed2d14f7b8a6c3e4f0.camel@linux.intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Date:   Fri, 09 Dec 2022 08:28:35 -0800
In-Reply-To: <015c7c006b0bbe935a31c837ed0fc5da9d7e43cd.camel@intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
         <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
         <015c7c006b0bbe935a31c837ed0fc5da9d7e43cd.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2022-12-09 at 21:32 +0800, Zhang Rui wrote:
> > > 
> > > > 

[...]

> > > > Well, what if somebody change tjmax on this cpu while this
> > > > function
> > > > is running?
> > > 
> > > tjmax is read only. Only firmware can change its value at
> > > runtime,
> > > say
> > > this field is updated when SST-PP level is changed.
> > 
> > Do we get any type of notification on tjmax changes, or do we need
> > to
> > poll for it?
> 
> I'm not aware of such a notification.
> Srinivas, do you know if there is one?
There is no explicit notification. You can infer from HWP guaranteed
change interrupt.

Thanks,
Srinivas

> 
> thanks,
> rui
> 
> 


