Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6407632D43
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKUTtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 14:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiKUTtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 14:49:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A792B78
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669060188; x=1700596188;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38xO/1DYtOcxoY97abJcMljpJqRJDhbQ82dJKHB8T50=;
  b=azar4VwfGrqC6s4MJIB5/XOAW7HuHKQpEF+I2mG+vaUdmHxDC9+eXK3S
   iDt4n+EJ6xInrII84bOWmGh28Czvtm76svwUuTeZ1PhlxvcUAtHYKvhDz
   0rdvES8ArtvOd1NBXfRm2jK08EJjgYraUS0IAoW78UTJl0+26CnJQ+aII
   f+ATOe+xsKt75ipmLQa2g0ryiYOAdkOvB4VQYWjGTqZ3P0q0uRGmbXB5Y
   httGkqnqrN7x+n8awcotG21Q0PSy4JvIZjZPyMvbDT8QXLRyw4XRyI9LO
   p0kHVzv7gAXwQQt0+Qu4txzAX6nwwuiXoD2Ymu8MG+iePL5JnDyte9y8t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="294038544"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="294038544"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:49:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="591882925"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="591882925"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:49:48 -0800
Message-ID: <5d5d0657425b6f6a8e784d97c4fe13615c24d29b.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel-uncore-freq: add Emerald Rapids
 support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Mon, 21 Nov 2022 11:49:47 -0800
In-Reply-To: <20221121170032.3258772-1-dedekind1@gmail.com>
References: <20221121170032.3258772-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This should be also sent to

Hans de Goede <hdegoede@redhat.com> (maintainer:X86 PLATFORM DRIVERS)
Mark Gross <markgross@kernel.org> (maintainer:X86 PLATFORM DRIVERS)
platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)

On Mon, 2022-11-21 at 19:00 +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Make Intel uncore frequency driver support Emerald Rapids by adding its
> CPU
> model to the match table. Emerald Rapids uncore frequency control is
> the same
> as in Sapphire Rapids.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency.c
> index 8f9c571d7257..00ac7e381441 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -203,6 +203,7 @@ static const struct x86_cpu_id
> intel_uncore_cpu_ids[] = {
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,   NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,   NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);


