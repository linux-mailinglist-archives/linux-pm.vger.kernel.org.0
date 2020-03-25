Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB41933D4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 23:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYWmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 18:42:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28264 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 18:42:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200325224213epoutp032d9aace057067773338e0721d51d2d4a~-rUt5z9Xq1515715157epoutp03E
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 22:42:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200325224213epoutp032d9aace057067773338e0721d51d2d4a~-rUt5z9Xq1515715157epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585176133;
        bh=826Bfg/I9oVM/LLiAioXIxGh58oxwAWjlXnI6vlCRKk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WMsOYe07NI2GVq4DREAdTzmohO071bnujNedKEIzNAVAIJGWhz7HOyPzE92jjS69E
         XGQrEO7NHz6v4yeLknJrtvKk6URMThgLo4nA/GovGvhWc1UrlynNdwVAwSD0gvRGPm
         UBZGiaPiTt/fIHa23RqQyo2kqsMjS1Ogv+Dk0uEk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200325224212epcas1p2e68be290d5da4ed5cfdff6cae9aaacfb~-rUs3fMoC1440314403epcas1p2q;
        Wed, 25 Mar 2020 22:42:12 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48njmL1tr7zMqYkW; Wed, 25 Mar
        2020 22:42:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.80.04160.24EDB7E5; Thu, 26 Mar 2020 07:42:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200325224209epcas1p16ff6a94f314a213b047869124266eb2f~-rUpwn8XJ2300323003epcas1p1X;
        Wed, 25 Mar 2020 22:42:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200325224209epsmtrp2ea43298ed97f652509e14c49a220b881~-rUpwBgcl2798027980epsmtrp2z;
        Wed, 25 Mar 2020 22:42:09 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-8d-5e7bde423b86
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.33.04024.04EDB7E5; Thu, 26 Mar 2020 07:42:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200325224208epsmtip242c3c6eaf2ad594338661efa2b5df786~-rUpkd-ff0598605986epsmtip2m;
        Wed, 25 Mar 2020 22:42:08 +0000 (GMT)
Subject: Re: [RFC] PM / devfreq: add busfreq governor
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b6cf3afd-47ef-5c1b-034d-b87c49135d38@samsung.com>
Date:   Thu, 26 Mar 2020 07:51:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB694176CC6B96EF2E612C552FEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmnq7Tveo4g9WreCzONr1ht1hx9yOr
        RdevlcwWn3uPMFpcerCC3eJ24wo2BzaPje92MHk82nGL0aNvyypGj8+b5AJYorJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM66/vcNY8Fqg
        4tm/vUwNjMd4uxg5OSQETCRe7n/B2MXIxSEksINRomPDJijnE6PE7eVbWEGqhAS+MUocW1AN
        07H6+DOoor2MEh/OnWCBKHrPKPFksTKILSxgKtG86jAbiC0iECex5vMrMJtZ4CKjxKb1YDab
        gJbE/hc3wGx+AUWJqz8eM4LYvAJ2Ehd/nAJbzCKgKjHr+xF2EFtUIEzi5LYWqBpBiZMzn4Dt
        5RSIldjV/AJqvrjErSfzmSBseYntb+cwgxwqIfCYTWLfvHXMEB+4SNzecpoJwhaWeHV8CzuE
        LSXx+d1eNgi7WmLlySNsEM0djBJb9l9ghUgYS+xfOhmomQNog6bE+l36EGFFiZ2/5zJCLOaT
        ePe1hxWkREKAV6KjTQiiRFni8oO7UGslJRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxiFEst
        KM5NTy02LDBBjuxNjOB0qWWxg3HPOZ9DjAIcjEo8vBssq+OEWBPLiitzDzFKcDArifBuTq2I
        E+JNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wFSeVxJvaGpkbGxsYWJoZmpoqCTOO/V6TpyQ
        QHpiSWp2ampBahFMHxMHp1QD4/p2v9cHgp7de7hk98TgWcFZ67Zrcq/9L+l74mv8yZo2raAr
        E+ZOzF4htbB9maDQuv/zzn63/pneba1/cdPtK1F3DHueLG9ZJXd0kvsqy0r1T1oZxkcenNWR
        /q5w+0ahjHlOlkHmqgjOGY0r/u3a/e6u97WJb7S6JKc+YAn3M7nR2njliOyKIjYlluKMREMt
        5qLiRADdGgYjrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXtfhXnWcwabr1hZnm96wW6y4+5HV
        ouvXSmaLz71HGC0uPVjBbnG7cQWbA5vHxnc7mDwe7bjF6NG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZ19/eYSx4LVDx7N9epgbGY7xdjJwcEgImEquPP2MEsYUEdjNK3Oy3gYhLSky7eJS5
        i5EDyBaWOHy4uIuRC6jkLaPEvP0v2EBqhAVMJZpXHQazRQTiJJZ0dzCD2MwCFxklvsx3g2h4
        wihxess8FpAEm4CWxP4XN8Aa+AUUJa7+eAy2mFfATuLij1OsIDaLgKrErO9H2EFsUYEwiZ1L
        HjNB1AhKnJz5BGwOp0CsxK5miCOYBdQl/sy7BLVYXOLWk/lMELa8xPa3c5gnMArPQtI+C0nL
        LCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERw5Wpo7GC8viT/EKMDB
        qMTDu8GyOk6INbGsuDL3EKMEB7OSCO/m1Io4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845F
        CgmkJ5akZqemFqQWwWSZODilGhh7ZSVKvp5XPH19zpue8y8FJwUwnKhl3tN9vzWQ96ya917L
        aCeBm5fzH5+a9/tI181D4qfjZ6k1sKh7eO0y2aNp+tmlesuaf1Wv5d2NNqtNCl07XTmkwWPb
        srsrWBnivmsHlE06mqWTI7DCWf4i56VXQllyjgZnT8/YJf1cT+LK268a0yQ2yKopsRRnJBpq
        MRcVJwIA27CtbJgCAAA=
