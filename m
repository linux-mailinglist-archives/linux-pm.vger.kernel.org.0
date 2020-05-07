Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED11C7E2F
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 01:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEFXxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 19:53:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16455 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFXxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 19:53:06 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200506235303epoutp038da89cf5efb2f46b5cf8914958c27687~MlYjPOO5v2475324753epoutp038
        for <linux-pm@vger.kernel.org>; Wed,  6 May 2020 23:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200506235303epoutp038da89cf5efb2f46b5cf8914958c27687~MlYjPOO5v2475324753epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588809183;
        bh=o2AlyizYfqY3ffmyHKBP6dMu177b2J0Zq9TqwShCWNw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=muR0CUZvYNdnzlo0FfCI/QdIOEvMQyIhsxxDdhi3gsdazxCKhFI0fGsPEyjkPs2Nf
         L4CDVV/5wNuUYAS/3Zk+5o8Yud6mJo1F0F1F2bKloMARx7FkgA/uwtBzuIAoDBA4i/
         IKI+oz+3avKqIx13pL72uRZ8OybbvGohDDLulLHY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200506235303epcas1p445c4c14013dbd47bb930fb707c34d41f~MlYi5KGLh0698406984epcas1p4u;
        Wed,  6 May 2020 23:53:03 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49HYLj5Nb4zMqYkn; Wed,  6 May
        2020 23:53:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.D8.04744.BDD43BE5; Thu,  7 May 2020 08:52:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200506235259epcas1p180e571147fbbdb104fe8618c7555abe8~MlYfVPW2h1116411164epcas1p1o;
        Wed,  6 May 2020 23:52:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200506235259epsmtrp13cc283328367adb6539eec52e4192124~MlYfUfuLu0130701307epsmtrp1V;
        Wed,  6 May 2020 23:52:59 +0000 (GMT)
X-AuditID: b6c32a38-26bff70000001288-d8-5eb34ddb4f54
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.90.18461.BDD43BE5; Thu,  7 May 2020 08:52:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200506235258epsmtip229c843a171187266b232c0a9050cf010~MlYfJ6JYq0254602546epsmtip2U;
        Wed,  6 May 2020 23:52:58 +0000 (GMT)
Subject: Re: [PATCH RE-SEND v1] PM / devfreq: Replace strncpy with strscpy
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <41092ded-8bb6-726f-6986-fee62a8a1325@samsung.com>
Date:   Thu, 7 May 2020 09:02:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <09712864-01a5-e2f9-b55f-e822169d30fc@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmvu5t381xBqc+S1is/viY0eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx85Zd9k9+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvj5KwbrAWvuSuOH9nI3sD4lbOL
        kZNDQsBEor9tKhuILSSwg1Hi7nOjLkYuIPsTo8TVcx/YIZxvjBKbP25ngunY1N/FDJHYyyjR
        +vQkE4TznlFi8benjCBVwgJeElcW97GA2CICNRJ7X08C28EsYCXx+mM3O4jNJqAlsf/FDbA4
        v4CixNUfj8F6eQXsJKbu2ccMYrMIqEic7+kC2ywqECZxclsLVI2gxMmZT8DmcwrYSrTdus8I
        MV9c4taT+UwQtrxE89bZYJdKCPxll5i7dTszxAsuEiv/7WWFsIUlXh3fwg5hS0m87G+Dsqsl
        Vp48wgbR3MEosWX/BagGY4n9SycDbeAA2qApsX6XPkRYUWLn77lQR/BJvPvawwpSIiHAK9HR
        JgRRoixx+cFdaChKSixu72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCCHNub
        GMHJUctiB+Oecz6HGAU4GJV4eA8s2xQnxJpYVlyZe4hRgoNZSYSX58fGOCHelMTKqtSi/Pii
        0pzU4kOMpsDQnsgsJZqcD0zceSXxhqZGxsbGFiaGZqaGhkrivFOv58QJCaQnlqRmp6YWpBbB
        9DFxcEo1MAaHFh959pDnxgRH4Zu3K0z+F7MmLb0dJNa2PnwWz469HtPi5A/1C63Qjl8w1bhR
        yuuTj6GOktDF5SdW7c7p/W0wUf+00OL4zVNyqxhqi9rXbLC9wssmsDL/8myHGbd/xViYvXx+
        08Pw65kTy6sUvj/lvf1ZYUPsya6vcxdP02iZ++qarXW8xiklluKMREMt5qLiRABUE8r0pAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO5t381xBl8/slqs/viY0eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx85Zd9k9+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK+PkrBus
        Ba+5K44f2cjewPiVs4uRk0NCwERiU38XM4gtJLCbUaK9xxUiLikx7eJRoDgHkC0scfhwcRcj
        F1DJW0aJX5v7WEFqhAW8JK4s7mMBsUUE6iSurZoAZjMLWEm8/tjNDtEANHN5cwM7SIJNQEti
        /4sbbCA2v4CixNUfjxlBbF4BO4mpe/aBHcEioCJxvqeLCcQWFQiT2LnkMRNEjaDEyZlPwBZw
        CthKtN26zwixTF3iz7xLzBC2uMStJ/OZIGx5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUo
        mVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwlWpo7GLev+qB3iJGJg/EQowQHs5IIL8+P
        jXFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1MIkELbuz
        75GKX9DByrqOmG/RBWf7DxxVF7/zPig7WLLvQ+/LfNsVbBM2bdzl+nDxf/YEG945T3f5Z2w1
        v7HodFqwi5jWJtOV1tVnVWcsCeC3sXZ9Hiu0bOM+Tbb7l3ZXXuTUfuOzjfXtiqKXgiEGAscs
        q/Xun78a8mLHcq7eqG4G/ll7X5ebNrKZvl799lz0u5/JPt1zfzw/G/fs0K8Axp+9vcJ7j5jm
        HbI9N/cFU/R/MauK4O6Jt9f1c++OX8W8b9MdTinR/tsul+L+/xCcZflNoujBsUY15oYpXQeu
        BlcFfVzx/vz80/3elZOl9rbKs1eXJ1tN0Fqq9+GGVPm7xz5dfNMsL399eqK9bZdn7DolluKM
        REMt5qLiRACHOvM6AQMAAA==
X-CMS-MailID: 20200506235259epcas1p180e571147fbbdb104fe8618c7555abe8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200417140545epcas1p38cdc6cc5e6059437e611cf7e771d0dbd
References: <20200227170854.9949-1-digetx@gmail.com>
        <CGME20200417140545epcas1p38cdc6cc5e6059437e611cf7e771d0dbd@epcas1p3.samsung.com>
        <09712864-01a5-e2f9-b55f-e822169d30fc@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 4/17/20 11:04 PM, Dmitry Osipenko wrote:
> 27.02.2020 20:08, Dmitry Osipenko пишет:
>> GCC produces this warning when kernel compiled using `make W=1`:
>>
>>   warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>>   772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>
>> The strncpy doesn't take care of NULL-termination of the destination
>> buffer, while the strscpy does.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/devfreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 8494c5f05a73..2011f64bfa3a 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	devfreq->dev.release = devfreq_dev_release;
>>  	INIT_LIST_HEAD(&devfreq->node);
>>  	devfreq->profile = profile;
>> -	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>> +	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>  	devfreq->previous_freq = profile->initial_freq;
>>  	devfreq->last_status.current_frequency = profile->initial_freq;
>>  	devfreq->data = data;
>>
> 
> Hello Chanwoo,
> 
> Do you have any objections to this patch?
> 

I'm sorry for late reply. I applied it for v5.8-rc1.
Thanks.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
