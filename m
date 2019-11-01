Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5255EBE84
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 08:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfKAHkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 03:40:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:48800 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKAHkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 03:40:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191101074012epoutp021e9e5bc8fc207a293a54a60edc0c1922~S_ewxWwcV0588205882epoutp02t
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 07:40:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191101074012epoutp021e9e5bc8fc207a293a54a60edc0c1922~S_ewxWwcV0588205882epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572594012;
        bh=FfrdmjGOwmokPiYT/n5Vgvnle4bdpTM1mCEMhI9JHKI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Qx/I6aL0YuJ/nTGvZg3eVGsbOxLzb/QJSuPKRX4iXT2/GTtl2+1l0FKTEql3suvhh
         pTMltrz70TXeSrJ6pyCwPINycFFqkhkALuUGVAUk/D9bdxeu5F4k4P6Mv3VSxD/KKN
         OXtMLGGsnnzSFIU+YQpIhW7FizXRHEIGUGBUXRTw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191101074011epcas1p17256087238c0314607abe70eb64a71e7~S_ev4LJ042542625426epcas1p1_;
        Fri,  1 Nov 2019 07:40:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 474DcV59SNzMqYkh; Fri,  1 Nov
        2019 07:40:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.64.04135.A51EBBD5; Fri,  1 Nov 2019 16:40:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191101074009epcas1p3c721e4a90fca071f8722f4586fc8b48c~S_ethhmEB0908309083epcas1p3q;
        Fri,  1 Nov 2019 07:40:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191101074009epsmtrp2643ef028aef5af36bb6b2e9cfcbbe24a~S_etgqmNj2501525015epsmtrp2G;
        Fri,  1 Nov 2019 07:40:09 +0000 (GMT)
X-AuditID: b6c32a36-c51679c000001027-dd-5dbbe15a8438
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.9C.24756.951EBBD5; Fri,  1 Nov 2019 16:40:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191101074009epsmtip1bc1fca3bdbfd369bcccbd23006c86cdd~S_etT5_JF1431514315epsmtip1T;
        Fri,  1 Nov 2019 07:40:09 +0000 (GMT)
Subject: Re: [PATCH v7 18/19] PM / devfreq: tegra30: Tune up MCCPU
 boost-down coefficient
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <99a90972-2170-ebcb-7bff-cd9ba8b0b0d1@samsung.com>
Date:   Fri, 1 Nov 2019 16:45:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-19-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvm7Uw92xBlsuaFms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnH3mbfFz1zwWi761l9gcuDx23F3C6LFz1l12
        j97md2wefVtWMXp83iQXwBqVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCX
        mJtqq+TiE6DrlpkDdJSSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4
        NC9dLzk/18rQwMDIFKgwITtj652vTAVLeCr+tLaxNjD+5exi5OSQEDCRWL28ia2LkYtDSGAH
        o8Tj+U+YIZxPQM7vC6wQzjdGiR0bZjPCtNyfNJ8dIrGXUeLlrq+MEM57RokN/xpYQaqEBaIl
        Xh+7BjZYRGARk8Tao9uZQRLMApESh3euZgKx2QS0JPa/uMEGYvMLKEpc/fEYaBIHB6+AncST
        E/4gYRYBFYlfc9ewgYRFBSIkTn9NBAnzCghKnJz5hAXE5hQwl3ix9BArxHRxiVtP5jNB2PIS
        zVtng70jIdDOLnH9RBMLyBwJAReJSR8KIJ4Rlnh1fAs7hC0l8fndXjYIu1pi5ckjbBC9HYwS
        W/ZfYIVIGEvsXzqZCWQOs4CmxPpd+hBhRYmdv+cyQuzlk3j3tYcVYhWvREebEESJssTlB3eZ
        IGxJicXtnWwTGJVmIflmFpIPZiH5YBbCsgWMLKsYxVILinPTU4sNC4yQI3sTIzi9apntYFx0
        zucQowAHoxIP74yu3bFCrIllxZW5hxglOJiVRHi3rwMK8aYkVlalFuXHF5XmpBYfYjQFhvVE
        ZinR5Hxg6s8riTc0NTI2NrYwMTQzNTRUEud1XL40VkggPbEkNTs1tSC1CKaPiYNTqoFxjWfu
        6+DC2+qXo/6ezLjyvfX83ncW9TfuXln4fnts9uGaKfUCS7aefv2k6rTYmw296kpvKrR+7p1V
        7r2L/5IVh/zErdrhZ0UdFspyKWSt+HPcMvNWuFrBqynSS/uzK+9Xf187n7n5/OOGqQGved7r
        x8l0vLBhUEkXD59V7aEfen37q5vC/PrrlFiKMxINtZiLihMBnxNzrsUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnG7kw92xBlf6OS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gszj7ztvi5ax6LRd/aS2wOXB477i5h9Ng56y67
        R2/zOzaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyth65ytTwRKeij+tbawNjH85uxg5OSQE
        TCTuT5rP3sXIxSEksJtR4sjKB2wQCUmJaRePMncxcgDZwhKHDxdD1LxllLiybRorSI2wQLTE
        xidtYM0iAkuYJM5+Wc4MkmAWiJTombuFDaJjG6NEw46JTCAJNgEtif0vboBt4BdQlLj64zEj
        yAZeATuJJyf8QcIsAioSv+auASsRFYiQeL79BiOIzSsgKHFy5hMWEJtTwFzixdJDrBC71CX+
        zLsEtVdc4taT+UwQtrxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst
        1ytOzC0uzUvXS87P3cQIjjUtzR2Ml5fEH2IU4GBU4uGd0bU7Vog1say4MvcQowQHs5II7/Z1
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY/b8IWb/r
        t/7mPs151p/KzwqFBuKOGjscGy/wLdxcMLHuwOm702q39X2V+3oxYtdlm/92jK5Opm+rhC7v
        WcazPSTg7vSCRUL+e849npnXbFOg0+FvlLj1vvn11ufOx7JWawUs5ZmVo8ptHLv1ZgdD44qp
        Ngcnv5b6mb2GU6kk1XHyRKYioZB0JZbijERDLeai4kQA0V0hbbECAAA=
X-CMS-MailID: 20191101074009epcas1p3c721e4a90fca071f8722f4586fc8b48c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220656epcas2p4b19cb854054ebce6132c7111f52cada4
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220656epcas2p4b19cb854054ebce6132c7111f52cada4@epcas2p4.samsung.com>
        <20191029220019.26773-19-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> MCCPU boosts up very aggressively by 800% and boosts down very mildly by
> 10%. This doesn't work well when system is idling because the very slow
> de-boosting results in lots of consecutive-down interrupts, in result
> memory stays clocked high and CPU doesn't enter deepest idling state
> instead of keeping memory at lowest freq and having CPU cluster turned
> off. A more faster de-boosting fixes the case of idling system and doesn't
> affect the case of an active system.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index d0dd42856e5b..9a21a29198ee 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -123,7 +123,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>  		.offset = 0x200,
>  		.irq_mask = 1 << 25,
>  		.boost_up_coeff = 800,
> -		.boost_down_coeff = 90,
> +		.boost_down_coeff = 40,
>  		.boost_up_threshold = 27,
>  		.boost_down_threshold = 10,
>  		.avg_dependency_threshold = 50000,
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

IMO, I think that it is not good to change the threshold value
on device driver directly when some requirement happen.
Instead, better to get the threshold value from device-tree file.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
 
