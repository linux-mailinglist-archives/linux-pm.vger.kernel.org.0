Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08592BBFE0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 04:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfIXCH3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 22:07:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14708 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfIXCH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 22:07:29 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190924020726epoutp01bfe80880bab429679816e9689596d73a~HPbXhoDeF1458114581epoutp01_
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 02:07:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190924020726epoutp01bfe80880bab429679816e9689596d73a~HPbXhoDeF1458114581epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569290846;
        bh=7C0ri+T6tbvlvMZb8A8pUAgT6/4070DYa2+5vpNKMiU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LswM1JL9cI62cc9Mip7s3z8iMEw9WhGWkTSpQc5CZ5CPWBN1lM4WS4um1mYkvbl8e
         RKsUJc0BStv4qeyyVQx+txQuQq7VaH3sk2gdEYoEp74I872M2Z5TKVTp3MfK4PLzAu
         D9/XT6N1dLwxp1diy0RN8ll9pTPKsswEJ0o7V6Mo=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190924020726epcas1p41a4b7e2129843522ef4fb95180db2d70~HPbXCHjRx2249022490epcas1p4Y;
        Tue, 24 Sep 2019 02:07:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46cl2329kjzMqYkW; Tue, 24 Sep
        2019 02:07:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.D3.04144.B5A798D5; Tue, 24 Sep 2019 11:07:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190924020722epcas1p469fd11675cb3aba0621799c929546e55~HPbUORCye2250322503epcas1p4m;
        Tue, 24 Sep 2019 02:07:22 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924020722epsmtrp10f940103cc22c3ea17bfdb74d03460bd~HPbUNd3Nn1456114561epsmtrp1C;
        Tue, 24 Sep 2019 02:07:22 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-eb-5d897a5b336d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.1F.03889.A5A798D5; Tue, 24 Sep 2019 11:07:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924020722epsmtip1f89493c7c3766b979efb12c01362c164~HPbUDXTty0560505605epsmtip19;
        Tue, 24 Sep 2019 02:07:22 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Lock devfreq in trans_stat_show
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <979d107f-0a52-3aa4-a397-acb0ff754a3c@samsung.com>
Date:   Tue, 24 Sep 2019 11:11:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmgW50VWeswfwGQYtDx7ayW0zfu4nN
        4vz5DewWZ5vesFvcapCxWHH3I6vFpsfXWC26fq1ktvjce4TR4vOGx4wWtxtXsDlwe8xuuMji
        sWlVJ5vHnWt72Dw2L6n32PhuB5PHwXd7mDz6tqxi9Pi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoTiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbDid/ZC66JVlx7WtDAOF2w
        i5GTQ0LAROL1ibWMILaQwA5GiVd3JboYuYDsT4wSDat62SGcb4wS51aeYofp+PXoHDNEYi+j
        RFvfORYI5z2jxJxpn1hBqoQFnCRevXnDBpIQEVjNKDHlxBewWcwCq5gkLlz5DDaLTUBLYv+L
        G2wgNr+AosTVH4/BLuEVsJNovb4HbBKLgKpEx9m3LCC2qECExKcHh1khagQlTs58AhbnFIiT
        WNH8FGwms4C4xK0n85kgbHmJ5q2zwW6VEFjELvHk+Wo2iCdcJO79OM0KYQtLvDq+Beo5KYmX
        /W1QdrXEypNH2CCaOxgltuy/ANVgLLF/6WSgDRxAGzQl1u/ShwgrSuz8PZcRYjGfxLuvPawg
        JRICvBIdbUIQJcoSlx/cZYKwJSUWt3eyTWBUmoXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8t
        NiwwRI7uTYzgRKxluoNxyjmfQ4wCHIxKPLwFOzpihVgTy4orcw8xSnAwK4nwbtJqixXiTUms
        rEotyo8vKs1JLT7EaAoM7YnMUqLJ+cAskVcSb2hqZGxsbGFiaGZqaKgkzuuR3hArJJCeWJKa
        nZpakFoE08fEwSnVwLhE6N355s2z89Xn/8r7x/VOx1Tq0vro5cfsN/xUjflbUj3ZtyGFwfLa
        1IhqEa/7MTkTOzZ5bN4VcuhQQeSBlykOD8xirnqcOML2aunfK6JLeGQjtrCxaZzXD9u0ZVNB
        jfFfyZinfwIWOhV9fXfUdeWrS9ovNJV2TVR5v6xv2p6Va0Lm9B/Zt9hKiaU4I9FQi7moOBEA
        tf3A4doDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSnG5UVWeswYajlhaHjm1lt5i+dxOb
        xfnzG9gtzja9Ybe41SBjseLuR1aLTY+vsVp0/VrJbPG59wijxecNjxktbjeuYHPg9pjdcJHF
        Y9OqTjaPO9f2sHlsXlLvsfHdDiaPg+/2MHn0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxsOJ
        39kLrolWXHta0MA4XbCLkZNDQsBE4tejc8xdjFwcQgK7GSVmTPnOApGQlJh28ShQggPIFpY4
        fLgYouYto8TeSzOZQGqEBZwkXr15wwZiiwisZpR40+sPUsQssIZJ4mL/IaipGxkl+l7OAati
        E9CS2P/iBpjNL6AocfXHY0YQm1fATqL1+h5WEJtFQFWi4+xbsCtEBSIkDu+YBVUjKHFy5hOw
        OKdAnMSK5qfsIDazgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDI
        sopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgitbR2MJ44EX+IUYCDUYmHV2JbR6wQ
        a2JZcWXuIUYJDmYlEd5NWm2xQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqem
        FqQWwWSZODilGhhXZNd0c9rOUsh93cbCLzbhmfrqg0rTJ8+siNhVf+rx+4+HV+u/C2V582tG
        HFedwdU5sV9aZjJe7RZJesmZVHQz+NqhfxPrFK708ocEsM2t4rx+I6XlnG945YbGhtb3V6+x
        t9++nnfb1uOKXmG8/5uMrqIdXRmH2cMiwvRCXvRKOS4U3FtyL12JpTgj0VCLuag4EQCpJrF9
        xAIAAA==
