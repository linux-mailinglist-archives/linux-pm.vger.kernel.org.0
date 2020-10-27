Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07A929A729
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408021AbgJ0JCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:02:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38548 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407613AbgJ0JCS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:02:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id bc23so610972edb.5;
        Tue, 27 Oct 2020 02:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yy8mpli12VbJ5JLskCF8LxLYU5O/pRr6aZZScegInuc=;
        b=SqlDgisesqolOtI2dy/ENh3LanAjiPfkJ0XqDKenMokuSGvqNh8B4ZkxO0JTJf8Nx3
         822DsJ3XroZj06+KLjFeuNOfX6g7uXWcJeztK8A4+A60yeUXD82mX+/IVE5LhC0vHXRK
         di6HBsqea+gxB6g8U8LLqbZ/wIuZM/sBwQjNNXe7YnowE7/6gF51I5MH0yB//oK/Xkyk
         OVI2/GiKMfi3qQZWc/PfhA0OLfKEElaxg+mtJq7dUAdHiY1SigE3llqYPixQoM9tF1PE
         WkUPf4x8ZCaLYMiBkY2xoPNYPu8nAGSr+dIsfechB4LLyFzsEmoCbPoQzC0WzDjJEJId
         0Q6g==
X-Gm-Message-State: AOAM5305LxFyNaRCW9ssi7epgNFdL3Zt7xjH+gkeR9fOB/xUZKc5+/+b
        mJDPEs/JD6ilzqPzhi1jSec=
X-Google-Smtp-Source: ABdhPJyQzsFsuzcSltesuym9LKHSYVZWlMr0dq392E04psYkjmxzcSL6mq0PR1/lxApk19ZIsIN9OA==
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr1183592edp.342.1603789336363;
        Tue, 27 Oct 2020 02:02:16 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id q3sm525786edv.17.2020.10.27.02.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:02:15 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:02:12 +0100
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
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
Message-ID: <20201027090212.GG4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-9-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:51AM +0300, Dmitry Osipenko wrote:
> External Memory Controller can gather various hardware statistics that
> are intended to be used for debugging purposes and for dynamic frequency
> scaling of memory bus.
> 
> Document the new mfd-simple compatible and EMC statistics sub-device.
> The subdev contains EMC DFS OPP table and interconnect paths to be used
> for dynamic scaling of system's memory bandwidth based on EMC utilization
> statistics.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.txt | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> index 8d09b228ac42..382aabcd6952 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
> @@ -4,7 +4,7 @@ Properties:
>  - name : Should be emc
>  - #address-cells : Should be 1
>  - #size-cells : Should be 0
> -- compatible : Should contain "nvidia,tegra20-emc".
> +- compatible : Should contain "nvidia,tegra20-emc" and "simple-mfd".

Changing a compatible match is another break of ABI, unless it is not
really required. It's unclear to me from the contents of the patch.

>  - reg : Offset and length of the register set for the device
>  - nvidia,use-ram-code : If present, the sub-nodes will be addressed
>    and chosen using the ramcode board selector. If omitted, only one
> @@ -17,7 +17,8 @@ Properties:
>  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
>  - operating-points-v2: See ../bindings/opp/opp.txt for details.
>  
> -Child device nodes describe the memory settings for different configurations and clock rates.
> +Child device nodes describe the memory settings for different configurations and clock rates,
> +as well as EMC activity statistics collection sub-device.
>  
>  Example:
>  
> @@ -31,17 +32,34 @@ Example:
>  		...
>  	};
>  
> +	emc_bw_dfs_opp_table: emc_opp_table1 {

Hyphens for node name.

Best regards,
Krzysztof
