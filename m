Return-Path: <linux-pm+bounces-19864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C29FECE5
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 06:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481DF1881F4B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2024 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C003154C0B;
	Tue, 31 Dec 2024 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ltmPATYy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D213C809;
	Tue, 31 Dec 2024 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621224; cv=none; b=YNYK8+Bzzl4fx2G4eijhjezfBMTp/XfXY4rqlvalvjTiWputmbLc9EJ9DkzpuZTGEaktolvOLIxR+qRvb6c0ZGSstA22LZEUYqPXmPYLkArB4bEz9cegtc5rB9kJSKGGw2m5JfTzu8hwBnrnv2n1AWgtHOX6qXE+zC4ZKOGXHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621224; c=relaxed/simple;
	bh=YzY3PbcvPveYA0Er+m9b94pGh/wJnWaCZp7qO5LwPNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MSdIWmpyJVHlQ7bMmwjwIBzadzZKf/wGwwVZwTTNSifat48Yzj035Q1YUvFcR1KdMhtvmdaqO8r08vuLDBRc/OFK5kmpPOzb9UN3qeGt2hAJlRFZjvxqTTfYXpjg9nKtRO0U1bw6j1UgO/5xCClF5wXvYmQI8dw4hsbIiSJ/7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ltmPATYy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUMViGw024008;
	Tue, 31 Dec 2024 05:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1Ywxb/8QeACUBS84I7kVKXn6HdMiacrafTLO8IBaVE=; b=ltmPATYy89tpm3Rk
	/CWXqoT35jXXterUHv7yT15/21GTE1pDoYjpKVy/Km5alOSqFYSU7RcB4gGdB3N2
	6dPxVYpO6XdM6iU9PNMYy5sp3lg6rLNul0E6M2pcfr6PYeKZgcIM1i9xSEIV4Su/
	zVQ014WLr/2Qu0E5f2GB0a68sVAHI3ajIP+SzGZCAFgiCttSFBdVzeD1q59CSZgC
	ctf9rghPCUGROtHvqoFguNCqULWxHmGwICAk7lwb0RLCx+DlZGZ0RSZZQY+4QxrE
	1Jxe12Omd1hrewb4QP/cvU3bOx6oiP1uvR+Sg6LAlYKo0pcl7Y27YJZ+fxPyM8OD
	z9TZ2Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43v35mrntg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 05:00:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BV508ve024076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 05:00:08 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Dec
 2024 21:00:04 -0800
Message-ID: <1dff7a78-1693-45d7-8ee3-357b33848595@quicinc.com>
Date: Tue, 31 Dec 2024 13:00:02 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
To: Pengyu Luo <mitltlatltl@gmail.com>
CC: <andersson@kernel.org>, <bryan.odonoghue@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <gregkh@linuxfoundation.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <konradybcio@kernel.org>,
        <krzk+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <nikita@trvn.ru>,
        <platform-driver-x86@vger.kernel.org>, <robh@kernel.org>,
        <sre@kernel.org>
References: <564fcad7-59d5-44da-8ed7-78fade8e40a8@quicinc.com>
 <20241230104404.184616-1-mitltlatltl@gmail.com>
From: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241230104404.184616-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L4K6RnS3fiL2G-z2UsHyP8fbKQI9Y2IG
X-Proofpoint-GUID: L4K6RnS3fiL2G-z2UsHyP8fbKQI9Y2IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310039

On 12/30/2024 6:44 PM, Pengyu Luo wrote:
> On Mon, Dec 30, 2024 at 5:04 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>> On 12/28/2024 1:13 AM, Pengyu Luo wrote:
[...]
>>> +     i2c_transfer(client->adapter, msgs, 2);
>>
>> ARRAY_SIZE(msgs) is suggested instead of pure 2.
>>
> 
> Agree
> 
>>> +     usleep_range(2000, 2500);
>>
>> Why is a sleep needed here? Is this information specified in any datasheet?
>>
> 
> Have a break between 2 transaction. This sleep happens in acpi code, also
> inside a critical region. I rearranged it.
> 
> Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
> ...
> write ops
> ...
> Sleep (0x02)
> ...
> read ops
> ...
> Release (\_SB.IC16.MUEC)

Could you please share the exact code snippet that is being referenced?
I'm a bit confused because it doesn't seem to align with the current
logic, which doesn't have read operations within the same mutex lock. I
also want to understand the background and necessity of the sleep function.

> 
>>> +
>>> +     mutex_unlock(&ec->lock);
>>> +
>>> +     return *resp;
>>> +}
>>> +
>>> +/* -------------------------------------------------------------------------- */
>>> +/* Common API */
[...]
>>> +     int i, ret;
>>> +     u8 _resp[RESP_HDR_SIZE + 1];
>>> +     u8 req[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };
>>
>> Could it be made more readable by specifying the macro names for 0x02
>> and 1? This would help in understanding the meaning of these numbers.
>>
> 
> I really don't know the meaning of master command 0x02, 1 is the size for
> the data_seq behind of it. There are many possible sizes. It is not a good
> idea to define a macro name for everyone.
> 

Perhaps you didn't get the "arg..." magic here. A single definition is
sufficient for all sizes.

>> Also, please ensure the actual size of the request buffer is handled
>> properly. In gaokun_ec_request(), the req is passed down directly, and
>> the i2c_msg.len is used dynamically with req[INPUT_SIZE_OFFSET] +
>> REQ_HDR_SIZE. This requires the caller to carefully manage the contents
>> to avoid memory over-read, making the code difficult to read.
>>
>> Creating a defined macro can help you avoid manually defining the size.
>> For example:
>> #define REQ(size, data_0, data_1, args...) \
>> u8 req[REQ_HDR_SIZE + size] = {data_0, data_1, size, args};
>>
> 
> I think wrapping like this is not recommended, see '5)' in [1]
> 
> Best wishes,
> Pengyu
> 
> [1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#macros-enums-and-rtl

I believe that the consideration of namespace collisions is a valid concern.

Some examples can be like have a naming pattern as well:
/*To have a name pattern to reflect the size like reg0/reg1/reg2*/
#define REQ(variable_name, size, data_0, data_1, args...) \
u8 ##variable_name[REQ_HDR_SIZE + size] = {data_0, data_1, size, args};

/*u8 req1[REQ_HDR_SIZE + 1] = {0x02, EC_READ, 1, };*/
REQ(req, 1, 0x02, EC_READ);

/*u8 req2[REQ_HDR_SIZE + 2] = {0x02, 0x68, 2, 3, 0x5a}; */
REQ(req, 2, 0x02, 0x68, 3, 0x5a);

Please note that this is just an example and a suggestion to avoid the
current manual variable pattern setting. The final decision still
requires the current maintainers' agreement.

-- 
Thx and BRs,
Aiqun(Maria) Yu

