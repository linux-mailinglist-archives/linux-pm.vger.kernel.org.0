Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7D2925C5
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgJSK1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:27:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22996 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgJSK1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 06:27:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201019102740epoutp028925f6df6791653611a9e61c58e298d6~-Xev_hMnX1509815098epoutp02s
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 10:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201019102740epoutp028925f6df6791653611a9e61c58e298d6~-Xev_hMnX1509815098epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603103260;
        bh=yDoDNggOg225OrRqSzF1Bazr7Llyp7wh5Skp9ddw+sE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tqtSjjqN0J/CyHqud8XhIJe2YsS5jLLchn7D+Z/iQbmhafUN9rRsveinPyIho2H8v
         gibGLwwlcDjawTb9CBJHsBFDH+gHqrLw05R1V7/Cp+gTMGM6P4ymywCyv3xNizYFXz
         F+plIiExPtscarsXOZA/Y3QjHO6Z/7jPf6gx0T5w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201019102739epcas1p42e5bfcd73ff2fa8b98b3cd0e920fd705~-XevXOg6F0830008300epcas1p4u;
        Mon, 19 Oct 2020 10:27:39 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CFCcn42zwzMqYkj; Mon, 19 Oct
        2020 10:27:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.1B.10463.91A6D8F5; Mon, 19 Oct 2020 19:27:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201019102736epcas1p32f607ce884d698b00f7f3a4c89f7fbbb~-XesqXydC0660906609epcas1p3T;
        Mon, 19 Oct 2020 10:27:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019102736epsmtrp21ee944d31054f04479a958947c9f1f89~-XespcpP31185611856epsmtrp2z;
        Mon, 19 Oct 2020 10:27:36 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-f5-5f8d6a195582
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.EE.08604.81A6D8F5; Mon, 19 Oct 2020 19:27:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201019102736epsmtip27f942c8dd0686286e094a9cede41c278~-XesV_66R0681806818epsmtip2S;
        Mon, 19 Oct 2020 10:27:36 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Organization: Samsung Electronics
