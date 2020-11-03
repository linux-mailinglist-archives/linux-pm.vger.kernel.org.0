Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894DA2A4450
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgKCLcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 06:32:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36030 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgKCLcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 06:32:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201103113243euoutp01a751213567a1679badda3a6f05e4c2e5~D-C1KPl920569605696euoutp01w
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 11:32:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201103113243euoutp01a751213567a1679badda3a6f05e4c2e5~D-C1KPl920569605696euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604403163;
        bh=fReq/5gleB0cci52KJ0pEExEhZgxvPuj7W3jQgkJdxw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=i8x5TOUHnU8xa5Ck6fEa0cVA+SMV1W0JbEi3Bnl2asUlyTC8+qp8WxzIPe+kc+FPB
         b0IEShTPAu6YnhJ688l1mcRFvbZ4rEVkIvICWL7f7q/T1bt32+EnE8PrrteTaoTy6x
         pqn3kyXbTaUF1xBOXFKzaaknHRD0scbd6sJpHGIE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201103113236eucas1p25c4317debfce3dd093e24503f4a02295~D-CuDkbNN0380303803eucas1p25;
        Tue,  3 Nov 2020 11:32:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AB.82.06456.4DF31AF5; Tue,  3
        Nov 2020 11:32:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201103113235eucas1p282f0b782b066ea7aea385c0d85b53951~D-CtrFiAq0380303803eucas1p24;
        Tue,  3 Nov 2020 11:32:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103113235eusmtrp2154c224a1b462956fbf31e688ec94053~D-CtqTkmS3132631326eusmtrp2K;
        Tue,  3 Nov 2020 11:32:35 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-7c-5fa13fd4f2d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.14.06017.3DF31AF5; Tue,  3
        Nov 2020 11:32:35 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103113234eusmtip1455972894957538c7a51aa7381fdf5ff~D-CsrFtLb2256922569eusmtip1i;
        Tue,  3 Nov 2020 11:32:34 +0000 (GMT)
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver
 for Exynos SoCs
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     georgi.djakov@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <6cc9a2f8-9d9a-68b7-9f47-e16fefb18d88@samsung.com>
Date:   Tue, 3 Nov 2020 12:32:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <88af4e53-6c7a-c2e6-ad28-a9d6bb5bf623@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2fa6VApXgqkh4qCDYnFKEjEOIkr6kPji5j4YCQsFUdQaSUd
        QNAHF8CFijag7NLKTiOiiERBBEkBEVkiiAuQxogoGiFYwH2hHY28fef+57/n/MmhSWm/UE4f
        0MazOq06VkGJBfXtX3tWDmy6GrGqroRkrEVpiLmZWyNknk2/FTJGS4+QGZiZpJicplqKybQa
        BExv7w0R099QSDG2DAticnvvE0y1ZUTEDJ2spJi0JouIyc0apzYvVNWaz1Gq4cF7lMqq7yBU
        F+rMSGWrXRIi3CNev4+NPZDI6gI2Ropj2nrKUNygT9KHG53oBHrhmY6caMBBkJ3xk0hHYlqK
        KxG0XG8n7IIUTyOoNnvygg3BrE1P/nNUlhdTvFCBoG+6QsgXUwjyClJF9i43HAqvshocDnes
        hLyfA8jeROIZAs71mpBdoHAgZLRdcLAEb4SipwaHQYB9oe3NFcceHjgcDDdTBXyPK3TmjTrY
        CW+CiR+FDiaxDF6OGgmevSHldgFpHwZ4RgRlD8YQv/c2aDGf/pvBDd531Il49oLfd40Eb0hB
        cL5xSMQXBgTWDtNf9zoY7vk2l5qeG+EHNQ0BdgQcDE8sSh5d4PlHV34HF8iszyH5ZwmcPS3l
        //CF7+Ycgmc56Ed/CwxIkT8vWf68NPnz0uT/H2tCAjOSsQmcJprlArXsEX9OreEStNH+UYc1
        tWju1Lp+dXy6g2ae7G1FmEYKZ8lm1hQhFaoTuWRNKwKaVLhLtnR3hUsl+9TJR1nd4QhdQizL
        taJFtEAhk6wuHg+T4mh1PHuIZeNY3T+VoJ3kJ5BHbHBpNldapN+fZ6uWT+0yPgoJqpI1R0VG
        JqWPfCNWXi6R5nQLv5TLtT7iYpOLUTbW/Liy+bUrFR/Vdejaw3bnY96iGr/ZrXc2rAlfrjy4
        ULn9YOaOuDC9327/UC9j1YK1k+6XPh9bEdNcZT3l0nAmzPtWfcI7vLRv8cTFnY3By44rBFyM
        OnA5qePUfwDMfoauZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7qX7RfGG5xYpmpxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFvMmPySzYHfY9OqTjaPO9f2sHnc7z7O5NG3ZRWjx+dNcgGsUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZR88tZSy4plDxesNJ
        xgbGm5JdjJwcEgImEiuWLWLrYuTiEBJYyijxvuswaxcjB1BCSmJ+ixJEjbDEn2tdUDXvGSWO
        nt7OBlIjLBAtMfWDI0iNiICGxMy/VxhBapgFvjJJXN5/BarhC6PE7+uTGUGq2AQMJXqP9oHZ
        vAJ2EvOuTmAGsVkEVCSOPp3LBGKLCsRJ/JjYywZRIyhxcuYTFhCbU8Be4t2fOWA2s4C6xJ95
        l5ghbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMIq3Hfu5ZQdj17vgQ4wCHIxKPLwOqQvihVgTy4orcw8xSnAwK4nwOp09HSfE
        m5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAEk1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgfEQX843rliR7mvVoS3Vsnf1D189Z2/KJBy6oz/IksdysWEMs0FP
        cmaZ+KQvs1z2eN3NvXzveMDPhdGfF+/9lGDe5LjL2k3o+vxTVVdXHr31LnimoX/Fnrvz7pzU
        WSNwvmydxZ3om+fEjFY6F7sdM3M4daVNtWTjwcXqLo3H8o1OXdiRy8KXslOJpTgj0VCLuag4
        EQC6appF+AIAAA==
