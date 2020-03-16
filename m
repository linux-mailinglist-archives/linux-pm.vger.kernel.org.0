Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543931864E3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 07:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCPGAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 02:00:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:45801 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgCPGAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 02:00:37 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200316060035epoutp03c78845a09374fece2f98605e8ffc672f~8s2meWeSJ1793017930epoutp03o
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 06:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200316060035epoutp03c78845a09374fece2f98605e8ffc672f~8s2meWeSJ1793017930epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584338435;
        bh=2Kv+w3PNCQWlj7hMQ3lPJvwlLeMJHkR1BiwXPydc7rw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SDO+TdYPcL+44Bmo9O1e8tSztlY20ABa79FfIaB2AMkdatblVSzchq+P4mSVu0J3q
         dGknKAXVxKmc5qDWgkTYhGZcZlmPUGV0gcsqvZwyrk42Dpdon/SOG4uCD7g+eEhMBR
         bWKRrtjUtPX6TATnxBUCOXDwAd0y3BTyPhls4Mm0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200316060033epcas1p25f9fcf0f932e4dcb8ed8d5a2639b5aa2~8s2lZHDLS0437604376epcas1p2t;
        Mon, 16 Mar 2020 06:00:33 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48glyk4dQlzMqYlm; Mon, 16 Mar
        2020 06:00:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.8F.04140.9F51F6E5; Mon, 16 Mar 2020 15:00:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200316060024epcas1p22426fb960f9d63d3e54178e0a7f7161d~8s2cemkrD0437704377epcas1p2X;
        Mon, 16 Mar 2020 06:00:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200316060024epsmtrp12481039a97564aae072b9d17e401300c~8s2cbFH2Y2667026670epsmtrp1j;
        Mon, 16 Mar 2020 06:00:24 +0000 (GMT)
X-AuditID: b6c32a36-412c19c00000102c-d6-5e6f15f9259a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.EB.04024.8F51F6E5; Mon, 16 Mar 2020 15:00:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200316060024epsmtip2997fd94dd47d0296cf99fd7f3550fd78~8s2cM7Ch32560725607epsmtip2q;
        Mon, 16 Mar 2020 06:00:24 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: Fix handling dev_pm_qos_remove_request
 result
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        dAN cARPENTER <DAN.CARPENTER@ORACLE.COM>
Cc:     mYUNGjOO hAM <MYUNGJOO.HAM@SAMSUNG.COM>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2b49cbce-7d3f-3c61-5ae8-98b5e7580553@samsung.com>
Date:   Mon, 16 Mar 2020 15:09:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <06fc3c3d0a8bca1bce104ca9d6a7d5ff94bdf9ab.1584027085.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmru5P0fw4g4tt3BZ3bp9mtnj9bzqL
        xfnzG9gtzja9YbdYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3G1ewWZw5fYnVYvODY2wO
        PB6zGy6yeOycdZfdY9OqTjaPzUvqPTa+28Hk8fHpLRaPLVfbWTz6tqxi9Pi8SS6AMyrbJiM1
        MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoZCWFssScUqBQ
        QGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdkbnpMyC
        P3wVd++INDBO5Oli5OSQEDCROP24kbWLkYtDSGAHo8S9B4+hnE+MEhMXfmCEcL4xSsw5f4cN
        pqXx+U12iMReRonpqw4wQzjvGSXO3TrKCFIlLBAq0bRnLguILSIQKXF+434mkCJmgTdMEnfv
        3WIGSbAJaEnsf3EDbCy/gKLE1R+PwZp5Bewk9vf8Barh4GARUJWYuiEbJCwqECZxclsLVImg
        xMmZT8DmcwrESfzsWw1mMwuIS9x6Mp8JwpaX2P52DjPE1ZvYJY5MzQQZKSHgItH4mwUiLCzx
        6vgWdghbSuJlfxuUXS2x8uQRNpCTJQQ6GCW27L/ACpEwlti/dDITyBxmAU2J9bv0IcKKEjt/
        z2WEWMsn8e5rDyvEKl6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8swsJA/MQvLALIRlCxhZ
        VjGKpRYU56anFhsWGCFH9SZGcFrWMtvBuOiczyFGAQ5GJR5eibS8OCHWxLLiytxDjBIczEoi
        vB012XFCvCmJlVWpRfnxRaU5qcWHGE2BQT2RWUo0OR+YM/JK4g1NjYyNjS1MDM1MDQ2VxHmn
        Xs+JExJITyxJzU5NLUgtgulj4uCUamBc65f1/83aW0ELzuZNPf1xrd/FPeL6lQ8cp/31yllh
        FOj6eU5Gr3LYjotSWh9PekuemjVl8b0TTrOqj/c9iDOOLcqOiTt3sMh2FVdwQOY8YYkTc5qr
        uk2cnB6I2m20yM7I3FZZLtr/bd+WtuK/cUK5q8J39UyZ+ej2rYksxS1Ctkq2xRN37nulxFKc
        kWioxVxUnAgAkhIITuEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO4P0fw4g0vH+S3u3D7NbPH633QW
        i/PnN7BbnG16w26x4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1uN65gszhz+hKrxeYHx9gc
        eDxmN1xk8dg56y67x6ZVnWwem5fUe2x8t4PJ4+PTWyweW662s3j0bVnF6PF5k1wAZxSXTUpq
        TmZZapG+XQJXRuekzII/fBV374g0ME7k6WLk5JAQMJFofH6TvYuRi0NIYDejxLIF39khEpIS
        0y4eZe5i5ACyhSUOHy6GqHnLKNE9oZ0RpEZYIFSiac9cFhBbRCBSYvbfw8wgRcwCb5gk2va3
        M4MkhAQ2Mkp8f+wFYrMJaEnsf3GDDcTmF1CUuPrjMdggXgE7if09f8GWsQioSkzdkA0SFhUI
        k9i55DETRImgxMmZT8B2cQrESfzsWw1mMwuoS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMwrOQ
        tM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER6iW5g7Gy0vi
        DzEKcDAq8fBKpOXFCbEmlhVX5h5ilOBgVhLh7ajJjhPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        +zTvWKSQQHpiSWp2ampBahFMlomDU6qBMd3k9STeP2eZjoqZJplU5s/Njlc9o8vtJKbL1q+e
        s1jfceJim2P3RJa8j+Vw+um9rXmi74fafJPV5yzXG8Z3vPeIS3K868Ez5XFZ8zWGOUX73P4y
        pHDcc1L9O23J549bi7KMg869PxL24sCq+Jo9i5fP8lKoVgsKfJPA2cOqZ7dEzfGsZSKPEktx
        RqKhFnNRcSIAYOoAtMwCAAA=
