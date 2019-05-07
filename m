Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93597160D4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEGJZ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 05:25:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52281 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfEGJZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 05:25:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190507092525euoutp0253bf07812192383a1a5ffc6713393dcc~cXF0S2aYj0331803318euoutp02L
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 09:25:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190507092525euoutp0253bf07812192383a1a5ffc6713393dcc~cXF0S2aYj0331803318euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557221126;
        bh=dB+e2yrRh4QWNuV04t7a1d5E5ggX5TKGj86c7YDqDwY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rFmCGa/z8wWMtc1sMbraKn6s7StHoNJFXZSg1xZ7Hyvys1iA9AjNZxwHiWVch3xqC
         BdPpp7Gm5mE9zPJo2NZ7xg6a74a8+82T8qSC6sNeLNEil6S9Pvoho0PFs6eZiVgrVx
         pOZBY2RWoajG4IsZaXBAYsOSMR+UbkN3TsUFjlY4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190507092525eucas1p22aa50e61cefb7cbeaa20193174475e49~cXFziqM8f1247712477eucas1p2C;
        Tue,  7 May 2019 09:25:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 12.85.04377.40F41DC5; Tue,  7
        May 2019 10:25:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190507092524eucas1p20bdd1319a20df133d656ce1b7932a5ce~cXFypbLUF1030410304eucas1p2P;
        Tue,  7 May 2019 09:25:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507092523eusmtrp27af9be321ccedbfe7d126bf0001eca29~cXFybNd8T2025120251eusmtrp24;
        Tue,  7 May 2019 09:25:23 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-5f-5cd14f04f2dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.7A.04146.30F41DC5; Tue,  7
        May 2019 10:25:23 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507092522eusmtip2067e1bc04156a115241aa01517a2c12f~cXFxfK_XN0483604836eusmtip2L;
        Tue,  7 May 2019 09:25:22 +0000 (GMT)
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
Message-ID: <eab8fd90-7075-3f7b-5634-553fdf32f546@partner.samsung.com>
Date:   Tue, 7 May 2019 11:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e808eb3a-9fbe-897d-ce25-cab732581391@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURjtzntv3tMaub40PyqSplWjsU262G4LQ0QG0aJJ9bKXSo7WPJc2
        ymxxyWkxXBozCyNzKtwl/dGig+aSoyRUimWOZGQppgmWbTNPyX/nfud895wDH0fxPcxULjQ8
        UtSHC2FqpSNdVj1sWUj7NQcuqvu1gBRm5DPk9WA3Q7LNjQx50G9F5HpdloI0XNKRK9Yeilgs
        BSx5GfeFJa8qbirJgMGMSIbliYI8MrezpO3sfSWp+hLPkKctm0nbTycy9KITreW1Q99TaG1m
        bDOtLTe2s9oiU6JSazjXq9ReLjEhbXH9Se1A0YxtXIDjyoNiWGi0qPdavd8xpH3kAnukZfqx
        9ic5VCy65paEHDjAy+CZNU+RhBw5Ht9HMDyUTdsIHg8iqC2cKRMDCDqShxVjG73melomchEk
        G+KR/PiK4P2LfNammoz9wZT1w0644BwEqXk/7SYUfqCAke+PmCTEcUqsgcemo7YFFd4EnfEG
        xoZpPBsMN1rt2BXvhvfVBYyscYbaG132fA54DZT130M2TGE3aO3KVsjYHc6VZlI2L8CpHPwu
        6lPYvABvgMy3vnKFyfC5poSV8XT4U549Wk2CWMMdJONTYL2SNapZAVU1zfbIFPaA/AovebwO
        zNZSJP/uBG++OssJnCClLJ2SxypIuMjL6vlQktw0ajQFch+msVeR2jiul3FcF+O4Lsb/vrcR
        bUJuYpSkCxalJeFijEYSdFJUeLAmKEJXhP6dYP3vmsHHqGLkQCXCHFJPUl31bQrkGSFaOq6r
        RMBRaheV8LExkFcdFI6fEPUR+/RRYaJUiaZxtNpNdXJCxx4eBwuR4mFRPCLqx1gF5zA1Fk0I
        mCF9+EambZwUkFu3d8POtO6slbnbAt2pvZsKq6N3HUp/2HM+0fP26Yb17hajf/Ec1nV1wpkQ
        q7f+5vPevDM+Qaoq7y0L58b1XVZGbl/O93fMW9pYGX/LOyZ01jsPHz/vHXO6u139T0cJhRq/
        lolYszV1TfOC2lUJYXdx4yfpVmmdmpZChMWelF4S/gLOddAifgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4PV1m/4sxBl8Wm1lsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxeE37awW+694Wdz+zWfx7cQjRgchj29fJ7F4zG64yOKxc9Zddo9NqzrZPHqb
        37F59G1Zxeix+XS1x+dNcgEcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZd/+0shdckam4u28xcwPjRPEuRk4OCQETiXdHTrN0MXJxCAksZZRo
        +HKMHSIhJjFp33YoW1jiz7UuNoii14wSu36uYgFJCAtESqya+4sRxBYRWMwo8bW1GqSIWWA1
        k8Skj1ugOtqYJU4d2wzUwcHBJqAnsWNVIUgDr4CbxKP2XlYQm0VARaJ35i0wW1QgQuLM+xUs
        EDWCEidnPgGzOQXsJbZ9XAa2jFnATGLe5ofMELa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScss
        JC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERj724793LyD8dLG4EOMAhyMSjy8
        D2wvxAixJpYVV+YeYpTgYFYS4U18di5GiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBaSmv
        JN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjhZ2mjwGDrk7G4YXX
        HmWpTUjc1C1wdr3OlBrxzojFnFOVjFfEetb0BWv718ozhnZH+9b7GU05fv3qcp24v9lVq99v
        Wz1ZO3eTe5jtl0y7qQVJD5IcXL90TboS8k997gU9ede9d/bk7/R8J675f/8uuY85EcZ7hJPO
        X7g6Nb2APUZuZ5S8hpkSS3FGoqEWc1FxIgDiB5B8EwMAAA==
