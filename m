Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70C86153
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfHHMHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 08:07:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40423 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbfHHMHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 08:07:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808120705euoutp0164f03cea1ce4282c2a9bcd0103dbd0b9~48SghLkBC2616226162euoutp01F
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 12:07:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808120705euoutp0164f03cea1ce4282c2a9bcd0103dbd0b9~48SghLkBC2616226162euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565266025;
        bh=wTw/zSeiLhrpgMAmruYSw68EDrMJ/8vKBiwL047PITk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZD9Qby7HYzK2lC/Vjog5BsNSIQok+U2a79R4NfUYZ5OVWLZfcwlUnx0f647kw6yUO
         Knw+x+gXeRGmB+G9KZ8qdxXpn2yQCHWxWWnK5uDRw08HrL19Fzb/m/8vMc03shMpl7
         Y61oYV36bxW4+HvjPLjyHP+iDmbVJ8zRmUpIuCUs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808120704eucas1p27aa37a816849c9af2f5fddc64eccffdc~48Sf44cAI2249122491eucas1p2O;
        Thu,  8 Aug 2019 12:07:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.16.04469.8601C4D5; Thu,  8
        Aug 2019 13:07:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808120703eucas1p1a79a8e2eab56201d5bdf16bf674302db~48SfLFaJE1416214162eucas1p1k;
        Thu,  8 Aug 2019 12:07:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808120703eusmtrp1b9096581da07a64626585cf295b0c250~48Se8jPPA2071120711eusmtrp1T;
        Thu,  8 Aug 2019 12:07:03 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-0e-5d4c10681521
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.37.04166.7601C4D5; Thu,  8
        Aug 2019 13:07:03 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808120702eusmtip140fc4db0fc50f1d5d9b94f81dfd5dc16~48SeYg4pt0142001420eusmtip13;
        Thu,  8 Aug 2019 12:07:02 +0000 (GMT)
Subject: Re: [PATCH v2 1/9] soc: samsung: Add exynos chipid driver support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b3a31424-84ec-63d7-16ca-26333ad12123@samsung.com>
Date:   Thu, 8 Aug 2019 14:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfLBif-=09B9jZ3qN1kWdTAcrBQZGvZ+A-MUifXK4si9Q@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT2t3vv7nVs+nNaHuyFQ+wB+YCKC4a9ySzQiKAUqVte1NymbGpZ
        gVpoapqilY+MNJVsEepKDcWQOZ0mKdoyQXyhZQ8NUsPMV5tXyf++c77vfOd8cBhC3kC5MBHq
        GF6j5pQKsYSsbZ3r3B2OT4V4VbVI2er8Sop9Yuyk2KzRHwTb1VVFs/rRXor9UF8kZqczjYjN
        73orYl8aB2j2ac0MzSY3Gmn21XCr+KDUT69LE/u9Kkvwu/dah/ym9VsDySDJ/lBeGRHHazx9
        L0rCsxpzyegs6lr6XLEoEZWR6ciWAbwH3s0lEelIwshxBYLucTNtJeR4BsHQC3uBmEaQ9t6A
        1iZyar6JBOIZgorqMVooJhE01d21MAzjiP2hPFljHXDCO+HT4ixlxQQuJWDq8V4rFmNvyGy5
        h6xyGfaFFiNjbZPYDXQl6SvyDfgcTA03r2AZdoD2grGVq23xaTAWlJOCpTPcmnm+ar8N6iaL
        VtIA7qVhxNhPWP0BH4WRJGfhfkf4bnpNC3gzdORmkIL+NoKMhn5aKLIt6U3Fq4l9oNnUTVmN
        CEuYynpPoX0I+trGKMHfDvomHYQb7CCnNm91rQxSU+SC2g3mdXkiAbvA3bFlMhspCtclK1yX
        pnBdmsL/e4sRqUPOfKxWFcZrvdX8VQ8tp9LGqsM8Lkep9MjyUh1Lpqk36HfPJQPCDFJIZdFt
        J0PkFBenjVcZEDCEwkk2GHciRC4L5eKv85qoC5pYJa81oE0MqXCW3bAZDpbjMC6Gj+T5aF6z
        xooYW5dE9ODAuFl/7Ka9wTPz/N+ofWX2W45zgXUTf5ruyMx5E5CAvCIYLmDRN7gqxWZqhzRI
        fNjO4+yR0T5mY4pKmbFQWtD+sGvB33VWaTY1Lie5Gjzc08Rmu5yf24dCl5PuLw18vPLrc1NJ
        qddgUOrwsa9nHmkCRuZyp0skkV98jqrn3XsUpDac895FaLTcP8VQrehOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7rpAj6xBrObJCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss2vqF3aJ17xF2i80PjrE5
        8HhsWtXJ5rF5Sb1H35ZVjB6fN8kFsETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZfTvncxS0M9a0fVzAVMD4xKWLkZODgkBE4lJW18ydTFycQgJ
        LGWUeLLuEHMXIwdQQkpifosSRI2wxJ9rXWwQNa8ZJZ5fuMgEUiMs4CWxtLUIpEZEQFPi+t/v
        rCA1zAKLmSUurJ/PDtHQwSTRPBVkAycHm4ChRO/RPkaQZl4BO4mjRzhAwiwCKhKrFnaxgtii
        AhESh3fMYgSxeQUEJU7OfAJ2KKdAoMSRmUvBbGYBdYk/8y4xQ9jiEk1fVrJC2PIS29/OYZ7A
        KDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBkbjv2c/MOxksb
        gw8xCnAwKvHwFpzwjhViTSwrrsw9xCjBwawkwnuvzDNWiDclsbIqtSg/vqg0J7X4EKMp0HMT
        maVEk/OBSSOvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjRuS0
        ihWtOkdz1HSZ3aZJKC7f/+a8/0PTgD1p61+pncrKDpdMVA97o6wX+enVqw0/krwz2Sf9Ubr2
        6PHxko49UQtu1rxMSvgWsU7X2f9MVzK/1oSM7eJL2iaZehVKRC+e+7j9YKz6zSSzXpvPJwvv
        LPw8Zw3DkvU3FbjeTtGQ2HI2peTcwuaVSizFGYmGWsxFxYkA9u7/3OICAAA=
X-CMS-MailID: 20190808120703eucas1p1a79a8e2eab56201d5bdf16bf674302db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3
References: <CGME20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3@eucas1p1.samsung.com>
        <20190718143044.25066-1-s.nawrocki@samsung.com>
        <20190718143044.25066-2-s.nawrocki@samsung.com>
        <CAJKOXPfLBif-=09B9jZ3qN1kWdTAcrBQZGvZ+A-MUifXK4si9Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/23/19 14:57, Krzysztof Kozlowski wrote:
>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c

>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-chipid.c
>> @@ -0,0 +1,111 @@
>> +// SPDX-License-Identifier: GPL-2.0

>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>
> Any changes here from my previous comments?

Oops, I tried hard to not miss any of the comments but probably not hard enough.
The two above platform header files will be removed in v3.

-- 
Regards,
Sylwester
