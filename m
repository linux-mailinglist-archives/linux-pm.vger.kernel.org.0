Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B312648318
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 14:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLIN5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 08:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIN5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 08:57:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526310FF
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670594252; x=1702130252;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+sRKPprQccFYoR1SAV8KBBM2jrtoDHIz4Ctj5QwEhI=;
  b=lh9GTsqsIX4L2OUY353A0FyTrOrGOW9ruo0UqBiB9VO7+6Sb86dCY9wz
   Jn7pHQpDLr8bJxZjQOKZ4GXAvcop6pB7qvMrUzpc4mPFpmktd4+O8wq9k
   53jbc4kanhFgJSiIAV6eqFWfvSvUwJrNNCFhi+Y+sPBATaTj/XdOuPyW+
   dIFodqiM9xfRQSaErE4xdtJNCCAFfS0uWxys5g0UTh1i+RVe3geAOCHwg
   4g9JYvq6qH0w1jL7xyQ4FV0IkIB/KwrKiyxWG82XkcihdYSRCjr500NYr
   qjF356AUi3jrSdaYc1OicrvxCyYhdEQ53zWDGO8qWNRsDm/7X1s/cTA0H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="318614708"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="318614708"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:57:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647405919"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="647405919"
Received: from zhiyongy-mobl.gar.corp.intel.com ([10.249.169.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 05:57:29 -0800
Message-ID: <55db7c8a8502c6a36aed12a3f75937dd4abd433c.camel@intel.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Date:   Fri, 09 Dec 2022 21:57:25 +0800
In-Reply-To: <CAJZ5v0gWoK9-X8m2pT3Q8z_B2xOVjmZoSQMpyy1a_Hrd73cNVQ@mail.gmail.com>
References: <20221108033332.27760-1-rui.zhang@intel.com>
         <20221108033332.27760-2-rui.zhang@intel.com>
         <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
         <CAJZ5v0gWoK9-X8m2pT3Q8z_B2xOVjmZoSQMpyy1a_Hrd73cNVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > > +
> > > +       err = rdmsr_safe_on_cpu(cpu, msr, &eax, &edx);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       if (eax & 0x80000000) {
> > > +               *temp = tjmax - ((eax >> 16) & 0x7f);
> > > +               return 0;
> > > +       }
> > > +       return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
> 
> And one more thing, but rather for the future.
> 
> Reading from these MSRs can be costly, especially when done on a
> remote CPU, so would it make sense to cache the retrieved values in
> case they are read relatively often?like the coretemp driver already
> has similar code.

For now, this API is called from sysfs attribute callback so it is okay
to add a unified rate_limit here, say 1 second like coretemp driver.

But for the future, I'm not sure. This really depends on the
expectation of the caller.

BTW, this reminds me that I can improve the code a little bit, to avoid
reading MSR from remote CPU when possible.

thanks,
rui

