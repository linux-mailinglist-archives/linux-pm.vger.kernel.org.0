Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01761CA1AC
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 05:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEHDsE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 23:48:04 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46966 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHDsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 23:48:04 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200508034801epoutp01160bab80e399966b5adbe0fa639e1478~M8O-hgHCe0534205342epoutp01B
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 03:48:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200508034801epoutp01160bab80e399966b5adbe0fa639e1478~M8O-hgHCe0534205342epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588909681;
        bh=H3dky0BejFaiWB40srhii5TqB3bg1Vcn1f7mHVdMoX4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Nc9GrC+dMNRy18z4gqUW9HlsMm9HvD2GjBjVOo/l9yNG6rwkPFRvlC5Oyr8ySETqY
         rufR30SbG+cMJrCf/oTgkLdM+DQvdxtBEOriWsXc6MS/xLKK8pNBbhJr9AhgF3xU7J
         y5fqLf5w2smzPcMlfeRY1dW+x3eMR6Ns/pKbiJqY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200508034800epcas1p1520d538908c47140a0292440575b1093~M8O_0bBZO2517225172epcas1p16;
        Fri,  8 May 2020 03:48:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49JGWL6pGwzMqYlp; Fri,  8 May
        2020 03:47:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.B5.04648.E66D4BE5; Fri,  8 May 2020 12:47:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200508034758epcas1p3f3d5d33ba201ffc9927c9e4e91309bd2~M8O8kjItc3050130501epcas1p37;
        Fri,  8 May 2020 03:47:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200508034758epsmtrp20fd869c5728f67c0757aec4dab885ba8~M8O8jqsiK2028120281epsmtrp2N;
        Fri,  8 May 2020 03:47:58 +0000 (GMT)
X-AuditID: b6c32a37-1dbff70000001228-9d-5eb4d66e5681
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.E9.25866.E66D4BE5; Fri,  8 May 2020 12:47:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200508034758epsmtip18c3331dd21c34d82042ca6612c31d6d5~M8O8S5fv61798317983epsmtip1R;
        Fri,  8 May 2020 03:47:58 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: imx: Fix inconsistent IS_ERR and PTR_ERR
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Organization: Samsung Electronics
Message-ID: <7dc02882-3317-20cc-450c-23abc23d5cb5@samsung.com>
Date:   Fri, 8 May 2020 12:57:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <82fc7219-b9c7-c5fa-10b1-692f6a5ed411@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmvm7etS1xBnv/mVg8vOpvsXWPqsWv
        i9NYLVZN3clicbbpDbvFirsfWS02Pb7GatH1ayWzxeVdc9gsPvceYbS43biCzeLv9k0sFi+2
        iDvweqw7qOqxc9Zddo9NqzrZPDYvqffY+G4Hk0f/XwOPvi2rGD0+b5IL4IjKtslITUxJLVJI
        zUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBulZJoSwxpxQoFJBYXKyk
        b2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ3x/dQ+loJF3BW7
        t91hbWCcwNnFyMkhIWAicWBiG1sXIxeHkMAORonDczaygiSEBD4xSsy56QBhf2aU+H85AKbh
        /80fjBANuxglmve2skM47xkl1h/YzwxSJSzgLfFgyXYwm01AS2L/ixtgK0QEfjNJvJq7Fayd
        WWASo8Tm3fvB9vELKEpc/fGYEcTmFbCTWDzvM1g3i4CKxOmrTWC2qECYxMltLVA1ghInZz5h
        AbE5BewlPi16ywZiMwuIS9x6Mp8JwpaX2P52DjPIMgmBKxwSa1ecZoN4wkXiQ+cqVghbWOLV
        8S3sELaUxOd3e6FqqiVWnjzCBtHcwSixZf8FqAZjif1LJwNt4ADaoCmxfpc+RFhRYufvuYwQ
        i/kk3n3tYQUpkRDglehoE4IoUZa4/OAuE4QtKbG4vZNtAqPSLCTvzELywiwkL8xCWLaAkWUV
        o1hqQXFuemqxYYExcnRvYgQnZS3zHYwbzvkcYhTgYFTi4bX4uDlOiDWxrLgy9xCjBAezkgjv
        xIotcUK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5gx8kriDU2NjI2NLUwMzUwNDZXEeade
        z4kTEkhPLEnNTk0tSC2C6WPi4JRqYAysVK4tmDPf9eG13devvnPgM5y9xsQ3/45vglF835Gv
        kxTseIw8yvY9zvhgKF+71Orbs7xlv1JMnnt7Wzu4zjWWbpzjoMed3sUsbHVn8akEfXHTid8D
        eFhf375x6eCHbbbSHy817L2zY2u7/V6r/+5/tgaJngu6pJ9ssO8nx6elbKEXpZ67NCuxFGck
        GmoxFxUnAgA6ul2q4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG7etS1xBn0XRC0eXvW32LpH1eLX
        xWmsFqum7mSxONv0ht1ixd2PrBabHl9jtej6tZLZ4vKuOWwWn3uPMFrcblzBZvF3+yYWixdb
        xB14PdYdVPXYOesuu8emVZ1sHpuX1HtsfLeDyaP/r4FH35ZVjB6fN8kFcERx2aSk5mSWpRbp
        2yVwZXw/tY+lYBF3xe5td1gbGCdwdjFyckgImEj8v/mDEcQWEtjBKNH+JwsiLikx7eJR5i5G
        DiBbWOLw4eIuRi6gkreMEt9/zGUGqREW8JZ4sGQ7mM0moCWx/8UNNpAiEYG/TBItdxexgSSY
        BSYxSnxenQ/RvY1R4u3jiWAJfgFFias/HoNt5hWwk1g87zPYJBYBFYnTV5vAbFGBMImdSx4z
        QdQISpyc+YQFxOYUsJf4tOgt1AJ1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYh
        aZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg6NTS2sG4Z9UHvUOMTByM
        hxglOJiVRHgnVmyJE+JNSaysSi3Kjy8qzUktPsQozcGiJM77ddbCOCGB9MSS1OzU1ILUIpgs
        EwenVAPTxVPzZK7UPNGt4xE3u2z+cKZSRfaGEoc3i75dnpnmKFr8xO/E+aVJ9VxVp+ZU/nWt
        +sEzJURh4dHHFxTO/GJ/lbj6pfz2HCfpnInHJj/8I7nkfsGSZNcptz0m3NexCj8ak2O9cEvL
        t9vuve7cqf8irsRNnW3NERpoPOdL7Robh+IQDz2/WS/edPu3MvsfORNwi1lUdlGVZlyOtV7R
        5WJ7Rr+8vLOJNv1B9nK/Xz5Tq6jZnSqnmXy66Azb5ke15+rLpopnPEgTSTs5d46TllvxhX8a
        m/sq9Ob52u2V2bCg/eq/rWZOgmaqC1yjHrzrPiR97+RXQevX5VeENsstZxcNevuYSXxmLLtP
        oOGciTeVWIozEg21mIuKEwFWYtzTPQMAAA==
