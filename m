Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33041E5E8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 03:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbhJABzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 21:55:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16335 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJABzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 21:55:02 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211001015317epoutp01e8dd4c1279e8882f6d6a32d08882756d~pxTsc6tu90324703247epoutp01K
        for <linux-pm@vger.kernel.org>; Fri,  1 Oct 2021 01:53:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211001015317epoutp01e8dd4c1279e8882f6d6a32d08882756d~pxTsc6tu90324703247epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633053197;
        bh=Y5D2RVidVyu2KzhxzGf+72FDuxXRMG26nBeLauIzi+U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=At1AGZ20R65OSunlg3MfGf5JRcV7MyTnzHszqeEJJqqaEjB+ygQk9J6L4lPZR6OXx
         n9v0ouA+ZTAeYdkCvxCv6yjVhlvQTU4yxWDgq+TkhTjk1qVN6lDEywkWPmkTUEMWqb
         2bxEZ5CDbkUqI6B+bSZmC4ZPFNKc0TqvW3L3mhfc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211001015316epcas1p2af6ded89d0eb2e2090a7a8e0c0d89577~pxTrWC8Xy3238432384epcas1p2P;
        Fri,  1 Oct 2021 01:53:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HLCmn08sTz4x9QP; Fri,  1 Oct
        2021 01:52:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.4F.62504.8F966516; Fri,  1 Oct 2021 10:52:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211001015255epcas1p2e5839149e0fb56ac2edc512310b69acd~pxTYTZKHe3018930189epcas1p2j;
        Fri,  1 Oct 2021 01:52:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211001015255epsmtrp25ae9295ad65437a2035fc5012fc6fbcc~pxTYSPwe83080930809epsmtrp2U;
        Fri,  1 Oct 2021 01:52:55 +0000 (GMT)
X-AuditID: b6c32a38-79bff7000002f428-6e-615669f87b99
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.FB.08750.7F966516; Fri,  1 Oct 2021 10:52:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211001015255epsmtip2e7386d8bb6a03f651228b107b24fe564~pxTX-lyEV0425404254epsmtip2p;
        Fri,  1 Oct 2021 01:52:55 +0000 (GMT)
