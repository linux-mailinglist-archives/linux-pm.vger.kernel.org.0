Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D903FEBE2D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfKAGzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 02:55:35 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55067 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKAGzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 02:55:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191101065532epoutp01e4db25daf0c9b06ad51559934c6e1e99~S93wcA8dd0429804298epoutp01C
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 06:55:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191101065532epoutp01e4db25daf0c9b06ad51559934c6e1e99~S93wcA8dd0429804298epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572591332;
        bh=izcNP/hLiYVSKEzCuHOenOd/RanTgVtooHCxQOAVUbs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cNB5MULEt0PkdJZOYt+X2jAPj0AsnxR4tUQm2zJONByAlYvV3Gqg1RmziG4dLUeYt
         SwPsgStQCVb09Zkv0CxU8iNnXYrUFjwBap3AXXlTfIyQJ92WpOaGyVB9S77OcL42JZ
         1OBLZ7LbiivfUbwXoqidBSouyTomEFFf09akuVh0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191101065531epcas1p3e0b6585497fecd265807acbd46533fea~S93v_YW4P0360703607epcas1p3C;
        Fri,  1 Nov 2019 06:55:31 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 474Ccx3ZghzMqYkb; Fri,  1 Nov
        2019 06:55:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.24.04085.1E6DBBD5; Fri,  1 Nov 2019 15:55:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191101065528epcas1p4c98eb2f047e91c429229c4b27df9c784~S93tP6U6d1538215382epcas1p4U;
        Fri,  1 Nov 2019 06:55:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191101065528epsmtrp19cf9a214cd77d85d892226ee58bc1536~S93tPEnkj2342223422epsmtrp1O;
        Fri,  1 Nov 2019 06:55:28 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-41-5dbbd6e143e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.59.24756.0E6DBBD5; Fri,  1 Nov 2019 15:55:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191101065528epsmtip11cd179d6b8c955003d04a9bd7f5c0595~S93s_MqwC1596415964epsmtip1j;
        Fri,  1 Nov 2019 06:55:28 +0000 (GMT)
Subject: Re: [PATCH v7 14/19] PM / devfreq: tegra30: Don't enable already
 enabled consecutive interrupts
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
Message-ID: <6b98cb58-7487-3e0d-705a-fa1d8e4e43bd@samsung.com>
Date:   Fri, 1 Nov 2019 16:00:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-15-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmge7Da7tjDe6uk7FY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCzOPvM2+LnrnksFn1rL7E5cHnsuLuE0WPnrLvs
        Hr3N79g8+rasYvT4vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5x
        aV66XnJ+rpWhgYGRKVBhQnbGl6/5Bf+5KuYsfcXYwPifo4uRk0NCwESie9IXxi5GLg4hgR2M
        ElOvTmOHcD4xSpxuu8sM4XxjlOjvngqU4QBrmb1aCiK+l1Fizr8XTBDOe0aJvws/sIIUCQtk
        SUx7KgsSFxFYxCSx9uh2ZpB9zAKREod3rmYCsdkEtCT2v7jBBmLzCyhKXP3xmBHE5hWwk/g7
        9xSYzSKgIvHi/0pGkJmiAhESp78mQpQISpyc+YQFxOYUMJfYcuEJI8R4cYlbT+YzQdjyEs1b
        ZzNDvPmfTWLX9AII20Xi1+ZXLBC2sMSr41vYIWwpiZf9bVB2tcTKk0fYQO6XEOhglNiy/wIr
        RMJYYv/SyUwg9zALaEqs36UPEVaU2Pl7LtQNfBLvvvawQsKKV6KjTQiiRFni8oO7TBC2pMTi
        9k62CYxKs5B8MwvJB7OQfDALYdkCRpZVjGKpBcW56anFhgXGyFG9iRGcWrXMdzBuOOdziFGA
        g1GJh3dG1+5YIdbEsuLK3EOMEhzMSiK829cBhXhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+
        MO3nlcQbmhoZGxtbmBiamRoaKonzOi5fGiskkJ5YkpqdmlqQWgTTx8TBKdXAmCztleCy5Jn4
        x5/PhNZIzm4XE+N5bqrmxrviUMWTZafc25X3a4u6OaU0vfddL9bkzrZr+YrFL593xVs3v5h9
        Ra9/a3OykhCDcq1M647+ngQ7N6NUzmUF1+7tmPdpaVZ145eLK+6Vcwh9yuRW85ZZEqThtfNh
        bYo2k/ye9Ks/Cx4HfPNcIPlbiaU4I9FQi7moOBEAQJiM2cMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnO6Da7tjDXo3Glqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnH3mbfFz1zwWi761l9gcuDx23F3C6LFz1l12
        j97md2wefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlfHla37Bf66KOUtfMTYw/ufoYuTgkBAw
        kZi9WqqLkYtDSGA3o8SWmb8Yuxg5geKSEtMuHmWGqBGWOHy4GKLmLaNE27oXjCBxYYEsiWlP
        ZUHiIgJLmCTOflnODNLLLBAp0TN3CxtEwzZGic5D31hBEmwCWhL7X9xgA7H5BRQlrv54DLaM
        V8BO4u/cU2A2i4CKxIv/K8FsUYEIiefbb0DVCEqcnPmEBcTmFDCX2HLhCSPEMnWJP/MuQS0W
        l7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxguNMS3MH4+Ul8YcYBTgYlXh4Z3TtjhViTSwrrsw9xCjBwawkwrt9HVCINyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRrFuzvrX9xKen3wr
        9LDL4nXAOXX3vMMK/Luv6ik4LBE42hQ41y66X+x+1o86i1Dlw11bZy3l+N+9JzSKs/HcnrnC
        /ctrQ29X1X3XUX31l6fbkaXwX5M3j75M5wPeclmNHIf+s8xPFTeJTdPZNOPQ84AFeiyrfa6e
        mzBri8d6gbArBz9ZiM5bo8RSnJFoqMVcVJwIAGnpTSivAgAA
X-CMS-MailID: 20191101065528epcas1p4c98eb2f047e91c429229c4b27df9c784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220705epcas5p2ea4d8a7c244b4ba35f98fba05cfab646
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220705epcas5p2ea4d8a7c244b4ba35f98fba05cfab646@epcas5p2.samsung.com>
        <20191029220019.26773-15-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> Consecutive up/down interrupt-bit is set in the interrupt status register
> only if that interrupt was previously enabled. Thus enabling the already
> enabled interrupt doesn't do much for us.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 9cbee82880ff..a9336cf4b37a 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -261,8 +261,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  
>  		if (dev->boost_freq >= tegra->max_freq)
>  			dev->boost_freq = tegra->max_freq;
> -		else
> -			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
>  		/*
>  		 * new_boost = old_boost * down_coef
> @@ -275,8 +273,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  
>  		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
>  			dev->boost_freq = 0;
> -		else
> -			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>  	}
>  
>  	if (dev->config->avg_dependency_threshold) {
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