Message-ID: <d198e358-f636-2f52-1d73-098f8bebffbf@samsung.com>
Date:   Mon, 19 Oct 2020 19:41:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1db2fb62-0b82-409d-20a7-c2ef376d4580@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzO6eP21q1yrIBHNIjXmE0USimFqwNnpm6Nw8GeCWroOnpDEWib
        e2ERCRsojIdjwxCSrkFExpBHN0YlUKuE0FUXXkOHCIjdXOgmEShQHKtD4/oy47/vd37fd77z
        /c45OFs4hYXgGeocilYrsghsHafrp12iiM0nK+VRtrtbyaZfbwCyQ9fOJc9P3OGQbUvTgDRM
        WQDp+nGATRbrGzhkvVPHJYfPzPHIZtsSlxw112LkcqUVkOWP9Rh56Uwxj5wqasbIJ+Y6zgEo
        M9QZgMxkawSyq3obT2ZsLcdklWcdmKzDYWLJnul7ObKvOluBbNkYmsw/lhmvohRKig6j1Gka
        ZYY6PYF4+335Qbk0NkocId5LxhFhakU2lUAcSkyOeDMjy52DCPtUkZXrXkpWMAwh2h9Pa3Jz
        qDCVhslJICitMku7VxvJKLKZXHV6ZJome584Kipa6iZ+nKnSGbq52mH8VE19Pa8QrGAVgI8j
        GIMW255xK8A6XAhNAJUUtbB8hROg3zpW2b5iBSDXQAnvhaS0rtTP6gHo+blKv34BoFqX08va
        COVosn2F7cEYDEe9MxNew0BYgKy3H2AeARs2s5ChfZjjaQTA7WjMNQ08WAD3o/nvrSwP5sCd
        qG1u1isOgh+h/q5iP2cD6v/G7tXy4euoumvJy2HDTeie/SLLh7eh7vlabwYEXTiaWRhj+TIc
        Qg5rJfDhjejRz53+bCFo2dHjH00+aum3Yj5xGUCdvbe4voYE9X5X7d4IdzvsQu1mkW95O7q6
        egH4jNcjx99fcj0UBAWo7Auhj7IDjT6w+Y+wGX1bWo5VAUK/Jo5+TQT9mgj6/83qAacVBFNa
        JjudYsTamLX3bQTeVx5OmsCF+cVIC2DhwAIQziYCBSkbKuRCgVKRd5qiNXI6N4tiLEDqHvB5
        dkhQmsb9TdQ5crE0WiKRkDHiWKlYTGwSPN1dJhfCdEUOlUlRWop+oWPh/JBC1jbnQUGE3bw4
        ePR62dBCtW22aWu8ceeWi+zDiYOi8ap7/+J5Txt1E9c+qzCE8uFNla3kWtKcY8L0y0suZmQo
        eOCyPdEYfvfI6In7x45nvrMFDil7/onVTexhhJ1Xaq4YdnfM5j0pv9/33uOUT8ZhI736SlHq
        SSruz2lefkEtVcCLDw/mNtTxxuLevRSSz3t+c+xzOH58h2j6yI23Aj6Q/KGm26IfpmCp0Jha
        U1Y4bk06ahqx/HW7qeVs3w/OO5fN1wdrTrCSZmbOvdb9sGDf0qS0ubB4j1kVNHLqdO38ra81
        B5QfVh0OyKPrQtf//nJog2D+VWVFXOBsov2RpS9wfGwy9Q2Cw6gU4nA2zSj+A88TQkxuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCSvK5EVm+8wcaHJhbLLh1ltNg4Yz2r
        xcQbV1gsVn98zGix5vYhRosfG04xW7TMWsRiseDTDFaLs01v2C1W3P3IanF51xw2i8+9Rxgt
        Or/MYrNY2NTCbnG7cQWbxc9d81gcBDzWzFvD6LHj7hJGj52z7rJ7bFrVyebR2/yOzWPjux1M
        Hn9n7Wfx6NuyitHj8ya5AM4oLpuU1JzMstQifbsErowZa7azFpzlqJi6YAF7A+M3ti5GTg4J
        AROJ9nntTF2MXBxCArsZJd6s2coCkZCUmHbxKHMXIweQLSxx+HAxRM1bRon5Z/awg9QIC8RL
        3Fz/jRnEZhPQktj/4gbYUBGBWolXq6ezgtjMAiuYJBZ+FoJoXs4k8W/vWSaQBL+AosTVH48Z
        QWxeATuJt2uPgMVZBFQlVr95DTZIVCBMYueSx0wQNYISJ2c+ATuOU8BeYvK2j2wQC9Ql/sy7
        xAxhi0vcejKfCcKWl9j+dg7zBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1
        ihNzi0vz0vWS83M3MYIjWktzB+P2VR/0DjEycTAeYpTgYFYS4Y0U7IoX4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznujcGGckEB6YklqdmpqQWoRTJaJg1Oqgck6KmfKslul4rfydl2IZ22N/rXL
        0cNCd7v6TjGBXpb/lXcEN9kd3hvuFzPl5crbBXx+u55t792pOjOmydHTR/yW0uHHWyf1HVzv
        u6bRtaa+UfrEN/tDC5W2Zgpb37R/rHrJ61LFuxXTSz+0LolrldZ1+LXDI3/b0hO7/fTkBF+I
        NOwIzzzdGVdyTD84tjbtq9XV545/us807mv+6bzkh0+K8RfrhoCt1YufPVyZMffDZS4WK5Us
        P1/rqi8xTzq2nuz39GX8qbSWb2rk7PvnOmzzyxfG/6h6tr+Nkd+KMbH2WtGsM+HnGyfLrX7H
        J8Rp3GR/TKvGeE7ZE99vUXJ3MsLFdrcJTsx5dW2eCOvr2UosxRmJhlrMRcWJAELi1pFXAwAA
X-CMS-MailID: 20201019102736epcas1p32f607ce884d698b00f7f3a4c89f7fbbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767
References: <20201007050703.20759-1-cw00.choi@samsung.com>
        <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
        <20201007050703.20759-3-cw00.choi@samsung.com>
        <4cb8ece7-9399-9ee0-5f93-6c19630308d6@gmail.com>
        <1db2fb62-0b82-409d-20a7-c2ef376d4580@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/19/20 1:11 PM, Chanwoo Choi wrote:
> On 10/19/20 9:39 AM, Dmitry Osipenko wrote:
>> ...
>>> @@ -1361,6 +1373,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>  		goto out;
>>>  	}
>>>  
>>> +	remove_sysfs_files(df, df->governor);
>>> +	create_sysfs_files(df, governor);
>>> +
>>>  	prev_governor = df->governor;
>>>  	df->governor = governor;
>>>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>> @@ -1460,39 +1475,6 @@ static ssize_t target_freq_show(struct device *dev,
>>>  }
>>
>> The further code may revert df->governor to the prev_governor or set it
> 
> prev_governor is better. I'll change it.
> 
>> to NULL. The create_sysfs_files(df->governor) should be invoked at the

Also, when creating and removing the sysfs files, devfreq instance is needed
because of df->dev.kobj. So, *_sysfs_files need the two parameters.

>> very end of the governor_store() and only in a case of success.
> 
> OK. I'll add more exception handling code.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
