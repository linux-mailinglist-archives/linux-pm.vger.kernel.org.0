Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992A33DE5FC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 07:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhHCFFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 01:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhHCFFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 01:05:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD11C061764
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 22:05:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so3111615pjh.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1x2eb6ArQwcke53LEN8sEzOMirAau5sq1TSi3sUCsY=;
        b=DAD9hD6clhuKpwr6lD/ftBB86FlJPFcaeGWcqGpbezF8x11hUauwJjYBYtgWpTkUE4
         ekMiL6uSzYSub/Fm2bcYDjHl2R96wJQ2EN4ZFJPtPf5Bb/DdW4nwnjfFRc7nn+kMpju0
         d/Q8MMNpte5V74V+nn5H0Oj4SHmd27ARSMfgTUnlaPiD8ajWiZUMGz0v6ffTqHd3CPns
         OjmeWF/RnGRxCUn813IkiM8u1HBMYfrHjm7ry0GLMPLUM56vKjYKFdi9z+XP/2Uwg7JQ
         Tt6ALJD5AZfATEbA86bZEbYTrn67HWfeUviDgNGBD/8Xd76PmQwVQIsG41ozOyQkx5Qf
         HuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1x2eb6ArQwcke53LEN8sEzOMirAau5sq1TSi3sUCsY=;
        b=s8hrnH0B6phwcB1nm2W+kgsR/z6gIQOl6ybkPjLXQTjri8xzW5fRwu7ZqLJH0xmWGy
         S2nUsNU4tUbH5G8oj1CSizm2tperKwsnbsYtc8k2+WvaLSWsmfwREJGSsqL50oinB+4+
         01usilhcE57BqeObSRq7i9kaSyznugIK1985DsvBtfxfhD25pdQF0UWsPnE6IXVSdLoz
         6PQLhOIfyaT20NTzR93o5v7CY7IILnZVJwGvOJlNCHHUP6AjVtruRcnFZXasmBd7G0ez
         To7HGVWeg0CgL+X4s2pi9MipEdAbsgAzL8vhR2wYJ3vrhFEw1atU74F7kJ+TYvU4oAql
         cSnA==
X-Gm-Message-State: AOAM532ZNhAWGyAArraQOdWPDT0+WppuosKv8T8V8mFeFUSd8bfaTf+m
        BMjnYfj5f/zRduwxF/LaxwK+Uw==
X-Google-Smtp-Source: ABdhPJwU4eUemoyxNXuECRUbX/OoxhUNMqe/MV3WYgB0tbaRQDpF/Pp0UeKo4qjqXyRbPmmiGibzQQ==
X-Received: by 2002:a62:606:0:b029:3b6:7e9a:fd2c with SMTP id 6-20020a6206060000b02903b67e9afd2cmr13151849pfg.24.1627967140745;
        Mon, 02 Aug 2021 22:05:40 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s7sm9910588pjg.34.2021.08.02.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 22:05:40 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:35:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20210803050538.g6aj2zsep735ywqv@vireshk-i7>
References: <1627574891-26514-1-git-send-email-hector.yuan@mediatek.com>
 <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627574891-26514-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-07-21, 00:08, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   70 ++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..6bb2c97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek's CPUFREQ Bindings
> +
> +maintainers:
> +  - Hector Yuan <hector.yuan@mediatek.com>
> +
> +description:
> +  CPUFREQ HW is a hardware engine used by MediaTek
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.
> +

Should this somewhere have a reference to
Documentation/devicetree/bindings/dvfs/performance-domain.yaml ?

> +properties:
> +  compatible:
> +    const: mediatek,cpufreq-hw
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Addresses and sizes for the memory of the
> +      HW bases in each frequency domain.
> +
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 1 for nodes
> +      providing multiple performance domains (e.g. performance controllers),
> +      but can be any value as specified by device tree binding documentation
> +      of particular provider.

You say this can have any value, 1 or more, but then ...

> +    const: 1

You fix it to 1 ?

Perhaps you should add a reference to the performance-domain.yaml here
as well, and say const 1 here and describe how the parameter is going
to be used. You should only explain it in respect to your SoC.

But I am not that good with Yaml stuff, I will let Rob correct me here
:)

-- 
viresh
