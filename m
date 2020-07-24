Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583C922BB86
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgGXB2u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 21:28:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33750 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGXB2u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 21:28:50 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200724012845epoutp04e1d31d9d5fcc1df24c0ea52c9447e8b1~kjAYS3dzB3244732447epoutp04B
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 01:28:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200724012845epoutp04e1d31d9d5fcc1df24c0ea52c9447e8b1~kjAYS3dzB3244732447epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595554125;
        bh=pDxZQjEv7mBk0U/xfnx3R6uLnhFHeCtJTsQ5goSgaF4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mxNYSFNc6TWOIVyhpyyO0wEaPtwGWLxl8gnPF3P1cmXacf6DfASe64kqYnGwD4SJZ
         tnOY6aVW+7NlE37pAOLF5doEs04xSUXS315xgnuMvOtDch3Wwal8FToccmlqFahbus
         EGVyyiulDyqDlUqZ8PxDS61ee34mgfJQfv6OyiFw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200724012845epcas1p487b493d7fec5d7e17230792aa44edb2d~kjAX4yvYp0267402674epcas1p4m;
        Fri, 24 Jul 2020 01:28:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BCWn64lDPzMqYkm; Fri, 24 Jul
        2020 01:28:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.EA.19033.7493A1F5; Fri, 24 Jul 2020 10:28:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200724012838epcas1p1ca5dba82e0500fbf14f004b21ed26289~kjARshl_r1209012090epcas1p1K;
        Fri, 24 Jul 2020 01:28:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200724012838epsmtrp12bd29ec8e984c87d23d5c5c8d8dca47f~kjARroT-l3006530065epsmtrp1Y;
        Fri, 24 Jul 2020 01:28:38 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-66-5f1a39470399
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.18.08303.6493A1F5; Fri, 24 Jul 2020 10:28:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200724012838epsmtip163ac4f6afb4f6349acb2e7b46cd0118a~kjARdgQcl3014530145epsmtip1Z;
        Fri, 24 Jul 2020 01:28:38 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] Exynos5422 DMC: adjust to new devfreq monitoring
 mechanism
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     willy.mh.wolff.ml@gmail.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b6e3e7af-203d-a24e-2757-c32236f494d4@samsung.com>
Date:   Fri, 24 Jul 2020 10:40:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200710191122.11029-1-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmrq67pVS8QfMVXouNM9azWky8cYXF
        YsGnGawW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWSxsamG3uN24gs3i
        8Jt2VotvJx4xOvB5rJm3htFj56y77B6bVnWyeWxeUu/Rt2UVo8fnTXIBbFHZNhmpiSmpRQqp
        ecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA1yoplCXmlAKFAhKLi5X0
        7WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjN+Tj7OXrCcu6Jx
        xmL2BsZJnF2MHBwSAiYSdxozuxi5OIQEdjBKnH6xmRXC+cQoMeXJEkYI5zOjxKJbzexdjJxg
        HUeuf4FK7GKU2LCqmRnCec8ocetbLxNIlbBAhMSrCydYQBIiAqsYJb6/PwI2mFngDqPE18a5
        jCBVbAJaEvtf3GADsfkFFCWu/ngMFucVsJOY8uYvK4jNIqAq8ePkSbC4qECYxMltLVA1ghIn
        Zz5hAbE5BSwlzr+eDlbPLCAucevJfCYIW15i+9s5YOdJCNzgkNg1dzkrxBMuEvfn3WSCsIUl
        Xh3fAvWclMTL/jYou1pi5ckjbBDNHYwSW/ZfgGo2lti/dDITKPyYBTQl1u/ShwgrSuz8DfEY
        swCfxLuvPayQIOaV6GgTgihRlrj84C7UWkmJxe2dbBMYlWYheWcWkhdmIXlhFsKyBYwsqxjF
        UguKc9NTiw0LjJDjexMjOC1rme1gnPT2g94hRiYOxkOMEhzMSiK8Oozi8UK8KYmVValF+fFF
        pTmpxYcYTYEBPJFZSjQ5H5gZ8kriDU2NjI2NLUwMzUwNDZXEef+dZY8XEkhPLEnNTk0tSC2C
        6WPi4JRqYJqd8p5lIcsnZjHXWLWH1uFhzvHzg0X+ptj+3dy6VfzUlw0rKqf9OO3GXaz/48Gq
        LvmbW4/9L6iaeut8Y/0fi/y7tV8XXJn2K8X2YP+3C8/X7/75bpXFW+6L55bbaAsuqN63vO+d
        253Vh0/+ENeLOLzR5Oh5peZz84snLEqxzymyu/3K8/okvTylzsezWMTn3ZwyM8vw74qvnzyz
        2tt2HatJ+XXLgCW0uNrpdv92rrWpy/PYg08eXCrgkvLBz+XMRF+JVxZnM/4fO/1gi97iPwUc
        1+xjnPNsTjVdKWE+MHOKquw3+9Kij/N35d2yF8+cfYvhwxf9qxvU8/e0FrEnVEXvE+FT1NgZ
        4sQ53Wv2F/16JZbijERDLeai4kQASlYPmlQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnK6bpVS8wZzbChYbZ6xntZh44wqL
        xYJPM1gt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jsljY1MJucbtxBZvF
        4TftrBbfTjxidODzWDNvDaPHzll32T02repk89i8pN6jb8sqRo/Pm+QC2KK4bFJSczLLUov0
        7RK4Mn5OPs5esJy7onHGYvYGxkmcXYycHBICJhJHrn9h7GLk4hAS2MEo8fHHGkaIhKTEtItH
        mbsYOYBsYYnDh4shat4ySjyZvZcFpEZYIELi1YUTLCAJEYFVjBL37t9gB0kwC9xhlDjYEgnR
        0cMo8er7N1aQBJuAlsT+FzfYQGx+AUWJqz8eg23jFbCTmPLmL1gNi4CqxI+TJ8HiogJhEjuX
        PGaCqBGUODnzCdhmTgFLifOvp7NCLFOX+DPvEjOELS5x68l8JghbXmL72znMExiFZyFpn4Wk
        ZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOTy2tHYx7Vn3QO8TI
        xMF4iFGCg1lJhFeHUTxeiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/XWQvjhATSE0tSs1NTC1KL
        YLJMHJxSDUzCTPOqFFN4+Ldln0nJNkmSYbRjSo4KeZev560y77zL5H0Wk15f/LbN2sfhflzK
        taL5yZOzjSc17p9ct//h9lwrda45+xY7OJ7c1W8981fFyyeyx5cwHr0zuWDpNN7p1W/28Rh0
        6MzdX/ff5MyCm4HL3l1PUjp6MeKsP/OJU9OttXoqq3cydJ+WcfQ+x+8xb65I+nYZU3f5/Yyu
        81zfqm1XELf79eXf1bRemak17He1lYM3TS60fLHdtNf2cpKrGfMZs31OpgzVyxucz11fM8vv
        5pbtzs98MpdVdDMxfDP++2D5k6Ib89+wyz3heXK+hDudu6pt5pcIBt47LDIhzSFaMjOjuvJE
        TTZcOn+hUFyJpTgj0VCLuag4EQCAQQkUPgMAAA==
