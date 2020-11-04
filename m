Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD822A6519
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgKDN1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 08:27:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44729 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgKDN1i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 08:27:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104132726euoutp0140104ddcc0baa0ebcbb8891d53098b7f~EUQRZ6-Eg1167311673euoutp01F
        for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2020 13:27:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104132726euoutp0140104ddcc0baa0ebcbb8891d53098b7f~EUQRZ6-Eg1167311673euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604496446;
        bh=oieoMezIQiMNV5YqAfnKGRVm058j0qgbcmHKQB7ZhZM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C3G0CwM6S5Upxt5SRyzrc/M1mNzKxVyPVhSJt2lCB7OhRmZYYoIK0XAiMswiGGaHp
         uMLKVGw/6L9s8t/kPYMTnc477nV7kB2BZ3KVRahVrRlRfDUR+Ha49I3WjJRTEtKrJZ
         dHhW0x1s9I8pjUT/9XvZd2VGxFJYU8Nh7PYcmSGI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201104132715eucas1p1db76eb64aef8abce39adb69752d91849~EUQHswlx80734507345eucas1p1q;
        Wed,  4 Nov 2020 13:27:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.0D.05997.33CA2AF5; Wed,  4
        Nov 2020 13:27:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201104132715eucas1p2ecb797ebb381ce4edf66f67680d7500a~EUQG_hUss1056010560eucas1p2g;
        Wed,  4 Nov 2020 13:27:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104132715eusmtrp1f533a233be927a45fbb2fddfee4e05e6~EUQG9s2k51807818078eusmtrp1m;
        Wed,  4 Nov 2020 13:27:15 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-74-5fa2ac3310bb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.C0.06017.33CA2AF5; Wed,  4
        Nov 2020 13:27:15 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201104132713eusmtip23508d058e272409090e63214ddf47f0e~EUQFqeAzw2190421904eusmtip2V;
        Wed,  4 Nov 2020 13:27:13 +0000 (GMT)
Subject: Re: [PATCH v8 3/7] MAINTAINERS: Add entry for Samsung interconnect
 drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <3fb7eb6b-6b3a-e170-92c3-910e31190d64@samsung.com>
