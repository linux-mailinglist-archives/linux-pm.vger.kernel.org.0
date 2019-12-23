Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3680D12907A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 01:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLWAlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 19:41:16 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:48257 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLWAlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 19:41:16 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191223004114epoutp034a84fb1ca1a04e7755927e26a0537db1~i2TytW-mV2760127601epoutp03P
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2019 00:41:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191223004114epoutp034a84fb1ca1a04e7755927e26a0537db1~i2TytW-mV2760127601epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577061674;
        bh=EbSFRlAeBgrwn4XhRFaJf/kcW7j+9EzzPWSniTn58jQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LtN/0uRX7hK/HqkiA4e1rySjW7bfArB7VJFIh7F7LfxTKBE7YnoHFjsGZjgJYrgQr
         ZAHL8UEPIdaw3kW5LYsae4NmPCvAsX4LtOAX1CT6n/mjzWT0KoS/DV45NtBxqQErXk
         oKb1L5Hp8oRKrkv/8arof2vSgGgks+sUrBEiXcco=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191223004113epcas1p4dfce13f59e14d59faa096d26f7abab28~i2TyM1TRv1257612576epcas1p4x;
        Mon, 23 Dec 2019 00:41:13 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47h0s32857zMqYkr; Mon, 23 Dec
        2019 00:41:11 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.4A.48498.02D000E5; Mon, 23 Dec 2019 09:41:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191223004103epcas1p14662d27ce98a16d2115ab28a607752d4~i2To4QGqj2153121531epcas1p1_;
        Mon, 23 Dec 2019 00:41:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191223004103epsmtrp1d36696d5f3ba658c1a5ca8b1c903be3c~i2To3tVN83041230412epsmtrp1s;
        Mon, 23 Dec 2019 00:41:03 +0000 (GMT)
X-AuditID: b6c32a36-ea9ad9c00001bd72-f3-5e000d20715c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.5E.06569.F1D000E5; Mon, 23 Dec 2019 09:41:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191223004103epsmtip11e635dc96df74372c59588f23858f3f7~i2TouoL502670726707epsmtip1H;
        Mon, 23 Dec 2019 00:41:03 +0000 (GMT)
Subject: Re: [PATCH v3] PM / devfreq: exynos-bus: Disable devfreq-event
 device when fails
To:     linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1baa1ace-5f27-0a64-7107-08468f6ff005@samsung.com>
Date:   Mon, 23 Dec 2019 09:47:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191223004603.7849-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTV1eBlyHO4MlLLouzTW/YLS7vmsNm
        8bn3CKPF7cYVbBZzf09gc2D12DnrLrtH35ZVjB6fN8kFMEdl22SkJqakFimk5iXnp2Tmpdsq
        eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhkaGBiZAhUmZGec/N/PWPCSq+Lqtu+MDYyPOboY
        OTkkBEwk/k5cwdLFyMUhJLCDUeJC+2tGCOcTo0TP7UfMIFVCAt8YJVYuL+5i5ADr+NoVA1Gz
        l1Hi2KxjUA3vGSVeTrrACNIgLBAtcfzcajYQW0RARmLqlf2sIDazQLXE7K1/wWrYBLQk9r+4
        AVbDL6AocfXHY0aQBbwCdhJ7O1NBTBYBVYmOznCQClGBMImT21rAOnkFBCVOznzCAmJzClhJ
        7Hs8jxFiurjErSfzmSBseYntb+cwQzx5m01i5zw1CNtFYsK2dhYIW1ji1fEt7BC2lMTL/jYo
        u1pi5ckjbCBvSQh0MEps2X+BFSJhLLF/6WQmkNuYBTQl1u/ShwgrSuz8PRfqBj6Jd197WCFB
        xSvR0SYEUaIscfnBXSYIW1JicXsn2wRGpVlIvpmF5INZSD6YhbBsASPLKkax1ILi3PTUYsMC
        I+SY3sQITopaZjsYF53zOcQowMGoxMPLMet/rBBrYllxZe4hRgkOZiUR3t21f2OFeFMSK6tS
        i/Lji0pzUosPMZoCw3ois5Rocj4wYeeVxBuaGhkbG1uYGJqZGhoqifNy/LgYKySQnliSmp2a
        WpBaBNPHxMEp1cCY/G/zpJlRUluDf96xb5938eIBo957j7NuHbzgMLPhR/Jqvyxht5e9mqoh
        a3RPP1u7rjfgaFVI0655s/9vv/Vv7s92kWsL32usmh+y75THwnPaB1YeiO5Z/vWnr0uv2pKU
        8lvf668usu6dKCG8LPirdrnwNnWm7oxPiWf5Wu+dO/EzWPJwRcyXO0osxRmJhlrMRcWJAEUV
        NhCgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK48L0OcQccvBYuzTW/YLS7vmsNm
        8bn3CKPF7cYVbBZzf09gc2D12DnrLrtH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZZz8389Y
        8JKr4uq274wNjI85uhg5OCQETCS+dsV0MXJyCAnsZpSYvkwLxJYQkJSYdvEoM0SJsMThw8Vd
        jFxAJW8ZJXpXX2MDqREWiJZ4Nn0uK4gtIiAjMfXKflaQemaBaokXa4og6nsZJe4//gBWwyag
        JbH/xQ2wXn4BRYmrPx4zgtTzCthJ7O1MBTFZBFQlOjrDQSpEBcIkdi55zARi8woISpyc+YQF
        xOYUsJLY93geI4jNLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxg
        ZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcHVpaOxhPnIg/xCjAwajEw8sx63+s
        EGtiWXFl7iFGCQ5mJRHe3bV/Y4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1O
        TS1ILYLJMnFwSjUwCu/YVpw7n3v9nk9T3Zb82HSBlfeaW+Rhb9aM1adP8qr72tYmFC05yJdW
        YaU3//trcfdD/3a6MWutK1mcePLSWcGIeYtC1//y+PH/86JVdV6hhys2mJv6uz/+/z5HtqSo
        6by7yebZtSuaH0npHX2we+/FGdPCN1um//xxcduvs0xhnRIz/joppymxFGckGmoxFxUnAgAn
        sZIoigIAAA==
X-CMS-MailID: 20191223004103epcas1p14662d27ce98a16d2115ab28a607752d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924
References: <CGME20191223003919epcas1p2f2035e39b9afe60f880bef5929fe3924@epcas1p2.samsung.com>
        <20191223004603.7849-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 9:46 AM, Chanwoo Choi wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> The exynos_bus_profile_init process may fail, but the devfreq event device
> remains enabled. Call devfreq_event_disable_edev on the error return path.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v2:
> - Just check the return value of exynos_bus_disable_edev()
>   and return the error value before jumped goto.
> 
>  drivers/devfreq/exynos-bus.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 7f5917d59072..1259a0da7db7 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -335,10 +335,16 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	ret = exynos_bus_set_event(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		return ret;
> +		goto err_edev;
>  	}
>  
>  	return 0;
> +
> +err_edev:
> +	if (exynos_bus_disable_edev(bus))
> +		dev_warn(dev, "failed to disable the devfreq-event devices\n");
> +
> +	return ret;
>  }
>  
>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
