Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCA19EEAD
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgDEXv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 19:51:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46819 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDEXv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2020 19:51:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200405235124epoutp03cdc8415ee4cbc6817aa407eb0b249b79~DEXQrcU9V2039120391epoutp03_
        for <linux-pm@vger.kernel.org>; Sun,  5 Apr 2020 23:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200405235124epoutp03cdc8415ee4cbc6817aa407eb0b249b79~DEXQrcU9V2039120391epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586130684;
        bh=lSt8LdJPpXoJoLD3otlucHeQK0lf6r+8c36+IMGqGZQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LUxeaH3f7tTFyDgfKW9t7wHpCSoM88qzVutRnG5xjFo1B+05WakEEGMHT+IxVdRtF
         RGnxp7JeeFCn+84E+LSxtru8lI4+OMex7aEbTsat6IeURJxCSSQECpez6TpLeMsJvn
         1r7IBfg+8KmL6ExuOURwoFmfJUmblUQWED+nB9eI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200405235123epcas1p47fa7ff1050cd380e55ddbd9c0794e0b4~DEXQDdyg01541915419epcas1p4r;
        Sun,  5 Apr 2020 23:51:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48wVn46KL9zMqYls; Sun,  5 Apr
        2020 23:51:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.87.04402.8FE6A8E5; Mon,  6 Apr 2020 08:51:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200405235120epcas1p45e7a155cbceaeb44f40f60c14c1c7cba~DEXMsm99c1826218262epcas1p4c;
        Sun,  5 Apr 2020 23:51:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200405235120epsmtrp1744663a0431b92a131236908e0f9896b~DEXMrzAYn2195221952epsmtrp1B;
        Sun,  5 Apr 2020 23:51:20 +0000 (GMT)
X-AuditID: b6c32a35-753ff70000001132-d9-5e8a6ef88e3d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.58.04024.7FE6A8E5; Mon,  6 Apr 2020 08:51:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200405235119epsmtip141572a1a03ca2dd0e1a8e20cdb8c43ea~DEXMT-pOM1472414724epsmtip10;
        Sun,  5 Apr 2020 23:51:19 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra30: Delete an error message in
 tegra_devfreq_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <924a6012-985e-b22d-6f85-e9eb3f03e88b@samsung.com>
Date:   Mon, 6 Apr 2020 09:00:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmge6PvK44gyeLjSxWf3zMaNEyaxGL
        xdZb0hZnm96wW1zeNYfN4nPvEUaLzi+z2Cz+z3rOanG7cQWbxcf/zcwWP3fNY3Hg9jg/vZfN
        Y+esu+wevc3v2Dz6tqxi9Pi8Sc7j9rNtLAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM04syyvYwlnx5cQExgbGE+xdjJwcEgImEmuf
        bmXtYuTiEBLYwSjRs3QfG4TziVHi3OeNUM43Ronvn84zwrQ8nbecBSKxl1Gi+/0cqKr3jBIf
        H70Bcjg4hAXiJGY+lgOJiwhsYZLYu38DE0g3s0CxRO/RJawgNpuAlsT+FzfYQGx+AUWJqz8e
        g23gFbCTePm5EcxmEVCRuDb1DJgtKhAmcXJbC1SNoMTJmU9YQGxOASuJJ6v+skDMF5e49WQ+
        1C55ieats5lBjpAQ6GeXmLCyiRniBReJza2/WSFsYYlXx7dAQ0NK4mV/G5RdLbHy5BE2iOYO
        Rokt+y9ANRhL7F86mQnkS2YBTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJssTl
        B3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNCwyRY3sTIzjpapnu
        YJxyzucQowAHoxIPL8Ptzjgh1sSy4srcQ4wSHMxKIrxSvUAh3pTEyqrUovz4otKc1OJDjKbA
        0J7ILCWanA/MCHkl8YamRsbGxhYmhmamhoZK4rxTr+fECQmkJ5akZqemFqQWwfQxcXBKNTBK
        n3sn+jbOrfLw6gaOdOPbc66sFJe9LTXLb0PPvzLVBRfjJPqaL7itOKQs4ep7N2ix2O3y67e8
        WYIXHrjYM4vb8gD7+RX3pj9+mLso9MLPpZPdHcwmPeQ57Xp5q06O3p3mggfSjrOeRD5le6Tv
        sePi1fVanvt7diVxtr4s/LQh/MPt662ZH2MMlFiKMxINtZiLihMBj+AQxtADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSnO73vK44g62TzSxWf3zMaNEyaxGL
        xdZb0hZnm96wW1zeNYfN4nPvEUaLzi+z2Cz+z3rOanG7cQWbxcf/zcwWP3fNY3Hg9jg/vZfN
        Y+esu+wevc3v2Dz6tqxi9Pi8Sc7j9rNtLAFsUVw2Kak5mWWpRfp2CVwZJ5blFWzhrPhyYgJj
        A+MJ9i5GTg4JAROJp/OWs3QxcnEICexmlHh6ei0zREJSYtrFo0A2B5AtLHH4cDFEzVtGiSXz
        P7CDxIUF4iRmPpYDKRcR2MYkcbg5D8RmFiiW2PZhDTtEfS+jxPvb+8CWsQloSex/cYMNxOYX
        UJS4+uMxI4jNK2An8fJzI5jNIqAicW3qGTBbVCBMYueSx0wQNYISJ2c+YQGxOQWsJJ6s+ssC
        sUxd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnlts
        WGCYl1quV5yYW1yal66XnJ+7iREce1qaOxgvL4k/xCjAwajEw8twuzNOiDWxrLgy9xCjBAez
        kgivVC9QiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkbe
        aYsCnbPDxQ9+4PjPe108nDO1/2uOQPPul6aTQ43/W30vnL1Nc3MDa4i/Wdx/s8d3j95K39Fv
        6nJzCuez3k/z3xzMKLrjUmVek2K5/t//xx3Om3/UWf8/8SZ+4xaWk8UPPC/fC5r169eS9XKz
        31Uuq5O6Kr5EIsFYo8pYVv9bmt7/jlOHYyyVWIozEg21mIuKEwFq319kuQIAAA==
X-CMS-MailID: 20200405235120epcas1p45e7a155cbceaeb44f40f60c14c1c7cba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200404184602epcas1p1e0188779ade7c393f9e37a4757e1b6cc
References: <CGME20200404184602epcas1p1e0188779ade7c393f9e37a4757e1b6cc@epcas1p1.samsung.com>
        <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/5/20 3:45 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 4 Apr 2020 20:34:02 +0200
> 
> The function “platform_get_irq” can log an error already.
> Thus omit a redundant message for the exception handling in the
> calling function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 28b2c7ca416e..93e6f4b25b04 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -807,10 +807,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
> 
>  	err = platform_get_irq(pdev, 0);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> +	if (err < 0)
>  		return err;
> -	}
> +
>  	tegra->irq = err;
> 
>  	irq_set_status_flags(tegra->irq, IRQ_NOAUTOEN);
> --
> 2.26.0
> 
> 
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
