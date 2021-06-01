Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8E396B76
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhFACi4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:38:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:57613 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhFACiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:38:55 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210601023713epoutp0424b6a20ca6bbfdac54cbf388ac4ffab7~EVNOfvqdi0099200992epoutp04T
        for <linux-pm@vger.kernel.org>; Tue,  1 Jun 2021 02:37:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210601023713epoutp0424b6a20ca6bbfdac54cbf388ac4ffab7~EVNOfvqdi0099200992epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622515033;
        bh=gWSBCF//VShn2ZIk0VPAllrHceiAsfA/yNtcD2mOuPo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HhDLnCmqrGKG5v1hOXwpHGAeH2FvLeIRAGQzsT5hYabUvaDdzTvl/H2Pj8PzEUGyj
         IZ+CjQUxWIetB1LPY5kjv4zg8NbGmshQ9aRYi0jUBcxSymsqDXe1p8IKEEanzpMCWl
         slD+kp+T7GYA3UKDTcWHlha1QoyHc654LA8fzkjw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210601023713epcas1p474a233204d5db2d3d4ee1096a5bdd31c~EVNN-oWyi2648626486epcas1p4V;
        Tue,  1 Jun 2021 02:37:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FvGX51f4sz4x9Q3; Tue,  1 Jun
        2021 02:37:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.20.09736.55D95B06; Tue,  1 Jun 2021 11:37:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210601023708epcas1p1d15530bb3d2d73ccb604e3c7c181d2b1~EVNJrUoAl2489424894epcas1p1p;
        Tue,  1 Jun 2021 02:37:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210601023708epsmtrp13ed9c06337449e4c23f4ab78660fa658~EVNJqYlRg1970419704epsmtrp1G;
        Tue,  1 Jun 2021 02:37:08 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-2d-60b59d5584a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.99.08637.45D95B06; Tue,  1 Jun 2021 11:37:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210601023708epsmtip1bbdd820ecfe1d1ee4e8b8334f1f6120e~EVNJXsywb1104811048epsmtip1a;
        Tue,  1 Jun 2021 02:37:08 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6bfdbc0c-bda0-3d43-e103-4d0611966b47@samsung.com>
