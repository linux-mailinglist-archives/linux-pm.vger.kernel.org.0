Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8F84C8BC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfFTH53 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 03:57:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43621 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTH53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 03:57:29 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190620075724epoutp04e327e89c6fa0f7b6382eb26f60d06289~p2Rhyg7j40850708507epoutp040
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 07:57:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190620075724epoutp04e327e89c6fa0f7b6382eb26f60d06289~p2Rhyg7j40850708507epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561017444;
        bh=dT369zs5ebt7Kyv1+tgYLEciD3HJB/5DKDdaLoYzZkM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nZlQ8/Im0TSiZJHkcbGDNTsK8uzWyerQgm/kqTcrVxO4vKnQnQQSTfXK4A932tPd3
         GW1I/yTue4+m5BwHArFLWGGeDsqHNV4wnv/ZwiaY4YqWAQmhvmK1izphZ1fDdtyKab
         fKI6TEgBmGMMZVxedrbFqJYcYKvIXE3BNfIj7gMs=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190620075722epcas1p116261fe361ce2d2268508b1a454a28f1~p2Rfio4oh0456904569epcas1p1-;
        Thu, 20 Jun 2019 07:57:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.65.04143.16C3B0D5; Thu, 20 Jun 2019 16:57:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190620075721epcas1p1840eedd5b8de12668c011e4eb6afbc57~p2ReLYcRU0241602416epcas1p1-;
        Thu, 20 Jun 2019 07:57:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190620075720epsmtrp258a487f55b4cd0248c53840c1347048a~p2ReKpRB42058820588epsmtrp2D;
        Thu, 20 Jun 2019 07:57:20 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-6f-5d0b3c6106de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.36.03662.06C3B0D5; Thu, 20 Jun 2019 16:57:20 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190620075720epsmtip1eebbc02681cd3d3b53b0b3bd46e23123~p2Rd-UNoh2365723657epsmtip1P;
        Thu, 20 Jun 2019 07:57:20 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: Fix governor module load failure
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7320aa6c-4a49-aae2-4db5-5c1f0d6ce76e@samsung.com>
Date:   Thu, 20 Jun 2019 16:59:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605190053.19177-1-ezequiel@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ12OizFa0E5VqM46AONLGOtVAXUiNpETBBfjAHrBEbArum0
        BsQHwEQWK9EoEguiBlQEEwmgAQ02onELIGpcETfQEENwKSoJuHQYiLx955z/3P+cey9FKE+Q
        Kirb4uDsFtZEk/7Sq7cioiLZuIC0mDuFq3WXejuQrq1xRK5r7nbJdF2FQ3Kd9/BtpOstqCPX
        kvrWvlqkL2upR3pv04JkYocxLotjMzh7GGdJt2ZkWzLj6c3bDOsN2hUxTCSzUhdLh1lYMxdP
        JyYlR27MNvl86bC9rMnpSyWzPE9HJ8TZrU4HF5Zl5R3xNGfLMNlW2qJ41sw7LZlR6VbzKiYm
        ZpnWJ9xlzKr7eoawVc7JcQ8PEPloeFYp8qMAL4eChoeSUuRPKXErgod1XkIMviNovzYoF4Of
        CN6VlxNTLTU9x6VioR1Bf0//pOoLguujnTJBFYw3QW1VvUwohOBCBENDDRMFAhuh6m61XGAS
        q8Ez+IIUeCZeBE9H+1EpoigFToBbN7VCWoqXQPeJzgnn2Xg7jLQ1IYEVeBbcPzkgFdgPx8Gf
        4guEeHwovBo4LRF5IRy4Ujk59VsSHt1QiZwIZb2v5SIHw+e7LZOsAu9wOylyHly8f5sU5gdc
        jKDF0yMTCxrwnDsmEeYkcARcvhYtphdB29gpJPoGwfAPl0yQAFZA8UGlKAmHJ+/6JCLPhZqi
        EvIIot3TtnFP28A9bQP3f7MzSFqP5nA23pzJ8YxNM/21m9DEn1THtqLG7qQOhClEByruqf3T
        lDJ2L59r7kBAEXSI4iMKSFMqMtjcfZzdarA7TRzfgbS+yz5KqGanW30/3OIwMNplGo1Gt5xZ
        oWUYOlRhCHiZqsSZrIMzcpyNs0/1SSg/VT7SZ5vLE2Unox+keoITPpie9Hs/Be3evD9h2/xf
        nhnPBpOSI77sdK4K/J3z8406r2lLkbUm8Ffe1gpXa/imlvFq8/OCUGODO+RVV++G1HX551/+
        zdcvTVkztge5xmv3V+K16TcPHcUpx065WFdu++LuvrH3VovybEX142/zTv+OjWwuoaV8Fsuo
        CTvP/gPudj9/qQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJTjfBhjvW4Ngcc4s1tw8xWuzc8IXd
        YvO5HlaLs01v2C0+9x5htLjduILNgc1jx90ljB59W1YxenzeJBfAHMVlk5Kak1mWWqRvl8CV
        seLDAuaC2WIVs949YW5gfCfYxcjJISFgIrH4whSWLkYuDiGB3YwSd5s/MEEkJCWmXTzK3MXI
        AWQLSxw+XAxR85ZR4snvHhaQGmEBd4klc1axgiREBFoYJR6fmskGkmAWyJZ4vnUtE0RHP6PE
        w2c72UESbAJaEvtf3AAr4hdQlLj64zEjyAZeATuJwwdNQcIsAqoS56adYQaxRQUiJGbvagBb
        xisgKHFy5hMwm1PARuJfx3JmiF3qEn/mXYKyxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFp
        mYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCI0dLawXjiRPwhRgEORiUe
        3hNaXLFCrIllxZW5hxglOJiVRHifMnLHCvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQ
        nliSmp2aWpBaBJNl4uCUamCMeH9f8p/ne53FTnvTznyfXRcUzHva0GppRuSBlEmn2yI0w/61
        xit2HVXjM2cR2rz+g6Idq+Eh296ny/7sevgjXK137+PDOme2/eaYfaWSkamm1NVg8uFn+y64
        MX756F97x6LVOq666iHHoRdrzry2v1jqYVd5SH1xt4XLFrecql7bOctvLpBWYinOSDTUYi4q
        TgQAAl5PG5QCAAA=