X-CMS-MailID: 20200316060024epcas1p22426fb960f9d63d3e54178e0a7f7161d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200312153613epcas1p14982cbd7b5e327f8a13a82c95b5bfce4
References: <CGME20200312153613epcas1p14982cbd7b5e327f8a13a82c95b5bfce4@epcas1p1.samsung.com>
        <06fc3c3d0a8bca1bce104ca9d6a7d5ff94bdf9ab.1584027085.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/13/20 12:36 AM, Leonard Crestez wrote:
> The dev_pm_qos_remove_request function can return 1 if
> "aggregated constraint value has changed" so only negative values should
> be reported as errors.
> 
> Fixes: 27dbc542f651 ("PM / devfreq: Use PM QoS for sysfs min/max_freq")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Changes since v1:
> * Add fixes and cc: stable, drop empty line in message.
> Link to v1: https://patchwork.kernel.org/patch/11433131/
> 
> I'm not sure this meet that stable kernel standard of "real bug that
> bothers people" because all this fixes is a spurious dev_warn on device
> removal. But Sasha Levin's script seem to collect a lot of low-priority
> fixes anyway.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 5c481ad1cfc7..6fecd11dafdd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -703,17 +703,17 @@ static void devfreq_dev_release(struct device *dev)
>  		dev_warn(dev->parent,
>  			"Failed to remove min_freq notifier: %d\n", err);
>  
>  	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req)) {
>  		err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> -		if (err)
> +		if (err < 0)
>  			dev_warn(dev->parent,
>  				"Failed to remove max_freq request: %d\n", err);
>  	}
>  	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req)) {
>  		err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> -		if (err)
> +		if (err < 0)
>  			dev_warn(dev->parent,
>  				"Failed to remove min_freq request: %d\n", err);
>  	}
>  
>  	if (devfreq->profile->exit)
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
