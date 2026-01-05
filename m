Return-Path: <linux-pm+bounces-40218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE9CF51C9
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E1C3103A6E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30B342511;
	Mon,  5 Jan 2026 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PZ3HIAIS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YRmCdEY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCE340DA5
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635111; cv=none; b=IySPOg2RLT3P4SOGttyWK7VDVgXyOEL9ZI5ujowxnQagH9LP1rrkEMuJISeiXttyNOGs+5kGOpCdONKO8JO0N3jDaiI3HVW7VOIxvGzJC3mUoKMdv2C6p9eVCqTIsXnoxiF310vaBLjwbehjHzxeXqaJWeTNiIU0sLg+l5BwlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635111; c=relaxed/simple;
	bh=DikS2dhL0RJzf7UClKK+maosedNp+l78RRU+uOEwdR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktBHUTwE6db4kGdw9lafpJADIJGl2b/xeUjSnSftcDyTldIbBXKTQhypJv/KpqRS3iCpuCeWP4pqUu+EyNYQw/3ocGO7UqKxnVuU+wGmrpmdy2k4w1yG5PGBLwXhJe+3uDjccEnHEtbi0mg8uLlbGATY3DS9mg+GYKPHDnSyQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PZ3HIAIS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YRmCdEY8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605AYYbM936780
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 17:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AwMJzsFg9xevmD9ITklkuyyQUn+U+1PS0H65W566dY=; b=PZ3HIAISH6GBLV2o
	UUTcWnvJgX12q6H8ZUW5vx4HxzqQHJ1yq17l3NLO3FzpUkQJeebCnHPLMWXv5ad0
	ZwbwpP8I9g5bX/QZ+MPXdAfiM7PHyCaO3H00kqNNI1yD0rZuLDqYivC10pR9ma6m
	uDuKbDIFZOvJdyh2MLsryoug4imulUwjB8Y2QJEpszXY1+VbkoJA4Rn5W468Imvv
	oZgSKI5YtYBy2rfpb8hHj/BTA5Jc3kV1UIcJWnctkt0xWM43oAGHdeyg+qXTb1qP
	pSDap32D8WULvzSWOLPPRK0WDsKVG+Dh9CE81vMP4WICp+U+F1AASkJ9vsch0t6/
	SiUZ+Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgbnv95hj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:45:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0f4822f77so2357155ad.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767635106; x=1768239906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AwMJzsFg9xevmD9ITklkuyyQUn+U+1PS0H65W566dY=;
        b=YRmCdEY89Icn25AzPqFPzlYpS2gDIfi2GcibHvZTcD9kEEWZd6o3tEpM9e8QDK6KA8
         +OTUao6MaRdaUehSdBIIOr6Ts+DtujzaVC9e3FAsHLPs4k5pi8n3AjuhVB7IZF7r6y7H
         Cqmqfg7O7Se5TYRwlj3sRSUt7CPXlarYoz+Y/4fbvct7Tc4+/ikyg1aaakJllol5fDc6
         q5/BQ5iSy8S3+pkj8MGeIhnOWDtkVVlOHtGrQN4R/wC0UnDnXD0NV6/RKp64bdw8VlSZ
         dL2iqlNF5E/HFWySfP2KLkXxeww1C3Jv+7oKqf+qSO520pzU8IwdTxrPx6TVe8/di8rK
         R+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635106; x=1768239906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AwMJzsFg9xevmD9ITklkuyyQUn+U+1PS0H65W566dY=;
        b=U2VMuFwksItNUSyk4TR2acnTJx/V6/DUTrFFXxHFfDwaoWB8crp2mjNjLlW+3el4QE
         4oYUIaocgWXbBPPjhWxt2zHEfn/6zTiBSNatBuPUZw3+6nXWuEtQc6v0xqG17P5R8lg1
         SG8eu74Joct0b+yYWD19H+xxMz493/WnasneSkZaPnoobjf7PrcOE1Fh88g8UVT/0/sj
         V/GngHY4bMeY/jnnP5AQPyUSEKDt2qraN9TUKBl+RzxP0GqTw0gYXT3lY1jT3S4vf5mZ
         th6sTnpZgTbJ5ZaXO/BtVonHTB/xqrGHw8lAQo1zwCP8LQ9UjNEgC+RssIqWWNKG5Hh9
         UaSw==
