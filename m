Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4496B1DDF2F
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgEVFTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 01:19:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60795 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgEVFTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 01:19:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200522051928euoutp01364a85b191648e57a18ba9dce95210b9~RQg1lQ_9b1376213762euoutp01g
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 05:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200522051928euoutp01364a85b191648e57a18ba9dce95210b9~RQg1lQ_9b1376213762euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590124768;
        bh=bDBvRfRwXpfJfQj2KXHjRFIv2OKEmKMJBjpkDpCPm3o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fEGc3xK//4xmizDC3Lwt/WL6Lc1RO1I1CCKcjMXmd9E9cCATyEKAGwHBOJ3uqbVVS
         P/c5qSS7wMONMPJ8euUOxN0FJRNs8dsOqCfCUH8q41izHujPPR9qDJyCr4paUEBzjw
         GtEnDGARkdGqjIAvwaBiYnpPCO8oQ6l+UIKTXoHk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200522051928eucas1p2ae7e6d0237f73826f0ec5fe6346314be~RQg1IgnGu1567415674eucas1p2Q;
        Fri, 22 May 2020 05:19:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1F.78.61286.0E067CE5; Fri, 22
        May 2020 06:19:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200522051927eucas1p107f4aae8f0f47043f067d7d6b58efd19~RQg04aWgR3127431274eucas1p1H;
        Fri, 22 May 2020 05:19:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200522051927eusmtrp132203103fb852f9fbbbdaf357a54095b~RQg030OQj2136521365eusmtrp1n;
        Fri, 22 May 2020 05:19:27 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-53-5ec760e0572c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.BE.08375.FD067CE5; Fri, 22
        May 2020 06:19:27 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200522051927eusmtip2f7fc78fc9283057109a1d9cdb3fa9efd~RQg0cUKZL3144231442eusmtip2O;
        Fri, 22 May 2020 05:19:27 +0000 (GMT)
Subject: Re: [PATCH] PM: runtime: clk: Fix clk_pm_runtime_get() error path
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e9130ce8-fd22-c871-c089-585585c7133f@samsung.com>
Date:   Fri, 22 May 2020 07:19:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5127441.yGvM1JjtLk@kreacher>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7oPEo7HGUw5zGexccZ6Vovz5zew
        W1zeNYfN4nPvEUaLi6dcLc6cvsRqcXxtuAO7x/sbrewem1Z1snncubaHzWPL1XYWj74tqxg9
        Pm+SC2CL4rJJSc3JLEst0rdL4MqYtWcbW8Fq/oqPl+6wNDAu4Oli5OSQEDCRWLngGVMXIxeH
        kMAKRokt66ZBOV8YJc4tOsIG4XxmlLjzaw9rFyMHWMvvkwYQ8eWMEmtmLGGEcN4zSnz7/YQd
        ZK6wgJfEh95mVhBbRCBIYu3cWWwgNrPAXUaJM/s4QWw2AUOJrrddYHFeATuJR3fbmEBsFgFV
        iT+HZjCC2KICsRKnF29mhKgRlDg58wkLiM0poCWx7ekRVoiZ8hLb385hhrDFJW49mQ/2goTA
        PnaJtrn3mSGudpE42p8K8bOwxKvjW9ghbBmJ05N7WCDqmxklHp5byw7h9DBKXG6CuEJCwFri
        zrlfbCCDmAU0Jdbv0ocIO0rsunGEHWI+n8SNt4IQN/BJTNo2HWotr0RHmxBEtZrErOPr4NYe
        vHCJeQKj0iwkn81C8s0sJN/MQti7gJFlFaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAi
        Ov3v+KcdjF8vJR1iFOBgVOLhfZB8LE6INbGsuDL3EKMEB7OSCO9C/qNxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBa/w8tPTJbp+v17y0ckt0yHVZb
        Voq4TAiWUVTe/K/RsChMTEXPeOad96u/HVN+knLrVr/HG6k9T5skTaX/bFAtOab2Immixsyz
        Fb/vhvS9qiys0q0/cH7PHaEwXkG/GlOdxPUib/cosGXzTbt0MVzPyJZvykM5UcGNTvZKPjGs
        czMdd76SzFFiKc5INNRiLipOBAC1zfHdQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7r3E47HGUxcYGGxccZ6Vovz5zew
        W1zeNYfN4nPvEUaLi6dcLc6cvsRqcXxtuAO7x/sbrewem1Z1snncubaHzWPL1XYWj74tqxg9
        Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MuYtWcbW8Fq/oqPl+6wNDAu4Oli5OCQEDCR+H3SoIuRi0NIYCmjxPoXZ9m7GDmB4jISJ6c1
        sELYwhJ/rnWxQRS9ZZQ4sfkXE0hCWMBL4kNvM1iRiECQxP15f1hAipgF7jJK/Dw/ESwhJFAr
        cfXsQ7CpbAKGEl1vQSZxcvAK2Ek8utsGNohFQFXiz6EZjCC2qECsxOprrYwQNYISJ2c+YQGx
        OQW0JLY9PQI2k1nATGLe5ofMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKK
        USS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMPa2Hfu5eQfjpY3BhxgFOBiVeHgfJB+LE2JNLCuu
        zD3EKMHBrCTCu5D/aJwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTQl5JvKGpobmFpaG5
        sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsaEnM0vvP7rpJpPf9dxI2d3lu9+uY1i
        U3wtsu3WzqqtPDDz+pt9XiGeD6TyD9yfqFbp7vN8Q8OT/R5+QcvzNdukMsqauDoWcB/NTN5z
        8+Av3XuHbpyyyZY/vXn9Iv6gm1qf3q2weriUJ17xoVFL2jKLf/5iIf0zre4utPu02Cyx5mSQ
        cRnf1a9KLMUZiYZazEXFiQCOKI8Y0wIAAA==
X-CMS-MailID: 20200522051927eucas1p107f4aae8f0f47043f067d7d6b58efd19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8
References: <CGME20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8@eucas1p1.samsung.com>
        <5127441.yGvM1JjtLk@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 21.05.2020 19:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> clk_pm_runtime_get() assumes that the PM-runtime usage counter will
> be dropped by pm_runtime_get_sync() on errors, which is not the case,
> so PM-runtime references to devices acquired by the former are leaked
> on errors returned by the latter.
>
> Fix this by modifying clk_pm_runtime_get() to drop the reference if
> pm_runtime_get_sync() returns an error.
>
> Fixes: 9a34b45397e5 clk: Add support for runtime PM
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Frankly, I would rather fix the runtime_get_sync() instead of fixing the 
return path everywhere in the kernel. The current behavior of the 
pm_runtime_get_sync() is completely counter-intuitive then. I bet that 
in the 99% of the places where it is being called assume that no special 
fixup is needed in case of failure. This is one of the most common 
runtime PM related function and it is really a common pattern in the 
drivers to call:

pm_runtime_get_sync()

do something with the hardware

pm_runtime_put()

Do you really want to fix the error paths of the all such calls?


> ---
>   drivers/clk/clk.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/clk/clk.c
> ===================================================================
> --- linux-pm.orig/drivers/clk/clk.c
> +++ linux-pm/drivers/clk/clk.c
> @@ -114,7 +114,11 @@ static int clk_pm_runtime_get(struct clk
>   		return 0;
>   
>   	ret = pm_runtime_get_sync(core->dev);
> -	return ret < 0 ? ret : 0;
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(core->dev);
> +		return ret;
> +	}
> +	return 0;
>   }
>   
>   static void clk_pm_runtime_put(struct clk_core *core)
>
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

