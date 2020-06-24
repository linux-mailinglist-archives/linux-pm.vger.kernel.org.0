Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0A2070C2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbgFXKGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:06:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51740 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390228AbgFXKGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 06:06:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624100619euoutp0251cec7d20e53e7171526c0150859f548~bctte_As71844918449euoutp02b
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 10:06:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624100619euoutp0251cec7d20e53e7171526c0150859f548~bctte_As71844918449euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592993179;
        bh=gmdK05OlNDzyRqMjs63+sr2ds8kaMPlsYliW3RCJnwM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QxwBtk6KHqtlQ/tj2lMc90VdDsSIJhFdhDiK3jWXXdN0R624jdQnYIa2fjH3XtSWL
         K69SSypdrgRLUgo69j0hk1yjZ/O3a3FZ7nwXW9+Xo3HSQNcYM9oA/WmWmNcmMXORJc
         8kHGYi0EcuCxSJYCbmkf29cgVEbfD/57HGiC45sY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624100619eucas1p1d73af6ccd1b4ba50d5f077b061587fff~bcttL8EBW1971919719eucas1p1G;
        Wed, 24 Jun 2020 10:06:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.50.05997.B9523FE5; Wed, 24
        Jun 2020 11:06:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624100619eucas1p256c46e5f2f263da3dacb4a4b4708a6fd~bcts4GFJu1629416294eucas1p2u;
        Wed, 24 Jun 2020 10:06:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200624100619eusmtrp200d8f3cf415fb037c07813baed1fd019~bcts3Yqym0244002440eusmtrp2j;
        Wed, 24 Jun 2020 10:06:19 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-6d-5ef3259b83dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.35.06017.A9523FE5; Wed, 24
        Jun 2020 11:06:19 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624100618eusmtip1e28e7de5f25c3ba8218c3d1d7abe235a~bctsdX_9j2278622786eusmtip1h;
        Wed, 24 Jun 2020 10:06:18 +0000 (GMT)
Subject: Re: [PATCH 3/4] ARM: exynos_defconfig: Enable big.LITTLE cpuidle
 driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ffab72c0-7df8-d190-16d2-8c6833108e26@samsung.com>
Date:   Wed, 24 Jun 2020 12:06:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616081230.31198-4-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/Xa2c46jyXEavpglDIws0rKiY4ZZSA6isgsUgdbS46Wcyo6a
        +k9q5mXlvBXmFGdiasN0THFNKmJ5oSSNMCnRMjSc1SidGl7SPJ4s//t9z/s+vM8DH4lJDSJ3
        MjY+iVHFK+JkuFjY1jXXu7PCyx6+a9nqTFfZN9N9fQaCNo4OiGh7QQei7/U9E9DfF6wEfT8r
        m6AfdQwTQaS8saoRyY36fFw+NPAEl7fUXpdrWvVIbjduCcUviA9GMnGxKYzKN/CSOCbDNocn
        1hGpP8fFGUiLq5EjCdReKG26gXEspRoQTOZ6qJF4hacRFGYNEPzDjmCicvafY6p8VsAP6hEs
        L84LebsNge1DAMcu1GnoHh1eNbhSvnArpx9xjFFFAjB/ZjjGqQNQnKtf0UlSQgWC6VMUJwsp
        LyhWlxAcb6TOw9TICxHHEsoZXpaPrZ5yXFnv1/B5MMoNBsd0Ap49wWSrxLhsQFkI6HpqQnzo
        YBipMGI8u8DX7laCZw9YNusEvKEJwe8861+3CUF96dLfygEw1DuPc0kxyhua2315+TA05X8U
        cTJQTvDe5syHcIKStjKMlyWQlyPlt7eCoc6Ar51Vmx9iRUimXVdNu66Odl0d7f+71UioR25M
        MquMZli/eOaaD6tQssnx0T4RCUojWvlHPUvd049R++JlC6JIJNsgMYxMhktFihQ2TWlBQGIy
        V8mR1z3hUkmkIi2dUSVcVCXHMawFbSKFMjfJnpqJMCkVrUhirjJMIqNamwpIR/cMhBzG7PqE
        IHNCRFSnXO+pDMFY3W1V9plMvysxKq+y1PqUQ7+6it59aSk826kJM7XeWcjU2YO7K2ST1cXf
        wrJD58y1Tidma7Z1+tMN+1JOvgl5NdOvDGjZccr7Jq0Z9ekpsx53SEo/VtDePLN/qpGNtJ4b
        z8g8Ovzj+eDdB2/N/u4yIRuj2L0dU7GKP+EqG8hDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7qzVT/HGZydxWgx77OsxfnzG9gt
        Nj2+xmrxufcIo8WM8/uYLN78fsFusbCphd1i7ZG77A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXkbD259sBcvYKz4852pgnMXWxcjJISFgIvFp5jemLkYuDiGBpYwS73/vAkpwACVk
        JI6vL4OoEZb4c62LDaLmNaPEwx9trCAJYYEgieOP74INEhHQl+huu8IIUsQsMIlJ4seZO2AJ
        IYGjjBJPn2qC2GwCVhIT21cxgizgFbCT2H4/DSTMIqAqMbFrEjuILSoQIXF4xyxGEJtXQFDi
        5MwnLCA2J1D5lb5vYCOZBdQl/sy7xAxhi0vcejKfCcKWl9j+dg7zBEahWUjaZyFpmYWkZRaS
        lgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3DbsZ9bdjB2vQs+xCjAwajEw7vhwcc4
        IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjA55JXEG5oa
        mltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYNyjf6SjfEvf1ekdM16Fvvdf
        dFDsOcf1n/EMYezGaSeYWRMzhVmXf3l+aRv7jMrUXJPPJ0ujU/cc2v3CgmtntdjDqDxdX91v
        KaKyK9101jQsdX3DFB+z7pXS/v3H7qT93RiQusZq8qMLf5edPZL6LqK8qL5/ZmafUZxTYs8J
        OxmvViaVTs2ld5VYijMSDbWYi4oTARFenOzWAgAA
X-CMS-MailID: 20200624100619eucas1p256c46e5f2f263da3dacb4a4b4708a6fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081250eucas1p2de7110898dad050866d78cb5d5120422
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081250eucas1p2de7110898dad050866d78cb5d5120422@eucas1p2.samsung.com>
        <20200616081230.31198-4-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/16/20 10:12 AM, Marek Szyprowski wrote:
> Enable big.LITTLE cpuidle driver, which can be used on Exynos-based
> Peach Pit/Pi Chromebooks.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 374fbff8eaa6..c928bc710c48 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -28,6 +28,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
>  CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_CPU_IDLE=y
> +CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> 

