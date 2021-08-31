Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15F83FCB4E
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbhHaQQj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhHaQQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 12:16:39 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D6C061575;
        Tue, 31 Aug 2021 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=PCQ8ZFnhW5N6IDS6udBJxjrWJnUDnnHP3/qSywcxIl4=; b=iA2ksHgpF7Xjs/fZF89GOdxJpC
        1EyTedjGzlGjIQkznv3R8r2fu0dJvkqxQCSb1gxOrrAMXlukvb1mdGyQHt0rjzof/XtBEsVEdumm7
        oyr3R5dmz6ptTExzYPCucW/xplqK+of7f6dqVneI4Sse81+36VRcWpGgENPspNuXPhQxpk5j3IAxG
        45ZT27LLZImGXG92jpqQEANtlN5UqqbKBoE2p2ZDmY5DB5MxU1XxsTMXc77pr2Vm41rISC0KigeOM
        wQkqi5FI+liHA4ZUo69y5LoRYfhI/JVwgkumb7fjSHNjtlQLoFb/tkdgn5B51nIzb7YfmnJrkENfg
        kTjwLzDw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL6QE-002hKY-7w; Tue, 31 Aug 2021 16:15:38 +0000
Subject: Re: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
To:     pandith.n@intel.com, georgi.djakov@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
References: <20210831063615.1021-1-pandith.n@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <986f25c1-a6ce-f142-018b-88ee0c237943@infradead.org>
Date:   Tue, 31 Aug 2021 09:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831063615.1021-1-pandith.n@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi--

On 8/30/21 11:36 PM, pandith.n@intel.com wrote:
> diff --git a/drivers/interconnect/intel/Kconfig b/drivers/interconnect/intel/Kconfig
> new file mode 100644
> index 000000000000..a2f933773380
> --- /dev/null
> +++ b/drivers/interconnect/intel/Kconfig
> @@ -0,0 +1,19 @@
> +# Copyright (C) 2019 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +config INTERCONNECT_INTEL
> +	bool "Intel Network-on-chip interconnect drivers"
> +	help
> +	  Support for Intel's Network on chip interconnect hardware.
> +
> +config INTERCONNECT_INTEL_KEEMBAY
> +	tristate "Intel Keem Bay Enable DDR profiling using NOC"
> +	depends on INTERCONNECT_INTEL || ARCH_KEEMBAY || COMPILE_TEST
> +	help
> +	  Enable this option for DDR bandwidth measurements using NOC

	                                                          NOC.

> +
> +	  Add support for Network-on-chip (NOC) in DDR Subsystem(DSS).

	                                               Subsystem (DSS).

> +	  DSS NOC has capabilities to enable and get statistics profiling.
> +	  NOC driver enables features to configure and capture NOC probe
> +          counters, needed for DSS bandwidth measurement.

Indent above with tab + 2 spaces instead of many spaces.

> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

