Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB707B732
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 02:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfGaAaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 20:30:12 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:39314 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGaAaL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 20:30:11 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190731003007epoutp0463e70402c29f4ff239757cce152bd75b~2VnshUWNk1223112231epoutp04d
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 00:30:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190731003007epoutp0463e70402c29f4ff239757cce152bd75b~2VnshUWNk1223112231epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564533007;
        bh=wTd3fwtX0IxUTdzCG0cl1kybCtrsuYuv54bmF5iTvGM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l+x04DqTDw+tXkXiQrMRZCa08s3Oev9TrLeQhQmAN2O0vhqe91fxGGTCnTcdPpTOi
         ShC2Z6nFs60dS9PxhfcCGmrc5TYhItLmEb2mCarFxgoi9vMpXzJNEwJS2n1qpQ5ZWz
         J9rejzKDy/RrbocAdbm8ZV0MXcAOu4wMvUQOalng=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190731003007epcas1p1463917ad173e6be1cc417ddd1b77e62b~2VnsQUBl52053920539epcas1p1X;
        Wed, 31 Jul 2019 00:30:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45yvT64KqQzMqYkh; Wed, 31 Jul
        2019 00:30:02 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.D9.04075.501E04D5; Wed, 31 Jul 2019 09:29:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190731002957epcas1p4ed4e79fa6d81dedc8aef3e17e7459668~2VnjAt6lZ2116821168epcas1p4a;
        Wed, 31 Jul 2019 00:29:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190731002957epsmtrp1c75d695fc7bb7369025de4713bfdbcd2~2VnjAB20k2425724257epsmtrp1D;
        Wed, 31 Jul 2019 00:29:57 +0000 (GMT)
X-AuditID: b6c32a36-b61ff70000000feb-f1-5d40e10522e1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.5E.03706.501E04D5; Wed, 31 Jul 2019 09:29:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190731002956epsmtip16320b414752961c44fae2aa4dd52b64c~2Vni1iQYZ2271322713epsmtip1G;
        Wed, 31 Jul 2019 00:29:56 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Drop the name check to request module in
 try_then_request_governor()
To:     Yue Hu <zbestahu@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc:     linux-pm@vger.kernel.org, huyue2@yulong.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8e5efa9c-96c4-0c2c-b92a-d72ee598838c@samsung.com>
Date:   Wed, 31 Jul 2019 09:33:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730100819.8056-1-zbestahu@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmni7rQ4dYg8cvJSz2zL7LbHG26Q27
        xefeI4wWtxtXsFnMPcXlwOqxc9Zddo++LasYPT5vkvPYumYxcwBLVLZNRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2RvPSa8wFJ4Ur3rw8y97A
        2CbQxcjJISFgInHw+WXWLkYuDiGBHYwSz/9cYgVJCAl8YpTYvDMfIvGNUeJNbz8TTMeylm1s
        EIm9jBK7/lxggnDeM0q0rLoC1i4skCnx9MZiFhBbRCBM4urjF4wgNrOAvsTNJe+ZQWw2AS2J
        /S9usIHY/AKKEld/PAar4RWwk7h5tBlsDouAqsT77UvAbFGBCIlPDw6zQtQISpyc+QRsPqeA
        ucTlLROh5otL3HoynwnClpdo3jqbGeQ4CYHrbBKXl3SzQrzgInH+30xmCFtY4tXxLewQtpTE
        y/42KLtaYuXJI2wQzR2MElv2X4BqNpbYv3Qy0AYOoA2aEut36UOEFSV2/p4LdQSfxLuvPawg
        JRICvBIdbUIQJcoSlx/chYaipMTi9k62CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anF
        hgVGyLG9iRGcJLXMdjAuOudziFGAg1GJh/dErEOsEGtiWXFl7iFGCQ5mJRHexeL2sUK8KYmV
        ValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jA80riDU2NjI2NLUwMzUwNDZXEeRf+sIgVEkhPLEnN
        Tk0tSC2C6WPi4JRqYGTN7DNZ27FmUZ+c4v3PijwlH369ZPesETud/CbvVI2Hxe0U5kLHo8o3
        dDX79D1npqjsPeV+sTk96MqPp+c1NGUD7scF/vplXbT0A//P9e92dkfK7mZQ/sl9VS1YR1kl
        zPY+4589shHWnOX/7k4TETraZqVxpCykrU7t265jn6fJHTlz1GnlZyWW4oxEQy3mouJEAGsr
        37+oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTpf1oUOswca/rBZ7Zt9ltjjb9Ibd
        4nPvEUaL240r2CzmnuJyYPXYOesuu0ffllWMHp83yXlsXbOYOYAlissmJTUnsyy1SN8ugSuj
        eek15oKTwhVvXp5lb2BsE+hi5OSQEDCRWNayja2LkYtDSGA3o8TpE9fZIBKSEtMuHmXuYuQA
        soUlDh8uhqh5yyixdedWVpAaYYFMiac3FrOA2CICYRL9vZOZQGxmAX2Jm0veM0M0dAE1TNzB
        CJJgE9CS2P/iBtgCfgFFias/HoPFeQXsJG4ebQYbyiKgKvF++xIwW1QgQuLwjllQNYISJ2c+
        AVvGKWAucXnLREaIZeoSf+ZdYoawxSVuPZkPdYS8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCy
        rGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4XLc0djJeXxB9iFOBgVOLhPRHrECvE
        mlhWXJl7iFGCg1lJhHexuH2sEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NT
        C1KLYLJMHJxSDYyqr964b3F3+3C2UiW7Xi/G8D2f/oRTe14cy404+dNRaQaH2LfwVNOS1opF
        Em4vf3nnL7rwOJBRdedZA4FtQdNOGheebxZdyK9iuVH/doZ/usWUBUnnHq3kMc08fXHK45+T
        73ZJVWUIb1U18Yp57PK1ZLuMpfu/252z5hZ/UikV+dP8hPtvN4sSS3FGoqEWc1FxIgA4mQB0
        kwIAAA==
