Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC24C8DB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFTICl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 04:02:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26647 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTICl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 04:02:41 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190620080238epoutp039c3fdedd6678a2f47d18a8b949ea3156~p2WFxh1nk2812928129epoutp03k
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 08:02:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190620080238epoutp039c3fdedd6678a2f47d18a8b949ea3156~p2WFxh1nk2812928129epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561017758;
        bh=YQKuTUaEFRAVJHBYizQgsuW7zqmT2n0ePf+cSQpJyfU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X3/jEmCZHvceg2l1saoz9lqBe0S4R5B64F2TDVNjMfsfDX4PQKMm6BO83XLiC+xs+
         YTZp0o8yjPqaWx3Bluffq7uOL6i1yRvWMHwG6rcW/dnaI/Sxzf7ud+gdnVHfEtPVUV
         5m982ZJH3hdfN73KWEZ/25cNKBpPOd9Tk3SqJdhY=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190620080233epcas1p3ff0d775b756ed0c868f796626fd5cab5~p2WBqOTKe2521625216epcas1p3F;
        Thu, 20 Jun 2019 08:02:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.85.04257.19D3B0D5; Thu, 20 Jun 2019 17:02:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190620080225epcas1p4b4e6908574db787acc37e35e8fa3398a~p2V5m2bSF1603116031epcas1p4g;
        Thu, 20 Jun 2019 08:02:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190620080225epsmtrp2af7230bbc5ccdf514d0986524132819d~p2V5jTPe52337623376epsmtrp2q;
        Thu, 20 Jun 2019 08:02:25 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-2f-5d0b3d91d29d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.86.03662.19D3B0D5; Thu, 20 Jun 2019 17:02:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190620080225epsmtip29bfcec7c36f6ded341af8f4d001c630a~p2V5UFP_e1185611856epsmtip2L;
        Thu, 20 Jun 2019 08:02:25 +0000 (GMT)
Subject: Re: [PATCH 1/2] PM / devfreq: Fix governor module load failure
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Organization: Samsung Electronics
Message-ID: <52870c3e-cbf1-d627-8e93-8e1fb8c31d48@samsung.com>
Date:   Thu, 20 Jun 2019 17:04:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7320aa6c-4a49-aae2-4db5-5c1f0d6ce76e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmge5EW+5Yg75uTYs1tw8xWuzc8IXd
        YvO5HlaLs01v2C0+9x5htLjduILNgc1jx90ljB59W1YxenzeJBfAHJVtk5GamJJapJCal5yf
        kpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0V0mhLDGnFCgUkFhcrKRvZ1OU
        X1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnbHv4QWmggfiFdNa+9gb
        GLuEuxg5OSQETCRe3Z7ABGILCexglLj/CijOBWR/YpT4e3Y7K4TzjVGi5Uc7O0zH8ev7oRJ7
        GSXWbNrLBuG8Z5Q4//M7M0iVsIC7xJI5q1hBbDYBLYn9L26AFYkINDFKvHmzGizBLJAtMef4
        PLCx/AKKEld/PGYEsXkF7CTW/n0INohFQFWi+9p7MFtUIELiy85NUDWCEidnPmEBsTkF7CXu
        dy5lhJgpLnHryXwmCFteonnrbGaQxRIC19kkGta/ZIP4wUVic9tNZghbWOLV8S1Qv0lJfH63
        F6qmWmLlySNsEM0djBJb9l9ghUgYS+xfOhloAwfQBk2J9bv0IcKKEjt/z4U6gk/i3dceVpAS
        CQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYb
        FpggR/cmRnCi1LLYwbjnnM8hRgEORiUe3hNaXLFCrIllxZW5hxglOJiVRHifMnLHCvGmJFZW
        pRblxxeV5qQWH2I0BYb2RGYp0eR8YBLPK4k3NDUyNja2MDE0MzU0VBLnjee+GSMkkJ5Ykpqd
        mlqQWgTTx8TBKdXAuN7ZqWL6vgrW+a/STrm+Uvwn3eYnkMqs0/5av99jnsvaS8GPc5lL7E4d
        13z2w7JwedK9t/n/2gKClnuE7vfP1mOWDLkYe/tgky+j6EcPo8uH5lzgFsza/SxqV+mNfy47
        l3/e7X6N+7de/9b3uRyrPjYeMY0+9XStnmneLmZfzvqw3qDpARtslFiKMxINtZiLihMBpOSH
        GaoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXneiLXesQfN5Los1tw8xWuzc8IXd
        YvO5HlaLs01v2C0+9x5htLjduILNgc1jx90ljB59W1YxenzeJBfAHMVlk5Kak1mWWqRvl8CV
        se/hBaaCB+IV01r72BsYu4S7GDk5JARMJI5f38/axcjFISSwm1Fi8dNvzBAJSYlpF48C2RxA
        trDE4cPFEDVvGSXWnXsPViMs4C6xZM4qVhCbTUBLYv+LG2wgRSICLYwSj0/NZANJMAtkSzzf
        upYJovsIo8SLCU0sIAl+AUWJqz8eM4LYvAJ2Emv/PgSbyiKgKtF9DWKDqECExOxdDSwQNYIS
        J2c+AbM5Bewl7ncuZYRYoC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUha
        FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4ZLa0djCdOxB9iFOBgVOLhPaHF
        FSvEmlhWXJl7iFGCg1lJhPcpI3esEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp
        2ampBalFMFkmDk6pBsbk35tjHgQucMrh/DdtR9siDlG2zKk7bWeurgnQV1Z5v9Zy+bW8rYcL
        P/xOvu5c06TlcmCHCHPynY1mh71NfGQ4GtTSAiL4RbIyl9Ty+Cfa/dltlvm9ZKWtIbPWUZfg
        bV8lswwW71XKXsD76cxqyYq6m8JXk3cwJs2Sat7BW68294Xn5eo/zkosxRmJhlrMRcWJAJSa
        PIaVAgAA
