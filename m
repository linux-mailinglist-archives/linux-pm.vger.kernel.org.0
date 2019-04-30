Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E228D101BD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfD3VYe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 17:24:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51170 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfD3VYe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 17:24:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190430212432euoutp02b0519bc365c7dc03c3ee50ae78747c03~aXYr5_dC11617016170euoutp02o
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 21:24:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190430212432euoutp02b0519bc365c7dc03c3ee50ae78747c03~aXYr5_dC11617016170euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556659472;
        bh=JOZLpmB1tmFont7oMkIPI2hxuxW5qxxPRMV6ScYkV90=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rAa6/+Ddxxi+lWpP7syKSvJYtv3/VUvx+mhLYaEh6lrNca2BcIPktmBEgS9HNDMSB
         kcqpaguKlOQy/w3hBWg70BVUCToCwQm1rZANI7gQWb5j611Y/2PlWWGdB8Msr/8pA2
         ZnTATpejv8PBdHir0wvAcXpl4gv6LqcZZEt0nr9Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430212431eucas1p248819b7788ae13f33d9dca8cafafc89a~aXYq8qs962985829858eucas1p2h;
        Tue, 30 Apr 2019 21:24:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.B5.04298.F0DB8CC5; Tue, 30
        Apr 2019 22:24:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190430212429eucas1p1d42dd180f478aa49bfd5419eab05b1a7~aXYpUI4ln0035200352eucas1p1u;
        Tue, 30 Apr 2019 21:24:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430212429eusmtrp1d7eefc8cbfabff6bb5ecd968797759d7~aXYpEesWJ2100921009eusmtrp17;
        Tue, 30 Apr 2019 21:24:29 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-17-5cc8bd0f1883
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.54.04146.D0DB8CC5; Tue, 30
        Apr 2019 22:24:29 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430212428eusmtip15666f96bbe9cfaf73cbcef92cde7c1d3~aXYoXqPVj1048010480eusmtip1w;
        Tue, 30 Apr 2019 21:24:28 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] DT: arm: exynos4412: add event data type which
 is monitored
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f8873863-9524-1ef0-9633-868edc3b56d3@partner.samsung.com>
Date:   Tue, 30 Apr 2019 23:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cee7b5a2-377e-59d6-7c6e-b6f9b3140d4f@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ2ZzrS1eKkIxxUokYCGIonGMRqXSLDKi76BYLTYCSCL2AFU
        1EjdQGQxaLRWENEq2OBWCqkmGC27CIhGMAXEWI2JQjRAXeISHUYib99/zn/u/c/NZQjVADWH
        SU7P5AzpulS1VE7Wt3zvCpvR0Ba/xPhExd413abYvvH3FFvR1EWxJe6PBNvdfYdmO48M06zN
        3Uuxz++XSdmxoibEmrofSNibTYM0e62vR8L2G6ul7PGGJpptHM6j2C9tb9BarK25VIO098yD
        tNZmPSnV1loOa4vtVqQdsy3YLN0qX6XnUpOzOUP46h3yJMdANZnRjPd9uXIK5SKXogDJGMBL
        YXi0hC5AckaFqxEc8wz+E+MIRq0WQhRjCFyXXNTkiH38Myk2qhBUOH5KRDGCoLzgqURwzcSx
        UDhciISGD25HUGQcpARBCGe1v+79KxhGijXgsO4RBpQ4Ct69eEwLTOKF8O76J1LgWTgGhlru
        UKLHG9ovvJ2oy/AayPt2ixCYwH7gelshEdkfjtZdnMgN2MiAp8wuFXNHwo3+YkLkmfCh1U6L
        PA86zhSSIvOQW1SJRD4I7pLyf56V0NjaM5GZwKFw+364WF4HDZ6HSCgD9oKXI95iBC8orT9P
        iGUl5J9Qie4QsBeKzwPYF6pqztGnkdo8ZTHzlGXMU5Yx/7/3MiKtyI/L4tMSOT4indur4XVp
        fFZ6ombn7jQb+vvnOn63jjqQ51mCE2EGqacrQza2xasoXTa/P82JgCHUPkpta3O8SqnX7c/h
        DLu3G7JSOd6J5jKk2k95YNrrOBVO1GVyKRyXwRkmuxJGNicXLZD3OFJGciWvKgPGD5mi+KE9
        o7DEop9b++vEjATTtL6AwJzQZINi+Qof03ziYie5K5KPDYw5G803hsTpg4Jmb9uUY4terygN
        rvuwOfGqvzPlVtijbMJTHRdkzMbAWGoVTstXWdWPTrfCcK44P7hu2dFlWzRHlvuGBsQvfv5z
        g5rkk3QRiwgDr/sDJWCXr28DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7q8e0/EGHzZqGCxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C0Ov2lntfh24hGjg4DHmnlrGD12zrrL7rFpVSebx+Yl9R59W1YxenzeJBfA
        FqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsePO
        CpaCowIV3xZ1MzYw3uLuYuTkkBAwkdjy5QMLiC0ksJRR4uO1Yoi4mMSkfdvZIWxhiT/Xutgg
        al4zSmzezdvFyMEhLBApcbCvoIuRi0NE4CSjxOwJf5lAHGaBz4wS09dcZgZxhASmMEn8ftPM
        DtLBJqAnsWNVIcggXgE3iadXT4EtYBFQlXi67D3YEaICERJn3q9ggagRlDg58wmYzSlgL9H+
        Yx0ziM0sYCYxb/NDKFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECIzqbcd+bt7BeGlj8CFGAQ5GJR7eC24nYoRYE8uKK3MPMUpw
        MCuJ8HocPxojxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAhJNXEm9oamhuYWlobmxubGah
        JM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFRKvHTw5fbO4MjE1LcLtXvDmZI3X+Pe25wgFp3
        zfKjujLelblnPxR831fDtrXv/LQqNdnc+n375zx/92pF57YTfDMmvGl6t0vWp+GV+N3D7bOE
        L313ePlDJf5890XxNotWH1PxzwdPau/PnSHygn9aslLG4fX/jQSXb4wPvHNUgKfjyf/U6v1F
        SizFGYmGWsxFxYkA7tpLnAADAAA=
