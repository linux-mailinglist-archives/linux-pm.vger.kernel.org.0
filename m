Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D802E2197F7
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 07:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGIFdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 01:33:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28587 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGIFdN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 01:33:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200709053311epoutp0313db5de0b8bb7590f9b914d7aaf1fb6b~f-qgc04rX3246432464epoutp03G
        for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2020 05:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200709053311epoutp0313db5de0b8bb7590f9b914d7aaf1fb6b~f-qgc04rX3246432464epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594272791;
        bh=X1YTmOssBERAODSAsBETo/lT7xvXnUKuUFH7w23s9GM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nSK+YTrEhYpQq9jHzurwJ0Eawyshff6nugLhlApRFlKb3YEf8Y/KAI1f2C/qtXVCu
         PVePRLVC4sm5PcutyGP6veXsXavitaY5W2BcsBUffLxAUUL/9uUijTEmNCHk+VEjJP
         o3eqcz+2dpSkVpzAVes+pehk/s/4ZTYINO5FpUS0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200709053310epcas1p4d71fd0b031de9cc974cf46ffa5e297ff~f-qfuNrfY1088810888epcas1p4r;
        Thu,  9 Jul 2020 05:33:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4B2Pw339C0zMqYm0; Thu,  9 Jul
        2020 05:33:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.44.29173.31CA60F5; Thu,  9 Jul 2020 14:33:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200709053306epcas1p1eda05ae48fbfc875ab6bc4fc029a96c9~f-qcconfX2317323173epcas1p1a;
        Thu,  9 Jul 2020 05:33:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200709053306epsmtrp25f0ec2fb134aaeba1b3f4d323b5a24e5~f-qcb21jr0317203172epsmtrp2b;
        Thu,  9 Jul 2020 05:33:06 +0000 (GMT)
X-AuditID: b6c32a37-9b7ff700000071f5-7b-5f06ac1369d8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.F1.08382.21CA60F5; Thu,  9 Jul 2020 14:33:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200709053306epsmtip2a5f8b7503a77e7f2f433c02bbae18ad3~f-qcNBlZm2921929219epsmtip2k;
        Thu,  9 Jul 2020 05:33:06 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] memory: samsung: exynos5422-dmc: Use delayed
 timer as default
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     lukasz.luba@arm.com, k.konieczny@samsung.com, kgene@kernel.org,
        s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <01df3ca7-a958-57a7-6120-3d7d3f2b394e@samsung.com>
