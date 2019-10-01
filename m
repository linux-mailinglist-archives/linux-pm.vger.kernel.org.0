Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3119AC42B4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJAV3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 17:29:02 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:47662 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfJAV3C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 17:29:02 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191001212859epoutp0326740612ac974b057d0f9e3083b1d757~JoyiVMhPw2644926449epoutp03W
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 21:28:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191001212859epoutp0326740612ac974b057d0f9e3083b1d757~JoyiVMhPw2644926449epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569965339;
        bh=Yw3R56mDxhyX+u4BbNdpgiLhPEMauvLJ8lCJK6ld5rI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B7G370sxl+pK92P/zn2FfPr/DyZWbVTyus2c5paURjEeGrcd5iEhvMk9iyHRDu0ti
         ZLfNXJtlPiFOIF17nzNkLRiJ3ue/3w1nOtZSYv3Hn7pnwPeT/iydEUjeYSPaE1Qhn1
         z5i3jhol3E7+w/H/rD3fLxFPjoufAMODqNdOZKdk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191001212859epcas1p3994901743dac42e89b4e5b8246638f0e~Joyh9zKKr2696226962epcas1p3W;
        Tue,  1 Oct 2019 21:28:59 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46jXT50YFmzMqYkV; Tue,  1 Oct
        2019 21:28:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.9D.04068.815C39D5; Wed,  2 Oct 2019 06:28:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191001212856epcas1p3e718d6ad3965a6956cc49007e3a95fd4~JoyfOofDg2696226962epcas1p3V;
        Tue,  1 Oct 2019 21:28:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001212856epsmtrp17d413fd26795ac38443de3f1128b6b65~JoyfLOYjM2299222992epsmtrp1f;
        Tue,  1 Oct 2019 21:28:56 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-6c-5d93c518e45c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.9F.03889.815C39D5; Wed,  2 Oct 2019 06:28:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191001212856epsmtip12fe8c2e438560997049fb2d8134b9bd1~Joye-1klJ2152221522epsmtip1S;
        Tue,  1 Oct 2019 21:28:56 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: remove useless assignment
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b70439ce-0300-1a95-7ed2-41d70db559a8@samsung.com>
Date:   Wed, 2 Oct 2019 06:33:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001124641.22896-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjt7uzOjuHWtGp9SpROEiioO+rqKBpBERv2Qygoim2ddNiVfbaz
        hlbQ9lDTsiyjdEt70UMjTTEpTRfUNAXflaFogi5lREFZmEq0zij573zfd84937n3EpiyAg8i
        Mi0Ozm5hTRS+WtrQFhYREfi6RKu6VSFhaktrZExf3zM5M9R4C2d+FrUjprSvRcI8bR+TM6On
        H+Pb5Zq6qgJcc6m+Cml+1m1KxQ4akwwcm8HZgzlLujUj06JPplL26nbo1HEqOoJOYOKpYAtr
        5pKpnXtSI3ZlmrzmVPAx1pTlbaWyPE9FbUuyW7McXLDByjuSKc6WYbIl2CJ51sxnWfSR6VZz
        Iq1SRau9xDSjofrvuMRWTGSfuzErc6JBvBD5EEDGwmTeGXkhWk0oyRcI3g4UYWLxA8F7z1eZ
        WPxG0HOzQbosKfRU4OKgGcHD6j9LxXcEHQ0FkkWWH7kbPo3XCwN/8iKC6dF+4SyMLERQPNwi
        W2ThZDi4P38QVllLhsC72Um0iBXkNvhaPiNwpGQozLbUCt4B5AH4MdEmEznroKtsSuj7ePnz
        j12CFiM3wMjUbYmIN8PZ5zeFREB+xKEzNxcTQ+yEucE3S9gPvnTWy0UcBNOX85bwCajsasdF
        8XkE9e5+mTiIAfeDEq8D4XUIg5rGKLEdAi/ny5eWWAPffl2ULVKAVMD5PKVI2QJDE2MSEQfC
        /fwCvBhRrhVxXCsiuFZEcP03u4OkVWg9Z+PNeo6nbeqVD16HhL8ZnvACdfTuaUUkgShfxYd9
        JVqljD3G55hbERAY5a9IWriqVSoy2JzjnN2qs2eZOL4Vqb23fQULCki3en+6xaGj1dExMTFM
        LB2npmlqg0Kjd2qVpJ51cEaOs3H2ZZ2E8Alyothn3MbW41uPenqaQsnaJ579AWu6a21NzemX
        VO6XJ+Ou6VbFb8k3DBlPlRq0vr1HJuuaIpt3DQ8/0oQ2vvI/OLKQeKi7sqhgIFuZ5ryRW3P4
        +t2U+Ed7D+TMXwB//J6xp7I/bGTq2/sZz9Gq0bnOabc6obojJMdZmZ3W1ZQ3HtJSRkl5A0uH
        Y3ae/QdqMkX4sQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTlfi6ORYg3sTRCw2zljPanH+/AZ2
        i8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHmwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBlrPt3j6lgAkdFy/QfrA2Ml9i6GDk5JARMJLqezgOzhQR2M0q0X1CAiEtKTLt4lLmL
        kQPIFpY4fLi4i5ELqOQto8SB02fB6oUFPCWe39vCBpIQEehhlHj3ah8jiMMM4mxrWsUK0TKR
        UWLXm9lMIC1sAloS+1/cAGvnF1CUuPrjMSOIzStgJ/Fm7hdWEJtFQEXix76NLCC2qECExOEd
        s6BqBCVOznwCFucEqv+9AiLOLKAu8WfeJWYIW1zi1pP5TBC2vETz1tnMExiFZyFpn4WkZRaS
        lllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiOHi2tHYwnTsQfYhTgYFTi
        4b0RMjlWiDWxrLgy9xCjBAezkgivzZ9JsUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJ
        pCeWpGanphakFsFkmTg4pRoYiwoFmJeafOY90+jfFTOz7JH8yfnFmY5hO+34hdwlbnRkBbJ9
        sVHMsqz9JpH0Xcvqi+cG8RdX6xPfy/WrqN9oOnXcO5X/k1Orcuu+WyvXNDHfiOq7onaeK7Sq
        3mbZpVzhNaaV96dOcd2wn2dWRNyU+aavGENL9pyrXvb7h0RIzsN3k3b+SJqgxFKckWioxVxU
        nAgAeqdNmpoCAAA=
X-CMS-MailID: 20191001212856epcas1p3e718d6ad3965a6956cc49007e3a95fd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781
References: <CGME20191001124646eucas1p2768afab3fc8fbaaf7c2bcf1966b06781@eucas1p2.samsung.com>
        <20191001124641.22896-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 10. 1. 오후 9:46, Marek Szyprowski wrote:
> The error code is propagated to the caller, so there is no need to keep
> it additionally in the unused variable.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 87b42055e6bc..85c7a77bf3f0 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -673,7 +673,6 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  	for (i = 0; i < info->num_events; i++) {
>  		edev[i] = devm_devfreq_event_add_edev(&pdev->dev, &desc[i]);
>  		if (IS_ERR(edev[i])) {
> -			ret = PTR_ERR(edev[i]);
>  			dev_err(&pdev->dev,
>  				"failed to add devfreq-event device\n");
>  			return PTR_ERR(edev[i]);
> 

Thanks.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
