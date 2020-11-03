Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F602A3FF4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 10:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgKCJ0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 04:26:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:36741 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCJ02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 04:26:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201103092624epoutp0243920f4f24248dac53092c4180f80b4e~D9Ui0gzfe0195501955epoutp02t
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 09:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201103092624epoutp0243920f4f24248dac53092c4180f80b4e~D9Ui0gzfe0195501955epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604395584;
        bh=xxXAuVLnvvEigU4dHlqA7WtN2zrSv6gHDky4J6f+6JA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FXMvHxB/FQNdSxeQJeGCnagUe0gnwgtRfR0JEC0CWPuLA51+TU2X+dbJKLgoKUj87
         Nu4qvHRamQGRsjJNT+evnwSkBo9QlZpvPp48/idLOpOjcoY4Z/tBmtysRMEZMhYstB
         NySVDOQ6k09x/M4B3It8PnpgeWKtllayiN8lh6jI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201103092624epcas1p25a0dd944a4e24d03cbdb234741610b1c~D9UiXsK_n1805818058epcas1p2S;
        Tue,  3 Nov 2020 09:26:24 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CQPY874l5zMqYkf; Tue,  3 Nov
        2020 09:26:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.4E.63458.C3221AF5; Tue,  3 Nov 2020 18:26:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201103092620epcas1p2c4bf8c4a69e2f328f0abceef7cbfb12d~D9Ue17KtO1053710537epcas1p2c;
        Tue,  3 Nov 2020 09:26:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103092620epsmtrp2654869d726a38db9c46bc7cb8cfbae7e~D9Ue1IVRh2378623786epsmtrp25;
        Tue,  3 Nov 2020 09:26:20 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-f9-5fa1223c8c62
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.C3.13470.C3221AF5; Tue,  3 Nov 2020 18:26:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201103092620epsmtip271da5f19f243cbbe70103a4aea3d2e18~D9Uej2plA0458704587epsmtip2e;
        Tue,  3 Nov 2020 09:26:20 +0000 (GMT)
Subject: Re: [PATCH v7 1/6] dt-bindings: devfreq: Add documentation for the
 interconnect properties
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        georgi.djakov@linaro.org, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2213a69c-1483-6840-28a4-ab7ca84d55bb@samsung.com>
Date:   Tue, 3 Nov 2020 18:40:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201030125149.8227-2-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmrq6N0sJ4g3kfzSzuz2tltNg4Yz2r
        xfwj51gtrnx9z2Yxfe8mNotJ9yewWJw/v4Hd4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7BZ
        tO49wm5x+E07q8WMyS/ZHPg9Nq3qZPO4c20Pm8f97uNMHn1bVjF6fN4kF8AalW2TkZqYklqk
        kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SukkJZYk4pUCggsbhY
        Sd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE748ffvSwF71Qr
        NiyYwN7A2CrXxcjJISFgIvHr/U7GLkYuDiGBHYwSb5c/h3I+MUp8PHSeHcL5xiix/uNfNpiW
        hm8vWCASexkltrSvgap6zyhx8M0vFpAqYYFUidnbNwF1cHCICMRIrH8XARJmFjjBJHHkjiCI
        zSagJbH/xQ2wofwCihJXfzxmBCnnFbCT2PFWGyTMIqAisWrmY7CJogJhEie3tTCC2LwCghIn
        Zz4Bi3MKWEssvfGICWK8uMStJ/OhbHmJ5q2zmUFOkxC4wSGx6sNFRogHXCTWLn/LCmELS7w6
        voUdwpaS+PxuL9ST1RIrTx5hg2juAHpy/wWoBmOJ/UsnM4EcyiygKbF+lz5EWFFi5++5jBCL
        +STefe1hBSmREOCV6GgTgihRlrj84C4ThC0psbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWj
        WGpBcW56arFhgRFyZG9iBKdkLbMdjJPeftA7xMjEwXiIUYKDWUmEtyZyXrwQb0piZVVqUX58
        UWlOavEhRlNgAE9klhJNzgdmhbySeENTI2NjYwsTQzNTQ0Mlcd4/2h3xQgLpiSWp2ampBalF
        MH1MHJxSDUyp9+9trDDx7eZ7a/GqIG7Kgb5Cxk5eOe401un/10oLC91jbryTqjtTsc84xefz
        u8b73iatSe+ceiLdQ46Yzz2eovSL4cYPmZi//NJ/76ncPLxaY6OJ6ScT1ZV/Xrc9EIiNl/h7
        5DvTFtv8Rf7sz6wm+139/EPlYVSJ1oYkm/0dl6b/+iA+OZP57rf6GfsZ7mvNvCy77b/zyqNt
        Cz6EiDjWnrow3yZ5yuI3Jx9t65H/NVcg4UDbzD/OUXfVZsrsn71ussXSHYf1UwTeT4jOklhw
        cE6s2XKTFbsYWLf4ZV3WS/53Vf3khtdW5QYtASf/ebE1Ll+7d3thwJaiWPvbF+Ldw5c0JeQf
        fMUTPznzkM8XJZbijERDLeai4kQAPZ7HGVIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK6N0sJ4gxuNChb357UyWmycsZ7V
        Yv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BucXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gs
        WvceYbc4/Kad1WLG5JdsDvwem1Z1snncubaHzeN+93Emj74tqxg9Pm+SC2CN4rJJSc3JLEst
        0rdL4Mr48XcvS8E71YoNCyawNzC2ynUxcnJICJhINHx7wdLFyMUhJLCbUWLpxBYWiISkxLSL
        R5m7GDmAbGGJw4eLIWreMkqceHOXCaRGWCBVYvb2TWwgtohAjMSpybPABjELnGCS+LjqARNE
        x35GidWbfoJVsQloSex/cQPM5hdQlLj64zEjyAZeATuJHW+1QcIsAioSq2Y+BjtCVCBMYueS
        x2DLeAUEJU7OfAIW5xSwllh64xFYnFlAXeLPvEvMELa4xK0n86Hi8hLNW2czT2AUnoWkfRaS
        lllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4PrU0dzBuX/VB7xAj
        EwfjIUYJDmYlEd6ayHnxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgt
        gskycXBKNTAFu3k6KbeaPf2/pftHYvFWF+OiuaeUzBUYZy14W9q04viUxLyDi7d7nvtrm7L/
        1dzw9E8PixvjG6V19W7+tHiyTeLqhbk6b0T8Z8xWXMuef271fsWSuYw/3C7+azE4lXzdxcB9
        q76w9P89xSeZBI9fUzl+wypDZObafhVl+RcPOK8wLud/fPaqhCHnhrfOt2Tm8zH2XwifOL1/
        vZbU+46irJaDkUvmrXZ5VJLM0Kq2xYbPxykjuWHjYfZfZ7af/tIxo+tN8pIdBw/2HnWN616+
        12c1x+mfpVG9IprLV4m1VGzX4SiYoPan9NUKXq9r/POD2R3eVAfx3DN+e2n3n6sT1hiU9Rmv
        P3ho7qQoo8mblViKMxINtZiLihMBqljVrD4DAAA=