X-CMS-MailID: 20200325224209epcas1p16ff6a94f314a213b047869124266eb2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200325223540epcas1p33b76ed4a630a5135ac784b2a8f57bb31
References: <20200325152224.6613-1-martin.kepplinger@puri.sm>
        <CGME20200325223540epcas1p33b76ed4a630a5135ac784b2a8f57bb31@epcas1p3.samsung.com>
        <VI1PR04MB694176CC6B96EF2E612C552FEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 3/26/20 7:35 AM, Leonard Crestez wrote:
> On 2020-03-25 5:23 PM, Martin Kepplinger wrote:
>> A devfreq governor to be used by drivers to request ("get") a frequency
>> setting they need. Currently only "HIGH" (performance) is available.
>>
>> ATTENTION: This is a first draft to serve merely as a basis for discussions!
>> ONLY USE FOR TESTING!
>> ---
>>
>> I wanted to get early feedback on an idea that AFAIK is not yet available
>> in the kernel (but something similar via "busfreq" in NXP's tree):
> 
> Kernel already provides soc-agnostic mechanism via pm_qos and 
> interconnect frameworks. The interconnect framework is more powerful 
> because devices express requests in kbps and provides can make better 
> decisions based on that.
> 
>> Let drivers request high (dram) frequencies at runtime if they know they need
>> them. In our case the display stack on imx8mq would be the first user,
>> looking like so: #include <linux/devfreq.h> and:
>>
>> 	--- a/drivers/gpu/drm/bridge/nwl-dsi.c
>> 	+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
>> 	@@ -1116,6 +1117,9 @@ static int imx8mq_dsi_poweron(struct nwl_dsi *dsi)
>> 			ret = reset_control_deassert(dsi->rstc);
>> 	
>> 	+       devfreq_busfreq_request(DEVFREQ_BUSFREQ_HIGH);
>> 	+
>> 		return ret;
>> 	@@ -1125,6 +1129,10 @@ static int imx8mq_dsi_poweroff(struct nwl_dsi *dsi)
>> 		if (dsi->rstc)
>> 			ret = reset_control_assert(dsi->rstc);
>> 	+
>> 	+       devfreq_busfreq_release(DEVFREQ_BUSFREQ_HIGH);
>> 	+
>> 		return ret;
>>
>>
>> Could be called in pm_runtime() calls too.
>>
>> _If_ the idea of such or a similar governor is viable, there are at least
>> some problems with this implemenation still:
> There's an older RFC which I have to resend which adds support an 
> interconnect provider for imx which then makes PM_QOS_MIN_FREQ requests 
> to devfreq. It has several advantages:
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=203215

I'm expecting your patches as your patches are good use-case of PM_QoS
on devfreq. Thanks.

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