X-CMS-MailID: 20200724012838epcas1p1ca5dba82e0500fbf14f004b21ed26289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200710191144epcas1p30f82bf6371f7f09a4e1ea1262234f392
References: <CGME20200710191144epcas1p30f82bf6371f7f09a4e1ea1262234f392@epcas1p3.samsung.com>
        <20200710191122.11029-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 7/11/20 4:11 AM, Lukasz Luba wrote:
> Hi all,
> 
> This is a v2 patch set adjusting Exynos5422 DMC to the new devfreq monitoring
> mechanism. This time the IRQ mode is explicitly controlled using module
> parameter (in default the driver uses polling mode = devfreq monitoring).
> 
> The detailed cover letter describing the topic can be found here [1].
> 
> The patches should apply on top of Chanwoo's devfreq-next branch, where
> the new devfreq mechanism is queued [2]. If there is no objections
> I think they can go via this tree, since they logically use it.
> 
> Changes:
> v2:
> - added Reviewed-by from Chanwoo for patch 1/2
> - added module_param which controls the mode in which the driver operates
> - switched in default to devfreq monitoring mechanism instead of interrupts
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/linux-pm/20200708153420.29484-1-lukasz.luba@arm.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
> 
> Lukasz Luba (2):
>   memory: samsung: exynos5422-dmc: Adjust polling interval and
>     uptreshold
>   memory: samsung: exynos5422-dmc: Add module param to control IRQ mode
> 
>  drivers/memory/samsung/exynos5422-dmc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Applied them to devfreq-next branch. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
