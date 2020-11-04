Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A52A6435
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 13:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKDMZT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 4 Nov 2020 07:25:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54849 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgKDMZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 07:25:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id d142so2142655wmd.4;
        Wed, 04 Nov 2020 04:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HuTwun2Dnd4h1S4X8KEOzU34Qd2VWJJ944RQvE10wwg=;
        b=CkRA4RYBe3wfhNh8vKIjOuPytIPr70lD03GExpVux5ezXlXIhVlUnrIeFV75GUTQTy
         TKOSv5AmhC0DyWPZstRoLlVqN7ndkdbAYyXez7BYO4TwC9h+Yab8HjEmsILtcfyUJEEe
         Xx0Wf3tmRH1C3/Wks4gxPY11ajTwzn0S96K8LKQtWLuMf92JTkxGxQjbPjRoN0wOX0NU
         4yW0S0DDGabrMvOExiawC+2bdFtGh146MXNAaXJ6ML7E67W7U2b8M82OwLCVEacyhRAa
         3/CGzCwAnYDKKfJkEzIR28HYVA1jTF19FvjB2SCE+V3s0wjEn27zS1a5P4dvqe5u8Wv2
         Vf9g==
X-Gm-Message-State: AOAM530xyoMQ6EE5XApfo0QIUNJIhFM7pXmU9jR3xwcrIaIVIxHtFaUE
        PaCnZ1oWFWSa4YJJd9zNcBo=
X-Google-Smtp-Source: ABdhPJwBZQBsDfz4trT0usXpkjYiPOZwSlK8h5bhMyUCxVi8CreHalUXc9dIF1MFkOTWPFzwF6p2Zw==
X-Received: by 2002:a1c:b387:: with SMTP id c129mr4540134wmf.66.1604492716841;
        Wed, 04 Nov 2020 04:25:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n4sm2017844wmi.32.2020.11.04.04.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:25:15 -0800 (PST)
Date:   Wed, 4 Nov 2020 13:25:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/7] dt-bindings: devfreq: Add documentation for the
 interconnect properties
Message-ID: <20201104122514.GA10157@kozik-lap>
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
 <CGME20201104103718eucas1p1c103f1a96499b03c72e5457ac2542c3d@eucas1p1.samsung.com>
 <20201104103657.18007-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104103657.18007-2-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 11:36:51AM +0100, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> interconnects, #interconnect-cells, samsung,data-clock-ratio.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v8:
>  - updated description of the interconnects property,
>  - fixed typo in samsung,data-clk-ratio property description.
> 
> Changes for v7:
>  - bus-width property replaced with samsung,data-clock-ratio,
>  - the interconnect consumer bindings used instead of vendor specific
>    properties
> 
> Changes for v6:
>  - added dts example of bus hierarchy definition and the interconnect
>    consumer,
>  - added new bus-width property.
> 
> Changes for v5:
>  - exynos,interconnect-parent-node renamed to samsung,interconnect-parent
> ---
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 71 +++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 2 deletions(-)

I already acked it and there are no signigicant changes from v7.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
