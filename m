Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CBF8AEA4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 07:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfHMFRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 01:17:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:62482 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHMFRJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 01:17:09 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190813051706epoutp04f67f7df12ba3071873dc85ba34d54c89~6Y6_1zQ0v2609126091epoutp04q
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 05:17:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190813051706epoutp04f67f7df12ba3071873dc85ba34d54c89~6Y6_1zQ0v2609126091epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565673426;
        bh=asg1+11sWbxWVm15jhQwqqQHiNjN+oh4Orb1yYvnZE4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jaLci8R34cu3oFmZweFCc9tZLG2eGeeKvMswbzNj09rhoK4Ev2SibWyCDOHy4cg2a
         9t3yhjl3muKm10YpRRfnUm7SwYph9a9Ae4XLs35J1d7tcKbylxr9hbennzOW2OZflw
         OmUgy80S08Zo6YlQtQDgLdWi3nrCPuBz8dhKag8w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190813051706epcas1p39a02e1745d36569887caf980517a5d35~6Y6_QCde42016820168epcas1p3-;
        Tue, 13 Aug 2019 05:17:06 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4671DH4jgYzMqYkk; Tue, 13 Aug
        2019 05:17:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.27.04160.FC7425D5; Tue, 13 Aug 2019 14:17:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190813051703epcas1p285e40712bffe72cac7679d9b7b077016~6Y67UzpT52039020390epcas1p29;
        Tue, 13 Aug 2019 05:17:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813051702epsmtrp20ff7dc760e948da36b76be2e3d3e1027~6Y67T6HZt2206022060epsmtrp2c;
        Tue, 13 Aug 2019 05:17:02 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-cd-5d5247cf1f99
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.9F.03638.EC7425D5; Tue, 13 Aug 2019 14:17:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813051702epsmtip2449d440ef1074f71d52b4f0970e4de19~6Y67A_GdB0268102681epsmtip26;
        Tue, 13 Aug 2019 05:17:02 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: passive: Use non-devm notifiers
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <609b263d-d852-205f-c786-2062ca5b36fc@samsung.com>
Date:   Tue, 13 Aug 2019 14:20:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <074ddc8e211bc7466b5ceec2591cb220a44d8d3a.1565672482.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmvu5596BYg7enxS0OHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtVtz9yGqx6fE1VovPvUcYLW43rmCzWH3uIJtF16G/bA48
        Hu9vtLJ7LNhU6rFpVSebx51re9g8Ni+p99j4bgeTx8F3e5g8+rasYvT4vEkugDMq2yYjNTEl
        tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GAlhbLEnFKgUEBi
        cbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbG26UnWQp6
        JSsevJvN2sB4X6SLkZNDQsBEonX9W+YuRi4OIYEdjBK3t0xghXA+MUos+vyQEcL5xiix//c6
        FpiW63032CASexklrlyawgySEBJ4zyhxcUEoiC0s4CrR0N4C1i0i0MwosfXEWyYQh1ngN5PE
        pG+v2UCq2AS0JPa/uAFm8wsoSlz98ZgRxOYVsJNof3wQbB2LgKpEQ+cmsBpRgQiJTw8Os0LU
        CEqcnPkErIZTIE7i18lX7CA2s4C4xK0n85kgbHmJ5q2zmSHO3sQuMXuRC4TtInHh+3EmCFtY
        4tXxLewQtpTE53d72SDsaomVJ4+AvSkh0MEosWX/BVaIhLHE/qWTgZo5gBZoSqzfpQ8RVpTY
        +XsuI4TNK9Gw8TfUPXwS7772sIKUg8Q72oQgSpQlLj+4yzSBUXkWkm9mIflgFpIPZiEsW8DI
        sopRLLWgODc9tdiwwAQ5ujcxglOzlsUOxj3nfA4xCnAwKvHwViQExgqxJpYVV+YeYpTgYFYS
        4b1kEhQrxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBeSOvJN7Q1MjY2NjCxNDM1NBQSZx3
        4Q+LWCGB9MSS1OzU1ILUIpg+Jg5OqQZGlW0qhxWZBDkup9l+5mvkfmr/QeHg/W+9X5T4vk90
        8ClNfPZp16yVx57ue/vTcVZW3ZOFyh++JHG6H/mZZvbEoVLrhZmx02f1Fa7rbE5qKAlYbxL5
        YnA/eFJqqtur+nsnl2fHZV5W92febK3B1aYUtUr+61mpVY+dTly6+WbKNp6wF3oVRyQPKLEU
        ZyQaajEXFScCAJcRCY7jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvO4596BYg9fvTC0OHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtVtz9yGqx6fE1VovPvUcYLW43rmCzWH3uIJtF16G/bA48
        Hu9vtLJ7LNhU6rFpVSebx51re9g8Ni+p99j4bgeTx8F3e5g8+rasYvT4vEkugDOKyyYlNSez
        LLVI3y6BK+Pt0pMsBb2SFQ/ezWZtYLwv0sXIySEhYCJxve8GG4gtJLCbUeLP1wiIuKTEtItH
        mbsYOYBsYYnDh4u7GLmASt4ySpz9vg6sXljAVaKhvYURJCEi0Moocef0DzYQh1ngN5PEip67
        zBAtGxklfi7fwQrSwiagJbH/BcQ6fgFFias/HjOC2LwCdhLtjw+ygNgsAqoSDZ2bwGpEBSIk
        Du+YBVUjKHFy5hOwGk6BOIlfJ1+xg9jMAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2
        WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAo1dLawXjiRPwh
        RgEORiUe3oqEwFgh1sSy4srcQ4wSHMxKIryXTIJihXhTEiurUovy44tKc1KLDzFKc7AoifPK
        5x+LFBJITyxJzU5NLUgtgskycXBKNTAKcN46pXFRtPwW1zH5vZ/SrU5r9F7zt7kvVDHJTqBD
        f1LchRkbOxT2nhTpeypoc7JsQbHDqcaGpnNbqpbYT1v653F43tEXd2bw8y3csGlf6rGFy3gt
        4tdmdzRzKGmYBsxRmvIgm112V5ZAV+RbtZ9rPBdc2Lhdeern2H/CCg7KlV+tV1n++rxAiaU4
        I9FQi7moOBEApbo07M4CAAA=
