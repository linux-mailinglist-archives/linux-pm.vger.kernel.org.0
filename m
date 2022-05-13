Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C08525AF3
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376995AbiEMFID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 May 2022 01:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiEMFIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2022 01:08:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6286E66AE8
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 22:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652418481; x=1683954481;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1V2YZ+Pq0dPPNcl1UGA9bRH6/07draFHFosPgkmsUI=;
  b=WLuK3i1pTKjbo6/k6ZleJBHbFnzpdsttcehZULqsNY5UI8ZRJEjloal4
   0CHXtBA3IGFRxICQTbjshOSD6MDlALV4ds2fTFGoB43yqm7KociKwTyuT
   aVT/b5MHyn3X64FFwJ45cDG9SKvRduSy4hF5BLgyT91a2eOQ8qBbXYfCd
   58dfumaeWvBAZIZq9tt0gfO1nk9SlrqdvShkWA1RdmgYmUMzyU3Mg79oz
   HnoiPQpiUfXAsms4qcTLpdOuk8HOgibAwtXatPVTvkyLIRNSOogNXF+IC
   J3LW5XUvNSlB0LpHGgU0sCtzsSw3r1l5YCDsZusVCJwbOq1x3GAR4JncG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250748940"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250748940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 22:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="712255333"
Received: from ychen23-mobl.ccr.corp.intel.com ([10.249.171.202])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 22:08:00 -0700
Message-ID: <4868e0731ded53d1a51c46a2338f206657aa50b9.camel@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: add support for ALDERLAKE_N
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Date:   Fri, 13 May 2022 13:07:58 +0800
In-Reply-To: <20220513050040.3387524-1-rui.zhang@intel.com>
References: <20220513050040.3387524-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Rafael,

Forgot to mention, this patch is made on top of this commit

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/drivers/powercap/intel_rapl_common.c?h=linux-next&id=ae0dc7ed1a7c713ee9ba563a328d3b4d59223d7c
in your linux-next branch.

thanks,
rui

On Fri, 2022-05-13 at 13:00 +0800, Zhang Rui wrote:
> Add intel_rapl support for the ALDERLAKE_N platform.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 83da499dd6ec..e45c1c3b0cae 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1107,6 +1107,7 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_default
> s_core),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_default
> s_spr_server),
>  	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_default
> s_core),