Date:   Wed, 4 Nov 2020 14:27:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201104122719.GB10157@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut/vYVZpdl+LJomAYYaCmFl5IrKxoQoXRg4hKZ15U0mm7aZZE
        K5v5TpR0+UjTQluWOU3Md2YukW2Q71ZqtBCTktBILTOv18j/vvOd8/2+8x1+FCa1EM5UhPIi
        q1IqImWkLV7XOWty864sDdqWW+3OjNzTIKZaW0UwA9NjBFPcYSKY3h+TJJPXrCeZ7JEsnDGb
        n4kZ/ad+gulpKCSZqYwOxGjNLSLmSccHMWO5XkEymuYOMaPNGSd303K9LoWUv+9vIuUjaQaR
        vObBNXlmrQ7Jp/QbA8lTtr6hbGREHKvy8Au2DU81mImYOXH857JypEZGMhXZUEBvB/XH23gq
        sqWkdAWCvsJWUiimEehGM8VCMYUgRTOBpSJqSdKv8RP4cgSPytMw/ikp/R3BnVsneLyWPg7D
        neYl3oF2hYH5nwQvwOgyDBYKbhB8g6Q9IeN1JuKxhPYD61sjzmOcdoE3Q7+XsCN9FrKqb+LC
        jD103bXi/BI2tAc8LrnK0xjtBO+sxSIBb4LE5wUY7wX0dQo0lfUiIec+6KqtQQJeC18MtWIB
        b4DunHRcECQiSG+0iIUiC8GIoWRZsRPem+ZI3hlbjFPV4CHQe6Co7REuXMUOBr/aC0vYQXZd
        3vKxJJCcJBWmXeCXLm95HWdIsy7gWUiWvyJZ/oo4+Svi5P/3LUG4DjmxsVxUGMt5KdlL7pwi
        iotVhrmfi47So8Uv1/3HMF2PGn6HtCOaQrLVkra6+0FSQhHHXY5qR0BhMgeJv7H7rFQSqrh8
        hVVFB6liI1muHa2ncJmTxLt0/IyUDlNcZM+zbAyr+tcVUTbOapT88FXuzKHOA37dgeot+6uG
        E4oCmqzhL0Zn5nNvhE04qksNhS9Sjgb4zDYelO1wO73L/uuHQOdf3/paXCdaXqqM/r5jEqRc
        05OkRIOVc61PuRAifqH3mrqt1+nw6MxJ7ZHJzaYCuTbWddacdsHLx96SMDT0w2L3bl1C4eix
        4Pq9q2Q4F67w3IqpOMVfgEWs3G4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7rGaxbFG9zYz2pxf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLNo3XuE3WLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j36tqxi9Pi8SS6A
        LUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo+v4
        edaCX+wVTxcvZ2xgPMvWxcjBISFgInGt1a6LkYtDSGApo0Rzz3x2iLiUxPwWpS5GTiBTWOLP
        tS42iJr3jBJzvq9nB0kIC4RK3Dt2nhnEFhHQlLj+9zsrSBGzwGJmiYZXC5ggOp4xSjQeXMcE
        UsUmYCjRe7SPEcTmFbCTeHLpLAuIzSKgInHi5h8wW1QgTuLHxF42iBpBiZMzn7CAXMQpoC+x
        ekEtSJhZQF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArNQtI9C0nLLCQts5C0LGBkWcUoklpa
        nJueW2ykV5yYW1yal66XnJ+7iREY1duO/dyyg7HrXfAhRgEORiUe3gPbFsYLsSaWFVfmHmKU
        4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgQknryTe0NTQ3MLS0NzY3NjM
        Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD487lk559Zs/hmusQZfUhzzoncJdiwMu5tUv/
        CoSvOP57rvudGUlxa/ovRutzm/zdVvUsYKtQwryqEq0t6qtb+dsnO3pP/ZI5Ic9sQvYOkycG
        cfM274t+km7erFjS12x0MWPP4R2s4S3xex6c+/1XKaF9wt2HD+b0cCQzRcepG+icF7gRuojb
        WYmlOCPRUIu5qDgRACFlBbYAAwAA
X-CMS-MailID: 20201104132715eucas1p2ecb797ebb381ce4edf66f67680d7500a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5
References: <20201104103657.18007-1-s.nawrocki@samsung.com>
        <CGME20201104103722eucas1p1db939995e60d0bf2cd581070c14379f5@eucas1p1.samsung.com>
        <20201104103657.18007-4-s.nawrocki@samsung.com>
        <20201104122719.GB10157@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04.11.2020 13:27, Krzysztof Kozlowski wrote:
> On Wed, Nov 04, 2020 at 11:36:53AM +0100, Sylwester Nawrocki wrote:
>> Add maintainers entry for the Samsung interconnect drivers, this currently
>> includes Exynos SoC generic interconnect driver.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e73636b..4bbafef 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9156,6 +9156,13 @@ F:	include/dt-bindings/interconnect/
>>  F:	include/linux/interconnect-provider.h
>>  F:	include/linux/interconnect.h
>>  
>> +SAMSUNG INTERCONNECT DRIVERS
> 
> Does not look like ordered alphabetically.
 
>> +M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>> +M:	Artur Swigoń <a.swigon@samsung.com>
>> +L:	linux-pm@vger.kernel.org
> 
> Also:
> L: linux-samsung-soc@vger.kernel.org

>> +S:	Supported
>> +F:	drivers/interconnect/samsung
> 
> Add trailing /.

Fixed all issues, thanks for your review!

-- 
Regards,
Sylwester