X-CMS-MailID: 20190430212429eucas1p1d42dd180f478aa49bfd5419eab05b1a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134823eucas1p1ff852194b1db655ed2dbce72b5f7f3a6@eucas1p1.samsung.com>
        <1555681688-19643-5-git-send-email-l.luba@partner.samsung.com>
        <cee7b5a2-377e-59d6-7c6e-b6f9b3140d4f@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/30/19 8:10 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
>> The patch adds new field in the PPMU event which shows explicitly
>> what kind of data the event is monitoring. It is possible to change it
>> using defined values in exynos_ppmu.h file.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> index 3a3b2fa..549faba 100644
>> --- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>> @@ -6,12 +6,16 @@
>>    * Author: Chanwoo Choi <cw00.choi@samsung.com>
>>    */
>>   
>> +#include <dt-bindings/pmu/exynos_ppmu.h>
>> +
>>   &ppmu_dmc0 {
>>          status = "okay";
>>   
>>          events {
>>   	       ppmu_dmc0_3: ppmu-event3-dmc0 {
>>   		       event-name = "ppmu-event3-dmc0";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -22,6 +26,8 @@
>>          events {
>>   	       ppmu_dmc1_3: ppmu-event3-dmc1 {
>>   		       event-name = "ppmu-event3-dmc1";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -32,6 +38,8 @@
>>          events {
>>   	       ppmu_leftbus_3: ppmu-event3-leftbus {
>>   		       event-name = "ppmu-event3-leftbus";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>> @@ -42,6 +50,8 @@
>>          events {
>>   	       ppmu_rightbus_3: ppmu-event3-rightbus {
>>   		       event-name = "ppmu-event3-rightbus";
>> +		       event-data-type = <(PPMU_RO_DATA_CNT |
>> +					   PPMU_WO_DATA_CNT)>;
>>   	       };
>>          };
>>   };
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you, added to the patch.

Regards,
Lukasz
> 
> 