Date:   Tue, 1 Jun 2021 11:55:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210601022319.17938-2-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmgW7o3K0JBm/vslvMP3KO1WL1x8eM
        Fi2zFrFYnG16w25xedccNovPvUcYLTq/zGKzuNeyl9XiduMKNouzz7wtWvceYbf4uWseiwOP
        x85Zd9k9Nq3qZPPobX7H5tHTtonJo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD
        453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
        l9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnXJz4jq1gilXFxeebWRoY/+p0MXJy
        SAiYSGy7foypi5GLQ0hgB6PEnPYbjBDOJ0aJDS3fmSGcb4wSH87/Z4Fp6dk+DaplL6PEsb1N
        bBDOe0aJg6tms4JUCQuESrTcvgzWLiIwj0niRedEMIdZYCajxJQl+9lBqtgEtCT2v7jBBmLz
        CyhKXP3xmBHE5hWwk5h/qJUZxGYRUJF4cX8zE4gtKhAmcXJbC1SNoMTJmU/AbuIUMJN4+Gsb
        WD2zgLjErSfzmSBseYntb+eALZYQOMEhMW/iBKgnXCROXZrJBGELS7w6voUdwpaSeNnfBmVX
        S6w8eYQNormDUWLL/gusEAljif1LJwM1cwBt0JRYv0sfIqwosfP3XEaIxXwS7772sIKUSAjw
        SnS0CUGUKEtcfnAXaq2kxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBabI
        Eb6JEZyEtSx3ME5/+0HvECMTB+MhRgkOZiURXve8rQlCvCmJlVWpRfnxRaU5qcWHGE2BATyR
        WUo0OR+YB/JK4g1NjYyNjS1MDM1MDQ2VxHnTnasThATSE0tSs1NTC1KLYPqYODilGpjK+LM1
        23sZXbcs/LDHVbou7dDP/0EMr2Z7bbD42HpLl6FP5Kv008+50yf+Zbdf2qLOzWFie1+kzFdx
        9jzHj6JzLFdmyP7av/5Wst+f0r9dUfviJy+/NCHnxqZ/vy+ZPb0yrf/1JaWMI3LlTaGvFK/K
        bTxRe6Im2XbDWsHwN15aObxON5jLZti77VJm/FfkfTd9kaSM4upFotx77e5G2jyMq2F96l5y
        5K6f4cw+ht9yE7dvt0iJN/2RGdjPKbCSueC4iLvW/PMfcm8Hv3Zc8fBXFZvHdseFNs0JS2M3
        njhll9p///jynQ0HZd7e8DE9OvP3nAlnb5gavYv31PE1b9rI72egU/NTsp3Lf9rCe9pKLMUZ
        iYZazEXFiQDg+RJ3SwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG7I3K0JBg9eClnMP3KO1WL1x8eM
        Fi2zFrFYnG16w25xedccNovPvUcYLTq/zGKzuNeyl9XiduMKNouzz7wtWvceYbf4uWseiwOP
        x85Zd9k9Nq3qZPPobX7H5tHTtonJo2/LKkaPz5vkAtiiuGxSUnMyy1KL9O0SuDIuTnzHVjDF
        quLi880sDYx/dboYOTkkBEwkerZPY+pi5OIQEtjNKPG67RELREJSYtrFo8xdjBxAtrDE4cPF
        IGEhgbeMEg1NYCXCAqESLbcvM4PYIgKLmCQeXZEEmcMsMJNR4ndDPxvE0K2MEhP+vWAFqWIT
        0JLY/+IGG4jNL6AocfXHY0YQm1fATmL+oVawSSwCKhIv7m9mArFFBcIkdi55zARRIyhxcuYT
        sM2cAmYSD39tA6tnFlCX+DPvEpQtLnHryXwmCFteYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCy
        rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI5ELc0djNtXfdA7xMjEwXiIUYKDWUmE
        1z1va4IQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTKFP
        RH5nMvA4f6spK2C702Aqlv30Y32I2KuGEpUDD2XXNHGr75p1POfivhR3m91b7sdNNRW6FHTL
        u3zb2aTrGmmiL1vZ/uXeqL6f8nKqyCnNviVz6/ZsO+H+/N/yZH+eguuFtlX1365n9n273CK3
        P/HK0f6zgWmJRUU8afJ9km+Cl7/P8xbYYvnlkcWe/Hnhf4VbNScx1hVEuaq7ryv7LVPXXFP1
        +nH7/fpJeQXfXB/9i/wcPFXmy579/SIyFrev2pe2bt58fGqk+DSLV/Vr5HxeSTxukTQ99lnA
        KOZKV0Gww+sTpy67xl88x6N9gTHD+r6/yMrpZtFFUj39HzKbTyw+oLLKz2jFPYs1mmsOKrEU
        ZyQaajEXFScCAJLur3MzAwAA
X-CMS-MailID: 20210601023708epcas1p1d15530bb3d2d73ccb604e3c7c181d2b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210601022420epcas1p3bc087871724a7a9e7cc1569daa2631ab
References: <20210601022319.17938-1-digetx@gmail.com>
        <CGME20210601022420epcas1p3bc087871724a7a9e7cc1569daa2631ab@epcas1p3.samsung.com>
        <20210601022319.17938-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/1/21 11:23 AM, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra ACTMON binding to schema.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
