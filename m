Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF117571
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfEHJu0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 05:50:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49426 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfEHJu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 05:50:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508095024euoutp029668196ee50731d997e1f8fdae89b132~crE52ZL7i1960619606euoutp02Y
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 09:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508095024euoutp029668196ee50731d997e1f8fdae89b132~crE52ZL7i1960619606euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557309024;
        bh=Ywi1wkeJuVFQ+t8gnUtKE7QRvdv9GhMOIUul9O7s9So=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NDnVQO1NQuYCY7nT5Fo+rtnd5JVlVMfe8DdpEeFDBg7JZBwGmEItcWL2D6IXaGCfI
         i9LVk5M212dTJF4UcOXZf8SRciMaJ1zBc0VTpJQlZNcrglqsIi0cLdtwMbUHg7gpu7
         gKvI8fozTlICiMkRtNrbHRlluJpvM285F0RpHPKY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508095023eucas1p2be99a06cecee4919cc5206474b562b19~crE4401tP2451924519eucas1p2U;
        Wed,  8 May 2019 09:50:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 00.EA.04298.E56A2DC5; Wed,  8
        May 2019 10:50:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190508095022eucas1p1cb92b51986b599f4e5c2c09bd27de96c~crE4E853Y0352903529eucas1p1h;
        Wed,  8 May 2019 09:50:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190508095022eusmtrp2b73f9c8c9b80d7f26f94e97802984405~crE32toPU1994219942eusmtrp2M;
        Wed,  8 May 2019 09:50:22 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-78-5cd2a65e5d69
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.97.04140.D56A2DC5; Wed,  8
        May 2019 10:50:21 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190508095020eusmtip263acdd83163621e120bbd1929e98478b~crE26CqsQ2603426034eusmtip28;
        Wed,  8 May 2019 09:50:20 +0000 (GMT)
Subject: Re: [PATCH v7 11/13] ARM: dts: exynos: add syscon to clock
 compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <8d02ef2c-c5dd-6a72-9638-d858df3ea16d@partner.samsung.com>
Date:   Wed, 8 May 2019 11:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ2ZzoCWDGU7onFpMFGjIATxJhoV1yIv+KQiIlUnQKQFO4Ky
        mKDEBQRBUQtlUwnWoIZFwuoWqBRZrBRicUFRUJTNaMEF41YGI2//Oec7+c9/cxlCOki5MuGq
        g5xapYiQiW3JysbvxqXBV01By951eeOyrBIKm0f7KVygf0Th6596Ec5szhPh1tNKnN47SGCj
        sZTGbceGaNxRmyvGljQ9wlnGuyJ8U99N4+dHr4lxw9BJCt/r3IKf/7DDX5reoLVS+Zexc6Q8
        J7GdlNdou2l5eXGyWJ6WNCKWn6koRvJbLfFyS/mcACbQdtU+LiI8hlN7rA6xDWvLHEZR39jD
        mq6bdCJKlqQghgHWG9JHY1OQLSNlryEYaUgXCcUogm+vXyGhsCAwt5SJU5DNxMYLnY4WBjoE
        F8czxEIxjOBJTxNlpRzYAKgazySt2pFdBOafXykrRLBlJFRV19JWczHrDtXFB6yMhN0EAy9b
        J3iSdYPT5y3Iqp3Y7fCqsZQSGHt4mN03wdiwWyHninmCIVgXeNZXIBL0XKgaziWsXsBmM1B0
        /zoSzt4AFq2JFLQDDBgqaEHPht81wjKwPCSmXZ7kE6A3PW+SWQkNhnbKejPxN0xJrYfQ9oXb
        ulJKeEc76Bq2F06wg3OVGkJoS+DUCalAL4SK1MeTRs6gu3GRzkAy7ZRg2ilhtFPCaP/7XkJk
        MXLhonllKMd7qrhD7rxCyUerQt33RirL0d8v2PLL8LkajZn21COWQbIZkvdR7UFSShHDxyrr
        ETCEzFFiPmsKkkr2KWLjOHXkbnV0BMfXo1kMKXORxE/r2SllQxUHuf0cF8Wp/01FjI1rIqpL
        CkxqN33Q978bO3rc7Uj+2tEHmqf9riEJ0Z6HBgN/3xpY7hnsm/qzw/GqqjT35a7N2HeFt8zP
        P9RYOD9j/ceSeRdeLNjRvaJgM9WpaTgfbhP8dluBzn98Zp0hWFvi96soPmz6niQ/n/yPcV7N
        G+3XOecXan1O3VmTsCTAa2h5SNUuJxnJhyk8FxNqXvEH90Mqkn4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7qxyy7FGJxbaWOxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlnJ38lrHgh0DF9Btr2RsYO3m7GDk5JARMJO4sX84OYgsJLGWUuH5N
        ASIuJjFp33Z2CFtY4s+1LrYuRi6gmteMEj/2vWcFSQgL+Emcmr0ZzBYR0JS4/vc7K0gRs8BG
        FomLr3qZIDqWM0ksm/qHuYuRg4NNQE9ix6pCkAZeATeJV/fOsIDYLAIqEt1TPjOC2KICERJn
        3q9ggagRlDg58wmYzSkQKDF70XWwGmYBM4l5mx8yQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDI33bs55YdjF3vgg8xCnAw
        KvHwvii4GCPEmlhWXJl7iFGCg1lJhPf6xEsxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwP
        TEp5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYZ3heU54QmrxY
        dF0AU9Z14fcfHLoy7k4rnfWePf2KlYZH7uINojee7Tz0e1/oIqPkgOerXDcfXHTs+11em8ab
        XzRW8L1T5ztufZnPuctwQput9t81ivl7zgcIRZ942td5KFoizHZR0JUaYbu/ry8rMgeyyMZe
        bEheHGGwbMGmgCZxrt6Zk1w6lViKMxINtZiLihMBKxn/OxIDAAA=