X-CMS-MailID: 20190924020722epcas1p469fd11675cb3aba0621799c929546e55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648
References: <CGME20190923162736epcas3p2c1db3bf767a07f17b609bc91fbbd9648@epcas3p2.samsung.com>
        <714675448e7fbf3c930b0dca6fbe54fa5f87211b.1569256001.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 1:27, Leonard Crestez wrote:
> There is no locking in this sysfs show function so stats printing can
> race with a devfreq_update_status called as part of freq switching or
> with initialization.
> 
> Also add an assert in devfreq_update_status to make it clear that lock
> must be held by caller.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Changes since v1:
> * Split from series: low-priority bugfix not strictly required for PM QoS
> * Only keep lock during update, release before sprintf
> Link to v1: https://patchwork.kernel.org/patch/11149493/
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c58fbf7d4e4..00fc23fea5b2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -206,10 +206,11 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int lev, prev_lev, ret = 0;
>  	unsigned long cur_time;
>  
>  	cur_time = jiffies;
> +	lockdep_assert_held(&devfreq->lock);

It better to move lock checking before 'cur_time = jiffies'
in order to reduce the redundant code execution.

>  
>  	/* Immediately exit if previous_freq is not initialized yet. */
>  	if (!devfreq->previous_freq)
>  		goto out;
>  
> @@ -1507,16 +1508,22 @@ static ssize_t trans_stat_show(struct device *dev,
>  	struct devfreq *devfreq = to_devfreq(dev);
>  	ssize_t len;
>  	int i, j;
>  	unsigned int max_state = devfreq->profile->max_state;
>  
> -	if (!devfreq->stop_polling &&
> -			devfreq_update_status(devfreq, devfreq->previous_freq))
> -		return 0;
>  	if (max_state == 0)
>  		return sprintf(buf, "Not Supported.\n");
>  
> +	/* lock and update */

It is not necessary. Anyone can know that this code is related to mutex lock/unlock.

> +	mutex_lock(&devfreq->lock);
> +	if (!devfreq->stop_polling &&
> +			devfreq_update_status(devfreq, devfreq->previous_freq)) {
> +		mutex_unlock(&devfreq->lock);
> +		return 0;
> +	}
> +	mutex_unlock(&devfreq->lock);
> +
>  	len = sprintf(buf, "     From  :   To\n");
>  	len += sprintf(buf + len, "           :");
>  	for (i = 0; i < max_state; i++)
>  		len += sprintf(buf + len, "%10lu",
>  				devfreq->profile->freq_table[i]);
> 

Basically, it is necessary. Please edit it by my comments.
Also, you have to add the following 'fixes' as following:
and send it stable mailing list.

Fixes: 39688ce6facd ("PM / devfreq: account suspend/resume for stats")

If you edit it by my comments, feel free to add my tag:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
