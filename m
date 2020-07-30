Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B122331FF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgG3M2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 08:28:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47211 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgG3M2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 08:28:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200730122821euoutp0280605b9e7ebbf9bcf8f0caa9a020326e~mh3-77SmW2885828858euoutp02X
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 12:28:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200730122821euoutp0280605b9e7ebbf9bcf8f0caa9a020326e~mh3-77SmW2885828858euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596112101;
        bh=tPSQqM65USa2+bVxBO4NArkt40afTFNoTXwqqkbLnBk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MAbNtK2Bs0sVsSqi9f8mypAeerjxMtcjvwQcPceAxij5eNkk41aAmffk51bWeB68R
         dtL8vUtyTHQz2+/SqPJqFw0tjadz02pRSIFZUQsRQ4KIh73a+1x27qo/LHeLMj8t0m
         LGB0TZid+sKAwQwvbZdVY1oejo9Am+gtangSsIpU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200730122821eucas1p180f3c9a08f3ebf68b9415e26bdfa404d~mh3-kOryC2255322553eucas1p1h;
        Thu, 30 Jul 2020 12:28:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.B5.05997.5ECB22F5; Thu, 30
        Jul 2020 13:28:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200730122820eucas1p11e7d3107b447fb0db19c6070c40f6807~mh3-JCeMB1440914409eucas1p17;
        Thu, 30 Jul 2020 12:28:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200730122820eusmtrp2f3aa1a75b1ff97a7f7d8ce02d76d68b9~mh3-HV2ll0062200622eusmtrp2Q;
        Thu, 30 Jul 2020 12:28:20 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-0f-5f22bce5d07f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.B5.06017.4ECB22F5; Thu, 30
        Jul 2020 13:28:20 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200730122819eusmtip2f5aada00e302856eacee883d0fdd524a~mh3_EbwOQ1715917159eusmtip27;
        Thu, 30 Jul 2020 12:28:19 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation
 for interconnect properties
To:     Rob Herring <robh@kernel.org>, georgi.djakov@linaro.org
Cc:     cw00.choi@samsung.com, krzk@kernel.org, devicetree@vger.kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
Date:   Thu, 30 Jul 2020 14:28:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709210448.GA876103@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsuFp8rsI3iy7D6K7Zhb4wxEJkBEE/KkNLW3lQSafsqGV/
        nFlq3hILtHVRU8gmpm15yamRqEsqJ11HagvS0iginYHmJc+Okf+e93mf53vf5+XjKNUA483F
        6pJ4vU4bp2YVdEPXhH3bUIs6cnvuwCLivHMZkYcltQx57/rKkNKOHoa8Gf/JkuJWM0uKnIU0
        sdvr5MT8+R1DXjffYslYfgciJfY2GanpGJCTvvQqlsy2NMlJybURNghrzKYrrKb/XQurceba
        ZBpLZZqm4JEJacbMqw+zYYp9UXxcbAqv9ws8pYjJs/ayib9XnH812k4bkG15DvLgAO+CmeEy
        JgcpOBWuQvDZnj5fuBA8mxlCUjGGwGL4Otfh3JZxh0ri7yG4fjV73vELQd1DFyO+uxTHwERj
        HiviZTgAqh3faVFE4UsU5I9UI7HBYn/I7yxwYyUOhMn8j7SIabweCp1P3Xg5joDakUaZpPGE
        7huDbt4Db4WGJ43uYRT2gg+DpTIJr4GM+puUOAzwtBxupA/IpaTBMGS5zUh4KXyzPZrnV8Hs
        Y9EsGjIQ5Fn75FJRiMBpK0OSKgD6eyZZ8QAU3gS1zX4SvR/qZh/LpLssAccPT2mJJVDUUExJ
        tBKyM1WS2gf+mIplEvaG3MFZuhCpjQuiGRfEMS6IY/w/twzRJuTFJwvx0bywQ8ef8xW08UKy
        Ltr3TEK8Gc19uuczNlcTap463Y4wh9SLlWt16yJVjDZFSI1vR8BR6mXKAy+fR6iUUdrUC7w+
        IVKfHMcL7WglR6u9lDvvjpxU4WhtEn+W5xN5/b+ujPPwNiDDQRyVPawPGnI0tiq0bRut4Sc2
        qG6GWzTHTFNru2t66o1hw8dN90PqbUddb8n1EIv1Z2eW/Vaqj2MysXLRp6QTO6dzvtQQ+Q8u
        be+n3VMVKX6G0PLcii0tTuue3tbR2EMPIuSezqYj5V8iLr4YbRO6Dnt3ZmnGMoMDQp3+bxJi
        1bQQo/XfTOkF7V+3TgYJcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7pP9ijFG1y4ZmBxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLP4v2cHu8WMyS/ZHAQ8Nq3qZPO4c20Pm8f97uNMHpuX1Hv0bVnF6PF5k1wA
        W5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRs/u
        C2wF3yQrLn06xNLAeFy0i5GDQ0LAROLrDaEuRi4OIYGljBLHDv5jhYhLScxvUepi5AQyhSX+
        XOtig6h5zyjx9/wUNpCEsECGxLJ9LxhBbBEBa4nVN96wgBQxC7QwS3ydNIMJouMho8SEh4/A
        qtgEDCV6j/aB2bwCdhK/eu+xgNgsAqoSE+4fBLNFBeIklm+Zzw5RIyhxcuYTsDingI7Etv3b
        WUFsZgF1iT/zLjFD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFu
        em6xkV5xYm5xaV66XnJ+7iZGYFxvO/Zzyw7GrnfBhxgFOBiVeHgV8hTjhVgTy4orcw8xSnAw
        K4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cCUk1cSb2hqaG5haWhubG5sZqEk
        ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgfFYgEeSe7nnmYIsSVOn+9f+7jUsNOv1Ufd4vMDx
        urj6lEv/3764rhHgaSoQULr6n9DpnqP9j87tDW8NvRzltlrExfTt91ZTVWeROZ0ec6RVP/Tn
        hz3Y/H71TqsLhxXLLSw3tBzzypHavpMp7OjMm44cUW0q/NGvJnnJScy3ZpqyeULi/sse65VY
        ijMSDbWYi4oTAWMBGHQBAwAA