X-CMS-MailID: 20190507092524eucas1p20bdd1319a20df133d656ce1b7932a5ce
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
        <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
        <e808eb3a-9fbe-897d-ce25-cab732581391@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/7/19 11:17 AM, Chanwoo Choi wrote:
> On 19. 5. 7. 오후 5:51, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 5/7/19 9:33 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>>>> Define new IDs for clocks used by Dynamic Memory Controller in
>>>> Exynos5422 SoC.
>>>>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
>>>>    1 file changed, 22 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>>>> index 355f469..bf50d8a 100644
>>>> --- a/include/dt-bindings/clock/exynos5420.h
>>>> +++ b/include/dt-bindings/clock/exynos5420.h
>>>> @@ -60,6 +60,7 @@
>>>>    #define CLK_MAU_EPLL		159
>>>>    #define CLK_SCLK_HSIC_12M	160
>>>>    #define CLK_SCLK_MPHY_IXTAL24	161
>>>> +#define CLK_SCLK_BPLL		162
>>>>    
>>>>    /* gate clocks */
>>>>    #define CLK_UART0		257
>>>> @@ -195,6 +196,16 @@
>>>>    #define CLK_ACLK432_CAM		518
>>>>    #define CLK_ACLK_FL1550_CAM	519
>>>>    #define CLK_ACLK550_CAM		520
>>>> +#define CLK_CLKM_PHY0		521
>>>> +#define CLK_CLKM_PHY1		522
>>>> +#define CLK_ACLK_PPMU_DREX0_0	523
>>>> +#define CLK_ACLK_PPMU_DREX0_1	524
>>>> +#define CLK_ACLK_PPMU_DREX1_0	525
>>>> +#define CLK_ACLK_PPMU_DREX1_1	526
>>>> +#define CLK_PCLK_PPMU_DREX0_0	527
>>>> +#define CLK_PCLK_PPMU_DREX0_1	528
>>>> +#define CLK_PCLK_PPMU_DREX1_0	529
>>>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>>>    
>>>>    /* mux clocks */
>>>>    #define CLK_MOUT_HDMI		640
>>>> @@ -217,6 +228,8 @@
>>>>    #define CLK_MOUT_EPLL		657
>>>>    #define CLK_MOUT_MAU_EPLL	658
>>>>    #define CLK_MOUT_USER_MAU_EPLL	659
>>>> +#define CLK_MOUT_SCLK_SPLL	660
>>>> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>>>>    
>>>>    /* divider clocks */
>>>>    #define CLK_DOUT_PIXEL		768
>>>> @@ -243,13 +256,16 @@
>>>>    #define CLK_DOUT_ACLK300_GSCL	789
>>>>    #define CLK_DOUT_ACLK400_DISP1	790
>>>>    #define CLK_DOUT_PCLK_CDREX	791
>>>> -#define CLK_DOUT_SCLK_CDREX	792
>>>> -#define CLK_DOUT_ACLK_CDREX1	793
>>>> -#define CLK_DOUT_CCLK_DREX0	794
>>>> -#define CLK_DOUT_CLK2X_PHY0	795
>>>> -#define CLK_DOUT_PCLK_CORE_MEM	796
>>>
>>> The your previous patch didn't change the id number
>>> of already exiting clocks. It cause the fault.
>>> In order to keep the compatibility, you keep
>>> the original id number without modification.
>> True, the previous patch didn't change these IDs.
>> I have not seen any faults during builds and stress tests, though.
> 
> If you use the built dtb file before modification, it cause the fault.
> It is advantage of device-tree style to split out
> the dependency between kernel image and dtb.
Good point.
> 
>>>
>>> Please don't change the id number of the existing clocks
>>> and then just add the new clocks.
>> OK, I will add CLK_DOUT_PCLK_DREX0	and CLK_DOUT_PCLK_DREX1
>> at the end:
>> ------------------>8--------------------------
>> @@ -248,8 +261,11 @@
>>    #define CLK_DOUT_CCLK_DREX0    794
>>    #define CLK_DOUT_CLK2X_PHY0    795
>>    #define CLK_DOUT_PCLK_CORE_MEM 796
>> +#define CLK_FF_DOUT_SPLL2      797
>> +#define CLK_DOUT_PCLK_DREX0    798
>> +#define CLK_DOUT_PCLK_DREX1    799
>>
>>    /* must be greater than maximal clock id */
>> -#define CLK_NR_CLKS            797
>> +#define CLK_NR_CLKS            800
>> -----------------8<---------------------------
>>
>> Can I add your ack in the modified version?
> 
> I agree.
Thank you.

Regards,
Lukasz
