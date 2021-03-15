Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6634E33ABF4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 08:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCOHEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 03:04:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46607 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCOHDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 03:03:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210315070340epoutp02b814b656d217c16aea4ecdfc72c79e30~schmo679R2428224282epoutp02h
        for <linux-pm@vger.kernel.org>; Mon, 15 Mar 2021 07:03:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210315070340epoutp02b814b656d217c16aea4ecdfc72c79e30~schmo679R2428224282epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615791820;
        bh=K0AMjK6xDxixk6h8BOyJRSQvpEFk16GWw8ahalOQEnM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EWduoRZ/P3kXSAEERc1yDnkuhAIIFeLfECZ0r6/hi1hr3ztJGz0j5qAXss2vXY3Tl
         Q60cUkS2XVVjKCBv8zQItYTYNlquUbHLkhnixQIKzybK3zbSLDYjK6bFHx7GWbfTCv
         KgPYkVfWf/nkm4s78uFB0CN73CmP3qCJ6/tCNxk8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210315070338epcas1p102ddff01d5b1e83377c4971132643c1e~schkJk7pu0105201052epcas1p1h;
        Mon, 15 Mar 2021 07:03:38 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DzS7W6qMqz4x9Py; Mon, 15 Mar
        2021 07:03:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.A7.59147.3C60F406; Mon, 15 Mar 2021 16:03:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210315070329epcas1p4a707a7b961b172fdd615c06731e6c61c~schbpogdT1473614736epcas1p4O;
        Mon, 15 Mar 2021 07:03:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210315070329epsmtrp14610096271e6cf9a179a9383ee6a4288~schbpAfdO2428224282epsmtrp1h;
        Mon, 15 Mar 2021 07:03:29 +0000 (GMT)