X-CMS-MailID: 20200730122820eucas1p11e7d3107b447fb0db19c6070c40f6807
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
        <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
        <20200702163724.2218-2-s.nawrocki@samsung.com>
        <20200709210448.GA876103@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09.07.2020 23:04, Rob Herring wrote:
> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>> Add documentation for new optional properties in the exynos bus nodes:
>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>> These properties allow to specify the SoC interconnect structure which
>> then allows the interconnect consumer devices to request specific
>> bandwidth requirements.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 68 +++++++++++++++++++++-
>>  1 file changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index e71f752..4035e3e 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -51,6 +51,13 @@ Optional properties only for parent bus device:
>>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>>  			the performance count against total cycle count.
>>  
>> +Optional properties for interconnect functionality (QoS frequency constraints):
>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>> +  passive devices should point to same node as the exynos,parent-bus property.
> 
> Adding vendor specific properties for a common binding defeats the 
> point.

Should we make it then a common interconnect-parent property? Perhaps allowing
also a second cell after the phandle to indicate the target interconnect id?

Currently the links are only being defined in drivers, I'm not sure if we want 
to go that direction and extend the interconnect binding so it is possible
to define any link between the nodes.

With the samsung,interconnect-parent property there was an assumption that
each DT node ("samsung,exynos-bus" compatible) corresponds to an interconnect 
provider with single interconnect node. The source and destination node id 
for the link were unspecified and dynamically allocated by the driver.

I guess we don't want a property that would contain pairs of the interconnect 
node specifiers (phandle + interconnect id) to define all links, since usually 
additional data is required per each link.

Then perhaps we could make the new interconnect-parent property applicable
only to DT nodes with #interconnect-cells == 0, i.e. valid only in such DT 
nodes?

>> +- #interconnect-cells: should be 0.
>> +- bus-width: the interconnect bus width in bits, default value is 8 when this
>> +  property is missing.
> 
> Your bus is 8-bits or 4-bits as the example?
Bus width might not be a good term for the intended purpose of that property.
It has been added to specify minimum bus clock rate required for given data
throughput. After checking the documentation again the AXI bus width is
actually 128 bits everywhere for instance. The example defines data path 
leftbus <- dmc <- (memory) and for leftbus we have bus-width=<8> and for dmc 
bus-width=<4>. 

Perhaps it's better to use a vendor specific property instead, e.g.
samsung, data-clock-ratio?

-- 
Thanks,
Sylwester
