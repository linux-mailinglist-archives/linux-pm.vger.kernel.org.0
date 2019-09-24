Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645EABBFCC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392671AbfIXBso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 21:48:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:55826 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfIXBso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 21:48:44 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190924014840epoutp0396e795f50c463813e9c43504b33f782f~HPK_fFycO2847128471epoutp03P
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 01:48:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190924014840epoutp0396e795f50c463813e9c43504b33f782f~HPK_fFycO2847128471epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569289720;
        bh=pJpHgTiVkNpubEJdZxNYCQu8eOFl0FLblp7ke2xtmf0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o2AJKqm8449qKKw+a7es/bzWGOrQSBi4x6rgpf/lit2uasPJ/KHW/FY6xyV+Zxalu
         p2i141blPw1DHZySR38rQF458nyC5nxNBR2OotRnrcaqkaXog7wEiLrfPyv+cbWCT1
         ktOEQ5A529McFnpOrN/FG9gRQ8o/lnYSe/0417EY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190924014839epcas1p36af68c6e22c22a0b1657c067d86065c6~HPK_DIj-F0605906059epcas1p3D;
        Tue, 24 Sep 2019 01:48:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46ckcL6CTSzMqYlr; Tue, 24 Sep
        2019 01:48:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.C0.04068.DE5798D5; Tue, 24 Sep 2019 10:48:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190924014828epcas1p2051e6043f723fb31f124e33d96f1d9d2~HPKz9b8h52249722497epcas1p2v;
        Tue, 24 Sep 2019 01:48:28 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924014828epsmtrp1e1d592f9fba9c92ba0622f993aa8975d~HPKz4HvTn0112501125epsmtrp1w;
        Tue, 24 Sep 2019 01:48:28 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-9c-5d8975ed6da2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.9D.03889.CE5798D5; Tue, 24 Sep 2019 10:48:28 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924014828epsmtip2b25f355d8bcd37a7bfa96664b0f50f2e~HPKzr6mpL1407214072epsmtip2L;
        Tue, 24 Sep 2019 01:48:28 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Check NULL governor in
 available_governors_show
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d6ea004f-4fbb-9a16-407e-ad8542abe1dc@samsung.com>
Date:   Tue, 24 Sep 2019 10:52:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <96f459015e6418cee4fa20fdbdb80c4caf417c19.1569256298.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0hTYRjm29nOzqzVcVm9WZme0Egwd5yrY2UESQwyEupHN1sHd5zibu1s
        mfXDdWG57GLY1RCDFGwZ2ryw7DKapkmUShfFEqsJXTTDS1HUj7YdI/89z/c+D8/3fBcCU7Ti
        0US+ycZZTayBwiPELW0rk5PG7K5sZV1LDOPvaJYy3d0NUubZsVEpM+BYwtQOjksYT+C1hJk8
        046YyYYAYt4crcU3yjTXHL1ijcftwjWN1cWaO2NekebR2H2R5myTG2kmPTFZ0t0F6/M4VsdZ
        YzlTjlmXb9KnU1u2azdp1auVdBKdxqyhYk2skUunMjKzkjbnG4Ibo2IPsgZ7cCmL5XkqecN6
        q9lu42LzzLwtneIsOoMlzbKKZ4283aRflWM2rqWVyhR1ULi/IK9h5DFmqZEfet/WiTlQX8Qp
        JCOATIWnz5+hUyiCUJBeBC/7AyKBTCCoap7CBfIDQc3b29J/lkv1/dOWBwg6S+vEAvmGwHn8
        MRZSzSN3QF9Hb3gQRd5CcOHJlDREMHIAQWX5lCikwslE8H3qx0N4LhkHr34GUAjLyQ0w+GFc
        HMJiMh7aR31hzXxyJ0y8a5MImkjoujoc1sjIfTDUfCWcjJELYWC4SiTgZXC8+RoWCgayVApD
        3T9woUQGBBorMQHPgy+dTdPlouHzOec0PgI3u9pxwVyCoMnXIxEGKvDVlAcTiGDCSqhvTRaW
        4+Du70okBM+Bse+nJSEJkHIocSoEyXJ48W5QJOBFcOOkCy9DVMWMOhUzKlTMqFDxP+w6ErvR
        As7CG/UcT1vUMy/cg8LvNjHNizqeZ/oRSSBqttziLclWSNiDfJHRj4DAqCi5J9GZrZDr2KLD
        nNWstdoNHO9H6uBpn8ei5+eYg7/AZNPS6hSVSsWk0qvVNE0tlGv0jmwFqWdtXAHHWTjrP5+I
        kEU70AOXJPXyggRXhnnJ/bpCedHhb72dS/foTnTtr084pI0f7COqicK9sxZ37yrcqrLdKXsU
        +SuztilX9TW398BSmS9HeXHv2aGJuFvx7uKyk+OO0p4Uz+XGmFa3M7L4472SdS8fuj06k18/
        mvTne4b2aUz5itxtOusRb1Talte+kfKeMkrM57F0Imbl2b93WiIrzQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSvO6b0s5Yg95rGhaHjm1ltzh/fgO7
        xdmmN+wWtxpkLFbc/chqsenxNVaLz71HGC0+b3jMaHG7cQWbA6fH7IaLLB6bVnWyeWxeUu+x
        8d0OJo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGhtdHmQuW8lY8PHycuYHxOlcX
        IyeHhICJxLT1Nxi7GLk4hAR2M0qcOPmCGSIhKTHt4lEgmwPIFpY4fLgYouYto8SkjtuMIDXC
        AiES149dZAGxRQRWM0q86fUHKWIWuMUo8WzXYbBBQgIbGSUuLXUCsdkEtCT2v7jBBmLzCyhK
        XP3xGGwQr4CdxN1HH8EGsQioShx5sx+sRlQgQuLwjllQNYISJ2c+AavhFIiTuL91Bth8ZgF1
        iT/zLkHZ4hK3nsxngrDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgVFe
        arlecWJucWleul5yfu4mRnDMaWntYDxxIv4QowAHoxIPr8S2jlgh1sSy4srcQ4wSHMxKIryb
        tNpihXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTDy2vE+
        LcvoMmTbYae/8d0xRrZi4UMTuC6yWXgJdoRumG3N1pOxZvb0xs0T2t+qFKzJig7vcvENf1Lb
        Mjmhw676ZNEuvu8fD/Ev4l3Zv+OHx24JoWnmPUt+XbTYV23E/ejTHqvFN27kJj6+eNXoD88R
        NcGwd71nr+mfKHfa/nuXIqt7oXGbvZYSS3FGoqEWc1FxIgAqLJSKtQIAAA==
