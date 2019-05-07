Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE715FCC
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 10:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEGIwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 04:52:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51235 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfEGIwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 04:52:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190507085158euoutp01ed35884e9ea0d0b4e906f3e3bbcc0a53~cWomOBMcO0554805548euoutp01F
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 08:51:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190507085158euoutp01ed35884e9ea0d0b4e906f3e3bbcc0a53~cWomOBMcO0554805548euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557219118;
        bh=hetYVOToJg0L8UX37YH89VTY9OyLVzGKnQVcgxs3fCs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=enRXQFbkqTQ7wv5Icv15/kG8ltrg058kut/tHESagolQXMe1GXTJxW5EQ1lWVOH5U
         KmEXWp9LNGt4gR4IYPIL/P8VG8w0mjC4mNTo5s/Msh5Y8qY/niaYuexxBMRacQRMAv
         bt8mrDJ/tp9uQ0BnzHRops6UbFfRz9vWitkipxzE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507085157eucas1p13a10163bad5ffdf23b19d06f265281e2~cWolfNSeF2606426064eucas1p18;
        Tue,  7 May 2019 08:51:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9D.CF.04377.C2741DC5; Tue,  7
        May 2019 09:51:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190507085156eucas1p18bf86f975316494ca113fb8277142d5d~cWokwCP7s2608326083eucas1p1R;
        Tue,  7 May 2019 08:51:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190507085156eusmtrp168231ad756fde37810c7f65c3a97e2cc~cWokh1vAC2307323073eusmtrp1f;
        Tue,  7 May 2019 08:51:56 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1f-5cd1472c3e72
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.B2.04140.C2741DC5; Tue,  7
        May 2019 09:51:56 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190507085155eusmtip14d97314f14b9d9cd177f7b8dbe9d5b18~cWojxjZQt1697216972eusmtip1i;
        Tue,  7 May 2019 08:51:55 +0000 (GMT)