X-Forwarded-Encrypted: i=1; AJvYcCVUSFT3vMMk5ptugCExqKBti2b7KdeVPs6CaYzuQ3ESn55NNLMkDuwRFoMT4HqSappRfgspEV5ByA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6BUTeBecjcl3pcbqpLJmPVPpdeoRj211ct1wrH8EdhDkclrx
	as+90LaF1OogS7iSnZs75WtKN8MH0ZKF8CTg42ScBLVABkRWBnALuDliXXotF1RejFs4LA0DZV+
	QYxDbHuAVJDdl8kHacf0BNfpXTsWrTTZT/m2aFe5sH2d1bMFA20RDfD87BAsv1m0figIEyg==
X-Gm-Gg: AY/fxX7A1F9ksUvqbvwc+FvNzUarbrqjmlIK40Sxhdas5eKImnp649Sx4aKbkfKw6gc
	+519eS7wjQNDWG5pB8qKf5c3VsEYxvQ8qonj4xOK+P4qruGz+J/20tQpMGY7LdyWFYF2gbxQyio
	lEClSIoJgwMq256nc8qYe6ZlpZCT5iKCUPygTZoYTEpNXWnZw+uIi6vlM4ybGJirFskJXosykdV
	2NWanbkuorN797e8v7CDIKb4e/2bPjFIe5YCiJUI6yId5OwlwbWAFB0iTU1nJTEk9v/hXSti4iq
	+aC4y84jMvxFKgsCiOTFw9bU5hUc8FhIpUMJ60th7DjrXr4AkU7jLfXc0TNStDREYUKNXH3tNXv
	M/JaEDeoQhzm7xiBo7I3PS2SH+xx/VfWhtswEFE4GwW7oUhmaK6nuY0SygQo51RjhomLOJPdgCk
	b0E+cP
X-Received: by 2002:a17:902:d4c7:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a3e2e1f2edmr3882905ad.49.1767635106035;
        Mon, 05 Jan 2026 09:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtmA1AkC7uEsR0BkxxEmtOHZYhWc57cT6nABk/liIy5W/O1D+pEbnAqkz11fSEvS2kSKS3Ew==
X-Received: by 2002:a17:902:d4c7:b0:2a0:ed13:398e with SMTP id d9443c01a7336-2a3e2e1f2edmr3882695ad.49.1767635105509;
        Mon, 05 Jan 2026 09:45:05 -0800 (PST)
Received: from ?IPV6:2405:201:c408:b07b:6589:c739:d9cc:4910? ([2405:201:c408:b07b:6589:c739:d9cc:4910])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e2b8e878sm3512305ad.84.2026.01.05.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:45:05 -0800 (PST)
Message-ID: <ee0c4a7b-e3d1-1816-d5b3-e53ec3cf2e8f@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 23:15:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v22 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Content-Language: en-US
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
References: <20251227-next-15nov_expose_sysfs-v22-0-2d153438ba19@oss.qualcomm.com>
 <20251227-next-15nov_expose_sysfs-v22-2-2d153438ba19@oss.qualcomm.com>
 <CAMRc=MewoxcijL_OYi=LwWMJmYCSsYFQ2j+koOF5b2_w8VyGsg@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MewoxcijL_OYi=LwWMJmYCSsYFQ2j+koOF5b2_w8VyGsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=695bf8a3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SSjAeza1avilwI61tZ8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: c_5wzuGM4FtTbw1f5U1guiBom0Px1OFI
