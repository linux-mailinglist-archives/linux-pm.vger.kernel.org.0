Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A478D447C38
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhKHIuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 03:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKHIuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 03:50:50 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7EC061570;
        Mon,  8 Nov 2021 00:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5NFnfqo73VmZa9KdPDtUR2AdqfLCRkiEPb4pbj86ui0=; b=dK/FD8/1D5AbzQUvYeuURUX7N+
        eALUIE8ff+2lsAqGOl2JGKcmAUDzXqinHQcDViR3VU0ACxuRwFfiM1L0CMQUHQW/l94PC13ssk+hb
        YBMwE7KwTFaYlEDKidSi2np4r00RFLym3d5sRCVk9/IMXy1rcuYSOcidlvonyO1hnOLMY4Wp9KnAF
        tS6D7Zsc72rn95JAduzEoyI3Cmudn2zftMAqSOp2M8y+Hng1LOfDaH+CR8KvooRTeaLctT/URJ7zz
        zA+2IO3TLT9+RQgUCdJr+tBnvU09XXK8RHRa/ll8F0Lqhbp8ojIe56XtsOVR9zjBxJ0xhO/yL7/SQ
        9aretSnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk0Jp-00Er30-8q; Mon, 08 Nov 2021 08:47:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 378E230022C;
        Mon,  8 Nov 2021 09:47:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8975D2671B8AC; Mon,  8 Nov 2021 09:47:54 +0100 (CET)
Date:   Mon, 8 Nov 2021 09:47:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <YYjkOkFmDG9IMPHu@hirez.programming.kicks-ass.net>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05, 2021 at 06:33:08PM -0700, Ricardo Neri wrote:
> +static __init int hfi_parse_features(void)
> +{
> +	unsigned int nr_capabilities, reg;
> +

> +	/*
> +	 * If we are here we know that CPUID_HFI_LEAF exists. Parse the
> +	 * supported capabilities and the size of the HFI table.
> +	 */
> +	reg = cpuid_edx(CPUID_HFI_LEAF);
> +
> +	hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> +	if (!(hfi_features.capabilities & HFI_CAPABILITIES_PERFORMANCE)) {
> +		pr_err("Performance reporting not supported! Not using HFI\n");
> +		return -ENODEV;
> +	}
> +
> +	/* The number of 4KB pages required by the table */
> +	hfi_features.nr_table_pages = ((reg & CPUID_HFI_TABLE_SIZE_MASK) >>
> +				      CPUID_HFI_TABLE_SIZE_SHIFT) + 1;
> +

> +/* Hardware Feedback Interface Enumeration */
> +#define CPUID_HFI_LEAF			6
> +#define CPUID_HFI_CAP_MASK		0xff
> +#define CPUID_HFI_TABLE_SIZE_MASK	0x0f00
> +#define CPUID_HFI_TABLE_SIZE_SHIFT	8
> +#define CPUID_HFI_CPU_INDEX_MASK	0xffff0000

Also, *if* you're going to do something like this, then at least write
out the masks in full so you can easily see how they relate. The above
is crap.

> +#define CPUID_HFI_CPU_INDEX_SHIFT	16
> +
> +/* Hardware Feedback Interface Pointer */
> +#define HFI_PTR_VALID_BIT		BIT(0)
> +#define HFI_PTR_ADDR_SHIFT		12
> +
> +/* Hardware Feedback Interface Configuration */
> +#define HFI_CONFIG_ENABLE_BIT		BIT(0)
> +
> +/* Hardware Feedback Interface Capabilities */
> +#define HFI_CAPABILITIES_MASK		0xff
> +#define HFI_CAPABILITIES_NR		8
> +#define HFI_CAPABILITIES_PERFORMANCE	BIT(0)
> +#define HFI_CAPABILITIES_ENERGY_EFF	BIT(1)


So personally I prefer a bitfield union a-la cpuid10_eax, cpuid10_ebx
cpuid10_edx etc.. Barring that, the above can also be written more
concise using FIELD_GET() from bitfields.

union cpuid6_edx {
	struct {
		unsigned int capabilities :  8;
		unsigned int table_size   :  4;
		unsigned int __reserved   :  4;
		unsigned int cpu_index    : 16;
	};
	unsigned int full;
};

