Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128F30B843
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBBHDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 02:03:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60247 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhBBHDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 02:03:03 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210202070219epoutp02c38e89da6d6d038f145e63b38fc9a748~f3DuKzbpc2082920829epoutp02N
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 07:02:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210202070219epoutp02c38e89da6d6d038f145e63b38fc9a748~f3DuKzbpc2082920829epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612249339;
        bh=HZk/iGxmMmUsPUIP+Xen8rXoX5WHXkDNB4oLh6lkz90=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D/lIpbhizrU65SD4Hg/PhUcGGQzQnUmjOkZNdMNlN9ip0p9r7U+zjXyl77xYVwsM4
         wrzpItqja6OTC0uEJFK+BREWg6ZoUn8yNgX6qMcZrQvl3HC5fGQDD5VGbc3Pqo/2XN
         8snUd8LkYeITIFmexfv6ZWrquStMNKQXjXH+H9LE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210202070219epcas1p4f0b13c74052a41f3175699fafe1f7c34~f3Dtg-W1x2917229172epcas1p4L;
        Tue,  2 Feb 2021 07:02:19 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DVG2w73x1z4x9Q7; Tue,  2 Feb
        2021 07:02:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.8B.09577.8F8F8106; Tue,  2 Feb 2021 16:02:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210202070215epcas1p3a294f2e8472c3e25a1bb2768396127ed~f3DqLQhIP1118711187epcas1p3B;
        Tue,  2 Feb 2021 07:02:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210202070215epsmtrp2476dd0ad3161f1f43a35c9a1ab352a9f~f3DqKiyKR0750007500epsmtrp2K;
        Tue,  2 Feb 2021 07:02:15 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-a2-6018f8f88856
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.D6.08745.7F8F8106; Tue,  2 Feb 2021 16:02:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210202070215epsmtip2ffe6eecfb6491a3b6d000ab4123f94a6~f3Dp-wkDD2724827248epsmtip2M;
        Tue,  2 Feb 2021 07:02:15 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, myungjoo.ham@samsung.com
Cc:     kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ebdca75c-1035-8f6e-9f40-fe88f3cbcb5e@samsung.com>
Date:   Tue, 2 Feb 2021 16:18:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1612248924-54419-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTX/fHD4kEgz9rzC3ONr1ht7i8aw6b
        xefeI4wWtxtXsFm8azzM6MDqsfOhpUffllWMHp83yQUwR2XbZKQmpqQWKaTmJeenZOal2yp5
        B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZkZzyZ0M1csJK9YvHNw8wNjA1sXYwc
        HBICJhKzFuV1MXJxCAnsYJS4sGUDM4TziVFiy5MOJgjnM6PEmUWvgDKcYB0bdq1lBbGFBHYx
        SlzdyAlR9J5R4s/kbSwgCWEBG4m5k5aAFYkIOEks37eHCcRmFgiXuLvnPNggNgEtif0vbrCB
        2PwCihJXfzxmBLF5Bewk9v3dCDaHRUBFouXZBzBbVCBM4uS2FqgaQYmTM5+AxTkFvCVe/1zK
        DjFfXOLWk/lQu+Qltr+dA/aOhMBPdoll008yQvzsIvHibB7EM8ISr45vYYewpSQ+v9vLBmFX
        S6w8eYQNorcDGBT7L7BCJIwl9i+dzAQyh1lAU2L9Ln2IsKLEzt9zGSH28km8+9rDCrGKV6Kj
        TQiiRFni8oO7TBC2pMTi9k62CYxKs5B8MwvJB7OQfDALYdkCRpZVjGKpBcW56anFhgWmyHG9
        iRGcFrUsdzBOf/tB7xAjEwfjIUYJDmYlEd5Tk8QShHhTEiurUovy44tKc1KLDzGaAsN3IrOU
        aHI+MDHnlcQbmhoZGxtbmBiamRoaKonzJhk8iBcSSE8sSc1OTS1ILYLpY+LglGpgUql5zfB7
        01MH2RcsEyPXWk+94NaavIZBw1jRWPh46ewpEQxup07/j1tqW7lTTL7MeorWTIvjCd4nNY/E
        LNlUoKXG81Hrd+bVT4ndTQeY64xsFlgWbTquU2TO+3NPa3eQUeX99uf6lewOblONVNwdL018
        23yVJ+/jJp32tZllj5PNf/g77pin/tWS88tzmYgHS6RXPGWw0Pg1ieWwdkv7vSkbnH7/esrZ
        mDO1TrUk5k3Yw9RF9p9OcX3eeiB4Tn552PlpKQWLFpatWN8h4LLV/esa76n6FXk5D/xEXlZ/
        mzOZJ9vUQ27qngfapozxRb2Rr2c8SWoX/rTx0yW5K2qc7w4znnvqdeSC/MGGmxP2KrEUZyQa
        ajEXFScCAOFawKoUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO73HxIJBoc6lS3ONr1ht7i8aw6b
        xefeI4wWtxtXsFm8azzM6MDqsfOhpUffllWMHp83yQUwR3HZpKTmZJalFunbJXBlPJnQzVyw
        kr1i8c3DzA2MDWxdjJwcEgImEht2rWXtYuTiEBLYwShxf9FxJoiEpMS0i0eZuxg5gGxhicOH
        iyFq3jJKvNiwhBmkRljARmLupCWsILaIgJPE8n17wHqZBcIlXjcuYINomMcoMedlGyNIgk1A
        S2L/ixtgm/kFFCWu/ngMFucVsJPY93cjC4jNIqAi0fLsA5gtKhAmsXPJYyaIGkGJkzOfgMU5
        BbwlXv9cyg6xTF3iz7xLzBC2uMStJ/OhjpCX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxgl
        UwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNES2sH455VH/QOMTJxMB5ilOBgVhLhPTVJ
        LEGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpr0v76f/
        K78RbJn0bmnxWdkJ51u2yaw7uVtgS+uzOFtl5+fTlx90n/VH+IJp3m6xTdebk9qPl+9TUjfw
        1u17V330KUvu3298bMEbJDfVN31WaNuvcf9W+dfZ2S+Of49VlXNY16Ryydh8+9XMzCLxb2HP
        9+/YN+MHF9fG1hqumLvz+BZKRKecP+ISF2jy/pHA9gl+TsYLHj+eqex0vmHOwmjRdXfOsevf
        XuLc1XJBV13ZqJX9jUlEb6mHlGPsBZm+ldLzHosu+RBr6x9VVLKWs9WKp3dtWfaRKXoXr70u
        3LhbWyDJmSN2olVr+IymFD/Zry82X7mt5STAUu/zSycrpkonsOWfjcaEi0oCLsVGSizFGYmG
        WsxFxYkAzxy9pwEDAAA=
X-CMS-MailID: 20210202070215epcas1p3a294f2e8472c3e25a1bb2768396127ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210202065527epcas1p3b6d20061d7f080ce9fe9269b86e9dfcb
References: <CGME20210202065527epcas1p3b6d20061d7f080ce9fe9269b86e9dfcb@epcas1p3.samsung.com>
        <1612248924-54419-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/2/21 3:55 PM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/devfreq/rk3399_dmc.c:403:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 2e91216..9e9d3b4c 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -400,7 +400,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	default:
>  		ret = -EINVAL;
>  		goto err_edev;
> -	};
> +	}
>  
>  no_pmu:
>  	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
> 

Applied it. I changed the patch title as following:
- PM / devfreq: rk3399_dmc: Remove unneeded semicolon

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
