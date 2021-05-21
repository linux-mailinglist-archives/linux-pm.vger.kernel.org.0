Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2D38BD14
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 05:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbhEUD6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 23:58:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30404 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhEUD6X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 23:58:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210521035659epoutp030870fc3c81cc90124e9418277f97d377~A_MuoKF-M2578325783epoutp03Y
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 03:56:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210521035659epoutp030870fc3c81cc90124e9418277f97d377~A_MuoKF-M2578325783epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621569419;
        bh=BTNkets0/BhE0imIWW//VHKC1l1wIVjQ1Na7P/zFRE4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F4cg0tMREwp91is3gANgt6SSPbU0i1lhPFUkuxkJMLC+S2hOZKc4Ki0UJ4iB5j0Uz
         b+Z8DiTUpAmR5mwXLVQ10vCekrQS40ebfyxOq3bMMyD1avm0KtBSQH2/Dridky4KC0
         ea10zKNphIt7NcbS+RZgLWnJCOwfxdWQquI3IYxs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210521035658epcas1p2c5e2c28b5ba4f329ac1293abdb09a714~A_MtcCH062946229462epcas1p2R;
        Fri, 21 May 2021 03:56:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FmXqB5PZ9z4x9QB; Fri, 21 May
        2021 03:56:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.1C.09824.38F27A06; Fri, 21 May 2021 12:56:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210521035650epcas1p46221bc6351c16061961846f20a57d748~A_MmSn94m3231732317epcas1p4n;
        Fri, 21 May 2021 03:56:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210521035650epsmtrp2c6d27de61e7a073fd94271fe543bd55b~A_MmRY2HV3055230552epsmtrp28;
        Fri, 21 May 2021 03:56:50 +0000 (GMT)
X-AuditID: b6c32a37-061ff70000002660-57-60a72f83b2cf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.2C.08637.28F27A06; Fri, 21 May 2021 12:56:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210521035650epsmtip10784020d1786a34f9600cd20a2ae845b~A_MmCXttd0130401304epsmtip1v;
        Fri, 21 May 2021 03:56:50 +0000 (GMT)