X-CMS-MailID: 20201103113235eucas1p282f0b782b066ea7aea385c0d85b53951
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
        <20201030125149.8227-3-s.nawrocki@samsung.com>
        <88af4e53-6c7a-c2e6-ad28-a9d6bb5bf623@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.11.2020 10:37, Chanwoo Choi wrote:
> On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
>> This patch adds a generic interconnect driver for Exynos SoCs in order
>> to provide interconnect functionality for each "samsung,exynos-bus"
>> compatible device.
>>
>> The SoC topology is a graph (or more specifically, a tree) and its
>> edges are specified using the 'samsung,interconnect-parent' in the
> 
> samsung,interconnect-parent -> interconnects?

Yes, I will rephrase the whole commit message as it's a bit outdated now.

I've changed the sentence to:
"The SoC topology is a graph (or more specifically, a tree) and its
edges are described by specifying in the 'interconnects' property
the interconnect consumer path for each interconnect provider DT node."

>> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
>> propagated to ensure that the parent is probed before its children.
>>
>> Each bus is now an interconnect provider and an interconnect node as
>> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
>> registers itself as a node. Node IDs are not hardcoded but rather
>> assigned dynamically at runtime. This approach allows for using this
>> driver with various Exynos SoCs.
>>
>> Frequencies requested via the interconnect API for a given node are
>> propagated to devfreq using dev_pm_qos_update_request(). Please note
>> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
>> case all interconnect API functions are no-op.
>>
>> The bus-width DT property is to determine the interconnect data
>> width and traslate requested bandwidth to clock frequency for each
>> bus.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>> +++ b/drivers/interconnect/exynos/exynos.c

>> +struct exynos_icc_priv {
>> +	struct device *dev;
>> +
>> +	/* One interconnect node per provider */
>> +	struct icc_provider provider;
>> +	struct icc_node *node;
>> +
>> +	struct dev_pm_qos_request qos_req;
>> +	u32 bus_clk_ratio;
>> +};
>> +
>> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
>> +{
>> +	struct of_phandle_args args;
>> +	struct icc_node_data *icc_node_data;
>> +	struct icc_node *icc_node;
>> +	int num, ret;
>> +
>> +	num = of_count_phandle_with_args(np, "interconnects",
>> +					 "#interconnect-cells");
>> +	if (num < 1)
>> +		return NULL; /* parent nodes are optional */
>> +
>> +	/* Get the interconnect target node */
>> +	ret = of_parse_phandle_with_args(np, "interconnects",
>> +					"#interconnect-cells", 0, &args);
>> +	if (ret < 0)
>> +		return ERR_PTR(ret);
>> +
>> +	icc_node_data = of_icc_get_from_provider(&args);
>> +	of_node_put(args.np);
>> +
>> +	if (IS_ERR(icc_node_data))
>> +		return ERR_CAST(icc_node_data);
>> +
>> +	icc_node = icc_node_data->node;
>> +	kfree(icc_node_data);
>> +
>> +	return icc_node;
>> +}
> 
> I have a question about exynos_icc_get_parent().
> As I checked, this function returns the only one icc_node
> as parent node. But, bus_display dt node in the exynos4412.dtsi
> specifies the two interconnect node as following with bus_leftbus, bus_dmc,
> 
> When I checked the return value of exynos_icc_get_parent()
> during probing for bus_display device, exynos_icc_get_parent() function
> only returns 'bus_leftbus' icc_node. Do you need to add two phandle
> of icc node?

Yes, as we use the interconnect consumer bindings we need to specify a path,
i.e. a <initiator, target> pair. When the provider node initializes it will
link itself to that path. Currently the provider driver uses just the first 
phandle.

> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -472,7 +472,7 @@
>                         clocks = <&clock CLK_ACLK160>;
>                         clock-names = "bus";
>                         operating-points-v2 = <&bus_display_opp_table>;
>                         interconnects = <&bus_leftbus &bus_dmc>;
>                         #interconnect-cells = <0>;
>                         status = "disabled";
>                 };

-- 
Regards,
Sylwester
