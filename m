Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A35389B69
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhETCe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 22:34:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23520 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhETCe1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 22:34:27 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210520023208epoutp01ffcca2f79498bd17d07e8d404a1b52d1~ApZXaJ6NZ2984829848epoutp01d
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 02:32:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210520023208epoutp01ffcca2f79498bd17d07e8d404a1b52d1~ApZXaJ6NZ2984829848epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621477928;
        bh=0z8L6+esZ+fdPKTGSA3R6RXbOD4PWlYtDwkEUPIzxW0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dke2ndYdUv/qieItNC3p1+Ygc1Az+kg0MbWLv2q2Iv5yO3oVY1nX0CirNy7O8xl8m
         UQqi+2OjyvPhZX9pbWjz7AtE3cTNQIpQdiFGU+iiFPN0FwPdTtfcqW53sEeymxvVuT
         6CP1tyOvOwYhPg1t+4nSllI95ptvk/MeRdhhFLX0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210520023208epcas1p257cb3f5bde793858261ba45b0ebe23ba~ApZW2ii482775227752epcas1p2J;
        Thu, 20 May 2021 02:32:08 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Fltzm31LTz4x9Px; Thu, 20 May
        2021 02:32:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.C4.09578.42AC5A06; Thu, 20 May 2021 11:32:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210520023200epcas1p443a1564d05162e990e18b8217798eee2~ApZP16FlM2759827598epcas1p4l;
        Thu, 20 May 2021 02:32:00 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210520023200epsmtrp2310242c549d7f8aa3fe320be365df1c5~ApZP077DM2012320123epsmtrp2N;
        Thu, 20 May 2021 02:32:00 +0000 (GMT)
X-AuditID: b6c32a35-fcfff7000000256a-f5-60a5ca24dc79
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.B3.08163.02AC5A06; Thu, 20 May 2021 11:32:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210520023200epsmtip1109bc88cca48a6bb1ba7dbc026c33702~ApZPiP0K90874308743epsmtip1S;
        Thu, 20 May 2021 02:32:00 +0000 (GMT)
