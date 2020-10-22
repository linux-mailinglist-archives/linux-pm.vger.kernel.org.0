Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D689C29566F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443193AbgJVCdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 22:33:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:64149 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442640AbgJVCd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 22:33:29 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201022023326epoutp019d72438602bf1eb6fd0f5fb01a847a50~AL8jKKKgJ1921319213epoutp01g
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 02:33:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201022023326epoutp019d72438602bf1eb6fd0f5fb01a847a50~AL8jKKKgJ1921319213epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603334006;
        bh=kDAYexLUL1fIzAZL+IINMuwVpdSM8IRXCDveo7dhFUY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YLw8Bz2HvkH40y1S0a89QuW37A1ZIQEaapLOAorBuC4C6I4HHI+aaf6wDMUx2qEiq
         rfapHcpvzjBJaxpTMAou/BjQDLHzxWS8MMZ7fP+yfvxO7kqEtxadxlblvixdM7tRtd
         2Pts87mjHtJoBkyMwM70VaArJq0e8lsnghVeShYo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201022023326epcas1p3b9bdd8fb412cd443e0c0b9d43fe7561e~AL8ijoQwv0726607266epcas1p3U;
        Thu, 22 Oct 2020 02:33:26 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CGryC4Xc0zMqYm6; Thu, 22 Oct
        2020 02:33:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.7B.09543.37FE09F5; Thu, 22 Oct 2020 11:33:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201022023323epcas1p4ea552e1162038d835a07738768d00b01~AL8fv2UJ51068810688epcas1p4s;
        Thu, 22 Oct 2020 02:33:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201022023323epsmtrp1dcb1f281dd861d046cab21ccbc6b5235~AL8fu4gmy2300923009epsmtrp1d;
        Thu, 22 Oct 2020 02:33:23 +0000 (GMT)
X-AuditID: b6c32a35-347ff70000002547-b0-5f90ef732b0b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.04.08604.27FE09F5; Thu, 22 Oct 2020 11:33:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201022023322epsmtip1bdc086dee72f2aaaec3bd4e62a5ab4b9~AL8fbDqUS2126221262epsmtip1F;
        Thu, 22 Oct 2020 02:33:22 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5802dfbd-22d2-0efb-cc98-2dbb1d420367@samsung.com>
Date:   Thu, 22 Oct 2020 11:47:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <bee3ef10-ddec-5ad4-9daa-79d9b01651d9@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmgW7x+wnxBs2TZC2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFtc3jWHzeJz7xFGi84vs9gs
        Fja1sFvcblzBZvFz1zwWB36PNfPWMHrsuLuE0WPnrLvsHptWdbJ59Da/Y/PY+G4Hk8ffWftZ
        PPq2rGL0+LxJLoAzKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJ
        xSdA1y0zB+gFJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5y
        fq6VoYGBkSlQYUJ2xvPHp5gK/kpWdKxcw9rA2CjaxcjJISFgIrF/83LWLkYuDiGBHYwSq3sa
        2SCcT4wSTWf+MUE43xgllq6dzw7TsutpLzNEYi+jxK5tc6Cc94wSfa9b2ECqhAXiJZ5OOs4I
        YosI1EocufgAbC6zQC+TxLQ9S5lAEmwCWhL7X9wAa+AXUJS4+uMxWAOvgJ3E5GXzmUFsFgFV
        iW+fH4PViwqESZzc1gJVIyhxcuYTFhCbU8BW4s7fZ2A2s4C4xK0n85kgbHmJ5q2zwa6TEPjB
        IXH1w06oH1wkbk7+BGULS7w6vgXKlpJ42d8GZVdLrDx5hA2iuYNRYsv+C6wQCWOJ/UsnA23g
        ANqgKbF+lz5EWFFi5++5jBCL+STefe1hBSmREOCV6GgTgihRlrj84C4ThC0psbi9k20Co9Is
        JO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgSFyfG9iBCdwLdMdjBPfftA7xMjEwXiIUYKD
        WUmEN090QrwQb0piZVVqUX58UWlOavEhRlNgAE9klhJNzgfmkLySeENTI2NjYwsTQzNTQ0Ml
        cd4/2h3xQgLpiSWp2ampBalFMH1MHJxSDUwLGqezBH+eNNFQ691t5wPnGd9s2j5r1XezU6sW
        b5G8ZJ3AV3mZIThx9b6pZ4/xK3dlLDvOu2l2H4vX1fvmq1O+ng19wM42++IP9qlz9f03OvI+
        /7LRJnc9s+Ue/ggpya55u8ROC+gp9XEURW1jL9Z8Y//8+rGZe7f92Pf0is7JM7pXPsv9eBdy
        YvadF7nFCq0h7zfmPdh355bq9u4DD2IZnqy8/2XSvKPvPZyvzpNoeNv24+tms1tCrmnrmeL+
        +OZXCJRHxU5pUnCKLg65JN/2RGPuN6tOu4VrpM5t2Cbm5/rMJKr9cvUMLm6152Hn/tXavF6i
        JCj8OHemy635c1YVBYkGXGE+2uAefkxf56XyfCWW4oxEQy3mouJEAOUGUHVpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnG7R+wnxBj9eWlksu3SU0WLjjPWs
        FhNvXGGxWP3xMaPFmtuHGC1+bDjFbNEyaxGLxYJPM1gtzja9Ybe4vGsOm8Xn3iOMFp1fZrFZ
        LGxqYbe43biCzeLnrnksDvwea+atYfTYcXcJo8fOWXfZPTat6mTz6G1+x+ax8d0OJo+/s/az
        ePRtWcXo8XmTXABnFJdNSmpOZllqkb5dAlfG88enmAr+SlZ0rFzD2sDYKNrFyMkhIWAisetp
        L3MXIxeHkMBuRokVK58xQSQkJaZdPAqU4ACyhSUOHy6GqHnLKDFj0SNGkBphgXiJp5OOg9ki
        ArUSr1ZPZwUpYhboZZLo2rWXFSQhJPCJUeL5fm4Qm01AS2L/ixtsIDa/gKLE1R+PwZp5Bewk
        Ji+bzwxiswioSnz7/BjsCFGBMImdSyBsXgFBiZMzn7CA2JwCthJ3/j4Ds5kF1CX+zLvEDGGL
        S9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnF
        pXnpesn5uZsYwXGspbmDcfuqD3qHGJk4GA8xSnAwK4nw5olOiBfiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomDU6qBybPg37cqt3vtM5ZeXM0/X23DD3ans7vf
        uIjGrzZMKF679J+lWfwSPSHWd2lCecJFdZFpG3w21VrPnZl5/NAVpc9r5t+672Q6J+V0Vcyn
        u757z63c9LnmiWKM0/UpbQxbt/yZd1Oo1+r3rNoNU6/+27WAn/cZ94vrNi+Zok4fetdjEi4Y
        +yrYbd0hzy13ZPm+BFkcP19jn1DuPntBYePiVa+P3WPgY3iS6xr54r+B8Fdug3cyaSuPbcs9
        u8XqeGtUxTbeTatMdXP6d3yozaj4LMv11PPpwqxll21n/mGaeZ2H4VBioRnDlP0bLildOLPs
        +bO8N+cfPv5nfpmByXUp79OcF49OGLUG+81ecWG5zUxhJZbijERDLeai4kQA1mNDNlIDAAA=