X-Proofpoint-ORIG-GUID: c_5wzuGM4FtTbw1f5U1guiBom0Px1OFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE1MyBTYWx0ZWRfX+pXubko6fR2L
 8ZBagNsCeQDX/YnJPSm/p3zh1QIw0Wv65n4PxMjRuHQFE4W3Tr6jauoz8Tqt6A/9zhL1QtU5Pis
 OFSitSJGz97FwKLC8iveybcxZQSIsbSSQtb22W1E7mh7bKrOq36bpGT8JD/3fEDAr0GtCXwQAgZ
 kPgy18Uz6gu8pF0s4KlD2ALNJr6Bq0DvOJ7wYm3hMwZ+kLXNmcYXNsZgQHj01pWQM/mCNyDrlLU
 Hk9V1s1RtIndRmk9v0m/YjPg6TChWa6WRIr2WZF0j62+Jzl9EQZ9hLts1BZnyaC3FxjdAu8CMAd
 Neheoma6c/HjCIMI74LKfLcPA14kR1TagRE3vZydhhZgY8zMGyZsxTityd5ZnULBc5QEdhRyhhi
 8KrrEzVX5NSvXNIko72/4hGXc14YTRy4wPXpb0xfJBai3zheSEn+Y1u9wT41BMeZnYZLzcNlEFj
 vVgm4kBvmVO/kLLmyrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050153



On 1/2/2026 6:55 PM, Bartosz Golaszewski wrote:
> On Fri, 26 Dec 2025 19:56:34 +0100, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
>> Currently, there is no standardized mechanism for userspace to discover
>> which reboot-modes are supported on a given platform. This limitation
>> forces tools and scripts to rely on hardcoded assumptions about the
>> supported reboot-modes.

[SNIP..]

>>
>> +struct sysfs_data {
> 
> Let's make this more descriptive? struct reboot_mode_sysfs_data?

Ack. thanks.

> 
>> +	const char *mode;
>> +	struct list_head list;
>> +};
>> +

[SNIP..]

>> +
>> +	reboot->reboot_mode_device = device_create(&reboot_mode_class, NULL, 0,
>> +						   (void *)head, reboot->dev->driver->name);
> 
> No, why pass the list? You should create an instance of struct sysfs_data per
> device_create(). If it needs to contain a list, then let it contain a list but
> don't allocate the list_head, that's really unusual.
> 

ok. Will create struct reboot_mode_sysfs_data with a list head and
allocate it as data.

>> +

[SNIP..]

>>
>> +static inline void reboot_mode_unregister_device(struct reboot_mode_driver *reboot)
>> +{
>> +	struct sysfs_data *sysfs_info;
>> +	struct sysfs_data *next;
>> +	struct list_head *head;
>> +
>> +	head = dev_get_drvdata(reboot->reboot_mode_device);
>> +	device_unregister(reboot->reboot_mode_device);
>> +	reboot->reboot_mode_device = NULL;
>> +
>> +	if (head) {
>> +		list_for_each_entry_safe(sysfs_info, next, head, list) {
>> +			list_del(&sysfs_info->list);
>> +			kfree_const(sysfs_info->mode);
>> +			kfree(sysfs_info);
>> +		}
> 
> This loop is duplicated, can you please factor it out into a dedicated
> function?

The loop frees the sysfs data. You mean i should directly call
reboot_mode_unregister_device in error path of reboot_mode_create_device
as not to duplicate the loop?

> 

[SNIP..]

>> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
>> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b56783c32068096325f92445b9530d1856c4826c 100644
>> --- a/include/linux/reboot-mode.h
>> +++ b/include/linux/reboot-mode.h
>> @@ -5,6 +5,7 @@
>>  struct reboot_mode_driver {
>>  	struct device *dev;
>>  	struct list_head head;
>> +	struct device *reboot_mode_device;
> 
> Why can't this be part of struct (reboot_mode_)sysfs_data?
> 

If reboot_mode_device is kept in sysfs_data, we need a reference to free
it. Should I maintain reference for it in "reboot struct" and store 
sysfs_data pointer, so that it can be used to call device_unregister()?

Eg:
struct reboot 
{ 
..
..
  void *priv;
};

struct reboot_mode_sysfs_data {
    struct device *reboot_mode_device;
    struct list_head head;
};

---
data =  kzalloc(reboot_mode_sysfs_data);
reboot->priv = data;
--

thanks,
Shivendra

