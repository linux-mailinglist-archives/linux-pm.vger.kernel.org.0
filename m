Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53F6389B88
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETCx1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 May 2021 22:53:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:30626 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhETCx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 May 2021 22:53:27 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210520025204epoutp03d229c85355951256b528334f5a69ab3f~Apqwk7J-l1967819678epoutp03h
        for <linux-pm@vger.kernel.org>; Thu, 20 May 2021 02:52:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210520025204epoutp03d229c85355951256b528334f5a69ab3f~Apqwk7J-l1967819678epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621479124;
        bh=xe5a/x2IOrL0M3auQ+UbPj1z/vvYCjMTEXFCUrUlYBE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rf7pJfk1AzEt3HUoW9z0EkuaV37c7VLLuYh7JODS0buzd+g7Tj7hIwSpsdr0tZjfG
         RkYsXNMcnKQqLk97P6XcW7AN2jBVR4Ir377i629v+zzXAWjlbVl5ldfbs0oIbwtJ/A
         oX8ncZtnMbGfgyVoTk0oYjPWzPTOk+mXNuhIhvOI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210520025203epcas1p1e2e1f4fe9f612f71fb2facd122632e50~Apqv4XcBK3125431254epcas1p1s;
        Thu, 20 May 2021 02:52:03 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FlvQn1BtNz4x9Pr; Thu, 20 May
        2021 02:52:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.12.09701.FCEC5A06; Thu, 20 May 2021 11:51:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210520025158epcas1p3d3ff725af7d573bbad95f53d8c2b25a4~ApqrRAKcW2908329083epcas1p3i;
        Thu, 20 May 2021 02:51:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210520025158epsmtrp203391865c01b987b4da7fc979b16d4a6~ApqrLQMEI2978129781epsmtrp2C;
        Thu, 20 May 2021 02:51:58 +0000 (GMT)
X-AuditID: b6c32a36-647ff700000025e5-65-60a5cecf6058
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.D5.08163.ECEC5A06; Thu, 20 May 2021 11:51:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210520025158epsmtip16a009e36c02dc24afc8a9f1c9efce15d~Apqq__eor2003720037epsmtip1O;
        Thu, 20 May 2021 02:51:58 +0000 (GMT)
Subject: Re: [PATCH 2/2] devfreq: imx8m-ddrc: de-select
 DEVFREQ_GOV_SIMPLE_ONDEMAND
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, dongas86@gmail.com,
        linux-imx@nxp.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, shawnguo@kernel.org,
        kernel@pengutronix.de, abel.vesa@nxp.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a6f61bf1-b1c3-692a-608c-fe5486a77e52@samsung.com>
