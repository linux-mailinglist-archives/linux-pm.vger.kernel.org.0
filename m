Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF31AEA92E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfJaCQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:16:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35746 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJaCQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:16:29 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191031021627epoutp0417226bc33072e868fa8350cb3055d5e6~Smay5Zfr40640506405epoutp04e
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:16:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191031021627epoutp0417226bc33072e868fa8350cb3055d5e6~Smay5Zfr40640506405epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572488187;
        bh=0gRbLXMZAt8FFWMG14xAWn8mAiyTn1jsY/Zr+NtuseM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SLfwxIrAzlZXsitHy24KSfWP/srf3/dU3kiUF24cJbvvSDCT4ODF9kLozE8YR+gHR
         j0gVIKux8QYWofuPL6d4PIZr8wtAzuy0/lQ2CzrEynBLbd7MpImGNWupHCEgZXwePI
         C/ydXe0ti8Z+kGFG09sbEvLfvP5GNi7A8+Wy97bk=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191031021626epcas1p45f68e04392fae54eac85ab23787559ec~SmayMC8Wm1510915109epcas1p4I;
        Thu, 31 Oct 2019 02:16:26 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 473TTM3bBFzMqYkf; Thu, 31 Oct
        2019 02:16:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.7C.04068.7F34ABD5; Thu, 31 Oct 2019 11:16:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191031021622epcas1p32a10d0435e0a6c4dd42ef1e5fec50da1~SmavDm8NL1928919289epcas1p3R;
        Thu, 31 Oct 2019 02:16:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191031021622epsmtrp21d748d3f271fc3f64fe1f22edc90a7e2~SmavCrCf52146121461epsmtrp2W;
        Thu, 31 Oct 2019 02:16:22 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-aa-5dba43f74692
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.AA.25663.6F34ABD5; Thu, 31 Oct 2019 11:16:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191031021622epsmtip1bad6ebd4622149580a9eb0178904ba9a~Smaupuiwr2460524605epsmtip11;
        Thu, 31 Oct 2019 02:16:22 +0000 (GMT)
Subject: Re: [PATCH v9 3/8] PM / devfreq: Set scaling_max_freq to max on OPP
 notifier error
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <802a29ac-d98e-db0b-0e6f-95d02a53d3b5@samsung.com>
Date:   Thu, 31 Oct 2019 11:21:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bee69d4635f83d8812fedbc108beb6c51ac9d4e7.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmru53512xBlfnSFgcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZ3yYcp+54CdXxdpH91gaGBs4uxg5OSQETCTW9X5i7mLk4hAS
        2MEose7PFXYI5xOjxKy+LSwQzjdGiU/rXrLDtEyYMosJIrGXUWLFzF9QzntGifV/JzGBVAkL
        xEos/X6YBcQWEaiTuLX4BNgSZoGJLBL/f3WBJdgEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk3h1
        7T+YzSKgKrH1XzNrFyMHh6hAhMTpr4kQJYISJ2c+ARvDKRAnseHwTDCbWUBc4taT+UwQtrxE
        89bZYHslBC6xS3xfepsF4gUXiRXbulkhbGGJV8e3QL0mJfH53V42CLtaYuXJI2wQzR2MElv2
        X4BqMJbYv3QyE8hBzAKaEut36UOEFSV2/p7LCLGYT+Ld1x6wmyUEeCU62oQgSpQlLj+4ywRh
        S0osbu9km8CoNAvJO7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhgihzdmxjBqVzLcgfjsXM+
        hxgFOBiVeHgnlO2MFWJNLCuuzD3EKMHBrCTC+80GKMSbklhZlVqUH19UmpNafIjRFBjYE5ml
        RJPzgXkmryTe0NTI2NjYwsTQzNTQUEmc13H50lghgfTEktTs1NSC1CKYPiYOTqkGxvwbm+ZU
        Z+h8qYnNaXiQ5j47+Xt50+28G2GS4u82dgft177st6BZd8O6gjzLpmPOZYmT590/lCGzclGy
        QxzHg6YJHOkGgdn6xq5zJqj90H8rvXi51xev28XnO+XSz0z6s297Y/bLbQceXF773NWv1H99
        ssCOzTsU1U38G3wvN63TX7OqvHRXiRJLcUaioRZzUXEiADtBGzv7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSnO43512xBr+e6VkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyPky5z1zwk6ti7aN7LA2MDZxdjJwc
        EgImEhOmzGLqYuTiEBLYzShx9M95doiEpMS0i0eZuxg5gGxhicOHiyFq3jJKvO16ygpSIywQ
        K7H0+2EWEFtEoE7iz/N9YIOYBSazSBw8uo8RouMRo8TL523MIFVsAloS+1/cYAOx+QUUJa7+
        eMwIYvMK2Em8uvYfzGYRUJXY+q8ZbIOoQITE8+03oGoEJU7OfAK2jVMgTmLD4ZlgNrOAusSf
        eZeYIWxxiVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1
        XK84Mbe4NC9dLzk/dxMjOKq1tHYwnjgRf4hRgINRiYd3QtnOWCHWxLLiytxDjBIczEoivN9s
        gEK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYpy3wPLQk
        IHn97BSmu5YSd4+/i/CaY36lxvTMFsHjn7/4+LoYan5q6A935dtxhK+yVua6oOXzqRVPC0PF
        Ts3UsPovku9pl+Nhrz/jZJakae7XS6wBTzRV6nL3dGl3Pz2nvn7us019r9c3fTuvZBC91y3o
        3xfldxrfbJ95xSYXbJlcdP4be5SFEktxRqKhFnNRcSIA2OCu4eYCAAA=
X-CMS-MailID: 20191031021622epcas1p32a10d0435e0a6c4dd42ef1e5fec50da1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192526epcas4p200615dced577dea9d99885b3b8b1bf36
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192526epcas4p200615dced577dea9d99885b3b8b1bf36@epcas4p2.samsung.com>
        <bee69d4635f83d8812fedbc108beb6c51ac9d4e7.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
> The devfreq_notifier_call functions will update scaling_min_freq and
> scaling_max_freq when the OPP table is updated.
> 
> If fetching the maximum frequency fails then scaling_max_freq remains
> set to zero which is confusing. Set to ULONG_MAX instead so we don't
> need special handling for this case in other places.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 32bbf6e80380..3e0e936185a3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -557,12 +557,14 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq)
>  		goto out;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq)
> +	if (!devfreq->scaling_max_freq) {
> +		devfreq->scaling_max_freq = ULONG_MAX;
>  		goto out;
> +	}
>  
>  	err = update_devfreq(devfreq);
>  
>  out:
>  	mutex_unlock(&devfreq->lock);
> 

Sorry for the late reply.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
