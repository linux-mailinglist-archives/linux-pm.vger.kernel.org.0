Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06614AB742
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbfIFLjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 07:39:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50881 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389929AbfIFLjP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 07:39:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190906113913euoutp01d47c7331408e28298f447c1aa710f27f~B1ndrcnaF0537305373euoutp01Q
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 11:39:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190906113913euoutp01d47c7331408e28298f447c1aa710f27f~B1ndrcnaF0537305373euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567769953;
        bh=epZ2/nn61cU86rBoZ+pM3kR6r5TNU/gcgmeJYFybZcI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gJBn6caSNHZViW8Q+RQ60DEZY8LUZF+rwFH8aLr8GOm7Kvp3hAzQcJGXxFxYBfWqK
         hmjVV/WZsWxmxT/w7GPDW4TRLWAnkxo1w590a0jXRfL76IjWFAdRLTKJJtStoLPlrT
         bPUxUCU1hIuztzb49hCcystDJBH2wYPyHgtfl41U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190906113912eucas1p15a6d144b485f3d7f7e6ef803aebba111~B1nc2DRO72600726007eucas1p1P;
        Fri,  6 Sep 2019 11:39:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.BD.04309.065427D5; Fri,  6
        Sep 2019 12:39:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906113911eucas1p25b42a5f4d3846ca4eb676dc5f6067c68~B1ncBI_rh2032920329eucas1p2v;
        Fri,  6 Sep 2019 11:39:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190906113911eusmtrp2df4582dc73d9c4f1f222973a160704dd~B1nby5MDL1602816028eusmtrp2P;
        Fri,  6 Sep 2019 11:39:11 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-d0-5d724560316e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.AC.04117.F55427D5; Fri,  6
        Sep 2019 12:39:11 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190906113910eusmtip177b7d502ecf9cac3a446211bb2bf282c~B1nbCck9m1696716967eusmtip1S;
        Fri,  6 Sep 2019 11:39:10 +0000 (GMT)
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3
 memories
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <52963d0d-cf48-7085-5581-a94c6e15e0bd@partner.samsung.com>
Date:   Fri, 6 Sep 2019 13:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2Lo5mX9Pam4nC8I+K1C6CH2VWdGFUdiGCqLRWHVRyajvO
        LgapkNZqZVFmw64khWjznq6M2pYXrKYILdIutkKwVplWStrydIz87/c97/PyPg98HKVy00Fc
        cmoGb0jVpWgYhbyuadgVvmuVIX5e9+tQUllkpYl7sJcmV53PaHLG85EiLlcFS57mfmJJlec5
        TTptxQwZMDsRKXI9kJFy5yuWlLg7ZKQr5zZDjjU6WeL4lE+THy3v0DKsLbtShrQNllestqr0
        BKOtvnlUe7qmFGkHqkI2MtsUMXv5lORM3hAZu0uRNGz1oPSKgIO55RUoG3VPMSE/DnAUPLKa
        WBNScCp8G0F15RAjPQYR5F+3M6JLhQcQ+C4E/tu40/uBkky3ENz4ViuXTF4EQ/eiRQ7AW+DJ
        yV+syIF4NrhHf9LiAoXtciiyDctMiOMYHAH1pftFjxKvhjedjUiU5TgMvC2JojwNb4Vvbx20
        ZJkKrZfe/z3lhzeBvcT1NxuF1fDy/VWZxKFw11tMSTlzOOgxb5Z4JXS1FzMSB0Bfcw0rcTD4
        GqRdwAJkm68jiY+A58zlcc9icDR30GI0aqyK1RYpycvBZznHiDJgf3jhnSol8IdzdRcpSVbC
        8TyV5J4FNafaxw9Nh1tlhWwB0lgm9LJM6GKZ0MXy/+41JC9Fat4o6BN5YUEqfyBC0OkFY2pi
        xJ40fRUa+25tv5sH65FtZLcdYQ5pJivJCkO8itZlCof0dgQcpQlUWivT41XKvbpDh3lD2k6D
        MYUX7GgmJ9eolVmT3m5X4URdBr+P59N5w7+pjPMLykYFF9Iim6CBqo0564939IcYff2ThlpW
        tWdzPVl8YZ/iB/+wIDjO9rNVF5fpkJnPF35P5ksG1M4lyYuSfCmtHev6GkfC63vWL36w1F2e
        h0LCtoQnxAZ9iZusH124L3ptwPnor59dm9oeU4sScqNmhMo01H3VbnbDmqye3Mw5I/FzNXIh
        STd/DmUQdH8Aj7eSLWoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7rxrkWxBs3/VC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i6XXLzJZ
        3G5cwWbRuvcIu8XhN+2sFt9OPGJ0EPBYM28No8fOWXfZPTat6mTz2Lyk3qNvyypGj8+b5ALY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyfq5/
        zFiwQbiiae0GxgbGO/xdjJwcEgImEuueP2XuYuTiEBJYyiixYkMzO0RCTGLSvu1QtrDEn2td
        bBBFrxklfp96zwaSEBYIlTjT/RusSERAU+L63++sIEXMAodYJD5tPc4IkhAS6GOS6H2k38XI
        wcEmoCexY1UhSJhXwE3i/uW9jCBhFgEVibcn0kHCogIREod3zGKEKBGUODnzCQuIzSkQKHFo
        6XmwtcwCZhLzNj9khrDFJW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXF
        uem5xUZ6xYm5xaV56XrJ+bmbGIFRve3Yzy07GLveBR9iFOBgVOLhfeBQFCvEmlhWXJl7iFGC
        g1lJhHf9xoJYId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4HJpy8knhDU0NzC0tDc2NzYzML
        JXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MZzmnpBhNFl7KHljM+f/laq8XYrGFoX+NxdJN
        vRt4TjGL+W597/Xm3rpQkd63504b3BS0ZHW+03a9+bG2gqXihy3r13z/c3VzX9fPEk6h5P9n
        /7y5ad4469rfdzdtz2YstFMQ3sQ9e96zHzm5KqaL9stWRJfLvjG8MXGr69IraQtTAuSsmM0L
        lViKMxINtZiLihMBVcSENwADAAA=