Date:   Thu, 20 May 2021 12:10:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210519070545.1728197-2-aisheng.dong@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmge75c0sTDD6fMLBYdukoo8WXqbuY
        Lf5uns5msWrqThaLs01v2C02Pb7GatH1ayWzxefeI4wWtxtXsFm82CLuwOWxc9Zddo9NqzrZ
        PDYvqffY+G4Hk0f/XwOPvi2rGD0+b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
        1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
        U2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ2x/A1/wUKOiua1bUwNjA/Yuhg5OSQETCRerNnI
        3sXIxSEksINRouP6dSjnE6NEd2s7C4TzmVHi79El7DAtbw+fYoZI7GKUeLfnHiOE855R4szf
        5WCDhQVCJV613AbrEBFwlFj/+CgrSBGzwHFGiUO7uplAEmwCWhL7X9wAa+AXUJS4+uMxI4jN
        K2An8fl3C1Ccg4NFQFVi8tNQkLCoQJjEyW0tUCWCEidnPmEBKeEUsJHouiwJEmYWEJe49WQ+
        E4QtL7H97RxmiKMPcEjsOBwCYbtIvPi4jRXCFpZ4dXwL1GNSEp/f7YWGS7XEypNH2EBOlhDo
        YJTYsv8CVIOxxP6lk5lA9jILaEqs36UPEVaU2Pl7LiPEXj6Jd197WEFKJAR4JTrahCBKlCUu
        P7jLBGFLSixu72SbwKg0C8kzs5B8MAvJB7MQli1gZFnFKJZaUJybnlpsWGCEHNebGMHJVsts
        B+Oktx/0DjEycTAeYpTgYFYS4d3uvThBiDclsbIqtSg/vqg0J7X4EKMpMHQnMkuJJucD031e
        SbyhqZGxsbGFiaGZqaGhkjhvunN1gpBAemJJanZqakFqEUwfEwenVAPTCsmqzO2X1k5wrE7o
        KHF57NnWtPjED+ZbK27nrT2oet/NLa5jT0PCuuX35+lJKJV/D7hd+KBHVSf1hd7vD4wLDn/T
        2Sv1/e1Hi9cCiwOL/222eLhSf73Uyvx+8y1a0rvPfhKVkX7cOWHDi5SgV94+bx/vbHlXc/LZ
        ddeU66fUhLIFjsx+ueFz6NQrFuervvFJHXpe/3nWSdnHh4t6TRbtW3Rxp5xnTWpHkeiZAj/j
        TKFZ9R1T1bunKn/k/rvxSAlrisXzP//CV6v8DlnwRKnaeP2u+mpmma3fhc5Evtcv7a3esNRD
        bZeCa3DG6ReyD87P4nc75aXHEi4Sc0Gm6+EXWZt9v93Y1t2pd65XjNHsUGIpzkg01GIuKk4E
        AJ8cC5c/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnO65c0sTDLYeFrBYdukoo8WXqbuY
        Lf5uns5msWrqThaLs01v2C02Pb7GatH1ayWzxefeI4wWtxtXsFm82CLuwOWxc9Zddo9NqzrZ
        PDYvqffY+G4Hk0f/XwOPvi2rGD0+b5ILYI/isklJzcksSy3St0vgylj+hr9gIUdF89o2pgbG
        B2xdjJwcEgImEm8Pn2LuYuTiEBLYwSjx/+FUZoiEpMS0i0eBbA4gW1ji8OFikLCQwFtGiXm/
        rUFsYYFQiVctt9lBbBEBR4n1j4+ygsxhFjjOKHF9yTx2iKEHGSVmTJrPCFLFJqAlsf/FDbDN
        /AKKEld/PAaL8wrYSXz+3cIGsoxFQFVi8tNQkLCoQJjEziWPmSBKBCVOznzCAlLCKWAj0XVZ
        EiTMLKAu8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPQtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCUl1quV5yYW1yal66XnJ+7iREcdVpaOxj3rPqgd4iRiYPxEKMEB7OSCO9278UJQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBlhWl/P/Y61mtb
        TWz/f5WTYsyHt6Ywz9aadMkyqaXzq853tj0b9vBvW3k+0mBljHP0msl7eGNuJ19pLE4+ZP35
        78/q85tXMzFEn147Qbv9a7s6U8yic1YL0uceWLiQ2dixZNGBHTe/Zy7X+GhQsIShoabEicuX
        /1OwXlWZnP+NGTesWD8W89QX+upPMfzM6dWabCT7TaCiuVO0f9vHDTve71lUvvubzO9Sv3aW
        l6snFYiKbWWy8pJa43r5xCXTj+1CInnZFx9vrv635LBHSO0blydNW+YFW7W/3cAUePHv82Uz
        /3bs3yzLq713qa+GU/Blb4WVT78+njDf82fQpMcyOe8WPJi8Is9QtV76S8FqJZbijERDLeai
        4kQAivnsPikDAAA=
X-CMS-MailID: 20210520025158epcas1p3d3ff725af7d573bbad95f53d8c2b25a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210519070650epcas1p1b4070dd9636125d708803b4cd94e5dbc
References: <20210519070545.1728197-1-aisheng.dong@nxp.com>
        <CGME20210519070650epcas1p1b4070dd9636125d708803b4cd94e5dbc@epcas1p1.samsung.com>
        <20210519070545.1728197-2-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/19/21 4:05 PM, Dong Aisheng wrote:
> The driver can't support simple ondemand governor due to missing
> .get_dev_status() capability.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/devfreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 20373a893b44..e87d01c0b76a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -103,7 +103,6 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  	tristate "i.MX8M DDRC DEVFREQ Driver"
>  	depends on (ARCH_MXC && HAVE_ARM_SMCCC) || \
>  		(COMPILE_TEST && HAVE_ARM_SMCCC)
> -	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>  	select DEVFREQ_GOV_USERSPACE
>  	help
>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
> 

Looks good to me. But, How about changing the patch title as following?
- PM / devfreq: imx8m-ddrc: Remove DEVFREQ_GOV_SIMPLE_ONDEMAND dependency


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
