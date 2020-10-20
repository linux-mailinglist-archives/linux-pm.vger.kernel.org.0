Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4042932BA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbgJTBke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 21:40:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:12786 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390078AbgJTBke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 21:40:34 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201020014032epoutp01d431e557c8c47ab5a843622ed6852467~-j7x6TAs50990309903epoutp01g
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 01:40:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201020014032epoutp01d431e557c8c47ab5a843622ed6852467~-j7x6TAs50990309903epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603158032;
        bh=Lp9BxQtLA61gpoNNU8F/S/p3RAvMH1U9ct/wG2U7yQQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uYpFwa9/rG6pmhw0fzS/RKz38pbdxGp7EKu0IYT8+rTiF9447QM1LLKsrY9fVsnqj
         Z/SfERTz8u7zWQ5rfbeDTCohcEcqDrR8lez5p8tw8JmoMbTwf5ynOC/WdeCawVig+a
         F4pV9YHFx5rGAfQyD9Vco/QMJxIDqLwPsv4M/TwY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201020014031epcas1p329e6260e7b77e435b8261e7e7db0c764~-j7xKh8nt1746017460epcas1p36;
        Tue, 20 Oct 2020 01:40:31 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CFbt46y2szMqYkf; Tue, 20 Oct
        2020 01:40:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.A6.09543.C004E8F5; Tue, 20 Oct 2020 10:40:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201020014028epcas1p30b4a11de9b3a598b0c4622665a38c9cc~-j7uYDDob1746017460epcas1p3z;
        Tue, 20 Oct 2020 01:40:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201020014028epsmtrp14fe8d55285fdc2d68814696ec3510f81~-j7uXF2-52839628396epsmtrp1D;
        Tue, 20 Oct 2020 01:40:28 +0000 (GMT)