X-CMS-MailID: 20190906113911eucas1p25b42a5f4d3846ca4eb676dc5f6067c68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190906101407eucas1p15eb0df53374b27497b4793eab24becf6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190906101407eucas1p15eb0df53374b27497b4793eab24becf6
References: <CGME20190906101407eucas1p15eb0df53374b27497b4793eab24becf6@eucas1p1.samsung.com>
        <20190906101344.3535-1-l.luba@partner.samsung.com>
        <20190906101344.3535-4-l.luba@partner.samsung.com>
        <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9/6/19 12:56 PM, Krzysztof Kozlowski wrote:
> On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
>> Minor fixes in the old documentation.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> index 3b2485b84b3f..de0905239767 100644
>> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
>> @@ -40,10 +40,34 @@ Child nodes:
>>     a given speed-bin. Please see Documentation/devicetree/
>>     bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
>>
>> +Samsung K3QF2F20DB LPDDR3 memory
>> +------------------------------------------------------------
>> +
>> +This binding uses the LPDDR3 binding (described above)
>> +
>> +Required properties:
>> +- compatible:  Should be:
>> +               "samsung,K3QF2F20DB"
>> +               followed by "jedec,lpddr3"
>> +- density  : <u32> representing density in Mb (Mega bits)
>> +- io-width : <u32> representing bus width. Possible value 32
>> +- #address-cells: Must be set to 1
>> +- #size-cells: Must be set to 0
> 
> If you decided to repeat all properties again, then it deserves its
> own bindings file. However I though about simpler solution - just
> document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
> There is not much benefit from copying all these properties.
OK, I see. I will add only 'compatible' and skip the rest then.
So the lpddr3.txt file will get this addition:

+Samsung K3QF2F20DB LPDDR3 memory
+------------------------------------------------------------
+
+This binding uses the LPDDR3 binding (described above)
+
+Required properties:
+- compatible:  Should be:
+               "samsung,K3QF2F20DB"
+               followed by "jedec,lpddr3"
+
+Optional properties:
+
+The optional properties are the same as in the LPDDR3 generic bindings and
+values should be taken from the data-sheet. Detailed bindings are described
+above.
+
+Child nodes:
+
+Detailed bindings are described in LPDDR3 generic bindings described above.
+

Is it OK?

Regards,
Lukasz
