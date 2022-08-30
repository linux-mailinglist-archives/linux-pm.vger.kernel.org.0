Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E815A59A7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 05:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiH3DA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 23:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiH3DA4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 23:00:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBF48CB8
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661828454; x=1693364454;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Stu+hUC00/+Rpxu0AF/BJdNwUuJ81mOHd0ZKLYyq4s=;
  b=aG0skwlrVXAdlRm+fveJqMPstQ7FweUPNheqUYEWJe7TkyPqvY0+tuCP
   KNh9b1dxBJuXZ81FJX2UiAe35Y0Z9YJkidc8CZEci3twcFlR9THICgtrv
   CsUHTwuMduBkROkS6Hb8Y/58i17RKsifxZ+5VfklbtrRIPA1Cm80nfDLH
   ZLp+us7lGOix5YW44tQ/Kufe5XLTRWUSO/2PBOI5PmUVv+R4p4NMjAVw9
   alVEgHi84eJEGYit6l5ZlLgGQ4Aa90l2hewdFKGNn60dw1b2s6v1XUacT
   WmudXe4M4hrkh76aRHPndVlXsTtbp5WAFCMn7NjZmod7dpR1yGlMXHh0l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292640833"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="292640833"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 20:00:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="939835412"
Received: from lijingth-mobl1.gar.corp.intel.com ([10.215.149.96])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 20:00:52 -0700
Message-ID: <efe3eb3d0ad53d58ebd1a54cb5b3a27fdaec3487.camel@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for RAPTORLAKE_S
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Date:   Tue, 30 Aug 2022 11:00:48 +0800
In-Reply-To: <20220830030134.8111-1-rui.zhang@intel.com>
References: <20220830030134.8111-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Note that this patch depends on commit
ea902bcc1943 ("x86/cpu: Add new Raptor Lake CPU model number") which
was merged in 6.0-rc3.

thanks,
rui

On Tue, 2022-08-30 at 11:01 +0800, Zhang Rui wrote:
> Add intel_rapl support for RAPTORLAKE_S platform, which behaves the
> same
> as RAPTORLAKE and RAPTORLAKE_P platforms.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 21d624f9f5fb..6812c1ca3100 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1110,6 +1110,7 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_default
> s_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_
> core),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_default
> s_spr_server),
>  	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_default
> s_core),
>  

