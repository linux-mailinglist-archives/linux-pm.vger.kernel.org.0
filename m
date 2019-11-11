Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20797F6E3D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 06:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfKKFqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 00:46:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:28161 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKFqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 00:46:25 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191111054620epoutp02fe6b79b7276070073cbfd87ad7c477c3~WBYM1FwSt2660526605epoutp02R
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 05:46:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191111054620epoutp02fe6b79b7276070073cbfd87ad7c477c3~WBYM1FwSt2660526605epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573451180;
        bh=8SfcOS7yf2L6oLFgtZFXODynh8Gmi92dVmq5MpiVnRs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aQl8BKFbgbd/5bTcR0tAFQILzH8IMmHboD8lrJdMCX2AoAA+aB2m7ZSH/ol+VbWkD
         GVpTi2NyXN5dAn8TT7Wo+60X0Ytg+dJPntwqYr3Cl78dfLJE9APK5rNaRLoB8sjrfc
         GJ4kNiwMmUDLExIhybQDwcCVTY5hM2bre6HD0+bM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191111054620epcas1p3c4a119681c299647982c91143eee0675~WBYMPwsiX3196131961epcas1p3m;
        Mon, 11 Nov 2019 05:46:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47BKcV0YF7zMqYkr; Mon, 11 Nov
        2019 05:46:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.D4.04144.9A5F8CD5; Mon, 11 Nov 2019 14:46:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191111054617epcas1p2f6b3c5247d770ad90f07c7433a7831cd~WBYJNlIRo2148421484epcas1p2E;
        Mon, 11 Nov 2019 05:46:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191111054617epsmtrp112613feea260dad2ac5afba759bf35e7~WBYJMphCQ2326723267epsmtrp1H;
        Mon, 11 Nov 2019 05:46:17 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-43-5dc8f5a951c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.30.25663.8A5F8CD5; Mon, 11 Nov 2019 14:46:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191111054616epsmtip1a95634a5810aff2507f3fac2c7e34c50~WBYI6gtw_2988629886epsmtip10;
        Mon, 11 Nov 2019 05:46:16 +0000 (GMT)
Subject: Re: [PATCH v10 06/11] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos
 structs
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a9d671f8-0720-84de-abc7-563cc35731a4@samsung.com>
Date:   Mon, 11 Nov 2019 14:52:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023B0E36FF4C9180F6B7A6AEE620@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmnu6qrydiDebMYbI4dGwru8XX06cY
        LZZdOspoMX3vJjaL8+c3sFucbXrDbrHi7kdWi02Pr7FadP1ayWzxufcIo8XnDY8ZLW43rmCz
        WH3uIJvFmdOXgLKH/rJZbPzq4SDg8f5GK7vH7IaLLB4LNpV6bFrVyeZx59oeNo/NS+o9Nr7b
        weRx8N0eJo8tV9tZPPq2rGL0+LxJLoA7KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        ZYFecWJucWleul5yfq6VoYGBkSlQYUJ2RvfL6WwFazUrnh7bydbAOFGxi5GTQ0LAROLfz4ds
        XYxcHEICOxglXp54zQqSEBL4xCjx5F0qROIbo8T7M9/ZYTrO3utnh0jsZZT4M+stE4TznlFi
        34G1TCBVwgKhEidPtDGD2CICERJTH65lASliFvjHIjHv6Ro2kASbgJbE/hc3wGx+AUWJqz8e
        M4LYvAJ2Ems2fgAbxCKgKrH/6B6gGg4OUaBBp78mQpQISpyc+YQFxOYUiJW4fnoy2NnMAuIS
        t57MZ4Kw5SWat85mBtkrIXCLXeLB3rVQL7hITJ+/iRnCFpZ4dXwLVFxK4mV/G5RdLbHy5BE2
        iOYORokt+y+wQiSMJfYvncwEchCzgKbE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQii
        RFni8oO7TBC2pMTi9k62CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgWGyLG9iRGc
        1LVMdzBOOedziFGAg1GJh/eHzolYIdbEsuLK3EOMEhzMSiK8OyqAQrwpiZVVqUX58UWlOanF
        hxhNgYE9kVlKNDkfmHHySuINTY2MjY0tTAzNTA0NlcR5HZcvjRUSSE8sSc1OTS1ILYLpY+Lg
        lGpgPPM18XNCyN//3yRXV300env+pU/vm71h+7UzL51kap8nrbP/ddVij+tRXatf9YsLVKh8
        WVq4PsyG6duXNRc+BPiw+ax2iD60yWlK2PVVwcfkDEq3/9TSKL9u+v41p7+jtofRy7tPFlhM
        6HdTtlr1lE9Qzt1g3/ZzL53b/lzv0A/RmnTr9dOW90osxRmJhlrMRcWJALwojkcABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnO6KrydiDda3mVkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM3izOlLQNlDf9ksNn71cBDweH+jld1jdsNFFo8Fm0o9Nq3qZPO4c20Pm8fmJfUeG9/t
        YPI4+G4Pk8eWq+0sHn1bVjF6fN4kF8AdxWWTkpqTWZZapG+XwJXR/XI6W8FazYqnx3ayNTBO
        VOxi5OSQEDCROHuvn72LkYtDSGA3o8S1L//YIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyjxettl
        NpAaYYFQiZMn2phBbBGBCIlTncdYQYqYBRpYJe4eXw019RWTxMamL0wgVWwCWhL7X9wA6+YX
        UJS4+uMxI4jNK2AnsWbjB7AaFgFVif1H94DViAJNfb79BlSNoMTJmU9YQGxOgViJ66cns4LY
        zALqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9Nxi
        wwKjvNRyveLE3OLSvHS95PzcTYzgCNfS2sF44kT8IUYBDkYlHt4fOidihVgTy4orcw8xSnAw
        K4nw7qgACvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCUamCU
        K14089eHKe/vPJhi9fnZxIXLXG+p1z+eLOMq98F0xQzmDc4szrPL9nPxC5gkGi+J/vaCQ3Rt
        9+YqFT4TZ5WFiWdnrzN4V3IsTlD6acLeT4e+CRvydzSJ3jzy9ffMj2V2rYfXTMyYv2Uu8/db
        rhFZvjGtB5bNlora5XBxTmae++7aLvmWwLWiSizFGYmGWsxFxYkABfDlf+wCAAA=
