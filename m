Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA58B5EB872
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 05:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiI0DPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Sep 2022 23:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiI0DP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2022 23:15:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FCABF2C
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2022 20:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664248416; x=1695784416;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJRT4VttEnMR5KT/3nW/PwoWRIQ0ayIBXSWGZYvyzck=;
  b=UpDrbxNHf5+Zvuh6UoIHgPDzUR14aRyIdiUjlz20xrZ4UDOaozadITo1
   rf+XE6NGCtbkLG7R2v/lITqyEQNtvjE00CWBhYhB7o8PidatrwJ3wD4k9
   A+zkdQ2qMTNwfkDuizmnkGXzXYpW0v1g6JpFGY0+D1wchk0lSd6rsQvX6
   jc+npJsgJ/KYv0h9GozOOtmrB3M5NAMEsi1DK+qpl0veTYXwbaxAZO3Vo
   SA4bhvJOoneyK0iyp7JiBDZqrbPETQIdQLoKjIDWupEiGsc+tjL4Dc/3x
   Ft3m2C90h1NxGTKhiguz1IQTpYTyudh+6VgG/Xi/RqL/5E20OsGKRxiww
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="284323027"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="284323027"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 20:13:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="746876135"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="746876135"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 20:13:35 -0700
Message-ID: <09403867fc1f0f89b06b5dbdb269fccf8ba22f99.camel@linux.intel.com>
Subject: Re: New error in 5.15: ACPI BIOS Error (bug): Could not resolve
 symbol [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Date:   Mon, 26 Sep 2022 20:13:35 -0700
In-Reply-To: <520d0a5b-cbae-554c-4905-5a68cc5f5ca6@molgen.mpg.de>
References: <520d0a5b-cbae-554c-4905-5a68cc5f5ca6@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
On Thu, 2022-09-22 at 18:57 +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Moving from Linux 5.10.113 to 5.15.69 on
> 
>      [    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 
> 2.22.0 07/13/2022
>      […]
>      [    1.521806] smpboot: CPU0: Intel(R) Core(TM) i7-7700 CPU @ 
> 3.60GHz (family: 0x6, model: 0x9e, stepping: 0x9)
> 
> Linux logs the errors below:
> 
These errors are coming from interpreter. Please try the latest
upstream kernel, to see if there is some version incompatibility.

Thanks,
Srinivas

> ```
> $ dmesg --level=err
> [    2.782085] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.792412] ACPI Error: Aborting method \_PR.CPU1._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.807882] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.818223] ACPI Error: Aborting method \_PR.CPU2._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.833675] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.844003] ACPI Error: Aborting method \_PR.CPU3._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.859452] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.869776] ACPI Error: Aborting method \_PR.CPU4._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.885227] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.895552] ACPI Error: Aborting method \_PR.CPU5._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.911018] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.921343] ACPI Error: Aborting method \_PR.CPU6._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> [    2.936810] ACPI BIOS Error (bug): Could not resolve symbol 
> [\_PR.CPU0._CPC], AE_NOT_FOUND (20210730/psargs-330)
> [    2.947136] ACPI Error: Aborting method \_PR.CPU7._CPC due to 
> previous error (AE_NOT_FOUND) (20210730/psparse-529)
> ```
> 
> Any idea, where that comes from? We only build intel_pstate, but it
> was 
> also selected in Linux 5.10.113.
> 
>      $ grep PSTATE /boot/config-{5.10.113,5.15.69}*
>      /boot/config-5.10.113.mx64.434:CONFIG_X86_INTEL_PSTATE=y
>      /boot/config-5.15.69.mx64.436:CONFIG_X86_INTEL_PSTATE=y
> 
> 
> Kind regards,
> 
> Paul