Subject: Re: [PATCH V2 1/1] PM / devfreq: imx8m-ddrc: Remove
 DEVFREQ_GOV_SIMPLE_ONDEMAND dependency
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1e29beb5-d12d-e0ee-aebf-cd7610f49875@samsung.com>
Date:   Fri, 21 May 2021 13:15:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210521031639.2767156-1-aisheng.dong@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmnm6z/vIEgzWdbBbLLh1ltPgydRez
        xd/N09ksVk3dyWJxtukNu8Wmx9dYLbp+rWS2+Nx7hNHiduMKNosXW8QduDx2zrrL7rFpVSeb
        x+Yl9R4b3+1g8uj/a+DRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaG
        uoaWFuZKCnmJuam2Si4+AbpumTlAxykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
        CiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjO+rV3NUnCbveL3pV72Bsb5bF2MnBwSAiYSLa3P
        mLsYuTiEBHYwSrzb+okdwvnEKLHyznIo5xujxLIlZ9lhWn51L2AEsYUE9jJKdHSLQRS9Z5Ro
        2bsNaBYHh7BAqkTno2yQGhEBR4n1j4+ygtQwCxxnlDi0q5sJJMEmoCWx/8UNsDv4BRQlrv54
        DDaUV8BO4v3zLjaQOSwCqhLzZoSAhEUFwiRObmuBKhGUODnzCQuIzSlgI7Hz0xpWEJtZQFzi
        1pP5TBC2vMT2t3PAXpMQOMIh8e/XelaIB1wkGr4/hXpGWOLV8S1QtpTE53d7oeFSLbHy5BE2
        iOYORokt+y9ANRtL7F86mQnkOGYBTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJ
        ssTlB3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC4yRI3sTIzjd
        apnvYJz29oPeIUYmDsZDjBIczEoivNu9FycI8aYkVlalFuXHF5XmpBYfYjQFhu9EZinR5Hxg
        ws8riTc0NTI2NrYwMTQzNTRUEudNd65OEBJITyxJzU5NLUgtgulj4uCUamAKWRs9P55Lymj3
        CoV3z+IaX+UaJwsa34633rZL2VLz0qd7ivdW1V49+ll7doOh31Vf66c2Z0SsxbT5f09c/c6v
        67pqzrPut5Mfrt3uWf9xxTeBxjlxhbsY2Safj8vbPlmpzuWJ+Zn/dyS4YxbNa3ryzOjBQcdD
        b22derKWmi8pWGG3ScjPsTKoMfDgvZBTBdf+Xpnt3/jB7N+U7Nh1ajPr/eWun3u/zvBjmUXo
        wklGVeqS8XsMzq0OfXja7uufl3yvC5l+PT4cEOm1OunAvrfrKoXCJoYLBt/yC9d95KJ/JF7z
        wiqeovaWDNXs3anKxX9dZ3oUO6wq7dld2Fw3n3HlOp/8cKd9fh+1hPVNS/WVWIozEg21mIuK
        EwFXE0RdQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnG6T/vIEg2OdohbLLh1ltPgydRez
        xd/N09ksVk3dyWJxtukNu8Wmx9dYLbp+rWS2+Nx7hNHiduMKNosXW8QduDx2zrrL7rFpVSeb
        x+Yl9R4b3+1g8uj/a+DRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGd/WrmYpuM1e8ftSL3sD
        43y2LkZODgkBE4lf3QsYuxi5OIQEdjNKfL68iBkiISkx7eJRIJsDyBaWOHy4GCQsJPCWUWLT
        Fn6QsLBAqkTno2yQsIiAo8T6x0dZQcYwCxxnlLi+ZB47xMx+RomVWzaCzWQT0JLY/+IG2GJ+
        AUWJqz8eM4LYvAJ2Eu+fd7GBDGURUJWYNyMEJCwqECaxc8ljJogSQYmTM5+wgNicAjYSOz+t
        YQWxmQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGC405Lcwfj9lUf9A4xMnEwHmKU4GBWEuHd7r04QYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam1f//21e0LVWs
        9njz0KP7u61Y8AT+yVdeO+88v/JXw46PobVVSjnHyvS2ulz6GN8U5aprJcsgUtR9JuTtswiJ
        q7P85G6fF1n160dbWrn9mnNrTlZ8j25zmz7946ZTVplHOG9yLWqqf3/7b9BMxQk3LeYLfDf7
        ZHviqtzZOzOXx89LvxzqxL2hm62+mqWhvPDqJi3JvZ3VQkGcW7rP7588deWSWx8naf985bTJ
        882VpbLnmlJuvXh6ZWa++J2958N1T81jPMv6InN3R0FObL5Cl8eG1U8nbFRc7Dezrv3/qlPp
        efITHmoGfXhd6dlqdlXx/1WplQ3r67XYJ3Q6vQpr3WR209j+n2KKx/rJ/589CVNiKc5INNRi
        LipOBAD3mycDKgMAAA==
X-CMS-MailID: 20210521035650epcas1p46221bc6351c16061961846f20a57d748
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210521031744epcas1p4513da01d2bc9fa59f955fdec20d7c026
References: <CGME20210521031744epcas1p4513da01d2bc9fa59f955fdec20d7c026@epcas1p4.samsung.com>
        <20210521031639.2767156-1-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/21/21 12:16 PM, Dong Aisheng wrote:
> The driver can't support simple ondemand governor due to missing
> .get_dev_status() capability.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>  * update commit title
> ---
>  drivers/devfreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 20373a893b44..e87d01c0b76a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -103,7 +103,6 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  	tristate "i.MX8M DDRC DEVFREQ Driver"
>  	depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
>  		(COMPILE_TEST && HAVE_ARM_SMCCC)
> -	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_USERSPACE
>  	help
>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
