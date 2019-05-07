Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06216063
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEGJQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 05:16:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:32100 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEGJQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 05:16:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190507091622epoutp031527ba19f31975dd16655b97a98c4980~cW96MU8pz3209832098epoutp03H
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 09:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190507091622epoutp031527ba19f31975dd16655b97a98c4980~cW96MU8pz3209832098epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557220582;
        bh=v2HrOoEod9+1sIMFA49m+eruBUyQZpx8ALLIXJFlWDc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qPp0kUOUIDD73vFNtsxJelHEthpiXqilZRX/eDP7hbuePfdy3cR7406srnQDu7rie
         r4VUBvPYJJr6S9rfVLqVFQqWi+u1n9BbZPJC4J7XiGV06VbiBVP+a1oNgkhSwOu6fH
         cQ4AE+GJ/QcoUXdSPiFk6BbgwDCEO0OA8xWUYeNk=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190507091619epcas1p430ace8bd55fd3b48261adaa72f1f9670~cW93pJDNI2091320913epcas1p4l;
        Tue,  7 May 2019 09:16:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.7F.04108.3EC41DC5; Tue,  7 May 2019 18:16:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190507091619epcas1p2ccd2c8b1cfb8db153f9f89a3f834b9bd~cW93BKKCv0374703747epcas1p2h;
        Tue,  7 May 2019 09:16:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190507091619epsmtrp10b7e336dba20f4d4823bd309b6b8f23e~cW93AKsKM0223502235epsmtrp1R;
        Tue,  7 May 2019 09:16:19 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-63-5cd14ce3fc45
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.8D.03662.2EC41DC5; Tue,  7 May 2019 18:16:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190507091618epsmtip1f9124ad45acf46b61d05b006162e4f4b~cW92uMKuU2965029650epsmtip1A;
        Tue,  7 May 2019 09:16:18 +0000 (GMT)
Subject: Re: [PATCH v7 01/13] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e808eb3a-9fbe-897d-ce25-cab732581391@samsung.com>
Date:   Tue, 7 May 2019 18:17:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmvu5jn4sxBtuO61lsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOAnlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGeseONVcFW+4sSCHvYGxlOSXYycHBICJhJ/1q9j7WLk
        4hAS2MEose3YJ2aQhJDAJ0aJ0yu9IBLfGCWeXLzO1sXIAdZx8ywLRHwvo8SFDx/ZIZz3jBI9
        K9ezgHQLC0RKrJr7ixEkISKwnFFi39S7YA6zwGomiT9f17KCVLEJaEnsf3GDDcTmF1CUuPrj
        MSOIzStgJ/Hn1i0wm0VARWLuzHNMILaoQITE/WMbWCFqBCVOznwCto1TwF1i8ofnYPXMAuIS
        t57MZ4Kw5SWat85mBlksIXCLXaKj5yQjxNcuEhcfL4eyhSVeHd/CDmFLSbzsb4OyqyVWnjzC
        BtHcwSixZf8FVoiEscT+pZOZQIHBLKApsX6XPsQyPol3X3tYIWHEK9HRJgRRrSxx+cFdJghb
        UmJxeycbhO0hsXrCCZYJjIqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBabIsb2JEZzQ
        tSx3MB4753OIUYCDUYmH94HthRgh1sSy4srcQ4wSHMxKIryJz87FCPGmJFZWpRblxxeV5qQW
        H2I0BYb2RGYp0eR8YLbJK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5YkpqdmlqQWgTTx8TB
        KdXAqHLvmInmjZ+xfP8uyfoG1M9ma/8q9KW5ab/15eIf5eteCO+JuqRyUS747ZPjL66sLPqg
        O4M31GTp4+a461nfvry++Ppb7IpVPqddNxuxRu053+7WLXN16XPl1Zd91oVzzM3ta7M680dt
        gszjvZtbzwn61ukU31ylv+Pemo83RLUv7HqtERGUKK/EUpyRaKjFXFScCADCGHHd/gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSnO5jn4sxBismMFlsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKO4bFJSczLLUov07RK4Mla88Sq4Kl9xYkEPewPjKcku
        Rg4OCQETiZtnWboYuTiEBHYzSpyc+Zq1i5ETKC4pMe3iUWaIGmGJw4eLIWreMkrM+/SLDaRG
        WCBSYtXcX4wgCRGB5YwSc/8uBZvELLCaSWLSxy1sEC0XmSSW9WxgB2lhE9CS2P/iBlg7v4Ci
        xNUfjxlBbF4BO4k/t26B2SwCKhJzZ55jArFFBSIkzrxfwQJRIwh03hMwm1PAXWLyh+dg9cwC
        6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMC
        o7zUcr3ixNzi0rx0veT83E2M4NjW0trBeOJE/CFGAQ5GJR7eDusLMUKsiWXFlbmHGCU4mJVE
        eBOfnYsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwFj/
        fnHNLsUPNw7Gc/JfzD7RLfDh0sypMSum1NkFrRPq4DnJ2JD1cC2/MrPm1gNqQS0Tn/7Xsvp7
        Uf2l85sjCgLnfeceDFxt/Mcz+Mqvc1OPM88Mn5cVsGCJp+9ZqYK3pcmxq6455L2IXxDlWKkw
        i/07k8D6+sgzDqy3LB4nKMRsWLiY7WHSskdKLMUZiYZazEXFiQB8k3Pi6QIAAA==
