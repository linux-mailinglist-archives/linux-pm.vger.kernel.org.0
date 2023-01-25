Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62567BC88
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjAYU0s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 15:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjAYU0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 15:26:47 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6138EAC;
        Wed, 25 Jan 2023 12:26:47 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id r205so17309871oib.9;
        Wed, 25 Jan 2023 12:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUCUxnM4fltCEjdbRgGnFoZ2FChxWtP2zRjR6RLOGZE=;
        b=GS4WT/gfIzEZL5lduTpFehG52leEMioY5uhvNGFpEbxWrKe8aiu73rshq4Srqjy0xz
         qmbJ0cEH3jyQrABvznIl0Fbl9pvI+ZYq52oW4HK4y5A4GoHVbGqpG7qxnAeK05zzO+zw
         iaxFXeaDxPUQwEYdOnYuOyW90Txy6zo7/HdBdyLnkhsl1nlkUenpus94/nx9FKBzPZaz
         EJ4C+3+IpRSxmChgfpffm5WMVC1U/ew5xwzHvookz2XMJuRkWHmBr+RM/04MA2w3a/U8
         UWh5UPYQXofecEmVMjIqc5xlU72Neb3AiMvFT1fia38XsXqYPTFh414QGImB+k5kbz0W
         y+kg==
X-Gm-Message-State: AFqh2kqplt979XqMcXdQV70E1Cu60VIALnxe0Gvc9b/3rcoKikGRxrHS
        CpVvDOYFmzNU+ubWLEVO781edA7QdA==
X-Google-Smtp-Source: AMrXdXumTIhX79Oul+xZZxS/Cos8KzC0UI7XemfDhG7X855afR2V108W9pBkZExx/R7qA1AI/eWOAQ==
X-Received: by 2002:aca:2b13:0:b0:355:1e71:768 with SMTP id i19-20020aca2b13000000b003551e710768mr14816982oik.39.1674678406357;
        Wed, 25 Jan 2023 12:26:46 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l1-20020a056830154100b006619533d1ddsm2531782otp.76.2023.01.25.12.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:26:45 -0800 (PST)
Received: (nullmailer pid 2851915 invoked by uid 1000);
        Wed, 25 Jan 2023 20:26:45 -0000
Date:   Wed, 25 Jan 2023 14:26:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add Tegra234 BPMP thermal zones
Message-ID: <20230125202645.GA2849386-robh@kernel.org>
References: <20230124115119.21451-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124115119.21451-1-jonathanh@nvidia.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 24, 2023 at 11:51:18AM +0000, Jon Hunter wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
> 
> Add BPMP thermal zone definitions for Tegra234.
> 
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../thermal/tegra234-bpmp-thermal.h           | 19 +++++++++++++++++++

Match the compatible name please.

>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/thermal/tegra234-bpmp-thermal.h
> 
> diff --git a/include/dt-bindings/thermal/tegra234-bpmp-thermal.h b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
> new file mode 100644
> index 000000000000..41a5efebcc7a
> --- /dev/null
> +++ b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
> @@ -0,0 +1,19 @@

License? Dual please.

> +/*
> + * This header provides constants for binding nvidia,tegra234-bpmp-thermal.
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_TEGRA234_BPMP_THERMAL_H
> +#define _DT_BINDINGS_THERMAL_TEGRA234_BPMP_THERMAL_H
> +
> +#define TEGRA234_THERMAL_ZONE_CPU	0
> +#define TEGRA234_THERMAL_ZONE_GPU	1
> +#define TEGRA234_THERMAL_ZONE_CV0	2
> +#define TEGRA234_THERMAL_ZONE_CV1	3
> +#define TEGRA234_THERMAL_ZONE_CV2	4
> +#define TEGRA234_THERMAL_ZONE_SOC0	5
> +#define TEGRA234_THERMAL_ZONE_SOC1	6
> +#define TEGRA234_THERMAL_ZONE_SOC2	7
> +#define TEGRA234_THERMAL_ZONE_TJ_MAX	8
> +#define TEGRA234_THERMAL_ZONE_COUNT	9
> +
> +#endif
> -- 
> 2.25.1
> 