Subject: Re: [PATCH v7 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
Date:   Tue, 7 May 2019 10:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8b063f30-1a4d-3292-2e57-6e33e94d57ae@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O5edM3FyWqYvaWkrySKnScTXhW50mf3qV3QRculJJTdtRy1T
        YiWUWWoplU5thYm6DFOnTX8kTtG8KxlGJmnazdQIp9QUqXkW+e95n/d5eJ8HXpaUT9Kr2Rht
        Aq/TqmMVEleqrvV3T+CWI/1hwT+aMK7Kq6TxoO0LjY0tPTR++nMM4dyOIgJ33dLg7LHvJO7t
        fc7g7muTDH7dUCjBM5ktCOf1viTws5ZhBg9dLZPg5skbNG4cOIqH5t3x3KuPaJ9cNTebQ6kK
        9P2Uqt4wzKiqTTclqsy0aYkqy2xCqprOFNVM9dpj7CnX3ZF8bEwSrwvaE+4and5fysSX+Vz6
        WfCG1qN5zwwkZYHbBvr0QpSBXFk5V4YgI7eNFgcbAktVnnMzg6D5moX8Z7n7q4MSF6UIespL
        nJYpBC8sesKhWsmdBFORfcnuwRUjuFc+TzgGkntKwMLss78WlpVwSrCYLjgMMu4wtL9pohw0
        xW0A00Sog17FnYAPrc9pUbIC2vPHKQeWcnth1PJkiSc5L3g3biRE7AtptQWk4xRw+SwMGkeQ
        GPsglJXbCRGvhIk2MyNiH+jMvU2JWAB95mOnPhXGsoucml3Q3Na/FJnkNkFlQ5BI74eWsVrk
        oIFzh7dTK8QI7pBT94AUaRmkX5eL6gAw3+5zBvCE0or7zB2kMCwrZlhWxrCsjOH/3UeIMiEv
        PlHQRPFCiJa/qBTUGiFRG6WMiNNUo78/2LnYZrOghoWzVsSxSOEmu3OgL0xOq5OEZI0VAUsq
        PGTqzz1hclmkOvkyr4s7o0uM5QUr8mYphZcsxWXktJyLUifw53k+ntf92xKsdLUeKV2ka0j/
        hxX6gB2SUZ+TpcklVFqFL9Oxbr33OcHvvbwrlQg+3hfxNZIyCcZvBYRswHtOmh9qs/sPbtS2
        fmpGqVlYar/cNFzbGIEO7TRPzxnfu1m3K4uHayJLttprzOGNgYsVbH2w7QQTsqjtTpI9QVby
        SlWM4mpsnY9fuIISotVbN5M6Qf0HzN2T/H8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xu7o67hdjDE5t4rDYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyOi4uZy9YIVPxcfZV1gbG32JdjJwcEgImEhN/nGLpYuTiEBJYyijx
        +cM6NoiEmMSkfdvZIWxhiT/Xutggil4zSlz//40VJCEsECmxau4vRhBbRGAxo8TX1mqQImaB
        1UwSkz5ugeqYwiRx8ulc5i5GDg42AT2JHasKQRp4BdwkTl49yAISZhFQkVj1yhMkLCoQIXHm
        /QoWiBJBiZMzn4DZnAL2Eg93LAHbyyxgJjFv80NmCFtc4taT+UwQtrxE89bZzBMYhWYhaZ+F
        pGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIz8bcd+btnB2PUu+BCjAAej
        Eg/vA9sLMUKsiWXFlbmHGCU4mJVEeBOfnYsR4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5Hxg
        UsoriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cB4NrfxqXKh+M1C
        5x3yEfm3o42NXr/euWBi4yubDvG2/AV3JE1euyYVWyVFTxTraPzvdUtZ8PenhLSjKYkNejMv
        Lbov125wmEMh8Pvq7LQ3Mim7d07hm7Q1gZl7JbtKHvfFi+GMXyaLZyp4uNc8zl3EGWyW8iji
        io3X0hpTxq1q6ve/7MspO6TEUpyRaKjFXFScCADylnyFEgMAAA==
X-CMS-MailID: 20190507085156eucas1p18bf86f975316494ca113fb8277142d5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf@eucas1p1.samsung.com>
        <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
        <8b063f30-1a4d-3292-2e57-6e33e94d57ae@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/7/19 9:33 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>> index 355f469..bf50d8a 100644
>> --- a/include/dt-bindings/clock/exynos5420.h
>> +++ b/include/dt-bindings/clock/exynos5420.h
>> @@ -60,6 +60,7 @@
>>   #define CLK_MAU_EPLL		159
>>   #define CLK_SCLK_HSIC_12M	160
>>   #define CLK_SCLK_MPHY_IXTAL24	161
>> +#define CLK_SCLK_BPLL		162
>>   
>>   /* gate clocks */
>>   #define CLK_UART0		257
>> @@ -195,6 +196,16 @@
>>   #define CLK_ACLK432_CAM		518
>>   #define CLK_ACLK_FL1550_CAM	519
>>   #define CLK_ACLK550_CAM		520
>> +#define CLK_CLKM_PHY0		521
>> +#define CLK_CLKM_PHY1		522
>> +#define CLK_ACLK_PPMU_DREX0_0	523
>> +#define CLK_ACLK_PPMU_DREX0_1	524
>> +#define CLK_ACLK_PPMU_DREX1_0	525
>> +#define CLK_ACLK_PPMU_DREX1_1	526
>> +#define CLK_PCLK_PPMU_DREX0_0	527
>> +#define CLK_PCLK_PPMU_DREX0_1	528
>> +#define CLK_PCLK_PPMU_DREX1_0	529
>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>   
>>   /* mux clocks */
>>   #define CLK_MOUT_HDMI		640
>> @@ -217,6 +228,8 @@
>>   #define CLK_MOUT_EPLL		657
>>   #define CLK_MOUT_MAU_EPLL	658
>>   #define CLK_MOUT_USER_MAU_EPLL	659
>> +#define CLK_MOUT_SCLK_SPLL	660
>> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>>   
>>   /* divider clocks */
>>   #define CLK_DOUT_PIXEL		768
>> @@ -243,13 +256,16 @@
>>   #define CLK_DOUT_ACLK300_GSCL	789
>>   #define CLK_DOUT_ACLK400_DISP1	790
>>   #define CLK_DOUT_PCLK_CDREX	791
>> -#define CLK_DOUT_SCLK_CDREX	792
>> -#define CLK_DOUT_ACLK_CDREX1	793
>> -#define CLK_DOUT_CCLK_DREX0	794
>> -#define CLK_DOUT_CLK2X_PHY0	795
>> -#define CLK_DOUT_PCLK_CORE_MEM	796
> 
> The your previous patch didn't change the id number
> of already exiting clocks. It cause the fault.
> In order to keep the compatibility, you keep
> the original id number without modification.
True, the previous patch didn't change these IDs.
I have not seen any faults during builds and stress tests, though.
> 
> Please don't change the id number of the existing clocks
> and then just add the new clocks.
OK, I will add CLK_DOUT_PCLK_DREX0	and CLK_DOUT_PCLK_DREX1
at the end:
------------------>8--------------------------
@@ -248,8 +261,11 @@
  #define CLK_DOUT_CCLK_DREX0    794
  #define CLK_DOUT_CLK2X_PHY0    795
  #define CLK_DOUT_PCLK_CORE_MEM 796
+#define CLK_FF_DOUT_SPLL2      797
+#define CLK_DOUT_PCLK_DREX0    798
+#define CLK_DOUT_PCLK_DREX1    799

  /* must be greater than maximal clock id */
-#define CLK_NR_CLKS            797
+#define CLK_NR_CLKS            800
-----------------8<---------------------------

Can I add your ack in the modified version?

Regards,
Lukasz
> 
> 
>> +#define CLK_DOUT_PCLK_DREX0	792
>> +#define CLK_DOUT_PCLK_DREX1	793
>> +#define CLK_DOUT_SCLK_CDREX	794
>> +#define CLK_DOUT_ACLK_CDREX1	795
>> +#define CLK_DOUT_CCLK_DREX0	796
>> +#define CLK_DOUT_CLK2X_PHY0	797
>> +#define CLK_DOUT_PCLK_CORE_MEM	798
>> +#define CLK_FF_DOUT_SPLL2	799
>>   
>>   /* must be greater than maximal clock id */
>> -#define CLK_NR_CLKS		797
>> +#define CLK_NR_CLKS		800
>>   
>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
>>
> 
