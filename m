Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEA229A707
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895136AbgJ0IyX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:54:23 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39919 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895135AbgJ0IyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:54:23 -0400
Received: by mail-ej1-f67.google.com with SMTP id bn26so1068738ejb.6;
        Tue, 27 Oct 2020 01:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pl76InKLYF2UwW9waAthO63zpy2TGEsyyfIicHpInyw=;
        b=kieuVls0MHnoY8T0ezMslg13UBPaOt5M1Jk1huNNVh5v1BfM8JHT7UabQX8UFvo/4m
         hAbDT3ky7mV/dKYx3a7l2ttWH2LlJe5ZDXh6BR7XhxzwyHwmbv28ZhFYvvAEwZVfRFKC
         CcVlc9O4w88D/O1LDMy5Qul/E8ecJtuxNxHtlMiWpmLNsy0290qz64N5jaebap3q/HUR
         eZZvxw6WkyJALTPJR3FImcmQxjGhQVEs5F94kmCRxb1L6AlUrAr7H/5I+aeGUocgEFqX
         wHN/5wFVgTusCA+TeuYNZFTqOEiRW//DmprNSt7nPMxCgrN7fcnzmCecUuN9EGoKWKZr
         chsw==
X-Gm-Message-State: AOAM531ig2VoO4phRloNS5AKclnBodDOXXONqv/igzRU2qoqTmoR+Laj
        XAha6rU8hq63TRVYzDJYas8=
X-Google-Smtp-Source: ABdhPJzmpTJ+ZcG8BezO09PSRSuSnCiQ/tWevDipQfx8F299/Gs4qAXSPmuMp8sWXOngl8h7jPxqAw==
X-Received: by 2002:a17:906:23f2:: with SMTP id j18mr1312596ejg.526.1603788861157;
        Tue, 27 Oct 2020 01:54:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id p9sm574643ejo.75.2020.10.27.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:54:20 -0700 (PDT)
Date:   Tue, 27 Oct 2020 09:54:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/52] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
Message-ID: <20201027085417.GD4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:47AM +0300, Dmitry Osipenko wrote:
> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> behind EMC and these controllers are tightly coupled. This patch adds the
> new phandle property which allows to properly express connection of EMC
> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> par with Tegra30+ EMC bindings, which is handy to have.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 567cffd37f3f..1b0d4417aad8 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -12,6 +12,7 @@ Properties:
>    irrespective of ram-code configuration.
>  - interrupts : Should contain EMC General interrupt.
>  - clocks : Should contain EMC clock.
> +- nvidia,memory-controller : Phandle of the Memory Controller node.

It looks like you adding a required property which is an ABI break.

Best regards,
Krzysztof