Date:   Thu, 9 Jul 2020 14:44:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200708123303.GB29033@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmnq7wGrZ4g6OvhC02zljPajHxxhUW
        iwWfZrBa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLGwqYXd4nbjCjaL
        w2/aWS2+nXjE6MDnsWbeGkaPnbPusntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEVl22SkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAXaukUJaYUwoUCkgsLlbS
        t7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM7oumFT0MdWcWvy
        buYGxlcsXYycHBICJhLbHmwFsrk4hAR2MErc/PSHEcL5xChx6/wasCohgW+MEvNeOcF0nN8+
        kw2iaC+jxP6zj5khnPeMEhOWH2UFqRIWiJG4P2cnE4gtIqApcf3vd7A4s8BTJonOp6YgNpuA
        lsT+FzfYQGx+AUWJqz8eM4LYvAJ2Env+vmEGsVkEVCQ2Nq4Hu0JUIEzi5LYWqBpBiZMzn4DF
        OQX0Je59Wc4EMV9c4taT+VC2vMT2t3PAjpMQuMIh8e/SZ0aIF1wkXvS9Y4OwhSVeHd/CDmFL
        SXx+txcqXi2x8uQRNojmDkaJLfsvsEIkjCX2L50MtIEDaIOmxPpd+hBhRYmdv+cyQizmk3j3
        tYcVpERCgFeio00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXF
        uempxYYFxsiRvYkRnJC1zHcwTnv7Qe8QIxMH4yFGCQ5mJRFeA0XWeCHelMTKqtSi/Pii0pzU
        4kOMpsAAnsgsJZqcD8wJeSXxhqZGxsbGFiaGZqaGhkrivJ8WsMULCaQnlqRmp6YWpBbB9DFx
        cEo1MJ1nOxOkybP7piPX6brMi4Yb1lwSXLUg5NiBwr8JFt0qwhWbEj5mOR0RyIxaEhqxJOiV
        oe+MmC93Qpo3h6y8Icm0OT0j45XPa+03pqWXw6euUgji8ViyzyLtqGgpd2Xq2/B1v4OMnqk9
        m/H40p7G1i5Vy+zOVbHy8tdUwpL3VU3kK98SvX2V28QgtUncKay/bko9mDcl+MRXidyVS64r
        X58wi425di73bN/YZi6r9fJGMpmcQpcYgm6Vn7NJTjjBtcFwncurBaYCgUHvFihsY/5bsEje
        M9h+i2bb/Lt/lO+1c8653JTBUNqjxB+h/OHqx9kqAneFLzx48vZUr5ba1FMpQol/NuUnzOe7
        cZpvsxJLcUaioRZzUXEiAL/4eCpRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSvK7QGrZ4g0OftS02zljPajHxxhUW
        iwWfZrBa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLGwqYXd4nbjCjaL
        w2/aWS2+nXjE6MDnsWbeGkaPnbPusntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEVx2aSk5mSWpRbp
        2yVwZXTdsCnoY6u4NXk3cwPjK5YuRk4OCQETifPbZ7J1MXJxCAnsZpRYfe87VEJSYtrFo8xd
        jBxAtrDE4cPFEDVvGSU6HmxjB6kRFoiRuD9nJxOILSKgKXH973dWkCJmgadMEofPP2eH6HjC
        KLHh+mNGkCo2AS2J/S9usIHY/AKKEld/QMR5Bewk9vx9wwxiswioSGxsXA92hahAmMTOJY+Z
        IGoEJU7OfAIW5xTQl7j3ZTlYnFlAXeLPvEvMELa4xK0n86Hi8hLb385hnsAoPAtJ+ywkLbOQ
        tMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwdGpp7mDcvuqD3iFGJg7G
        Q4wSHMxKIrwGiqzxQrwpiZVVqUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgsky
        cXBKNTA1xG0oKp8f3Fa3ZwKf+W6x7o0e/24VeDQ3xj6Pf/ggsr79ZPYd3ckJdwttPgXNbDz0
        +/OeG7emMAr9YyyK2lPc1vfinEbVTZXnScJ3dq1dM2XN01XBHU3Nu/LuPTgasHxD9p5fM2d0
        LglUmR6b6vfpl47ehn+TX25o5ErtVeXpP1ob+GsVC4vpFX/GiyU/rjZ2fKr7YusrF+j8PKfd
        KMz49GbOJ1ef7bDaqH75E0+Tt/8+39sRHQGF66P+fdp00OCD2tVduwXPM0Ssm7lUx+Gi9mn5
        n6FnT2zwCY/Oy0g9Jh1dtORmuTa/fPPBGU/3Fi1446aUXyK099TDO3tntpj80rwzqfrHw2e+
        s7Nv+LY0K7EUZyQaajEXFScCAN26sRI9AwAA
X-CMS-MailID: 20200709053306epcas1p1eda05ae48fbfc875ab6bc4fc029a96c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb
References: <20200703062622.11773-1-cw00.choi@samsung.com>
        <CGME20200703061509epcas1p3e338b614c44f5d8b566dae92f11cc8cb@epcas1p3.samsung.com>
        <20200703062622.11773-3-cw00.choi@samsung.com>
        <20200708123303.GB29033@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/8/20 9:33 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2020 at 03:26:22PM +0900, Chanwoo Choi wrote:
>> Use delayed timer as default instead of deferrable timer
>> in order to monitor the DMC status regardless of CPU idle.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/memory/samsung/exynos5422-dmc.c | 1 +
>>  1 file changed, 1 insertion(+)
> 
> If you want to take this through devfreq tree, I'm fine:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

OK. I'll take it to devfreq-next for v5.9-rc1. Thanks.

> 
> Otherwise I could grab it through samsung-soc after devfreq change ends
> in mainline.
> 
> Best regards,
> Krzysztof
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
