Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66AD2070C4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbgFXKGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:06:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39803 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390133AbgFXKGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 06:06:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624100644euoutp01d960a0aca504ee561f97a97b764bf434~bcuEcQfPg0952509525euoutp01r
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 10:06:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624100644euoutp01d960a0aca504ee561f97a97b764bf434~bcuEcQfPg0952509525euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592993204;
        bh=ElIIgJiCGK3igywiFZvai5FDMBo5AkeSvYXQLNTvpI4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=imdBl9PIQqH92B5TVh6YvBMoVNnnEvOxUCR24J65QIvyQd30HOvPVtlzPUSy9vm28
         k0lr0EdFKMEWLKI/tN1du+4IfLNDQhw2zL19UwaS3zDvsrGuKrPXZSwpQi5ZHP8/75
         P15uZb84FrV2IzI4CBc+MQzBnxhLqQXqeoX3qwHk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624100643eucas1p212a0e63f9f2be65f9c9dcaea403103a2~bcuD70-3P2465624656eucas1p20;
        Wed, 24 Jun 2020 10:06:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.FB.06456.3B523FE5; Wed, 24
        Jun 2020 11:06:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624100643eucas1p2afb2e6567bb6dda6ea237ad2bf3a7051~bcuDdxAh01629516295eucas1p26;
        Wed, 24 Jun 2020 10:06:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624100643eusmtrp101841f7e1e88bcbceb564666c728459f~bcuDc-TWZ1004110041eusmtrp1H;
        Wed, 24 Jun 2020 10:06:43 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-f9-5ef325b31d03
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.76.06314.3B523FE5; Wed, 24
        Jun 2020 11:06:43 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624100642eusmtip20d288534e9ef67ebaa19c8c663537068~bcuDAmEmP3156331563eusmtip2C;
        Wed, 24 Jun 2020 10:06:42 +0000 (GMT)
Subject: Re: [PATCH 4/4] ARM: multi_v7_defconfig: Enable big.LITTLE cpuidle
 driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5262c50b-d9b8-8f32-874e-5ebc0672ed8c@samsung.com>
Date:   Wed, 24 Jun 2020 12:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616081230.31198-5-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87qbVT/HGWx+qWsx77OsxfnzG9gt
        Nj2+xmrxufcIo8WM8/uYLN78fsFusbCphd1i7ZG77A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8aTu19YCw6wV0zcNZWpgXEbWxcjJ4eEgInE6sVb
        gGwuDiGBFYwS7zd/Z4ZwvjBK/DvezgLhfGaU6N6+jAmm5fui70wQieWMEt+fnWYFSQgJvGWU
        2LuWA8QWFgiR+HajixHEFhHQl+huuwJmMwtMYJLY+TAVxGYTsJKY2L4KLM4rYCdxue0QM4jN
        IqAqceHGc3YQW1QgQuLTg8OsEDWCEidnPmEBsTmB6t/fameDmCkucevJfCYIW15i+9s5zBCH
        7mOXuHlKGMJ2kfh34S47hC0s8er4FihbRuL05B6wLyUE1jFK/O14wQzhbGeUWD75HzSUrCXu
        nPsFZHMAbdCUWL9LHyLsKPH2bTcTSFhCgE/ixltBiBv4JCZtm84MEeaV6GgTgqhWk9iwbAMb
        zNqunSuZJzAqzULy2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525i
        BKak0/+Of9rB+PVS0iFGAQ5GJR7eDQ8+xgmxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkb9OS8b93hcFlZ23Ht+K9tu
        6dVfJJYlFB2turb96VK3JadKlasP2G1/wZcutqDdrndb8iaReXN8fSd1eS7VMZrRdMh1XcS6
        XEbWVL2ssOrM9c9fLpx2bYayhnFNXXbz2jLRal156UVG206w39dkOfP7xObZ2yVmPbNdPIuN
        o2/1Vf99qVYJl7SUWIozEg21mIuKEwGH9PalRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qbVT/HGdyZxGcx77OsxfnzG9gt
        Nj2+xmrxufcIo8WM8/uYLN78fsFusbCphd1i7ZG77A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsaTu19YCw6wV0zcNZWpgXEbWxcjJ4eEgInE90XfmboYuTiEBJYySuw60waU4ABK
        yEgcX18GUSMs8edaF1i9kMBrRomNF81AbGGBEIlvN7oYQWwRAX2J7rYrjCBzmAUmMUn8OHMH
        quEoo8TB/1YgNpuAlcTE9lVgDbwCdhKX2w4xg9gsAqoSF248ZwexRQUiJA7vmAVVIyhxcuYT
        FhCbE6j+/a12sJnMAuoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJG
        llWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbjt2M/NOxgvbQw+xCjAwajEw7vhwcc4IdbE
        suLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjA95JXEG5oamltY
        GpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYEwMdVA7Kv+U4ZjxFbMFUh+bam9z
        TOm7tEakM96qxEp4ZYDZv+Db+9ccO7hN7nar9Z5LQr0Ggo8N9ezv6rBtl2jWyzolsiHCL+Di
        6keuYkvNeW2cJWbmrFY9sHRZbSCXXMXBlJOslXt37mblf3P6j3tY3OqPteUi9YcL00/wT8ry
        dHgecFc1VYmlOCPRUIu5qDgRANo6Y/jXAgAA
X-CMS-MailID: 20200624100643eucas1p2afb2e6567bb6dda6ea237ad2bf3a7051
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081250eucas1p2a98f8810962ddc692fa5588a74f911b3@eucas1p2.samsung.com>
        <20200616081230.31198-5-m.szyprowski@samsung.com>
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
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 95543914d3c7..6a922a8ef712 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -111,6 +111,7 @@ CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
>  CONFIG_QORIQ_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_CPUIDLE=y
> +CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
>  CONFIG_ARM_ZYNQ_CPUIDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
>  CONFIG_ARM_TEGRA_CPUIDLE=y
> 
