Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69219A262
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgCaXUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:20:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47124 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbgCaXUe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:20:34 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200331232032epoutp02b69282807622f652f61b3d6cf712a622~Bht4duhCT0450504505epoutp022
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:20:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200331232032epoutp02b69282807622f652f61b3d6cf712a622~Bht4duhCT0450504505epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585696832;
        bh=Ykc51i8hr0AncU8IY+n1mU9alBghALWWelj6pYw7wT8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GbksPALQYDbyuDVhQCba/AjdCK+F2JEAMKWVpG8p3Tt1tD6Toq1s8QxqbjNI5gSn5
         0RgsOJ5ya1KDaOcBbb+1WvTrquOZU7yhskk088pyJBR17DpDG0MKbytJLXR8GonkME
         S0/G/RbAQ20Dnf70Psq5dikp4IbRjHtB/oAYTeq0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331232031epcas1p198ac5d860533e73152c178ceb5a8b4d6~Bht3uqVc91864018640epcas1p10;
        Tue, 31 Mar 2020 23:20:31 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48sQKn0WwbzMqYm1; Tue, 31 Mar
        2020 23:20:29 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.1F.04140.A30D38E5; Wed,  1 Apr 2020 08:20:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200331232025epcas1p242a0b7a24c7a68d679ae6b42a40e3985~BhtyRVhZH3036430364epcas1p2I;
        Tue, 31 Mar 2020 23:20:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331232025epsmtrp1b84b8180cf280a74e93bbd400b0d6324~BhtyQa0M02638126381epsmtrp1I;
        Tue, 31 Mar 2020 23:20:25 +0000 (GMT)
X-AuditID: b6c32a36-fbbff7000000102c-57-5e83d03a5b87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.75.04024.930D38E5; Wed,  1 Apr 2020 08:20:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331232025epsmtip29ebcd9c061df67d3a392e4649743f696~BhtyAla7I2561625616epsmtip24;
        Tue, 31 Mar 2020 23:20:25 +0000 (GMT)
Subject: Re: [PATCH v1 5/5] PM / devfreq: tegra30: Make CPUFreq notifier to
 take into account boosting
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <afcc9f80-c102-da42-8f7f-9b66417a9d4d@samsung.com>
Date:   Wed, 1 Apr 2020 08:29:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200330231617.17079-6-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmga7VheY4g5erxCxWf3zMaNEyaxGL
        xdmmN+wWH3vusVpc3jWHzeJz7xFGi84vs9gsLp5ytbjduILN4t+1jSwWP3fNY3Hg9nh/o5Xd
        Y+esu+wem1Z1snn0Nr9j8+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDzlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGRNaWlgKHnBU9Lxay9TAOI+9i5GTQ0LAROJy
        wxTWLkYuDiGBHYwSpxc1s0A4nxgl5n1qZIJwvjFKHF64A65l78fbUIm9jBLbJj9nh3DeM0p8
        +LaXDaRKWCBDYumWE2BVIgKLmSReb57LApJgFiiR2D3xCBOIzSagJbH/xQ2wBn4BRYmrPx4z
        gti8AnYSBw9dA4uzCKhIfHr6A6xeVCBM4uS2FqgaQYmTM5+AzeQUMJNon/uHGWK+uMStJ/OZ
        IGx5ie1v5zCDHCEh0M8ucfZOIyPEDy4Ss7e0QP0jLPHq+BYoW0riZX8blF0tsfLkETaI5g5G
        iS37L7BCJIwl9i+dDLSBA2iDpsT6XfoQYUWJnb/nMkIs5pN497WHFaREQoBXoqNNCKJEWeLy
        g7tMELakxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBUbI8b2JEZx4tcx2
        MC4653OIUYCDUYmHV8GqOU6INbGsuDL3EKMEB7OSCC+bf0OcEG9KYmVValF+fFFpTmrxIUZT
        YGhPZJYSTc4HZoW8knhDUyNjY2MLE0MzU0NDJXHeqddz4oQE0hNLUrNTUwtSi2D6mDg4pRoY
        NRIE+5JZZ/bcNakJ/Se00v1bqMbd4DMfqvJfe3k8UFjRpLJ5Vf1ptY5rt/OWhhyoX63rvufN
        5IN7dBu9bq1Y+nvl55gwt72bN2ld/+IbxOZao8n3/YvHv/zJ60tffH+cltSi5vp8ycYDl2dM
        8vRO1fRflZY5O+1yBfO6fI4yN14XzrJv0U9DlViKMxINtZiLihMBn1W5AtIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK7lheY4gxeblS1Wf3zMaNEyaxGL
        xdmmN+wWH3vusVpc3jWHzeJz7xFGi84vs9gsLp5ytbjduILN4t+1jSwWP3fNY3Hg9nh/o5Xd
        Y+esu+wem1Z1snn0Nr9j8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MCS0tLAUPOCp6Xq1l
        amCcx97FyMkhIWAisffjbaYuRi4OIYHdjBIzzmxlhkhISky7eBTI5gCyhSUOHy6GqHnLKLFt
        ag8jSI2wQIbE0i0nwJpFBJYySay4+QVsKrNAicSJZ/9YITq2Mkr8bG8D62AT0JLY/+IGG4jN
        L6AocfXHY7A4r4CdxMFD18DiLAIqEp+e/mACsUUFwiR2LnnMBFEjKHFy5hMWEJtTwEyife4f
        Zohl6hJ/5l2CssUlbj2ZzwRhy0tsfzuHeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnF
        hgWGeanlesWJucWleel6yfm5mxjBEailuYPx8pL4Q4wCHIxKPLwKVs1xQqyJZcWVuYcYJTiY
        lUR42fwb4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg
        9LC/mrlrVVeUq/kT58cLavNYXQ5zntzGY3Nqb/Ce3H260oEMsbtuBbPfq2UynarzMHu7mf+U
        lx0HX/f+4xKNc9SIb/6yOdVL9pPoDONHQUqXZsdbveUQSzJZIZKsGyanlL4+4U+RutxPxady
        9zi49F5seHNNRFXGdvWy9dfLFe2yrHqyqy8qsRRnJBpqMRcVJwIAo1QZCLwCAAA=
X-CMS-MailID: 20200331232025epcas1p242a0b7a24c7a68d679ae6b42a40e3985
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232026epcas1p2234ae241b9693555b4df74aab3d8aee9
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232026epcas1p2234ae241b9693555b4df74aab3d8aee9@epcas1p2.samsung.com>
        <20200330231617.17079-6-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
> MCCPU frequency boosting needs to be taken into account in order to avoid
> scheduling of unnecessary devfreq updates.

"in order to avoid scheduling of unnecessary devfreq updates."
I don't understand the correct meaning of following description.
Could you explain it more detailed?

> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 34f6291e880c..3b57aac9894c 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -420,7 +420,7 @@ tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>  
>  	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>  
> -	if (dev_freq >= static_cpu_emc_freq)
> +	if (dev_freq + actmon_dev->boost_freq >= static_cpu_emc_freq)
>  		return 0;
>  
>  	return static_cpu_emc_freq;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