X-CMS-MailID: 20190813051703epcas1p285e40712bffe72cac7679d9b7b077016
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190813050645epcas4p1ff658228ef2ebe18c4259d6c33ed5345
References: <CGME20190813050645epcas4p1ff658228ef2ebe18c4259d6c33ed5345@epcas4p1.samsung.com>
        <074ddc8e211bc7466b5ceec2591cb220a44d8d3a.1565672482.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Why do you miss the 'Fixes' tag as I commented?
Is there any reason?

On 19. 8. 13. 오후 2:06, Leonard Crestez wrote:
> The devfreq passive governor registers and unregisters devfreq
> transition notifiers on DEVFREQ_GOV_START/GOV_STOP using devm wrappers.
> 
> If devfreq itself is registered with devm then a warning is triggered on
> rmmod from devm_devfreq_unregister_notifier. Call stack looks like this:
> 
> 	devm_devfreq_unregister_notifier+0x30/0x40
> 	devfreq_passive_event_handler+0x4c/0x88
> 	devfreq_remove_device.part.8+0x6c/0x9c
> 	devm_devfreq_dev_release+0x18/0x20
> 	release_nodes+0x1b0/0x220
> 	devres_release_all+0x78/0x84
> 	device_release_driver_internal+0x100/0x1c0
> 	driver_detach+0x4c/0x90
> 	bus_remove_driver+0x7c/0xd0
> 	driver_unregister+0x2c/0x58
> 	platform_driver_unregister+0x10/0x18
> 	imx_devfreq_platdrv_exit+0x14/0xd40 [imx_devfreq]
> 
> This happens because devres_release_all will first remove all the nodes
> into a separate todo list so the nested devres_release from
> devm_devfreq_unregister_notifier won't find anything.
> 
> Fix the warning by calling the non-devm APIS for frequency notification.
> Using devm wrappers is not actually useful for a governor anyway: it
> relies on the devfreq core to correctly match the GOV_START/GOV_STOP
> notifications.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: stable@vger.kernel.org
> 
> ---
> Changes since v1:
> * Remove unused variable "dev" and avoid warning
> * Added ack and cc stable
> Link to v1: https://patchwork.kernel.org/patch/11084541/
> 
>  drivers/devfreq/governor_passive.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 58308948b863..be6eeab9c814 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -147,11 +147,10 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  }
>  
>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  				unsigned int event, void *data)
>  {
> -	struct device *dev = devfreq->dev.parent;
>  	struct devfreq_passive_data *p_data
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent = (struct devfreq *)p_data->parent;
>  	struct notifier_block *nb = &p_data->nb;
>  	int ret = 0;
> @@ -163,16 +162,16 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	case DEVFREQ_GOV_START:
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
>  		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devm_devfreq_register_notifier(dev, parent, nb,
> +		ret = devfreq_register_notifier(parent, nb,
>  					DEVFREQ_TRANSITION_NOTIFIER);
>  		break;
>  	case DEVFREQ_GOV_STOP:
> -		devm_devfreq_unregister_notifier(dev, parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		WARN_ON(devfreq_unregister_notifier(parent, nb,
> +					DEVFREQ_TRANSITION_NOTIFIER));
>  		break;
>  	default:
>  		break;
>  	}
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
