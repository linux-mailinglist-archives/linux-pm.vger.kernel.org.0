Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093DD10E417
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 02:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLBBAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 20:00:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:18219 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLBBAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2019 20:00:51 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191202010048epoutp01c3820d37a0ee8728afeee3b556865a63~caB49Jyov0458304583epoutp01q
        for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2019 01:00:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191202010048epoutp01c3820d37a0ee8728afeee3b556865a63~caB49Jyov0458304583epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575248448;
        bh=5lFMFChe3Ry+ugQQRZv5k+ooAqZ6OdSiChuoscX1Dw4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I9hsrc9uXDTtkiZLB7vVgNlPjuhpq+S18YaP39MWUR8deqxlwv0R4D5pCvvyAvIw3
         KNJuRyGhQQSiEGZ7tcUhQ4fbIGcDAluodgVh6+9/P4zGpPxClAy+GwLVaKr5gVPLQl
         sxlJRorla9J/KRxB6RwoawXATghdrvUQoXJx7rKo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191202010047epcas1p4ef9ef9e623b05e643691a3d3a9ff0634~caB3_kdkG2267222672epcas1p4Z;
        Mon,  2 Dec 2019 01:00:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47R6HK3F3rzMqYkn; Mon,  2 Dec
        2019 01:00:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.75.51241.C3264ED5; Mon,  2 Dec 2019 10:00:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191202010043epcas1p3b05a2fc24f783e81eec4af14cc748a61~caB0Cea0n1912619126epcas1p3I;
        Mon,  2 Dec 2019 01:00:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191202010043epsmtrp1c673d5b4fba4e8acd7367c46527be5f7~caB0BpdSH0602506025epsmtrp1j;
        Mon,  2 Dec 2019 01:00:43 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-d2-5de4623c7eee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.10.06569.B3264ED5; Mon,  2 Dec 2019 10:00:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191202010043epsmtip2ad925c5d6baa0c471243c212409275b7~caBzzOvxa2462424624epsmtip2b;
        Mon,  2 Dec 2019 01:00:43 +0000 (GMT)