X-CMS-MailID: 20190508095022eucas1p1cb92b51986b599f4e5c2c09bd27de96c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2
References: <CGME20190506151219eucas1p2feab00f7b7c1c5fdd5614423fb38eae2@eucas1p2.samsung.com>
        <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <1557155521-30949-12-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPd6GKVPixMiG37SoHiswaih-3S+o7QJn=WbuqdZzu-s_w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/8/19 9:22 AM, Krzysztof Kozlowski wrote:
> On Mon, 6 May 2019 at 17:12, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> In order get the clock by phandle and use it with regmap it needs to be
>> compatible with syscon. The DMC driver uses two registers from clock
>> register set and needs the regmap of them.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5800.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
>> index 57d3b31..0a2b328 100644
>> --- a/arch/arm/boot/dts/exynos5800.dtsi
>> +++ b/arch/arm/boot/dts/exynos5800.dtsi
>> @@ -17,7 +17,7 @@
>>   };
>>
>>   &clock {
>> -       compatible = "samsung,exynos5800-clock";
>> +       compatible = "samsung,exynos5800-clock", "syscon";
> 
> What about Exynos5420 DTSI?
OK, I will also add it to 5420 dtsi.
--------------------------8<------------------------------------------
diff --git a/arch/arm/boot/dts/exynos5420.dtsi 
b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..d9203f0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -173,7 +173,7 @@
                 };

                 clock: clock-controller@10010000 {
-                       compatible = "samsung,exynos5420-clock";
+                       compatible = "samsung,exynos5420-clock", "syscon";
                         reg = <0x10010000 0x30000>;
                         #clock-cells = <1>;
                 };
diff --git a/arch/arm/boot/dts/exynos5800.dtsi 
b/arch/arm/boot/dts/exynos5800.dtsi
index 57d3b31..0a2b328 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,7 +17,7 @@
  };

  &clock {
-       compatible = "samsung,exynos5800-clock";
+       compatible = "samsung,exynos5800-clock", "syscon";
  };
----------------------------->8-----------------------------------

Can I add your ack after that?

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
>>   };
>>
>>   &cluster_a15_opp_table {
>> --
>> 2.7.4
>>
> 
> 
