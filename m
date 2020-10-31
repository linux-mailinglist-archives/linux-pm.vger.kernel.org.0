Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477A42A1746
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgJaMRx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 31 Oct 2020 08:17:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40829 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJaMRx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 08:17:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so5173096wmj.5;
        Sat, 31 Oct 2020 05:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WKzF1aaYbnVmrdWhOCJIvuCVQXHEwFndydQ7LCQLM48=;
        b=uMrXN3jhJacu5R/EzUuTLunep6fgZSHIlfPz/e7IPwkaCwsQjQJmA3ZEHUXd8XkXF1
         Nd53PpnRSVmBCkO4PhrsiJ2r9pDo/e4voDtvB5f8dZp/VWNf6//M5r7m+q/fyLADDTv9
         vWpllHbmDrXDE7WgHPS/6Y00JjYa0CqYb0b0asvZnUE1jW4fv4GkNLi79rHDE57mQjZh
         /vBcaj+TUIlVS1A5/aZwTxT4F4p/6dGVpazggZiDPTAE9zzdvBX7xslRLWvUAdW3V/t9
         sT6MzVvuPQsqBQpvStpxm2g+wgtk9Wpd9aRdWvY4jDrufPWmQkj1ySPCkgoZBXJp7OJr
         ZHcQ==
X-Gm-Message-State: AOAM530y3wsuLAaiV2zrxzcb4q2C0ltIUo/p2X986SWmOOuk9e15sdks
        cjYEL6kSVInr2IVKtEj+f426W+WcGlXzGg==
X-Google-Smtp-Source: ABdhPJxtVxlOWJenfMblp90f/+WbEdzV8cTky1eQNG/79J3aKlrJViN3Ma99nExe5hJCGVj0D/9hNw==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr2090447wma.91.1604146670479;
        Sat, 31 Oct 2020 05:17:50 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r18sm15981833wrj.50.2020.10.31.05.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 05:17:49 -0700 (PDT)
Date:   Sat, 31 Oct 2020 13:17:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver for
 Exynos SoCs
Message-ID: <20201031121747.GB9399@kozik-lap>
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
 <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
 <20201030125149.8227-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201030125149.8227-3-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 01:51:45PM +0100, Sylwester Nawrocki wrote:
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

How about naming the directory as "samsung"? I don't expect interconnect
drivers for the old Samsung S3C or S5P platforms, but it would be
consisteny with other names (memory, clk, pinctrl).

How about adding separate maintainers entry for the driver with you and
Artur (if he still works on this)?

Best regards,
Krzysztof