Subject: Re: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <afde619a-6816-0a93-807a-01e3718a38c1@samsung.com>
Date:   Fri, 1 Oct 2021 11:14:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <7107eea6-f2ca-fb7c-5975-569066ba21a7@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnu6PzLBEg2NzNC3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGc8ve9cME2p4lnrPuYGxnvSXYycHBICJhInL01n7WLk4hAS2MEocXXJAkYI5xOjxLYf
        x5khnM+MEh+XPGDqYuQAa2n8ZgkR38UoMf9SCzuE855RYtG9s0wgc4UFfCRuvlrBBmKLCNRJ
        vDt4igmkiFmggVniwd5JLCAJNgEtif0vboAV8QsoSlz98ZgRxOYVsJPo2NvGDGKzCKhI/Luz
        DMwWFQiTOLmtBapGUOLkzCdgczgFHCS+zGsDW8wsIC5x68l8KFteYvvbOWAvSAg84ZDo29DH
        DPG1i8TLq79ZIWxhiVfHt7BD2FISn9/tZYOwqyVWnjzCBtHcwSixZf8FqAZjif1LJ4PDgllA
        U2L9Ln2IsKLEzt9zGSEW80m8+9rDCgkuXomONiGIEmWJyw/uMkHYkhKL2zvZJjAqzULyziwk
        L8xC8sIshGULGFlWMYqlFhTnpqcWGxaYwGM7OT93EyM4XWtZ7GCc+/aD3iFGJg7GQ4wSHMxK
        Irw/xIMThXhTEiurUovy44tKc1KLDzGaAgN4IrOUaHI+MGPklcQbmlgamJgZGZtYGJoZKonz
        HnttmSgkkJ5YkpqdmlqQWgTTx8TBKdXApBzW7X6p6Fp1QKaO87UNN1i6KsXLp6/xW6GtKOki
        mZuYt+WynfrK62dTZ2+x2zah5+7Eyn8xqkdVM2Ta355tY3/S9KDj8gemfO2rLo/sIjqmdpaf
        +Nue9vHES23eKD251Ens8QvmTf4RPMX58f6YudG1r/U3bkk73pug+MSR5/AVtf8PZhUv4RHM
        ty27q/Ux/OGlzRfO6E9PmFz8fbaPg5yg/Mq5nctWuWamye7n3j63oLHUYe1dbwefLS1f9jMH
        ZtavXOgpIs98yuZ1xt45RtfPRS2M160wko1b0uUpNDVlD29w46c9gZ/+7uO98/Xgf6/I0/f/
        zRYMW8IY1hWTG9O9cFLas72fPBhtZuydocRSnJFoqMVcVJwIAJBH2ixgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWy7bCSvO73zLBEg/vtKhbzj5xjtXg+fx2j
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFlP27WKzaOtcxmpx8ZSrxe3GFWwWrXuPsFs8f9TJZvHv
        2kYWi5+HzjM58Hm8v9HK7rHh0WpWj52z7rJ7bFrVyeaxeUm9x4vNMxk9+rasYvR49XUuo8fn
        TXIBnFFcNimpOZllqUX6dglcGU/vOxdMU6p41rqPuYHxnnQXIweHhICJROM3yy5GLg4hgR2M
        EhdnnGHuYuQEiktKTLt4lBmiRlji8OFiiJq3jBJzzrQygtQIC/hI3Hy1gg0kISLQwCgx7dte
        sASzQAOzxOE9dRAdE5kl/vdcYgFJsAloSex/cYMNxOYXUJS4+uMxWAOvgJ1Ex942sM0sAioS
        /+4sA7NFBcIkdi55zARRIyhxcuYTsDmcAg4SX+a1MUEsU5f4M+8SM4QtLnHryXyouLzE9rdz
        mCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHLda
        WjsY96z6oHeIkYmD8RCjBAezkgjvD/HgRCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqYVsd/Yuhxk3UI3DNFzGfR9XlaEzzqfRLntEVYcykWzGk4HrT3
        Oa/iY9Frs549FT3FteoON4fQf+aGWW32PX2Z4U7ZdpfKYyuD5wTufJfG0eYQvGZZIiNDhHWo
        ++bnN8sP/JzFVnVT71KFketBDgk2vmZTib7zPWb6QR+nW9SkTQvg+3ybKWKB0tz9NUK6f2/M
        /df985XajxNn762ou/tn9rcFVToNq55Yv5LN/xHuOG3V3JklelN1rxotXbCs2fV+imFb2Mfr
        cw4vPaLxQP3b1v4l06/srHGOfjY3+5ZLQUrXdEurL69f79ZnY5V81P+C49K5ludaj0QSA3tK
        9eqrtyyRPP/kM6OVWnmBjO9nJZbijERDLeai4kQA/XhCO0oDAAA=
X-CMS-MailID: 20211001015255epcas1p2e5839149e0fb56ac2edc512310b69acd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4
References: <20210929044254.38301-1-samuel@sholland.org>
        <CGME20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4@epcas1p4.samsung.com>
        <20210929044254.38301-3-samuel@sholland.org>
        <114afa7e-6218-6b1f-f87e-84690f10029c@samsung.com>
        <d0a2c36b-4019-2f52-13f0-be76db5a48ec@sholland.org>
        <7d404f89-6567-61e6-7964-d2ca578ed652@samsung.com>
        <7107eea6-f2ca-fb7c-5975-569066ba21a7@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/1/21 10:45 AM, Samuel Holland wrote:
