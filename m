Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2AA182764
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 04:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgCLDWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 23:22:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14637 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCLDWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 23:22:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200312032207epoutp01b62184fcae058a63a9c5aa337b54c1ad~7cHG1jCXO2421624216epoutp01Y
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 03:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200312032207epoutp01b62184fcae058a63a9c5aa337b54c1ad~7cHG1jCXO2421624216epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583983327;
        bh=uLAVmZ2p+1+IMeWkIh9m0NcgBMrgc4rjWb1DML2JnEc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NbqEbhB1I9024fr2llJPrp7l9BYVDUOcGhiA52ukeC2pB5hlAVciZTChbc8IcxUxS
         nQDby9pKfFDErkq3IRWPJyKz1PO6Ai6IcHL2OErwdVF3BY7q7qxoL+CRRj3kbkQK8t
         A5uONHlxueLXVOKF3RxaarLaJ+q59wcs53ZvcdIc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200312032206epcas1p4c7b07c482fa95c63a7bc37745826ab7f~7cHGM2C_X2451824518epcas1p4g;
        Thu, 12 Mar 2020 03:22:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48dDdl5sX3zMqYkY; Thu, 12 Mar
        2020 03:22:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.DF.48019.BDAA96E5; Thu, 12 Mar 2020 12:22:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200312032203epcas1p1a1e4c02645970949f1d67b977818f282~7cHCsQ4_H1822418224epcas1p1g;
        Thu, 12 Mar 2020 03:22:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200312032203epsmtrp135c246ff6f8533dc906c8f8cde5b0425~7cHCrJqU_2406124061epsmtrp1F;
        Thu, 12 Mar 2020 03:22:03 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-77-5e69aadba18c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.79.10238.BDAA96E5; Thu, 12 Mar 2020 12:22:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200312032202epsmtip14a44645c0406dac7bc77aa06783af8e6~7cHCeUWBu2602526025epsmtip1f;
        Thu, 12 Mar 2020 03:22:02 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Fix handling dev_pm_qos_remove_request
 result
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <780efc9c-a85f-ef9f-e64f-68e5edce4cd3@samsung.com>
Date:   Thu, 12 Mar 2020 12:30:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ea4c8b53f2a045116a5f70e24374ce62c85f0b81.1583982882.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmge7tVZlxBkfX6Vrcn9fKaHHn9mlm
        i9f/prNYnD+/gd3ibNMbdosVdz+yWmx6fI3VouvXSmaLz71HGC0+b3jMaHG7cQWbxZnTl1gt
        Nj84xubA6zG74SKLx85Zd9k9Nq3qZPPYvKTeY+O7HUweH5/eYvHYcrWdxaNvyypGj8+b5AI4
        o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DuVlIo
        S8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl5+daGRoYGJkCFSZk
        Z8z7cJCt4AhPxdSp05gaGCdxdTFycEgImEisXC/SxcjFISSwg1Fi5YbNTBDOJ0aJz6v/sUE4
        3xglnl3aC+RwgnXcf/OJBSKxl1Hi4srlUC3vGSX2XljCAlIlLBAksbfhDTOILSIQKfHv+waw
        ImaB5cwSr65cZAdJsAloSex/cQNsLL+AosTVH48ZQWxeATuJ30v+gMVZBFQlvp05AzZIVCBM
        4uS2FqgaQYmTM5+ALeMUiJOYf/c0E4jNLCAucevJfChbXmL72znMIIslBPaxS+yetpcR4gcX
        iQmvLzNB2MISr45vYYewpSRe9rdB2dUSK08eYYNo7mCU2LL/AitEwlhi/9LJTKDgYxbQlFi/
        Sx8irCix8/dcRojFfBLvvvawQkKYV6KjTQiiRFni8oO7UGslJRa3d7JNYFSaheSdWUhemIXk
        hVkIyxYwsqxiFEstKM5NTy02LDBBju5NjOBErWWxg3HPOZ9DjAIcjEo8vBM+Z8QJsSaWFVfm
        HmKU4GBWEuGNl0+PE+JNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wCySVxJvaGpkbGxsYWJo
        ZmpoqCTO+zBSM05IID2xJDU7NbUgtQimj4mDU6qBcYJvaVXEhg9frp2aXRAafXYSA69Bo9z7
        xhkmL3ZHfgwq3G49nWtWg6vj5a8TV055WsnOcF5qleCv6dY+giyu0qVf0ny0E3gem8vKL922
        XkN20dcI2WdbZqiZpUbFcX5wWpFhk3BZ5vGvKmbb6KkLuBn7/v8v1c3b825XoZ5P7Juueas/
        X9vtp8RSnJFoqMVcVJwIABy0UeTqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSnO7tVZlxBt/msVncn9fKaHHn9mlm
        i9f/prNYnD+/gd3ibNMbdosVdz+yWmx6fI3VouvXSmaLz71HGC0+b3jMaHG7cQWbxZnTl1gt
        Nj84xubA6zG74SKLx85Zd9k9Nq3qZPPYvKTeY+O7HUweH5/eYvHYcrWdxaNvyypGj8+b5AI4
        o7hsUlJzMstSi/TtErgy5n04yFZwhKdi6tRpTA2Mk7i6GDk5JARMJO6/+cTSxcjFISSwm1Fi
        08SrLBAJSYlpF48ydzFyANnCEocPF0PUvGWUWL7hMBNIjbBAkMTehjfMILaIQKTEjt+/wQYx
        Cyxnlvh5YAEbRMdGRolH6+cxglSxCWhJ7H9xgw3E5hdQlLj64zFYnFfATuL3kj9gcRYBVYlv
        Z86ATRUVCJPYueQxE0SNoMTJmU/AruMUiJOYf/c0WJxZQF3iz7xLzBC2uMStJ/Oh4vIS29/O
        YZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcMxq
        ae5gvLwk/hCjAAejEg/vhM8ZcUKsiWXFlbmHGCU4mJVEeOPl0+OEeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYFx4zHHBPH4PBZUFy1gtep40hDzUrNpY
        +PQ4w9/YED3pgrz4Nbs7a27+r4rOKp7M7nr6tdfkDEN30dm1kj/nbOe/+GRVEe/165OfbUiw
        X+d/yFxP7hZHcrT1/T9es3IO3lgZ8X/ry7NCETVbDRou8eb+lwgx7DtR2XXKlNX1oMXjjMPl
        P2KOb1FiKc5INNRiLipOBACj6kOh1QIAAA==
X-CMS-MailID: 20200312032203epcas1p1a1e4c02645970949f1d67b977818f282
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200312031520epcas1p3ae8085a7d85da5b41776136f61ad40a3
References: <CGME20200312031520epcas1p3ae8085a7d85da5b41776136f61ad40a3@epcas1p3.samsung.com>
        <ea4c8b53f2a045116a5f70e24374ce62c85f0b81.1583982882.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/12/20 12:15 PM, Leonard Crestez wrote:
> The dev_pm_qos_remove_request function can return 1 if
> "aggregated constraint value has changed" so only negative values should
> be reported as errors.
> 
> Fixes: 27dbc542f651 ("PM / devfreq: Use PM QoS for sysfs min/max_freq")
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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

Looks good to me.
But, It doesn't contain the stable mailing list.
Please add stable mailing list to Cc and resend it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