X-CMS-MailID: 20200508034758epcas1p3f3d5d33ba201ffc9927c9e4e91309bd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200507130824epcas1p287961e0a2f5019a55ecd1c94772fdfff
References: <CGME20200507130824epcas1p287961e0a2f5019a55ecd1c94772fdfff@epcas1p2.samsung.com>
        <20200507131245.GA709@embeddedor>
        <82fc7219-b9c7-c5fa-10b1-692f6a5ed411@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/8/20 12:55 PM, Chanwoo Choi wrote:
> On 5/7/20 10:12 PM, Gustavo A. R. Silva wrote:
>> Fix inconsistent IS_ERR and PTR_ERR in imx_bus_init_icc().
>>
>> The proper pointer to be passed as argument to PTR_ERR() is
>> priv->icc_pdev.
>>
>> This bug was detected with the help of Coccinelle.
>>
>> Fixes: 16c1d2f1b0bd ("PM / devfreq: imx: Register interconnect device")
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/devfreq/imx-bus.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
>> index 532e7954032f..4f38455ad742 100644
>> --- a/drivers/devfreq/imx-bus.c
>> +++ b/drivers/devfreq/imx-bus.c
>> @@ -88,8 +88,8 @@ static int imx_bus_init_icc(struct device *dev)
>>  			dev, icc_driver_name, -1, NULL, 0);
>>  	if (IS_ERR(priv->icc_pdev)) {
>>  		dev_err(dev, "failed to register icc provider %s: %ld\n",
>> -				icc_driver_name, PTR_ERR(priv->devfreq));
>> -		return PTR_ERR(priv->devfreq);
>> +				icc_driver_name, PTR_ERR(priv->icc_pdev));
>> +		return PTR_ERR(priv->icc_pdev);
>>  	}
>>  
>>  	return 0;
>>
> 
> Applied it. Thanks.
> 

I edit the patch title as following:
- before : PM / devfreq: imx: Fix inconsistent IS_ERR and PTR_ERR
- after  : PM / devfreq: imx-bus: Fix inconsistent IS_ERR and PTR_ERR

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