> On 9/30/21 8:59 PM, Chanwoo Choi wrote:
>> On 9/30/21 8:37 PM, Samuel Holland wrote:
>>> On 9/29/21 11:19 PM, Chanwoo Choi wrote:
>>>> Hi Samuel,
>>>>
>>>>
>>>> On 9/29/21 1:42 PM, Samuel Holland wrote:
>>>>> Since commit ea572f816032 ("PM / devfreq: Change return type of
>>>>> devfreq_set_freq_table()"), all devfreq devices are required to have a
>>>>> valid freq_table. If freq_table is not provided by the driver, it will
>>>>> be filled in by set_freq_table() from the OPPs; if that fails,
>>>>> devfreq_add_device() will return an error.
>>>>>
>>>>> However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
>>>>> adding the devfreq device"), devfreq devices are _also_ required to have
>>>>> an OPP table, even if they provide freq_table. devfreq_add_device()
>>>>> requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
>>>>> return successfully, specifically to initialize scaling_min/max_freq.
>>>>>
>>>>> Not all drivers need an OPP table. For example, a driver where all
>>>>> frequencies are determined dynamically could work by filling out only
>>>>> freq_table. But with the current code it must call dev_pm_opp_add() on
>>>>> every freq_table entry to probe successfully.
>>>>
>>>> As you commented, if device has no opp table, it should call dev_pm_opp_add().
>>>> The devfreq have to use OPP for controlling the frequency/regulator.
>>>>
>>>> Actually, I want that all devfreq driver uses the OPP as default way.
>>>
>>> The current code/documentation implies that an OPP table is intended to
>>> be optional. For example:
>>>
>>>  * struct devfreq - Device devfreq structure
>>> ...
>>>  * @opp_table:  Reference to OPP table of dev.parent, if one exists.
>>>
>>> So this should be updated if an OPP table is no longer optional.
>>
>> Right. Need to update it.
>>
>>>
>>>> Are there any reason why don't use the OPP table?
>>>
>>> dev_pm_opp_add() takes a voltage, and assumes the existence of some
>>> voltage regulator, but there is none involved here. The only way to have
>>> an OPP table without regulators is to use a static table in the
>>> devicetree. But that also doesn't make much sense, because the OPPs
>>> aren't actually customizable; they are integer dividers from a fixed
>>> base clock.
>>
>> You can use OPP for only clock control without regulator. OPP already
>> provides them. OPP already provides the helpful function which
>> implement the functions to handle the clock/regulator or power doamin.
>> It is useful framework to control clock/regulator. 
>>
>> If the standard framework in Linux kernel, it is best to use
>> this framework in order to remove the duplicate codes on multiple
>> device drivers. It is one of advantage of Linux kernel. 
>>
>> Also, if OPP doesn't support the some requirement of you,
>> you can contribute and update the OPP.
>>
>>  And adding a fixed OPP table to each board would be a lot of
>>> work to replace a trivial loop in the driver. So it seems to be the
>>> wrong abstraction.
>>
>> I don't understand. As I commented for patch 10, you can add
>> the OPP entry of the clock without the fixed OPP table in devicetree.
>>
>>>
>>> Using an OPP table adds extra complexity (memory allocations, error
>>> cases), just to duplicate the list of frequencies that already has to
>>> exist in freq_table. And the driver works fine without any of that.
>>
>> 'freq_table' of devfreq was developed before of adding OPP interface to Linux kernel as I knew. Actually, I prefer to use the OPP interface
>> instead of initializing the freq_table directly by device driver.
>> I just keep the 'freq_table' for preventing the build/working issue
>> for older device driver. I think OPP is enough to control frequency/voltage
>> and it provides the various helper funcitons for user of OPP.
> 
> Thanks for the explanation. I will convert the driver to use
> dev_pm_opp_add(), and I will drop patches 2 and 4. I think patch 3 is
> still worth considering.

Thanks. Previously, there was some devfreq driver to use freq_table
with descending order. I'll check the devfreq driver in linux kernel.
If there are no any use-case of freq_table with descending order,
I'll accept the patch3.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