X-CMS-MailID: 20190924014828epcas1p2051e6043f723fb31f124e33d96f1d9d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923163453epcas4p1f9cff7d9f1a33fabcf4c980560d6c27d
References: <CGME20190923163453epcas4p1f9cff7d9f1a33fabcf4c980560d6c27d@epcas4p1.samsung.com>
        <96f459015e6418cee4fa20fdbdb80c4caf417c19.1569256298.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 1:34, Leonard Crestez wrote:
> The governor is initialized after sysfs attributes become visible so in
> theory the governor field can be NULL here.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Found this by hacking device core to call attribute "show" functions
> from inside device_add.
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 00fc23fea5b2..896fb2312f2f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1322,11 +1322,11 @@ static ssize_t available_governors_show(struct device *d,
>  
>  	/*
>  	 * The devfreq with immutable governor (e.g., passive) shows
>  	 * only own governor.
>  	 */
> -	if (df->governor->immutable) {
> +	if (df->governor && df->governor->immutable) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>  				  "%s ", df->governor_name);
>  	/*
>  	 * The devfreq device shows the registered governor except for
>  	 * immutable governors such as passive governor .
> 

As you mentioned, it create sysfs and then initialize the governor instance
as following:

	device_register()
		device_add()
			device_add_attrs()
				creating sysfs entries.
	governor = try_then_request_governor(...)


Thanks for fix-up.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


Additionally, you have to add the following 'fixes' tag
and then send it to stable mailing list(stable@vger.kernel.org).
- Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
