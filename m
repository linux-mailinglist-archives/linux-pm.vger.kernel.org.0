Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE2F8F9
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfD3Mgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 08:36:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40071 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfD3Mgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 08:36:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190430123637euoutp013135c3b1027cc69fa159c3ad2166352d~aQLwUBQk22276422764euoutp01P
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 12:36:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190430123637euoutp013135c3b1027cc69fa159c3ad2166352d~aQLwUBQk22276422764euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556627797;
        bh=X7YzOGNdDkST8oqsRp5UiPvT7RSLwxnDlcKCn95vBoE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g/MDhkaAiVSXpiGeXmzf+poIHXO+OS+dg/Yrf3BV+QfE5nGp5K5OqQq/ghZVkW7+Y
         jfzzQyS94lZBcdgZ6RDmdS7rHZBysib/9d5fKXIdj1APZJPl7ljUmlPTYCm7tY0jmg
         7ieEKAtsZyI/asB/Gjcyg7wmVBVcliSBFXdrBtlk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190430123636eucas1p23a83aeb652f4957f2a9a878d7bd2b0a4~aQLviOEEb2285722857eucas1p2m;
        Tue, 30 Apr 2019 12:36:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C1.00.04298.45148CC5; Tue, 30
        Apr 2019 13:36:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430123635eucas1p28c2161b465569c46f941e76fd7c9c63b~aQLuiqyie2344423444eucas1p2Z;
        Tue, 30 Apr 2019 12:36:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430123635eusmtrp1a769c1af2c8e7eb5ae012d538ed32d44~aQLuTB59_0421804218eusmtrp1P;
        Tue, 30 Apr 2019 12:36:35 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-36-5cc841543dff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.12.04146.35148CC5; Tue, 30
        Apr 2019 13:36:35 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430123634eusmtip2007e1d3560b4714296da1244959e2a28~aQLtjzC6A0081400814eusmtip2b;
        Tue, 30 Apr 2019 12:36:34 +0000 (GMT)
Subject: Re: [PATCH v6 01/10] clk: samsung: add needed IDs for DMC clocks in
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
Message-ID: <345488e4-ba7e-1f34-e166-cb340d7f7dab@partner.samsung.com>
Date:   Tue, 30 Apr 2019 14:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9eb04a57-3e80-b0ba-334a-927493deb969@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7ohjidiDH7fV7LYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i8Nv2lkt9l/xsrj9m8/i24lHjA5CHt++TmLxmN1wkcVj56y77B6bVnWyefQ2
        v2Pz6NuyitFj8+lqj8+b5AI4orhsUlJzMstSi/TtErgynjVdYylYxFsxuauTuYHxI1cXIyeH
        hICJxJ1V19i6GLk4hARWMEq8WdPPDOF8YZS429sN5XxmlJi79hoTTMunKW+gWpYzSny+ex2q
        6i2jxI/181lBqoQFIiVWvp7CBJIQEVjMKDF15W8wh1lgNZPEn69rgao4ONgE9CR2rCoEaeAV
        cJOY+66THcRmEVCV2LDvAdg6UYEIifvHNrBC1AhKnJz5hAXE5hSwl5jz4R0biM0sIC5x68l8
        JghbXqJ562ywiyQEpnJIvJmygRHibheJGz3b2SFsYYlXx7dA2TISpyf3sEDYxRINvQuh6msk
        HvfPhaqxljh8/CLYzcwCmhLrd+lDhB0lNkzayQYSlhDgk7jxVhDiBD6JSdumM0OEeSU62oQg
        qjUktvRcgAaimMTyNdPYJzAqzULy2Cwkz8xC8swshL0LGFlWMYqnlhbnpqcWG+allusVJ+YW
        l+al6yXn525iBCbC0/+Of9rB+PVS0iFGAQ5GJR5ej3fHYoRYE8uKK3MPMUpwMCuJ8HocPxoj
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1OqgbGxPGzn/JV+
        lx94uluJL259KsRgYXWn6a7I3oSXppVin2Tn/5DheiD5JFpJhM9I4f7/nctuXz/HqX+26cAC
        TfEG8VBlDbmHbcbXvQT6MhL+PvKrnHe8X+jQ1aOqEYHBgY/YPJPMWtOTfm980csQ/HaGg3MA
        2xvl9/YhLYUTL8pPXv/7+K0DD5VYijMSDbWYi4oTAaGkKVqAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd1gxxMxBncWKVhsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxeE37awW+694Wdz+zWfx7cQjRgchj29fJ7F4zG64yOKxc9Zddo9NqzrZPHqb
        37F59G1Zxeix+XS1x+dNcgEcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZz5qusRQs4q2Y3NXJ3MD4kauLkZNDQsBE4tOUN2xdjFwcQgJLGSVO
        3DrPDpEQk5i0bzuULSzx51oXVNFrRokzExeygCSEBSIlVr6ewgRiiwgsZpT42loNUsQssJpJ
        YtLHLVAdU5gkdp95BlTFwcEmoCexY1UhSAOvgJvE3HedYBtYBFQlNux7ADZIVCBC4sz7FSwQ
        NYISJ2c+AbM5Bewl5nx4xwZiMwuYSczb/JAZwhaXuPVkPhOELS/RvHU28wRGoVlI2mchaZmF
        pGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmN/27Gfm3cwXtoYfIhRgINRiYfX
        492xGCHWxLLiytxDjBIczEoivB7Hj8YI8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wLeWV
        xBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBUdStnW3JUOLW6kklY
        NV56XsFGo2chvobmrpveMHoYhKxx33fqZrGzXcCbKbujEgPuNzLpmv0XD79/2euu0gOnuopV
        t1a/X/glperZjezXFwqnCz84WRtuxLvkYu0nq+tedh6pV6ZsX69ns6WLv2jV3UtFM1zZmF6J
        f7239zNXtd2FoNS33nZKLMUZiYZazEXFiQDILCoDEwMAAA==
X-CMS-MailID: 20190430123635eucas1p28c2161b465569c46f941e76fd7c9c63b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141940eucas1p295a1130863cf2e69476ca0ba11a8a102@eucas1p2.samsung.com>
        <1555683568-20882-2-git-send-email-l.luba@partner.samsung.com>
        <9eb04a57-3e80-b0ba-334a-927493deb969@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 4/30/19 6:47 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>> Define new IDs for clocks used by Dynamic Memory Controller in
>> Exynos5422 SoC.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>> index 355f469..abb1842 100644
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
>> @@ -195,6 +196,18 @@
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
>> +#define CLK_CDREX_PAUSE		531
>> +#define CLK_CDREX_TIMING_SET	532
> 
> I cannot find the usage code of both CLK_CDREX_PAUSE
> and CLK_CDREX_TIMING_SET in these patchset.
Thank you for this catch. I will remove them.

Regards,
Lukasz
> 
> Please remove them.
> 
> (snip)
> 