Subject: Re: [PATCH v1 3/7] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <16556bf1-1c31-a92f-a18e-c2fb536505e1@samsung.com>
Date:   Thu, 20 May 2021 11:50:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210510211008.30300-4-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmnq7KqaUJBvOaOCzmHznHarH642NG
        i5ZZi1gszja9Ybe4vGsOm8Xn3iOMFp1fZrFZ3GvZy2pxu3EFm8XZZ94WrXuPsFv83DWPxYHH
        Y+esu+wem1Z1snn0Nr9j8+hp28Tk0bdlFaPH501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QDcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzXv1bzlRwybKi+9BylgbGIzpdjJwc
        EgImEjMPL2LpYuTiEBLYwSgx8etERgjnE6PEi5eHmCCcz4wSVw89ZYdpufHlJguILSSwi1Hi
        6V0/CPs9UMf/TBBbWCBU4kzfaVaQZhGBQ0wS8yc0AY3l4GAWKJXYvcEGpIZNQEti/4sbbCA2
        v4CixNUfjxlBbF4BO4m9P3vYQcpZBFQlDqw3BwmLCoRJnNzWAlUiKHFy5hOwEzgFzCTmHF7F
        BGIzC4hL3HoyH8qWl9j+dg4zxMlHOCT6OkohbBeJf38vMkLYwhKvjm+BektK4vO7vWwQdrXE
        ypNH2EDOlxDoYJTYsv8CK0TCWGL/0slMEK9oSqzfpQ8RVpTY+XsuI8RePol3X3tYQUokBHgl
        OtqEIEqUJS4/uMsEYUtKLG7vZJvAqDQLyTezkHwwC8kHsxCWLWBkWcUollpQnJueWmxYYIgc
        1ZsYwYlXy3QH48S3H/QOMTJxMB5ilOBgVhLh3e69OEGINyWxsiq1KD++qDQntfgQoykweCcy
        S4km5wNTf15JvKGpkbGxsYWJoZmpoaGSOG+6c3WCkEB6YklqdmpqQWoRTB8TB6dUA9O0qVET
        NdaaFecLK51+GxG/fs2hDv5Hf5v9Xq8oEm07tU6QP6si72tG9e67Z+Ii2PRPcK94fvewSpzr
        orJJs2OED37P47q2eMejo6fv9B4o/N5vkLvetjCy6rNu6bsHe24a77t2bq5906y7/rtkTcze
        HTgWPp1pOmfiildxMk0VK1fkBsg+FNzocJdPVt9x4lmGm98PX8l/GP3s7ZOJyxNYS3MqvM0e
        HQpR2W6xYnf67FVMDqVsx3pWzf1xozzG1Gv1MjNu+fumqzq+nZM5fK80ytTtpXdfxmXbZveG
        ZUFWSd3H576IdDh4yj44ff3jA9bp1VrGLq6eW3vLnwhf0Sr7W3HEZfXEaJHjGl8bJ6orsRRn
        JBpqMRcVJwIAfspy+kUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnK7CqaUJBuebVCzmHznHarH642NG
        i5ZZi1gszja9Ybe4vGsOm8Xn3iOMFp1fZrFZ3GvZy2pxu3EFm8XZZ94WrXuPsFv83DWPxYHH
        Y+esu+wem1Z1snn0Nr9j8+hp28Tk0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBmv/i1nKrhk
        WdF9aDlLA+MRnS5GTg4JAROJG19usnQxcnEICexglLi8+BIzREJSYtrFo0A2B5AtLHH4cDFE
        zVtGiQsvOlhBaoQFQiXO9J0Gs0UEjjBJfOvxA7GZBUolnm1sZ4Ro2Moo8f7xPrAiNgEtif0v
        brCB2PwCihJXfzxmBLF5Bewk9v7sYQdZxiKgKnFgvTlIWFQgTGLnksdMECWCEidnPmEBsTkF
        zCTmHF7FBLFLXeLPPIibmQXEJW49mQ8Vl5fY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVT
        C4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC41BLawfjnlUf9A4xMnEwHmKU4GBWEuHd7r04
        QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamg60/3vzn
        fR++f66lwZuVJ+w17hw+arvt63S1y9tOqf6amjPr4mz5/EflUe096vYqgS/FzsTFZj2/mXI7
        W1uuODzPq/mQwLf1UivkVpk4GXT0GHCuPWnIYBFSLLr48/vy1cHe4awqxfY7P3DUMPz0DFBj
        7fz8/OIz9Xsqonuzp12sVP2Z/DZmb0uVvc35XYHXwn4/f9RZ+qlYc4Vn6LZOpS8q6/d1XjFg
        DZ61VzIg9dN0387/u71XfnZs0ZnL15R0acIv4/W2W4+IFM3a3NGy89HTZOf6mXrJbJvfbbXe
        7FPQf2XD2otpospb3CVVmNY+3rpGUiWiZ/bKbYUpEzc9yIie89Sq402r/fLQLm0bJZbijERD
        Leai4kQAZeQQ1TIDAAA=
X-CMS-MailID: 20210520023200epcas1p443a1564d05162e990e18b8217798eee2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210510211159epcas1p3c8ffedf8ffd1a34aa6960058eed2c379
References: <20210510211008.30300-1-digetx@gmail.com>
        <CGME20210510211159epcas1p3c8ffedf8ffd1a34aa6960058eed2c379@epcas1p3.samsung.com>
        <20210510211008.30300-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/11/21 6:10 AM, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra ACTMON binding to schema.
> 
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
> index 000000000000..2a940d5d7ab4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/v1/url?k=45c89d0a-1a53a410-45c91645-000babff24ad-23dabc3fb0c14687&q=1&e=3278a7b6-8f85-494f-a1fa-d926c45f4529&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdevfreq%2Fnvidia%2Ctegra30-actmon.yaml%23
> +$schema: https://protect2.fireeye.com/v1/url?k=f9f2037e-a6693a64-f9f38831-000babff24ad-e0e7e870e2aea6e2&q=1&e=3278a7b6-8f85-494f-a1fa-d926c45f4529&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
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
> +      memory clients, see ACTIVITY MONITOR section.
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

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

After tegra SoC maintainer review this patch, I'll take it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