X-CMS-MailID: 20201022023323epcas1p4ea552e1162038d835a07738768d00b01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21
References: <20201020030407.21047-1-cw00.choi@samsung.com>
        <CGME20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21@epcas1p4.samsung.com>
        <20201020030407.21047-3-cw00.choi@samsung.com>
        <bee3ef10-ddec-5ad4-9daa-79d9b01651d9@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/22/20 11:30 AM, Dmitry Osipenko wrote:
> Hello Chanwoo,
> 
> 20.10.2020 06:04, Chanwoo Choi пишет:
>> @@ -1354,55 +1365,71 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>  	struct devfreq *df = to_devfreq(dev);
>>  	int ret;
>>  	char str_governor[DEVFREQ_NAME_LEN + 1];
>> -	const struct devfreq_governor *governor, *prev_governor;
>> +	const struct devfreq_governor *new_governor, *prev_governor;
>>  
>>  	if (!df->governor)
>>  		return -EINVAL;
>> +	prev_governor = df->governor;
>>  
>>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>  	if (ret != 1)
>>  		return -EINVAL;
>>  
>>  	mutex_lock(&devfreq_list_lock);
>> -	governor = try_then_request_governor(str_governor);
>> -	if (IS_ERR(governor)) {
>> -		ret = PTR_ERR(governor);
>> +	new_governor = try_then_request_governor(str_governor);
>> +	if (IS_ERR(new_governor)) {
>> +		ret = PTR_ERR(new_governor);
>>  		goto out;
>>  	}
>> -	if (df->governor == governor) {
>> +	if (prev_governor == new_governor) {
>>  		ret = 0;
>>  		goto out;
>> -	} else if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)
>> -		|| IS_SUPPORTED_FLAG(governor->flags, IMMUTABLE)) {
>> +	} else if (IS_SUPPORTED_FLAG(prev_governor->flags, IMMUTABLE)
>> +		|| IS_SUPPORTED_FLAG(new_governor->flags, IMMUTABLE)) {
>>  		ret = -EINVAL;
>>  		goto out;
>>  	}
>>  
>> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>> +	/*
>> +	 * Stop the previous governor and remove the specific sysfs files
>> +	 * which depend on previous governor.
>> +	 */
>> +	ret = prev_governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>>  	if (ret) {
>>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
>> -			 __func__, df->governor->name, ret);
>> +			 __func__, prev_governor->name, ret);
>>  		goto out;
>>  	}
>>  
>> -	prev_governor = df->governor;
>> -	df->governor = governor;
>> -	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>> -	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>> +	remove_sysfs_files(df, prev_governor);
>> +
>> +	/*
>> +	 * Start the new governor and create the specific sysfs files
>> +	 * which depend on new governor.
>> +	 */
>> +	strncpy(df->governor_name, new_governor->name, DEVFREQ_NAME_LEN);
>> +	ret = new_governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> 
> The "df->governor = new_governor" needs to be set before invocation of
> the event_handler(GOV_START) because governors like a
> performance-governor need to have the df->governor being set before the
> GOV_START callback, otherwise performance governor will use
> devfreq->prev_governor->get_target_freq() in devfreq_update_target(),
> thus setting a wrong (non-max) freq.

You're right. It is my mistake. Thanks for your detailed review.

> 
>>  	if (ret) {
>>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>> -			 __func__, df->governor->name, ret);
>> -		df->governor = prev_governor;
>> +			 __func__, new_governor->name, ret);
>>  		strncpy(df->governor_name, prev_governor->name,
>>  			DEVFREQ_NAME_LEN);
>> -		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> 
> Same here.

OK.

> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