X-AuditID: b6c32a38-e53ff7000000e70b-d8-604f06c32441
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.8B.13470.0C60F406; Mon, 15 Mar 2021 16:03:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210315070328epsmtip2a118853963d9fef374eafed02c16d7d1~schbaaAUr1820518205epsmtip27;
        Mon, 15 Mar 2021 07:03:28 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: unlock mutex and free devfreq struct in
 error path
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <aa65398e-6de6-92df-3c27-a8a7f43eda10@samsung.com>
Date:   Mon, 15 Mar 2021 16:20:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210312184534.6423-1-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQPcwm3+Cwe9HGhZnm96wW1zeNYfN
        4nPvEUaLhU0t7Ba3G1ewObB6rJm3htGjb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVioplCXmlAKFAhKLi5X07WyK8ktLUhUy
        8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjM29K9gLHjNWXFw4162Bsbv7F2M
        nBwSAiYSez/fYu1i5OIQEtjBKPFk93MWCOcTo8SFa03sEM43Romm1w1wLdM2zmYGsYUE9jJK
        vJwZD1H0nlHi6YSHQEUcHMIC4RJHtiaD1IgIxEssPPQBrJdZwFzi796zLCA2m4CWxP4XN9hA
        bH4BRYmrPx4zgti8AnYS3T3nwepZBFQlNpzdBRYXFQiTOLmtBapGUOLkzCdgczgFLCTu9kxl
        hpgvLnHryXwmCFteYvvbOcwgt0kI/GSXmNexhRniAReJG8d2M0LYwhKvjm+BekxK4mV/G5Rd
        LbHy5BE2iOYORokt+y+wQiSMJfYvncwE8iSzgKbE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKA
        V6KjTQiiRFni8oO7TBC2pMTi9k62CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgUm
        yJG9iRGcGrUsdjDOfftB7xAjEwfjIUYJDmYlEd7POr4JQrwpiZVVqUX58UWlOanFhxhNgQE8
        kVlKNDkfmJzzSuINTY2MjY0tTAzNTA0NlcR5kwwexAsJpCeWpGanphakFsH0MXFwSjUwifwV
        +35uWofKPoeTQbqvFHe21tgK1V7x28k55y6PrPRpvi0hOieZRW5U+E2ql/v9JUqVSfX3pE1t
        J92+Cmrkcaf0iKY9qGJ/1HveYbtxsvdVvhzLx8avFl0KiTi2VCxgXsjhLdYP8q2Nl25oPuLX
        vb9dtPjiP7ZLoc65NTr1kx3vq9uYHvJe2XH10IpL18S+t9z4bnZa5drR21t2BVypKj5rumub
        zt8KxxWXVbyn/6x9ppzKo15gGLXgHdPVTB0da45fZoEfuovFWpd6CDXvU7rIPbPyzi2RGsPD
        PltPOp8J2l0SW61ysdJp15XqQ/eCT9w0NPSxSnmsPs/u+P30rj3L4q96st93Ud78P8JIiaU4
        I9FQi7moOBEArBVa/BYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO4BNv8Eg2uXLC3ONr1ht7i8aw6b
        xefeI4wWC5ta2C1uN65gc2D1WDNvDaNH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZWzoX8FY
        8Jqz4uDGvWwNjN/Zuxg5OSQETCSmbZzN3MXIxSEksJtR4tjJ3WwQCUmJaRePAiU4gGxhicOH
        iyFq3jJKTPp5gAkkLiwQLnFkazJIuYhAvMSEB9fBZjILmEv83XuWBaK+m1Hixd4XYAk2AS2J
        /S9ugM3nF1CUuPrjMSOIzStgJ9Hdcx6shkVAVWLD2V1gcVGBMImdSx4zQdQISpyc+YQFxOYU
        sJC42zOVGWKZusSfeZegbHGJW0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2Rq
        QXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwlGhp7mDcvuqD3iFGJg7GQ4wSHMxKIryfdXwT
        hHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBSNKvIvB+x
        cYLJ24QGHr/ZDQuCdFd+8StP2sfCKDgv51qrXu2s29skwycn/FZo7tg/1+jG/P5l/mJHXj9n
        W/D3aJxPyNS4Bf5C0/OuMyzMOPmqc1OARNOj+Kwji/gc/G4sPXBpd6t2m+3m5es1zGZaqrMc
        3DxxV3KR/Dm5j+urS2pOCmxR7d35d59Rq8tSqdKo8CUvt6n4X8r2u++QlOORdM3iw7UjHKVr
        ljh1dyueSvp2rs32TCPjkren57sb6ZnPnr/rgN+aDsFFW7q905mzrknl3vrqpLp/HtsnrnVL
        medtOsDcsTvq1j3TB959Mxuv3muf3yNhOXfr7KyTk7+8eNqxvd7jn9G5owpNNy+xKrEUZyQa
        ajEXFScCANZ7F8EBAwAA
X-CMS-MailID: 20210315070329epcas1p4a707a7b961b172fdd615c06731e6c61c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210312184551epcas1p2fe579b2a736cac2814b8a236869c4c27
References: <CGME20210312184551epcas1p2fe579b2a736cac2814b8a236869c4c27@epcas1p2.samsung.com>
        <20210312184534.6423-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 3/13/21 3:45 AM, Lukasz Luba wrote:
> The devfreq->lock is held for time of setup. Release the lock in the
> error path, before jumping to the end of the function.
> 
> Change the goto destination which frees the allocated memory.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/devfreq/devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6d3e7db0b09..99b2eeedc238 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -822,7 +822,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	if (devfreq->profile->timer < 0
>  		|| devfreq->profile->timer >= DEVFREQ_TIMER_NUM) {
> -		goto err_out;
> +		mutex_unlock(&devfreq->lock);
> +		goto err_dev;
>  	}
>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> 

Looks good to me. But, need to add the following information
and please use capital letter of the first character of patch title. Thanks.

Fixes: 4dc3bab8687f ("PM / devfreq: Add support delayed timer for polling mode")

Also, need to send it to stable lkml.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