X-CMS-MailID: 20190620080225epcas1p4b4e6908574db787acc37e35e8fa3398a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605190147epcas1p3e74fba524dfcfc87f7ce3c9569ffaa3f
References: <CGME20190605190147epcas1p3e74fba524dfcfc87f7ce3c9569ffaa3f@epcas1p3.samsung.com>
        <20190605190053.19177-1-ezequiel@collabora.com>
        <7320aa6c-4a49-aae2-4db5-5c1f0d6ce76e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 6. 20. 오후 4:59, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 6. 6. 오전 4:00, Ezequiel Garcia wrote:
>> A bit unexpectedly (but still documented), request_module may
>> return a positive value, in case of a modprobe error.
>> This is currently causing issues in the devfreq framework.
>>
>> When a request_module exits with a positive value, we currently
>> return that via ERR_PTR. However, because the value is positive,
>> it's not a ERR_VALUE proper, and is therefore treated as a
>> valid struct devfreq_governor pointer, leading to a kernel oops.
>>
>> The right way to fix this is hinted in __request_module documentation:
>>
>> """
>> [snip] The function returns
>> zero on success or a negative errno code or positive exit code from
>> "modprobe" on failure. Note that a successful module load does not mean
>> the module did not then unload and exit on an error of its own. Callers
>> must check that the service they requested is now available not blindly
>> invoke it.
>> """
>>
>> Therefore, drop the return value check, which is not useful, and instead
>> just re-try to find the (hopefully now loaded) governor.
>>
>> Fixes: 23c7b54ca1cd1 ("PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.")
>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>> ---
>>  drivers/devfreq/devfreq.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 6b6991f0e873..8868ad9472d2 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -236,7 +236,6 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>  static struct devfreq_governor *try_then_request_governor(const char *name)
>>  {
>>  	struct devfreq_governor *governor;
>> -	int err = 0;
>>  
>>  	if (IS_ERR_OR_NULL(name)) {
>>  		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
>> @@ -251,13 +250,10 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>  
>>  		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>  			     DEVFREQ_NAME_LEN))
>> -			err = request_module("governor_%s", "simpleondemand");
>> +			request_module("governor_%s", "simpleondemand");
> 
> I don't agree to remove the exception handling. Even if request_module()
> returns positive value, 

Sorry, I wrote the wrong comment. It have to handle the positive return value
for exception handling.

> 
>>  		else
>> -			err = request_module("governor_%s", name);
>> -		/* Restore previous state before return */
>> +			request_module("governor_%s", name);
> 
> ditto.
> 
>>  		mutex_lock(&devfreq_list_lock);
>> -		if (err)> -			return ERR_PTR(err);
> 
> You better to modify it as following:
> 
> if (err < 0)
> 	return ERR_PTR(err);
> else if (err > 0)
> 	return ERR_PTR(-EINVAL);
> 
> 
>>  
>>  		governor = find_devfreq_governor(name);
>>  	}
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
