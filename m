Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13D2145EDD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVW6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 17:58:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:61265 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAVW6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 17:58:34 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200122225831epoutp046dd2423b4d751b62a5e49659f6c589ff~sV5_Fxadi3120131201epoutp04V
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2020 22:58:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200122225831epoutp046dd2423b4d751b62a5e49659f6c589ff~sV5_Fxadi3120131201epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579733911;
        bh=nFrx10v7A1u9/HQM+bH+e/JDlZ6OmMIlx/iNZ05UEeQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jYdXX8s+6siXl+LhCwLAO5d6BTI9QdAKiJBbGACFtezPcbFsqIHKtnD5tS4XBnuGX
         2ffBe6tDeM4XWtp2/EffHrOEaaBYiiwhFc292642QqhhU7dRaKv7pZMZ+/ree+Swg6
         NC6whXz0K5TaH/u3PinwN/0dQa9irfbWaczhTabQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200122225831epcas1p4ba70f6483c1dc7c84e3565e65f0510e2~sV59SsFNA2799227992epcas1p4Q;
        Wed, 22 Jan 2020 22:58:31 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48316D5hq9zMqYkV; Wed, 22 Jan
        2020 22:58:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.DC.48019.493D82E5; Thu, 23 Jan 2020 07:58:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200122225828epcas1p2854507e83c7119ba9199268015e48165~sV56jvcO30642106421epcas1p24;
        Wed, 22 Jan 2020 22:58:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200122225828epsmtrp15a18527e95f99c010fe1f4fc887e4a74~sV56jBVvm1436914369epsmtrp1r;
        Wed, 22 Jan 2020 22:58:28 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-5c-5e28d3943fbe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.E5.06569.393D82E5; Thu, 23 Jan 2020 07:58:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200122225827epsmtip264fe73873f27dcd737d69717a8da557d~sV56Urrc82971029710epsmtip2R;
        Wed, 22 Jan 2020 22:58:27 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Fix two malformed kerneldoc comments
To:     Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <543b6c56-a93a-2397-b1af-8ce8aa2c2e54@samsung.com>
Date:   Thu, 23 Jan 2020 08:05:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200122105716.2868f272@lwn.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTX3fKZY04g7ZlmhZPDrQzWpxtesNu
        8bn3CKPF7cYVbA4sHov7JrN69G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8
        qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0DYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1S
        akFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGtpnn2Auu81VMOyXVwDiPp4uRk0NCwETi
        zsktLF2MXBxCAjsYJeYu/8II4XxilFg5cQorhPONUWLLr4MsMC07nj5kgkjsZZTYM3cjVP97
        RolDXYfBqoQF3CXWPTzGCGKLCFRJPG+5yQxiMwvISPx+sQjMZhPQktj/4gYbiM0voChx9cdj
        sHpeATuJf40HwOawCKhKdH78ywRiiwqESZzc1gJVIyhxcuYTsBpOAT2JI6f+Qs0Xl7j1ZD4T
        hC0vsf3tHGaQ4yQETrBJnNy+gxHiBReJIzM+sELYwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2ju
        APp//wWoBmOJ/UsnA23gANqgKbF+lz5EWFFi5++5jBCL+STefe1hBSmREOCV6GgTgihRlrj8
        4C4ThC0psbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgQlybG9iBKdELYsd
        jHvO+RxiFOBgVOLhdbDUiBNiTSwrrsw9xCjBwawkwrugSTVOiDclsbIqtSg/vqg0J7X4EKMp
        MLQnMkuJJucD03VeSbyhqZGxsbGFiaGZqaGhkjjvdBeFOCGB9MSS1OzU1ILUIpg+Jg5OYII6
        Lu6QcLLn5gWm2M/bskzUquPtPyd81M38/Lv8ocTMkEtvNz4Pf2g2232tQQzfy9wen6IlEydv
        rGG89vvLlZzTDDvn3RQvq8wJZVjwofbRgdL7hxSeZ5xqXqGZ5fLWQ+oAr8+Or7McVz1T3Myx
        PcyAeckFl9YvRlolV9MXbLkeVxY0d+v9r71blViKMxINtZiLihMBClG4jJ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO6UyxpxBr+mMVk8OdDOaHG26Q27
        xefeI4wWtxtXsDmweCzum8zq0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBnbZp5jL7jOVzHt
        lFQD4zyeLkZODgkBE4kdTx8ydTFycQgJ7GaUOPd9PyNEQlJi2sWjzF2MHEC2sMThw8UQNW8Z
        JRbP3ccCUiMs4C6x7uExsHoRgSqJ66ses4PYzAIyEr9fLGKGaGhklNiz8A4bSIJNQEti/4sb
        YDa/gKLE1R+PwZp5Bewk/jUeABvKIqAq0fnxLxOILSoQJrFzyWMmiBpBiZMzn4DVcAroSRw5
        9ZcZYpm6xJ95l6BscYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56
        brFhgVFearlecWJucWleul5yfu4mRnBsaGntYDxxIv4QowAHoxIPr4OlRpwQa2JZcWXuIUYJ
        DmYlEd4FTapxQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODiB
        cbP42+eXe4S8mTc8cV6m9jTvdKsHV1rAysOfj+kLJ0QsVpkxaaOM5m+Xn6zXPi7RsU+Z6vZz
        4exuY3YfkW2XjY3/zPjUqqZ1aNsxzhdXXhWkMP/epNepE3ZBvERHv2fif9eKdXmne5gL1kfL
        xhQZG8iGLNvnMa9i7xPjSEbzXCn9a5uaI2aVHlNiKc5INNRiLipOBAAHEpBMiQIAAA==
X-CMS-MailID: 20200122225828epcas1p2854507e83c7119ba9199268015e48165
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200122175720epcas1p3655a86344a8a934828ca0371da3cdcca
References: <CGME20200122175720epcas1p3655a86344a8a934828ca0371da3cdcca@epcas1p3.samsung.com>
        <20200122105716.2868f272@lwn.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jonathan,

The same patch[1] was already merged to linux-pm.git
via devfreq git. Thanks for your patch.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=54cb5740526a2f30d57f146d8a17364c59287187

Regards,
Chanwoo Choi

On 1/23/20 2:57 AM, Jonathan Corbet wrote:
> Two kerneldoc comments in devfreq.c fail to adhere to the required format,
> resulting in these doc-build warnings:
> 
>   ./drivers/devfreq/devfreq.c:1818: warning: bad line:
>   	- Resource-managed devfreq_register_notifier()
>   ./drivers/devfreq/devfreq.c:1854: warning: bad line:
> 	- Resource-managed devfreq_unregister_notifier()
> 
> Add a couple of missing asterisks and make kerneldoc a little happier.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 57f6944d65a6..00c9b80b3d33 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1814,7 +1814,7 @@ static void devm_devfreq_notifier_release(struct device *dev, void *res)
>  
>  /**
>   * devm_devfreq_register_notifier()
> -	- Resource-managed devfreq_register_notifier()
> + *	- Resource-managed devfreq_register_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> @@ -1850,7 +1850,7 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
>  
>  /**
>   * devm_devfreq_unregister_notifier()
> -	- Resource-managed devfreq_unregister_notifier()
> + *	- Resource-managed devfreq_unregister_notifier()
>   * @dev:	The devfreq user device. (parent of devfreq)
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to be unregistered.
> 