>  .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
> deleted file mode 100644
> index 897eedfa2bc8..000000000000
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -NVIDIA Tegra Activity Monitor
> -
> -The activity monitor block collects statistics about the behaviour of other
> -components in the system. This information can be used to derive the rate at
> -which the external memory needs to be clocked in order to serve all requests
> -from the monitored clients.
> -
> -Required properties:
> -- compatible: should be "nvidia,tegra<chip>-actmon"
> -- reg: offset and length of the register set for the device
> -- interrupts: standard interrupt property
> -- clocks: Must contain a phandle and clock specifier pair for each entry in
> -clock-names. See ../../clock/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - actmon
> -  - emc
> -- resets: Must contain an entry for each entry in reset-names. See
> -../../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - actmon
> -- operating-points-v2: See ../bindings/opp/opp.txt for details.
> -- interconnects: Should contain entries for memory clients sitting on
> -                 MC->EMC memory interconnect path.
> -- interconnect-names: Should include name of the interconnect path for each
> -                      interconnect entry. Consult TRM documentation for
> -                      information about available memory clients, see MEMORY
> -                      CONTROLLER section.
> -
> -For each opp entry in 'operating-points-v2' table:
> -- opp-supported-hw: bitfield indicating SoC speedo ID mask
> -- opp-peak-kBps: peak bandwidth of the memory channel
> -
> -Example:
> -	dfs_opp_table: opp-table {
> -		compatible = "operating-points-v2";
> -
> -		opp@12750000 {
> -			opp-hz = /bits/ 64 <12750000>;
> -			opp-supported-hw = <0x000F>;
> -			opp-peak-kBps = <51000>;
> -		};
> -		...
> -	};
> -
> -	actmon@6000c800 {
> -		compatible = "nvidia,tegra124-actmon";
> -		reg = <0x0 0x6000c800 0x0 0x400>;
> -		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
> -			 <&tegra_car TEGRA124_CLK_EMC>;
> -		clock-names = "actmon", "emc";
> -		resets = <&tegra_car 119>;
> -		reset-names = "actmon";
> -		operating-points-v2 = <&dfs_opp_table>;
> -		interconnects = <&mc TEGRA124_MC_MPCORER &emc>;
> -		interconnect-names = "cpu";
> -	};
> diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> new file mode 100644
> index 000000000000..ba938eed28ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/v1/url?k=c852e9c6-97c9d0fb-c8536289-0cc47a31309a-748d620b8cc48f8b&q=1&e=c1b6a671-e53d-468c-81f5-3e23bd2e67d9&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdevfreq%2Fnvidia%2Ctegra30-actmon.yaml%23
> +$schema: https://protect2.fireeye.com/v1/url?k=1abc12fa-45272bc7-1abd99b5-0cc47a31309a-ca738d567d90525e&q=1&e=c1b6a671-e53d-468c-81f5-3e23bd2e67d9&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: NVIDIA Tegra30 Activity Monitor
> +
> +maintainers:
> +  - Dmitry Osipenko <digetx@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  The activity monitor block collects statistics about the behaviour of other
> +  components in the system. This information can be used to derive the rate at
> +  which the external memory needs to be clocked in order to serve all requests
> +  from the monitored clients.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra30-actmon
> +      - nvidia,tegra114-actmon
> +      - nvidia,tegra124-actmon
> +      - nvidia,tegra210-actmon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: actmon
> +      - const: emc
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: actmon
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interconnects:
> +    minItems: 1
> +    maxItems: 12
> +
> +  interconnect-names:
> +    minItems: 1
> +    maxItems: 12
> +    description:
> +      Should include name of the interconnect path for each interconnect
> +      entry. Consult TRM documentation for information about available
> +      memory clients, see MEMORY CONTROLLER and ACTIVITY MONITOR sections.
> +
> +  operating-points-v2:
> +    description:
> +      Should contain freqs and voltages and opp-supported-hw property, which
> +      is a bitfield indicating SoC speedo ID mask.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - interconnects
> +  - interconnect-names
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/memory/tegra30-mc.h>
> +
> +    mc: memory-controller@7000f000 {
> +        compatible = "nvidia,tegra30-mc";
> +        reg = <0x7000f000 0x400>;
> +        clocks = <&clk 32>;
> +        clock-names = "mc";
> +
> +        interrupts = <0 77 4>;
> +
> +        #iommu-cells = <1>;
> +        #reset-cells = <1>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    emc: external-memory-controller@7000f400 {
> +        compatible = "nvidia,tegra30-emc";
> +        reg = <0x7000f400 0x400>;
> +        interrupts = <0 78 4>;
> +        clocks = <&clk 57>;
> +
> +        nvidia,memory-controller = <&mc>;
> +        operating-points-v2 = <&dvfs_opp_table>;
> +        power-domains = <&domain>;
> +
> +        #interconnect-cells = <0>;
> +    };
> +
> +    actmon@6000c800 {
> +        compatible = "nvidia,tegra30-actmon";
> +        reg = <0x6000c800 0x400>;
> +        interrupts = <0 45 4>;
> +        clocks = <&clk 119>, <&clk 57>;
> +        clock-names = "actmon", "emc";
> +        resets = <&rst 119>;
> +        reset-names = "actmon";
> +        operating-points-v2 = <&dvfs_opp_table>;
> +        interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
> +        interconnect-names = "cpu-read";
> +    };
> 

If tegra maintainer confirms this patch, I'll take it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
