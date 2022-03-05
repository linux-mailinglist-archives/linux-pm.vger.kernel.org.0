Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539644CE3F1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Mar 2022 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiCEJVz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Mar 2022 04:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiCEJVz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Mar 2022 04:21:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C3314236E
        for <linux-pm@vger.kernel.org>; Sat,  5 Mar 2022 01:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646472065; x=1678008065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QDyX2sp5NV23hA4PXAgEC36x+xa2bhE9auGVLUjYq/Q=;
  b=a5Nv7/v1m2GCs5gLkf8tjWqIZTerV0USXuSAg1d3u90AQNh1yJGWPmPx
   DWyBk99DaLLVq6KCha9MhCVaKBSPTcY7TiZue1LQQJ1DANV6OIJ+YySCN
   1/ZDTU4uZxSrPrDC0QTJSN9zfGuMG9wqryrjYQa9Jg/vEOB71ysYLFHLo
   hkV2Nrrf9NsrxIQkgnO1HjBMJyWmWVgKPpd0TqcsQ8KIk/JsjngNxnpyT
   ZBhnFV3L9zbhlb4F4Kw5ybXOOiJn7eCgD0ppdImW+C3tW2HuP7Flb26A4
   TtL1fzi+R+1l9aPEU722sXcdE8U2j/7SMaNoWEQoSYIqyDCjPir6Vn5Qg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="340562529"
X-IronPort-AV: E=Sophos;i="5.90,157,1643702400"; 
   d="scan'208";a="340562529"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2022 01:21:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,157,1643702400"; 
   d="scan'208";a="552523817"
Received: from weizhiba-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2022 01:21:02 -0800
Date:   Sat, 5 Mar 2022 17:20:57 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Kin Cho <kin.cho@oracle.com>
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] tools/power/turbostat: Remove Package C6 Retention on
 Ice Lake Server
Message-ID: <20220305092057.GA8207@chenyu5-mobl1>
References: <20210504145234.4103405-1-artem.bityutskiy@linux.intel.com>
 <01dd04dd-a2ad-6ee2-4a8f-f801908e4299@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01dd04dd-a2ad-6ee2-4a8f-f801908e4299@oracle.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cho,
On Fri, Mar 04, 2022 at 01:35:17PM -0800, Kin Cho wrote:
> Hi,
> 
> This patch (25368d7cefcd87a94ccabcc6f9f31796607bbe4e) has affected Sapphire
> Rapids support.
> Specifically Pkg%pc2 and Pkg%pc6 are now missing on Sapphire Rapids (with
> package C6 retention).
> See below for a diff of turbostat --list output with and without 25368d7.
> 
> -kin
> 
> --- turbostat-0304_115100-v5.12-10-g25368d7cefcd    2022-03-04
> 11:51:00.184727582 -0800
> +++ turbostat-0304_124741-v5.12-10-g25368d7cefcd--25368d7 2022-03-04
> 12:47:41.543801798 -0800
> @@ -1,2 +1,2 @@
>  turbostat version 21.03.12 - Len Brown <lenb@kernel.org>
> -usec,Time_Of_Day_Seconds,Package,Core,CPU,APIC,X2APIC,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,IPC,IRQ,SMI,POLL,C1ACPI,C2ACPI,POLL%,C1ACPI%,C2ACPI%,CPU%c1,CPU%c6,CoreTmp,PkgTmp,PkgWatt,RAMWatt,PKG_%,RAM_%
> +usec,Time_Of_Day_Seconds,Package,Core,CPU,APIC,X2APIC,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,IPC,IRQ,SMI,POLL,C1ACPI,C2ACPI,POLL%,C1ACPI%,C2ACPI%,CPU%c1,CPU%c6,CoreTmp,PkgTmp,Pkg%pc2,Pkg%pc6,PkgWatt,RAMWatt,PKG_%,RAM_%
>
My guess is that the max limited package c-state exposed might be '3' rather than '2'.
Artem has previously found this issue on ICX and there is a patch:
https://patchwork.kernel.org/project/linux-pm/patch/20211004105224.3145916-1-dedekind1@gmail.com/
would you please help check if that helps?

thanks,
Chenyu