X-CMS-MailID: 20191111054617epcas1p2f6b3c5247d770ad90f07c7433a7831cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191031213442epcas1p41dc9214e98c05c634647ef06cdd0a7f3
References: <cover.1572556786.git.leonard.crestez@nxp.com>
        <CGME20191031213442epcas1p41dc9214e98c05c634647ef06cdd0a7f3@epcas1p4.samsung.com>
        <254e9ed653c7d9d866a860673629d02351c1afd8.1572556786.git.leonard.crestez@nxp.com>
        <072ef916-1753-ddc9-0fe8-7704b85def7a@samsung.com>
        <VI1PR04MB7023B0E36FF4C9180F6B7A6AEE620@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 11/1/19 11:45 PM, Leonard Crestez wrote:
> On 01.11.2019 04:07, Chanwoo Choi wrote:
>> Hi Leonard,
>>
>> Why do you add the new patches on v10 (patch6/7/8)
>> in this series? If you think that need to update
>> the pm_qos core, you have to send the new patchset
>> on separate mail thread. It make the difficult
>> to merge the PM_QoS support of devfreq.
>>
>> Please split out the patch6/7/8 from this series.
> 
> Unfortunately DEV_PM_QOS_MIN/MAX_FREQUENCY was removed when cpufreq 
> switched away:
> 
>      https://patchwork.kernel.org/cover/11193021/
> 
> Support for freq limits in PM QoS needs to be restored, otherwise PM QoS 
> for devfreq doesn't even compile. I posted the restoration separately:
> 
>      https://patchwork.kernel.org/cover/11212887/
> 
> I guess we can wait for Rafael to review that?

I'm sorry for late reply.
Thanks for the explanation.

> 
> We could also consider other alternatives such as using "raw" PM QoS 
> aggregation inside devfreq and asking all consumers to call 
> devfreq-specific APIs for frequency constraints?

Actually, I don't want to make the separate devfreq-specific something
for PM QoS feature. If possible, I think that we need to reduce the redundant
or duplicate code in the linux kernel. Even if spend the long time
for updating or fixing the issue of PM QoS, we need to do them. Thanks.


> 
> In the meantime I can post the devfreq cleanups in separately. would 
> that help?

Yes, you better to send the devfreq cleanup patches separately.