Subject: Re: [PATCH 1/5] PM / devfreq: Don't fail devfreq_dev_release if not
 in list
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8af7ba2c-14eb-fbfa-9fdc-93210c32e65f@samsung.com>
Date:   Mon, 2 Dec 2019 10:07:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <85684020f25ce186e3383d6bd67a15c54f930316.1573686315.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmga5N0pNYgwOHZSwOHdvKbjF97yY2
        i7NNb9gtVtz9yGqx6fE1VouuXyuZLT73HmG0+LzhMaPF7cYVbBZnTl9itdj41cOB22N2w0UW
        jzvX9rB5bF5S77Hx3Q4mj4Pv9jB5bLnazuLRt2UVo8fnTXIBHFHZNhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjPWHb3IVnBGsKJn9wW2BsYb
        fF2MnBwSAiYSUz4dZO5i5OIQEtjBKHGo4SAbSEJI4BOjxIXZ9hCJb4wSPf/eM8F0nFt+lAUi
        sZdR4u3T16wQzntGic7rn1hAqoQFwiR+TnjL3sXIwSEiECEx7bU7SA2zwBsmiW9fL7CC1LAJ
        aEnsf3EDbB2/gKLE1R+PGUFsXgE7iSUrH7KD2CwCKhITf80AqxEFmnlyWwtUjaDEyZlPWEDm
        cwrESTw+mQ8SZhYQl7j1ZD4ThC0vsf3tHLDXJASWsUusnLWQDeIDF4m+js8sELawxKvjW9gh
        bCmJl/1tUHa1xMqTR9ggmjsYJbbshzhaQsBYYv/SyUwgi5kFNCXW79KHCCtK7Pw9lxFiMZ/E
        u689rCAlEgK8Eh1tQhAlyhKXH9yFBqKkxOL2TrYJjEqzkHwzC8kLs5C8MAth2QJGllWMYqkF
        xbnpqcWGBabIkb2JEZyEtSx3MB4753OIUYCDUYmH1+DF41gh1sSy4srcQ4wSHMxKIrzXlR7G
        CvGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YIbIK4k3NDUyNja2MDE0MzU0VBLn5fhxMVZI
        ID2xJDU7NbUgtQimj4mDU6qBkclPObvj51aWGXEGWRNfzqr939p/2ZuZTTbwZvSSdSE50+Rm
        Gnu6h8ZuDZlkK+yzZuGrAqbfsv2Fj7TXhWQwzN0RnnXqxa0DD5z4pQ/v8k9XSHnf5PXovvL1
        rRr7nlVF1l9Z/dim90DkycerV2o8DPmjuFJacZ1YJM8kth+T2l4JHcn2WiulpcRSnJFoqMVc
        VJwIAA4q33vYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvK510pNYg0v9EhaHjm1lt5i+dxOb
        xdmmN+wWK+5+ZLXY9Pgaq0XXr5XMFp97jzBafN7wmNHiduMKNoszpy+xWmz86uHA7TG74SKL
        x51re9g8Ni+p99j4bgeTx8F3e5g8tlxtZ/Ho27KK0ePzJrkAjigum5TUnMyy1CJ9uwSujHVH
        L7IVnBGs6Nl9ga2B8QZfFyMnh4SAicS55UdZuhi5OIQEdjNK3GnuYoVISEpMu3iUuYuRA8gW
        ljh8uBii5i2jxPrN98FqhAXCJH5OeMsOYosIREjMmTYDbBCzwBsmidWzljNDdDxilJi8fSYT
        SBWbgJbE/hc32EBsfgFFias/HjOC2LwCdhJLVj4Em8QioCIx8dcMsBpRoA07lzxmgqgRlDg5
        8wkLyEWcAnESj0/mg4SZBdQl/sy7xAxhi0vcejKfCcKWl9j+dg7zBEbhWUi6ZyFpmYWkZRaS
        lgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjUktrB+OJE/GHGAU4GJV4eDte
        PY4VYk0sK67MPcQowcGsJMJ7XelhrBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGmfk3vdqXxGT+mvhbtP+f1MK7241U1F+wrUwW8bog227+NO79ppNL
        akQfs6nd8tbQ2iEvX3nuxoY3VdbJ39/bh7/RmcowJ1wov43pP8M/7YnnfTr//lVdv2VjjyP7
        FZeo7FOpC53PT9riOP2VT86R7d+ufFmbyX3FoqF24ZaMzYFlkpvjH69dosRSnJFoqMVcVJwI
        AImToBXEAgAA
X-CMS-MailID: 20191202010043epcas1p3b05a2fc24f783e81eec4af14cc748a61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113232144epcas1p33ca3f51e043c4dbd1ddd5b776016335d
References: <cover.1573686315.git.leonard.crestez@nxp.com>
        <CGME20191113232144epcas1p33ca3f51e043c4dbd1ddd5b776016335d@epcas1p3.samsung.com>
        <85684020f25ce186e3383d6bd67a15c54f930316.1573686315.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/14/19 8:21 AM, Leonard Crestez wrote:
> Right now devfreq_dev_release will print a warning and abort the rest of
> the cleanup if the devfreq instance is not part of the global
> devfreq_list. But this is a valid scenario, for example it can happen if
> the governor can't be found or on any other init error that happens
> after device_register.
> 
> Initialize devfreq->node to an empty list head in devfreq_add_device so
> that list_del becomes a safe noop inside devfreq_dev_release and we can
> continue the rest of the cleanup.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 94fb8e821e12..27af1b95fd23 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -635,15 +635,10 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  static void devfreq_dev_release(struct device *dev)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
>  
>  	mutex_lock(&devfreq_list_lock);
> -	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
> -		mutex_unlock(&devfreq_list_lock);
> -		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
> -		return;
> -	}
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
> @@ -694,10 +689,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_init(&devfreq->lock);
>  	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
> +	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