X-CMS-MailID: 20190507091619epcas1p2ccd2c8b1cfb8db153f9f89a3f834b9bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151210eucas1p13c2a4b86a6f987ff34fbe1e2d705fbbf@eucas1p1.samsung.com>
        <1557155521-30949-2-git-send-email-l.luba@partner.samsung.com>
        <8b063f30-1a4d-3292-2e57-6e33e94d57ae@samsung.com>
        <55e89fc7-6f22-b384-adbf-40c68618bdac@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 5. 7. 오후 5:51, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 5/7/19 9:33 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>>> Define new IDs for clocks used by Dynamic Memory Controller in
>>> Exynos5422 SoC.
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   include/dt-bindings/clock/exynos5420.h | 28 ++++++++++++++++++++++------
>>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
>>> index 355f469..bf50d8a 100644
>>> --- a/include/dt-bindings/clock/exynos5420.h
>>> +++ b/include/dt-bindings/clock/exynos5420.h
>>> @@ -60,6 +60,7 @@
>>>   #define CLK_MAU_EPLL		159
>>>   #define CLK_SCLK_HSIC_12M	160
>>>   #define CLK_SCLK_MPHY_IXTAL24	161
>>> +#define CLK_SCLK_BPLL		162
>>>   
>>>   /* gate clocks */
>>>   #define CLK_UART0		257
>>> @@ -195,6 +196,16 @@
>>>   #define CLK_ACLK432_CAM		518
>>>   #define CLK_ACLK_FL1550_CAM	519
>>>   #define CLK_ACLK550_CAM		520
>>> +#define CLK_CLKM_PHY0		521
>>> +#define CLK_CLKM_PHY1		522
>>> +#define CLK_ACLK_PPMU_DREX0_0	523
>>> +#define CLK_ACLK_PPMU_DREX0_1	524
>>> +#define CLK_ACLK_PPMU_DREX1_0	525
>>> +#define CLK_ACLK_PPMU_DREX1_1	526
>>> +#define CLK_PCLK_PPMU_DREX0_0	527
>>> +#define CLK_PCLK_PPMU_DREX0_1	528
>>> +#define CLK_PCLK_PPMU_DREX1_0	529
>>> +#define CLK_PCLK_PPMU_DREX1_1	530
>>>   
>>>   /* mux clocks */
>>>   #define CLK_MOUT_HDMI		640
>>> @@ -217,6 +228,8 @@
>>>   #define CLK_MOUT_EPLL		657
>>>   #define CLK_MOUT_MAU_EPLL	658
>>>   #define CLK_MOUT_USER_MAU_EPLL	659
>>> +#define CLK_MOUT_SCLK_SPLL	660
>>> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
>>>   
>>>   /* divider clocks */
>>>   #define CLK_DOUT_PIXEL		768
>>> @@ -243,13 +256,16 @@
>>>   #define CLK_DOUT_ACLK300_GSCL	789
>>>   #define CLK_DOUT_ACLK400_DISP1	790
>>>   #define CLK_DOUT_PCLK_CDREX	791
>>> -#define CLK_DOUT_SCLK_CDREX	792
>>> -#define CLK_DOUT_ACLK_CDREX1	793
>>> -#define CLK_DOUT_CCLK_DREX0	794
>>> -#define CLK_DOUT_CLK2X_PHY0	795
>>> -#define CLK_DOUT_PCLK_CORE_MEM	796
>>
>> The your previous patch didn't change the id number
>> of already exiting clocks. It cause the fault.
>> In order to keep the compatibility, you keep
>> the original id number without modification.
> True, the previous patch didn't change these IDs.
> I have not seen any faults during builds and stress tests, though.

If you use the built dtb file before modification, it cause the fault.
It is advantage of device-tree style to split out
the dependency between kernel image and dtb.

>>
>> Please don't change the id number of the existing clocks
>> and then just add the new clocks.
> OK, I will add CLK_DOUT_PCLK_DREX0	and CLK_DOUT_PCLK_DREX1
> at the end:
> ------------------>8--------------------------
> @@ -248,8 +261,11 @@
>   #define CLK_DOUT_CCLK_DREX0    794
>   #define CLK_DOUT_CLK2X_PHY0    795
>   #define CLK_DOUT_PCLK_CORE_MEM 796
> +#define CLK_FF_DOUT_SPLL2      797
> +#define CLK_DOUT_PCLK_DREX0    798
> +#define CLK_DOUT_PCLK_DREX1    799
> 
>   /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS            797
> +#define CLK_NR_CLKS            800
> -----------------8<---------------------------
> 
> Can I add your ack in the modified version?

I agree.

> 
> Regards,
> Lukasz
>>
>>
>>> +#define CLK_DOUT_PCLK_DREX0	792
>>> +#define CLK_DOUT_PCLK_DREX1	793
>>> +#define CLK_DOUT_SCLK_CDREX	794
>>> +#define CLK_DOUT_ACLK_CDREX1	795
>>> +#define CLK_DOUT_CCLK_DREX0	796
>>> +#define CLK_DOUT_CLK2X_PHY0	797
>>> +#define CLK_DOUT_PCLK_CORE_MEM	798
>>> +#define CLK_FF_DOUT_SPLL2	799
>>>   
>>>   /* must be greater than maximal clock id */
>>> -#define CLK_NR_CLKS		797
>>> +#define CLK_NR_CLKS		800
>>>   
>>>   #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
>>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
