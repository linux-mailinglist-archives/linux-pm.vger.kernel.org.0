Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDFD2A2AD8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgKBMk7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:40:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56018 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgKBMk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 07:40:59 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201102124047euoutp01da6846228be081367dca70fd502e0aa1~DsU_RnNHI2107121071euoutp01j
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 12:40:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201102124047euoutp01da6846228be081367dca70fd502e0aa1~DsU_RnNHI2107121071euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604320847;
        bh=bWbmHJ8Du94K7fAcUqgi6AZ5cA8+sLowwwXH4NkGAxM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GnVqcu/nFACV2HlqwVURVZNxUhaTWOO5aSumoYAmTFoOUpoyJBB1LxbywKVzsGB+5
         lMLzjL+Is4vbKTrz0u4U9Qvx0poP/ulEPmpQOMBJiVj5mh2QI4hv1lu3HTPBbvC6s8
         hAfYPbJLuKTByn52zmljRmFcK+9JOj856CURf2Vo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201102124046eucas1p1b9b691bb50e03c6c36d273e1f8a2b2d1~DsU9XoFHn2519725197eucas1p1i;
        Mon,  2 Nov 2020 12:40:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EC.B1.05997.E4EFF9F5; Mon,  2
        Nov 2020 12:40:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201102124046eucas1p15cd9e163dbab72cdc639f5e71d8b6a18~DsU83Ov3w2548025480eucas1p1o;
        Mon,  2 Nov 2020 12:40:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201102124046eusmtrp1d756f9fc75e6d18bf544860bd2a2610d~DsU82a0VW0712107121eusmtrp1d;
        Mon,  2 Nov 2020 12:40:46 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-77-5f9ffe4e1cde
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.76.06017.D4EFF9F5; Mon,  2
        Nov 2020 12:40:45 +0000 (GMT)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201102124044eusmtip29d092f9ae4a62c942b57db01db98d466~DsU73NJjF2594525945eusmtip2q;
        Mon,  2 Nov 2020 12:40:44 +0000 (GMT)
Subject: Re: [PATCH v7 6/6] drm: exynos: mixer: Add interconnect support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <f8f4dce0-9da2-30d6-32bf-4b6ec9f11f5e@samsung.com>
Date:   Mon, 2 Nov 2020 13:40:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201031124717.GE9399@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuO46OHafpyxKDUwQVapbQCaUbQQuirP+6aSc9qKhTdubK
        EFqUXczFMkhbl2lZ2ULUY1hpy7U0CdERXdXVoFZRYRc2E8s0j6fI/37v877v9z4PfBSmfUzo
        qFyDSTAa+HyW1OCtD0e98ZvGHRlL3lrncf6LZYhrrm4kuBehDwTn6OwjuKfDX0muyiWRXKXf
        hnNeb5Oae9J2nuSC1k7EVXvvqbiGzldqbvBgPcmVuTrVXPXpj+TqWXrJeZzU+57fJfX+E90q
        /cmbTqQPSnFpxHZNapaQn2sWjIkrd2ty+m/EFVnxfRcHjhIWdAErR2EUMMlgc7lQOdJQWqYe
        wYPW46pyRE0WIQRjWxQ9iGD4/QD5b6HO1YUpjWsILkgtuFJ8R3Dd0oHLU5GMHvraapHMUcxC
        ePF7hJCHMOaXCg45e9Vyg2SSwNp1EsnnaGYl+B6ysowz8+H+m6NT78xm0sHWfHiKaSYCHp0N
        THEYkwDfzlwmZMaYGBgIOFQKz4VbQ+en3AEzqoYflZJKsb0OWjwVSOFI+NR9U61wLPScrsCV
        hUMIKtoH1UphQ+Dvrvm7kQK+vp+k7BSbjNPYlqjIa6Cjzq2WZWDC4eVQhGIiHCpbqzBFpuHY
        Ea0yPR9+Oav+2tHBicAEbkOsfVo0+7Q49mlx7P/v1iDciWKEYrEgWxCXGoS9CSJfIBYbshMy
        CwskNPnResa7Q7dR29geD2IoxM6k3ZGODC3Bm8WSAg8CCmOj6LW9PelaOosv2S8YCzOMxfmC
        6EFzKJyNoZdd+rhLy2TzJiFPEIoE47+uigrTWVApH5Nhi3drDrCm6NI7vlVNqVIa5kqqvbrZ
        seNU0djMFaGlQ/cbC83JXa4rn2fcpk3E4Jdnktulz5szsbGD4Ps3pC0fqZcmzKOJmeu9seGv
        U7ac6zWP77TkZOrcDZ7+x7ZAe9a2rXuDP9+lL4gcWRzlN5SIOz0LnzdwmUfKtkWzuJjDJy3C
        jCL/BzLy3AtkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7q+/+bHG6xfZm1xf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C3uLxrDpvF594jjBYzzu9jslh75C67
        xe3GFWwWrXuPsFvMmPySzYHfY9OqTjaPO9f2sHnc7z7O5NG3ZRWjx+dNcgGsUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZN1fLFfSyVMy71c7a
        wDiXuYuRk0NCwERiyd6jYLaQwFJGiUVv47sYOYDiUhLzW5QgSoQl/lzrYuti5AIqec8o8Wbp
        IyaQhLCAh8S5XQsZQWwRAU2J63+/s4IUMQv8ZpI4cO8yC0THY0aJ40/62UGq2AQMJXqP9jGC
        bOAVsJO4cwxsA4uAisTBR+0sILaoQJzEj4m9bCA2r4CgxMmZT8DinAJ6Eh+mLWYFsZkF1CX+
        zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQIjeNuxn1t2MHa9Cz7EKMDBqMTDe0B4frwQa2JZcWXuIUYJDmYlEV6ns6fj
        hHhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmFzySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJ
        pCeWpGanphakFsH0MXFwSjUwrmrQyajdsuaVsrPCly7bSVN3vfnsfPBFqXJ6+qHJ59uuFM/u
        SxLLblm1X0Ykwu366tXxbm7p7KyLr81VZa4ObV3lf33OgdcZi0sXt2+fMC/xnH+PUtij2S7T
        Jm7dUGHLwfR9TerVarGXRkoHM9M4HhuZH55u/ufcxYZ1rZMuHDj2b2XIks+HbyuxFGckGmox
        FxUnAgDqsO3P9gIAAA==
X-CMS-MailID: 20201102124046eucas1p15cd9e163dbab72cdc639f5e71d8b6a18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e
References: <20201030125149.8227-1-s.nawrocki@samsung.com>
        <CGME20201030125308eucas1p14ae969ae1d5549d422c478aa54d3311e@eucas1p1.samsung.com>
        <20201030125149.8227-7-s.nawrocki@samsung.com>
        <20201031124717.GE9399@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31.10.2020 13:47, Krzysztof Kozlowski wrote:
>> @@ -1223,19 +1330,33 @@ static int mixer_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	const struct mixer_drv_data *drv;
>>  	struct mixer_context *ctx;
>> +	struct icc_path *path;
>>  	int ret;
>>  
>> +	/*
>> +	 * Returns NULL if CONFIG_INTERCONNECT is disabled.

> You could add here:
> or if "interconnects" property does not exist.

Right, thanks for pointing out, I will update that comment.

-- 
Regards,
Sylwester
