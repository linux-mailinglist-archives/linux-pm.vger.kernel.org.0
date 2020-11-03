Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C86A2A3E5A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCILC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 03:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCILB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 03:11:01 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEBC061A47
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 00:11:01 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so11827781wmj.5
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdpvY3vnaHaD1F97XwauJjhuWBuAAnyJbZWUZsOfYIU=;
        b=o/lYcogsCxglhqmUdOWe0mVbuMYgm+696ln9cDs0FwKWIQToTKL+VTH57ieU/ATbYG
         WVorhWY5rLIFydEs2Cc9bHf/ORwndSoLCL3b9Z8y6u3vZLohzRq8BGKj/n74RlX9ILVP
         HHcP2wpFHpjVD8TAQy1ysGwNxbB0AVGXGPUoXiUtA7hI6FzjVZjIopfHsrUl3eh+uw8y
         MnokL/RLQRmtnKMxfrANV6K6/hqjnSn15XsjqnXpPGDpdirZCWKYpZhkT2xHr8E7zuh4
         +/Mpe0crtfFnLK7qHBhT7bm9xpL1ptDV1IkmMkgvD8WdrDzqqHrRbRc+bYGm1pBM8EIT
         yPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdpvY3vnaHaD1F97XwauJjhuWBuAAnyJbZWUZsOfYIU=;
        b=OA6yRFEF1FZ6n9jGkcuZn6gi0/oj3bx9vFyDe8zgX1hJpCd/6WjCIGCcCXUT30qdM1
         My0FyrjtmkMDlx9it3MDEhtDbzSIfOl4W/eE1vuxR3MoVRtIvjinITNwfo5sGh6LPc0U
         VOG3a6eg1BIwXFjHdgxuG05qNvwVlJQoVJJR4oKluXHOd3yztdkfB6JNtP9/6WEt87RS
         zChLIx43dQ3EDqsbHgG7JWHjIeu3Who49KdCs+Y5+irNVyNOWLYCweFDIG8ZC3cZgvrU
         5CGANcHGxSMQbot2lHWfdpi5PmAmLj3UAH7qYwtXMz34QAtiHDwMzxdhpl8KtKaxaoBg
         NjdA==
X-Gm-Message-State: AOAM531Gtd07vamaLqIGWfMV/2aprJvMzoaF1T9Sh4RDIWr4mlJb6HrA
        R/YfU+6I8pdUJKtdmC3sV8QQhA==
X-Google-Smtp-Source: ABdhPJznyfH5Fysxc+b+rJCGR0FORQrMIC5CSZyZl0VHqCzJY5ZMpqAAP02BQlCEerKUyIxg4RHemg==
X-Received: by 2002:a1c:b346:: with SMTP id c67mr2181585wmf.60.1604391059673;
        Tue, 03 Nov 2020 00:10:59 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h7sm25054331wrt.45.2020.11.03.00.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 00:10:59 -0800 (PST)
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver for
 Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, cw00.choi@samsung.com,
        krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
 <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
 <20201030125149.8227-3-s.nawrocki@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <2f243097-7b8c-9b39-989d-a36d226ecd23@linaro.org>
Date:   Tue, 3 Nov 2020 10:11:00 +0200
MIME-Version: 1.0
In-Reply-To: <20201030125149.8227-3-s.nawrocki@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

Thank you for refreshing the patchset!

On 10/30/20 14:51, Sylwester Nawrocki wrote:
> This patch adds a generic interconnect driver for Exynos SoCs in order
> to provide interconnect functionality for each "samsung,exynos-bus"
> compatible device.
> 
> The SoC topology is a graph (or more specifically, a tree) and its
> edges are specified using the 'samsung,interconnect-parent' in the
> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> propagated to ensure that the parent is probed before its children.
> 
> Each bus is now an interconnect provider and an interconnect node as
> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> registers itself as a node. Node IDs are not hardcoded but rather
> assigned dynamically at runtime. This approach allows for using this
> driver with various Exynos SoCs.
> 
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note
> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> case all interconnect API functions are no-op.
> 
> The bus-width DT property is to determine the interconnect data
> width and traslate requested bandwidth to clock frequency for each
> bus.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v7:
>  - adjusted to the DT property changes: "interconnects" instead
>    of "samsung,interconnect-parent", "samsung,data-clk-ratio"
>    instead of "bus-width",
>  - adaptation to of_icc_get_from_provider() function changes
>    in v5.10-rc1.
> 
> Changes for v6:
>  - corrected of_node dereferencing in exynos_icc_get_parent()
>    function,
>  - corrected initialization of icc_node->name so as to avoid
>    direct of_node->name dereferencing,
>  - added parsing of bus-width DT property.
> 
> Changes for v5:
>  - adjust to renamed exynos,interconnect-parent-node property,
>  - use automatically generated platform device id as the interconect
>    node id instead of a now unavailable devfreq->id field,
>  - add icc_ prefix to some variables to make the code more self-commenting,
>  - use icc_nodes_remove() instead of icc_node_del() + icc_node_destroy(),
>  - adjust to exynos,interconnect-parent-node property rename to
>    samsung,interconnect-parent,
>  - converted to a separate platform driver in drivers/interconnect.
> 
> ---
>  drivers/interconnect/Kconfig         |   1 +
>  drivers/interconnect/Makefile        |   1 +
>  drivers/interconnect/exynos/Kconfig  |   6 ++
>  drivers/interconnect/exynos/Makefile |   4 +
>  drivers/interconnect/exynos/exynos.c | 198 +++++++++++++++++++++++++++++++++++
>  5 files changed, 210 insertions(+)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c
> 
[..]
> +
> +static struct platform_driver exynos_generic_icc_driver = {
> +	.driver = {
> +		.name = "exynos-generic-icc",

I think that you will need this:
		.sync_state = icc_sync_state,

Thanks,
Georgi

> +	},
> +	.probe = exynos_generic_icc_probe,
> +	.remove = exynos_generic_icc_remove,
> +};
> +module_platform_driver(exynos_generic_icc_driver);
> +
> +MODULE_DESCRIPTION("Exynos generic interconnect driver");
> +MODULE_AUTHOR("Artur Świgoń <a.swigon@samsung.com>");
> +MODULE_AUTHOR("Sylwester Nawrocki <s.nawrocki@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:exynos-generic-icc");
> 