X-CMS-MailID: 20190620075721epcas1p1840eedd5b8de12668c011e4eb6afbc57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605190147epcas1p3e74fba524dfcfc87f7ce3c9569ffaa3f
References: <CGME20190605190147epcas1p3e74fba524dfcfc87f7ce3c9569ffaa3f@epcas1p3.samsung.com>
        <20190605190053.19177-1-ezequiel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 6. 6. 오전 4:00, Ezequiel Garcia wrote:
> A bit unexpectedly (but still documented), request_module may
> return a positive value, in case of a modprobe error.
> This is currently causing issues in the devfreq framework.
> 
> When a request_module exits with a positive value, we currently
> return that via ERR_PTR. However, because the value is positive,
> it's not a ERR_VALUE proper, and is therefore treated as a
> valid struct devfreq_governor pointer, leading to a kernel oops.
> 
> The right way to fix this is hinted in __request_module documentation:
> 
> """
> [snip] The function returns
> zero on success or a negative errno code or positive exit code from
> "modprobe" on failure. Note that a successful module load does not mean
> the module did not then unload and exit on an error of its own. Callers
> must check that the service they requested is now available not blindly
> invoke it.
> """
> 
> Therefore, drop the return value check, which is not useful, and instead
> just re-try to find the (hopefully now loaded) governor.
> 
> Fixes: 23c7b54ca1cd1 ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6b6991f0e873..8868ad9472d2 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -236,7 +236,6 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  static struct devfreq_governor *try_then_request_governor(const char *name)
>  {
>  	struct devfreq_governor *governor;
> -	int err = 0;
>  
>  	if (IS_ERR_OR_NULL(name)) {
>  		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
> @@ -251,13 +250,10 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>  
>  		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>  			     DEVFREQ_NAME_LEN))
> -			err = request_module("governor_%s", "simpleondemand");
> +			request_module("governor_%s", "simpleondemand");

I don't agree to remove the exception handling. Even if request_module()
returns positive value, it have to be handled the negative code for error case.

>  		else
> -			err = request_module("governor_%s", name);
> -		/* Restore previous state before return */
> +			request_module("governor_%s", name);

ditto.

>  		mutex_lock(&devfreq_list_lock);
> -		if (err)> -			return ERR_PTR(err);

You better to modify it as following:

if (err < 0)
	return ERR_PTR(err);
else if (err > 0)
	return ERR_PTR(-EINVAL);


>  
>  		governor = find_devfreq_governor(name);
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