> 
>> On 19. 11. 1. 오전 6:34, Leonard Crestez wrote:
>>> This allows dev_pm_qos to embed freq_qos structs, which is done in the
>>> next patch. Separate commit to make it easier to review.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   include/linux/pm_qos.h | 74 ++++++++++++++++++++++--------------------
>>>   1 file changed, 38 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>>> index c35ff21e8a40..a8e1486e3200 100644
>>> --- a/include/linux/pm_qos.h
>>> +++ b/include/linux/pm_qos.h
>>> @@ -47,25 +47,10 @@ struct pm_qos_request {
>>>   struct pm_qos_flags_request {
>>>   	struct list_head node;
>>>   	s32 flags;	/* Do not change to 64 bit */
>>>   };
>>>   
>>> -enum dev_pm_qos_req_type {
>>> -	DEV_PM_QOS_RESUME_LATENCY = 1,
>>> -	DEV_PM_QOS_LATENCY_TOLERANCE,
>>> -	DEV_PM_QOS_FLAGS,
>>> -};
>>> -
>>> -struct dev_pm_qos_request {
>>> -	enum dev_pm_qos_req_type type;
>>> -	union {
>>> -		struct plist_node pnode;
>>> -		struct pm_qos_flags_request flr;
>>> -	} data;
>>> -	struct device *dev;
>>> -};
>>> -
>>>   enum pm_qos_type {
>>>   	PM_QOS_UNITIALIZED,
>>>   	PM_QOS_MAX,		/* return the largest value */
>>>   	PM_QOS_MIN,		/* return the smallest value */
>>>   	PM_QOS_SUM		/* return the sum */
>>> @@ -88,10 +73,48 @@ struct pm_qos_constraints {
>>>   struct pm_qos_flags {
>>>   	struct list_head list;
>>>   	s32 effective_flags;	/* Do not change to 64 bit */
>>>   };
>>>   
>>> +
>>> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0
>>> +#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
>>> +
>>> +enum freq_qos_req_type {
>>> +	FREQ_QOS_MIN = 1,
>>> +	FREQ_QOS_MAX,
>>> +};
>>> +
>>> +struct freq_constraints {
>>> +	struct pm_qos_constraints min_freq;
>>> +	struct blocking_notifier_head min_freq_notifiers;
>>> +	struct pm_qos_constraints max_freq;
>>> +	struct blocking_notifier_head max_freq_notifiers;
>>> +};
>>> +
>>> +struct freq_qos_request {
>>> +	enum freq_qos_req_type type;
>>> +	struct plist_node pnode;
>>> +	struct freq_constraints *qos;
>>> +};
>>> +
>>> +
>>> +enum dev_pm_qos_req_type {
>>> +	DEV_PM_QOS_RESUME_LATENCY = 1,
>>> +	DEV_PM_QOS_LATENCY_TOLERANCE,
>>> +	DEV_PM_QOS_FLAGS,
>>> +};
>>> +
>>> +struct dev_pm_qos_request {
>>> +	enum dev_pm_qos_req_type type;
>>> +	union {
>>> +		struct plist_node pnode;
>>> +		struct pm_qos_flags_request flr;
>>> +	} data;
>>> +	struct device *dev;
>>> +};
>>> +
>>>   struct dev_pm_qos {
>>>   	struct pm_qos_constraints resume_latency;
>>>   	struct pm_qos_constraints latency_tolerance;
>>>   	struct pm_qos_flags flags;
>>>   	struct dev_pm_qos_request *resume_latency_req;
>>> @@ -253,31 +276,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>>>   {
>>>   	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>>>   }
>>>   #endif
>>>   
>>> -#define FREQ_QOS_MIN_DEFAULT_VALUE	0
>>> -#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
>>> -
>>> -enum freq_qos_req_type {
>>> -	FREQ_QOS_MIN = 1,
>>> -	FREQ_QOS_MAX,
>>> -};
>>> -
>>> -struct freq_constraints {
>>> -	struct pm_qos_constraints min_freq;
>>> -	struct blocking_notifier_head min_freq_notifiers;
>>> -	struct pm_qos_constraints max_freq;
>>> -	struct blocking_notifier_head max_freq_notifiers;
>>> -};
>>> -
>>> -struct freq_qos_request {
>>> -	enum freq_qos_req_type type;
>>> -	struct plist_node pnode;
>>> -	struct freq_constraints *qos;
>>> -};
>>> -
>>>   static inline int freq_qos_request_active(struct freq_qos_request *req)
>>>   {
>>>   	return !IS_ERR_OR_NULL(req->qos);
>>>   }
>>>   
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