X-CMS-MailID: 20201103092620epcas1p2c4bf8c4a69e2f328f0abceef7cbfb12d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125257eucas1p29c6b018cfcdda337b2b3d2a496f0c830@eucas1p2.samsung.com>
        <20201030125149.8227-2-s.nawrocki@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

This patch contains one typo.

On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> Add documentation for new optional properties in the exynos bus nodes:
> interconnects, #interconnect-cells, samsung,data-clock-ratio.
> These properties allow to specify the SoC interconnect structure which
> then allows the interconnect consumer devices to request specific
> bandwidth requirements.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
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
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> index e71f752..e34175c 100644
> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> @@ -51,6 +51,16 @@ Optional properties only for parent bus device:
>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>  			the performance count against total cycle count.
>  
> +Optional properties for interconnect functionality (QoS frequency constraints):
> +- #interconnect-cells: should be 0.
> +- interconnects: as documented in ../interconnect.txt, describes a path
> +  at the higher level interconnects used by this interconnect provider.
> +  If this interconnect provider is a parent of a top level interconnect
> +  provider the property contains only one phandle.
> +
> +- samsung,data-clock-ratio: ratio of the data troughput in B/s to minimum data

s/troughput/throughput

> +   clock frequency in Hz, default value is 8 when this property is missing.
> +
>  Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  - In case of Exynos3250, there are two power line as following:
>  	VDD_MIF |--- DMC
> @@ -135,7 +145,7 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
>  		|--- PERIC (Fixed clock rate)
>  		|--- FSYS  (Fixed clock rate)
>  
> -Example1:
> +Example 1:
>  	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
>  	power line (regulator). The MIF (Memory Interface) AXI bus is used to
>  	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
> @@ -184,7 +194,7 @@ Example1:
>  	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
>  	----------------------------------------------------------
>  
> -Example2 :
> +Example 2:
>  	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
>  	is listed below:
>  
> @@ -419,3 +429,57 @@ Example2 :
>  		devfreq = <&bus_leftbus>;
>  		status = "okay";
>  	};
> +
> +Example 3:
> +	An interconnect path "bus_display -- bus_leftbus -- bus_dmc" on
> +	Exynos4412 SoC with video mixer as an interconnect consumer device.
> +
> +	soc {
> +		bus_dmc: bus_dmc {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_DIV_DMC>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_dmc_opp_table>;
> +			samsung,data-clock-ratio = <4>;
> +			#interconnect-cells = <0>;
> +		};
> +
> +		bus_leftbus: bus_leftbus {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_DIV_GDL>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
> +			interconnects = <&bus_dmc>;
> +		};
> +
> +		bus_display: bus_display {
> +			compatible = "samsung,exynos-bus";
> +			clocks = <&clock CLK_ACLK160>;
> +			clock-names = "bus";
> +			operating-points-v2 = <&bus_display_opp_table>;
> +			#interconnect-cells = <0>;
> +			interconnects = <&bus_leftbus &bus_dmc>;

About adding two icc_node, I queried you on patch2.

> +		};
> +
> +		bus_dmc_opp_table: opp_table1 {
> +			compatible = "operating-points-v2";
> +			/* ... */
> +		}
> +
> +		bus_leftbus_opp_table: opp_table3 {
> +			compatible = "operating-points-v2";
> +			/* ... */
> +		};
> +
> +		bus_display_opp_table: opp_table4 {
> +			compatible = "operating-points-v2";
> +			/* .. */
> +		};
> +
> +		&mixer {
> +			compatible = "samsung,exynos4212-mixer";
> +			interconnects = <&bus_display &bus_dmc>;
> +			/* ... */
> +		};
> +	};
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