X-AuditID: b6c32a35-347ff70000002547-ad-5f8e400cbc46
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.3E.08604.C004E8F5; Tue, 20 Oct 2020 10:40:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201020014027epsmtip1f076a002ef970953421ddfe7c56a277e~-j7uB8C550193201932epsmtip1j;
        Tue, 20 Oct 2020 01:40:27 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add governor feature flag
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <81b05e8b-48c6-2ed4-ed2e-4516b8824369@samsung.com>
Date:   Tue, 20 Oct 2020 10:53:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <0d3d20f1-6a23-27c2-1a9d-1c7ac60ce1e7@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wbZRjH8/au13ZaPQpsL1UcPYIJID9upewwg83BtjOQSGSYhWSrJxwt
        A9quV+ZQ5xCQURgw1CjWUahjDimTrTIsLIYMMK5kGH5MBQkEBgmFKRMGDubPHmWR/77P83ye
        93m/7w8xIvsZk4tzdCbWqGPyCGwb2tEbGhHx5L5qdXRfUQz1xfB3gLpW1yakakfvoJR9aQZQ
        reM9gFq72o9QpZbPUapxuU5IDRT/KqKaJ5aE1EjXBYx6UNUHKPOKBaNsxaUiavy9Zoxa77Ki
        +3C61doKaOdEE6A7LRMi2tFixuiqkkWMvrboFNB/W7pRurq9BdAPHM+lSjJy92hZJos1BrG6
        TH1Wjk4TTySnqRPVqthoMoKMo3YTQTomn40nklJSIw7m5Hl8EEEnmbwCTyqV4TgiKmGPUV9g
        YoO0es4UT7CGrDxDnCGSY/K5Ap0mMlOf/yIZHb1L5QFfz9VevwgNQ8ipb3pq0SLgFlQAiRji
        MdBitQkrwDaxDHcCeKvTDbzBMoDmCxUblAz/A0B7r+lxh+2rr0Ve6FsAKwf5pfjgPoB3eycx
        nvLFE+G5s49EvPbDT8O+oSmMhxC8WQBb2wZQvoDhYbDbPbrR8DSugD+uzQBeS/EE+NFls4cR
        i1E8BLY2nOLT/vhr0NVRuon4QNensxuIBI+H0yWZfBrBd8BfZhsEXr0Tllz/DOHHQnxFDO80
        3d/0nARv3VgDXu0LF75vF3m1HM7XlG3qt+GXrj7M21wOYHv3oNBbUMLuSx8K+MEIHgrbuqK8
        aQXs/LMeeAc/BRdXzwl5BOJSWF4m8yLBcGRqYnMLAfDiWTN2HhCWLW4sWyxYtliw/D+sEaAt
        YDtr4PI1LEcayK137QAbLzxM5QS1v/0e2QMEYtADoBgh/KTnhdVqmTSLKXyLNerVxoI8lusB
        Ks/x1iJy/0y954voTGpStUupVFIxZKyKJIkd0r/Cy9UyXMOY2FyWNbDGx30CsUReJHDuT3+0
        3DTWoHiovBuS7Bc1dHru8DuN66EmW3Z4kPKTq2n0Xvdydkxg6dHdSZXsB+M1hv6OaddD++Wb
        fQvkG7YzZxKOH2o/4pqME5SkvFKezBUcLVt6Jt3nJURjDrQevDfnHrAFZt1+dyDqTd/YKseB
        G2OylpAV5Bhtn6++8uqliNVpv0PZYPTK8+T+wJ0nZvYWzk9kzJyssRUycsbP9UNA8cvDY5PN
        ZgU+XnbkxOzh4GdzggMWmrerR7Qa9+0M6RO1Kath6cfw3Hr/9f5Rn0HrlNZfgX6crPx3+ICz
        MyqjO/EFf93x4bpQBmsPGfzJdM8pSeNuovX/cD5ux1xl+Pt2AuW0DBmGGDnmP29Op2NqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnC6PQ1+8wbatbBbLLh1ltNg4Yz2r
        xcQbV1gsVn98zGix5vYhRosfG04xW7TMWsRiseDTDFaLs01v2C1W3P3IanF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroytiyUKLjJXbD80kaWB8QVTFyMnh4SA
        icTCdZvZQWwhgd2MEv83MkLEJSWmXTzK3MXIAWQLSxw+XNzFyAVU8pZR4tW3FhaQGmEBZ4me
        9l9gvSICtRKvVk9nBbGZBVYwSSz8LATRcItJ4k7HbDaQBJuAlsT+FzfAbH4BRYmrPx6DLeMV
        sJOYsryTBWQZi4CqxJr5FSBhUYEwiZ1LHjNBlAhKnJz5BKyEU8BW4mFzMsQqdYk/8y4xQ9ji
        EreezGeCsOUlmrfOZp7AKDwLSfcsJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5x
        aV66XnJ+7iZGcCRrae5g3L7qg94hRiYOxkOMEhzMSiK8E1j74oV4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz3ihcGCckkJ5YkpqdmlqQWgSTZeLglGpg2rIm0a5kg/UKFXeBlqM1pp2BknLT1/n6
        XF7I26kYt2N6X5DMheLgGZ+nsO9hXspzm9HHnGWi6565h9hE7+UU5Ro1Jal9NP7C0FKtJnsr
        ICa17e/Wf79P3bp/LFe7+srn3WtVQ1YEmGzJ2nGvXTlm2ZvHmvMsG/W7u8yzLpUumVR/Imzf
        synijkwfFKb9V5PiuMFaE2h/xu3xs84nn6Z0qDVkLJc6oDXP4YbAI8mQqLWV5z6YVVYJyUxP
        OCP1dObOruxz2f0uz3bU+IXb9jyPmGXRrnzo+IyNm1qsrQK3xx50mdsj+XXS4efnLMTWK/ps
        1OGRzn6ulsqXpl78uCH0t13uzxahGye2rXx2q/+sEktxRqKhFnNRcSIAz8YKlFMDAAA=
X-CMS-MailID: 20201020014028epcas1p30b4a11de9b3a598b0c4622665a38c9cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p4e63955385b1841f44e7a07e2d5d962c4@epcas1p4.samsung.com>
        <20201007050703.20759-2-cw00.choi@samsung.com>
        <83b952ab-a25e-8984-8804-1dd990eec835@gmail.com>
        <9267f046-1adc-b43d-51ef-2e0ad41dc322@samsung.com>
        <0d3d20f1-6a23-27c2-1a9d-1c7ac60ce1e7@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/20/20 7:39 AM, Dmitry Osipenko wrote:
> 19.10.2020 06:53, Chanwoo Choi пишет:
> ...
>>>> +	const u64 flag;
>>> A plural form of flag(s) is more common, IMO.
>>
>> When need to add more feature flag, I prefer to add
>> the definition instead of changing the structure.
>> I think it is better.
> 
> I meant to rename the new member "flag" to "flags".

I misunderstood. I'll edit it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