X-CMS-MailID: 20190731002957epcas1p4ed4e79fa6d81dedc8aef3e17e7459668
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190730100844epcas4p14dfa39fff2636e89c94033f154240db0
References: <CGME20190730100844epcas4p14dfa39fff2636e89c94033f154240db0@epcas4p1.samsung.com>
        <20190730100819.8056-1-zbestahu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 30. 오후 7:08, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> No need to check specific governor name of `simple_ondemand` to request
> module, let's change the name string to `simpleondemand` to keep the
> consistency on loading module if needed.

NACK.

hmm.... It is impossible to change the devfreq governor name
because there are many reason.

The devfreq governor could be changed through the sysfs interface
on runtime. For a long time, many users or platforms change
the devfreq governor with the defined governor name through sysfs.
If it is just changed, it breaks ABI interface and cannot support
the compatibility. It is very critical problem. Please drop it.


Maybe, you didn't check the usage of devfreq device driver
in the mainline kernel. Almost devfreq device using simple_ondemand
governor have to add the governor name with devfreq_add_device().
If changed the governor name, it cause the fault of device driver
using the devfreq framework with simple_ondemand.


> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/devfreq/devfreq.c | 6 +-----
>  include/linux/devfreq.h   | 2 +-
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e..baff682 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -246,11 +246,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  	if (IS_ERR(governor)) {
>  		mutex_unlock(&devfreq_list_lock);
>  
> -		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> -			     DEVFREQ_NAME_LEN))
> -			err = request_module("governor_%s", "simpleondemand");
> -		else
> -			err = request_module("governor_%s", name);
> +		err = request_module("governor_%s", name);
>  		/* Restore previous state before return */
>  		mutex_lock(&devfreq_list_lock);
>  		if (err)
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed..41e8792 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -17,7 +17,7 @@
>  #define DEVFREQ_NAME_LEN 16
>  
>  /* DEVFREQ governor name */
> -#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> +#define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simpleondemand"
>  #define DEVFREQ_GOV_PERFORMANCE		"performance"
>  #define DEVFREQ_GOV_POWERSAVE		"powersave"
>  #define DEVFREQ_GOV_USERSPACE		"userspace"
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
