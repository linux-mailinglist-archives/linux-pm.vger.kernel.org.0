Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1764931B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Dec 2022 08:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLKHuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Dec 2022 02:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLKHuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Dec 2022 02:50:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F5EE07
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 23:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670745023; x=1702281023;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48BwlvPNLSRZ7gIgEY4Ru+7dcmAn8bYZZ5d54CQbcxo=;
  b=XHGD5J0DloLCCEiHtDtwvgdZuuE4p6NzoJ3V81RPtHdUNR6FqT059oVk
   KNBaZFECAaK5iJVpekkRmy4f4HYYhbRt1dDOx4QPGLc2j8j0AjzsqHOvP
   qYMww48JBTaqNI9v08vEXvZkYqDpsXld0zZjbvnmLGSfsztgVKpKEhStD
   TzHYTAenx3XoYCsy+BzQ0pS7VYMCGHgUBervV0IIOdE1ymkufMRApiYeV
   273sy9B6S7cr2ciW/yvH4/ilp7URghR+iEskolS6eYEg2NjzWSDv0TGpw
   5C9p15zCG8Nx6F8qvQDK/alOV685GjQotgguRW3bDSiCnzSgXkKus69JV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="344732370"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="344732370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 23:50:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="641415846"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="641415846"
Received: from zhenzhu-mobl1.ccr.corp.intel.com ([10.255.30.120])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 23:50:20 -0800
Message-ID: <5c0e237bc3338ea61e04643b0077e4d55479e4fc.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Date:   Sun, 11 Dec 2022 15:50:17 +0800
In-Reply-To: <fd4b11f8f9ce4b592c6fdfed2d14f7b8a6c3e4f0.camel@linux.intel.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
         <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
         <015c7c006b0bbe935a31c837ed0fc5da9d7e43cd.camel@intel.com>
         <fd4b11f8f9ce4b592c6fdfed2d14f7b8a6c3e4f0.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2022-12-09 at 08:28 -0800, srinivas pandruvada wrote:
> On Fri, 2022-12-09 at 21:32 +0800, Zhang Rui wrote:
> 
> [...]
> 
> > > > > Well, what if somebody change tjmax on this cpu while this
> > > > > function
> > > > > is running?
> > > > 
> > > > tjmax is read only. Only firmware can change its value at
> > > > runtime,
> > > > say
> > > > this field is updated when SST-PP level is changed.
> > > 
> > > Do we get any type of notification on tjmax changes, or do we
> > > need
> > > to
> > > poll for it?
> > 
> > I'm not aware of such a notification.
> > Srinivas, do you know if there is one?
> There is no explicit notification. You can infer from HWP guaranteed
> change interrupt.

But
1. tjmax may or may not change when HWP guaranteed change interrupt
fires. And it does not change in most cases, right?
2. HWP guaranteed change interrupt is per CPU, so if we update tjmax in
the interrupt handler, we also need to cache the timestamp to avoid
duplicate updates from multiple CPUs in the same package/die.

Given that the TCC lib APIs may or may not be called, depends on the
usersapce behavior, do you think this is a win by adding this extra
cost?

Instead, update the tjmax value only when the API is called, and then
cache it to handle frequent read is sufficient. what do you think?

thanks,
rui

> 
> Thanks,
> Srinivas
> 
> > thanks,
> > rui
> > 
> > 
> 
> 

