Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F116A77B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387662AbfGPLco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:32:44 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:24876 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbfGPLcn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:32:43 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716113240epoutp0208f58b6972cf3f6a0a41f5f7379cc1db~x3_5QaieY0711907119epoutp02D
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716113240epoutp0208f58b6972cf3f6a0a41f5f7379cc1db~x3_5QaieY0711907119epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563276760;
        bh=Czm2jUEgwWPbrgS6DDeuw3qD4aYubyUUsTQoEq/4aGk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XaYuuYGahBvWnn2NVgOZmeJ1oA7BqWq8MlQlUgNBKg8w3mRNYNyWfZcSJsif+jKjg
         keh2aADXsgCnqzksxujrR5Ox1dffIzx+vVXiuPthDy14SDqAJ2dm5CD6jkJAX6cUkt
         3qcaBZLgBeYkZbQl6FkmhWZUTBBfSfNkwZh2K1NE=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716113239epcas1p257772ee641552084cb5c08d8a8eb6190~x3_4ZZ5g40758307583epcas1p2m;
        Tue, 16 Jul 2019 11:32:39 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45nytY1jCTzMqYkb; Tue, 16 Jul
        2019 11:32:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.09.04088.5D5BD2D5; Tue, 16 Jul 2019 20:32:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716113236epcas1p3bbc89147b610146d5c8d327533bc11aa~x3_17DYxl1708317083epcas1p3k;
        Tue, 16 Jul 2019 11:32:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716113236epsmtrp12b3e11b8d2a13b81e905741433f25e89~x3_16VF151088810888epsmtrp1a;
        Tue, 16 Jul 2019 11:32:36 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-9d-5d2db5d5dfb1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.BC.03638.4D5BD2D5; Tue, 16 Jul 2019 20:32:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716113236epsmtip2a8c0241aaa241566bfe38bdcba432870~x3_1vd1t50967509675epsmtip2j;
        Tue, 16 Jul 2019 11:32:36 +0000 (GMT)
Subject: Re: [PATCH v4 01/24] PM / devfreq: tegra30: Change irq type to
 unsigned int
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <628e2752-61fb-f070-94fe-dad4c83ea97a@samsung.com>
Date:   Tue, 16 Jul 2019 20:35:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-2-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe+ee3oOx9dJfWTjeowpSk/n8oQwzM40hc3P3fKoZ9eP+7Xn
        uZDfnFJRGGaOLqv8nl8Vu26srcJCkdb8aMmWDWl+puT33T2Z/nt9fn/fn++HkquvkiFUmsXO
        CxbORJODiRu1YZERLdcjDFG5PRR78VMHYvc4Swi2YXdXANvsOUmyXwrqEJvX7STZ1l3nSLbP
        4yLYwkuPyblKvbutDOmrnG0B+gLHe1JfWHkB6b+Uj01UrMmYlcpzKbyg4S3J1pQ0izGOXrw8
        aX6SLiaKiWBi2em0xsKZ+Th6QXxixMI0k/dBtGYDZ8r0uhI5UaSnzp4lWDPtvCbVKtrjaN6W
        YrLF2iJFzixmWoyRyVbzDCYqKlrnTVyXkfq9M1tm+zhkU8OZJ4qd6L4yHykpwNPg2q4WRT4a
        TKmxG8H3y8dIyfiMoKD1rFwyehA8/HaU+FeS48pHUuAWgjftd2SS8QGB51ivtxlFjcQr4G7e
        RJ8/EP9GkNfnIH3VcrwaaqsuynxM4nCofvPU7x+OQ6HlWwfysQrPht4HtwN8TOAJ4K4oUvh4
        FF4F9+pchJQzAuqPv/KzEuug61cTIfUPhuevimUSjwPH9RN+CYD/kNDb8U4mSVgATUUv+nkk
        dN6tDJA4BN4eyOnnLXC+vo6UinMRVFY/UkgBLVSfPizzqZTjMLjimSq5Q6HqRxGSBg+D91/3
        +xcBWAW5OWopZTw0v2zrHzsaSvfmkQcR7RwgxzlAgnOABOf/YacQcQEF8TbRbORFxsYM/O5y
        5L/WcJ0bHWmMr0GYQvRQlaZ6ikGt4DaIWeYaBJScDlTFfZ1sUKtSuKzNvGBNEjJNvFiDdN5t
        H5KHjEq2em/fYk9idNFarZadxsToGIYOVrl+hhnU2MjZ+Qyet/HCvzoZpQzZibaEGp4zRSX1
        R/cd+NDc+ptdZY9OHj+socl45rw7YaWr0+Det3ZPeXfNnKsjGrvmWBzqvrL4JbF9jsBS9+vs
        nu3zhEX29DFLtnH3MmRLl+1gt65esVHrONlITRqOb8Q0J65fo69PZ7o9YtbM1y9jgsa2CyXd
        vwZZN2fXPquoWJdws5gmxFSOCZcLIvcXjMvgE8MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvO6VrbqxBkf/aVis/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl/HrVylTwgbvi7LLrrA2Mpzm7GDk5JARMJNrm
        dTF2MXJxCAnsZpQ4/fU+E0RCUmLaxaPMXYwcQLawxOHDxRA1bxklphxbygYSFxYIkzjeqQYS
        FxFoYpLY1HuBHaSXWSBSomfuFjaIhs2MEr+Pr2cGSbAJaEnsf3GDDcTmF1CUuPrjMSOIzStg
        J/H9zFGwZhYBVYkdm+eygtiiAhESk67tZIGoEZQ4OfMJmM0pYCrx5u9FFohl6hJ/5l1ihrDF
        JW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4BjT0trBeOJE/CFGAQ5GJR7eE3t0YoVYE8uKK3MPMUpwMCuJ8Np+1Y4V4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGg9LWyS93fHKKmC
        ntuMlSxhm95e1El1OqGWtKBiUqLtvKiOcF+D9QJm4ne/B9o8eVS6+1RKpeN6VqdPVaIHfjGX
        du9e1BUQVPJwlk6vVkvwXFNzdV0hW6NZD6ccStnmenv/4YaaEifLqOTnNg8kJt2KWhwm17bs
        pdnSsyX7Gxx/zF6wX6JFT4mlOCPRUIu5qDgRANJoZletAgAA
X-CMS-MailID: 20190716113236epcas1p3bbc89147b610146d5c8d327533bc11aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223724epcas4p2a636661375e5147dfa5109967b441496
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223724epcas4p2a636661375e5147dfa5109967b441496@epcas4p2.samsung.com>
        <20190707223303.6755-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> IRQ numbers are always positive, hence the corresponding variable should
> be unsigned to keep types consistent. This is a minor change that cleans
> up code a tad more.
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a6ba75f4106d..a27300f40b0b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -160,7 +160,7 @@ struct tegra_devfreq {
>  
>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs)];
>  
> -	int irq;
> +	unsigned int		irq;
>  };
>  
>  struct tegra_actmon_emc_ratio {
> @@ -618,12 +618,12 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
>  
> -	tegra->irq = platform_get_irq(pdev, 0);
> -	if (tegra->irq < 0) {
> -		err = tegra->irq;
> +	err = platform_get_irq(pdev, 0);
> +	if (err < 0) {
>  		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
>  		return err;
>  	}
> +	tegra->irq = err;
>  
>  	reset_control_assert(tegra->reset);
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
