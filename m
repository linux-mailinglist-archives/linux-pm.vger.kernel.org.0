Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA54AAE74
	for <lists+linux-pm@lfdr.de>; Sun,  6 Feb 2022 09:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiBFIaU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Feb 2022 03:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIaU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Feb 2022 03:30:20 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 00:30:19 PST
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEDC06173B
        for <linux-pm@vger.kernel.org>; Sun,  6 Feb 2022 00:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644136219; x=1675672219;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0XhoIcm2MujWG5qTur+WC9Gb3is33DUrzknKzpbEYfQ=;
  b=ESFc2vv5y/OdMmz24v0qYctbFjM5PwewVX5Df4Q91wzWHwbFfCWTykwi
   FzpCihqyHkf8MLzFz2gc2tMvsbhQo9mYzH81Au33WD11AltOs366Evt8O
   Bafp9CFCLUh52/Fwppg0YHhSpZUKYxLZHhNHDWCdhrZtwupRyD+D0MCkf
   4VYng7IukcYnXf+9CDcy1mOtvcOWQgCRvRfiUAc6kcilEk5HSmHLoMDli
   v7iqco6yw93NVCIsYFldU+jtz3e9Yupl5doUdebPhKlz67+n2KVDAWgDE
   NeMCrgZSzGAmstkPRmVAN1sgXgscSEWT5UNDq1T9uFuHEYWwWD7rSzYNh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="235963742"
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="235963742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 00:29:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="539697486"
Received: from xfeng8-mobl2.ccr.corp.intel.com ([10.249.173.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 00:29:15 -0800
Message-ID: <44a1ea665bad28a8e2d314427d9c50c214e1a436.camel@intel.com>
Subject: Re: DRAM power consumption with turbostat
From:   Zhang Rui <rui.zhang@intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>, Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org
Date:   Sun, 06 Feb 2022 16:29:12 +0800
In-Reply-To: <alpine.DEB.2.22.394.2201301121380.3109@hadrien>
References: <alpine.DEB.2.22.394.2201301121380.3109@hadrien>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Julia,

Thanks for reporting this.

On Sun, 2022-01-30 at 11:27 +0100, Julia Lawall wrote:
> Hello,
> 
> I was wondering whether the DRAM power consumption reported by
> turbostat
> is reliable on recent Intel machines?
> 
> In particular, I observed that turbostat reported a high DRAM energy
> comsumption on a machine (Intel 5128)

are you sure it is 5128? google tells me that 5128 is pretty old, in
around 2006.

can you please paste the lscpu output?

>  with persistent memory, but where
> the persistent memory was not being used.  A colleague did an
> experiemnt
> on another machine with persistent memory, and reported:
> 
> -----
> 
> I didn't run the test on troll but on another server equipped with PM
> where I was able to reproduce the bug and by reading directly the msr
> registers, I see that:
> CPU Energy units = 0.00006104J
> DRAM Energy units = 0.00001526J
> 
> However turbostat assumes that the DRAM  Energy units is 0.00006104J
> when
> it runs the computation to obtain Joules (hence the too-high value
> returned by turbostat)

And can you please try latest version of turbostat?

The problem should be fixed by the below commit

commit abdc75ab53b7fd2ef42c79e88cf0caf2d007c4f2
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Thu Mar 11 10:05:13 2021 +0800
Commit:     Len Brown <len.brown@intel.com>
CommitDate: Tue May 4 18:23:14 2021 -0400

    tools/power turbostat: Fix DRAM Energy Unit on SKX
    
    SKX uses fixed DRAM Energy Unit, just like HSX and BDX.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

thanks,
rui
> 
> -----
> 
> I see the code in turbostat that just uses the CPU energy units value
> (rapl_dram_energy_units_probe), but I don't know what was the MSR
> used to
> collect the above information.  Overall, I am wondering if the DRAM
> energy
> consumption values are reliable in cases with and without persistent
> memory.
> 
> thanks,
> julia

