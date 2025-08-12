Return-Path: <linux-pm+bounces-32222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C778B22488
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DB33ABE0E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D62EB5CC;
	Tue, 12 Aug 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEzzw8J5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E712EBBBE
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994343; cv=none; b=IgO2rA4LlJvS2ONdrUQBSxyb0+G64GFYKKZHKY69B+5+aKfAW8psB4GDrooInqA58y+uyfSeNODTg+pNqqm1FRBx7KCRT8NjvUTjqkSsmsZDaMsE0mY5lHA6GYFgBZek0bQGr9xwYYpuKgZbdGfwcuHFOqHFczMhpG6EtqMRLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994343; c=relaxed/simple;
	bh=kPPuaswxwsoGjiS70z4R/GpzZWbmk4tdm1gnkzx6Rx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prBQDr20L7k7gacKXA+XlrAPAZySu6D4PEEd9QVb43O++ju7zZGn1zylgHoiDWmq5ISzVCnF+3b5HUYZ5EZyYLjnkK0V6cUngjm+GHeguoO/o+BlzKtZ3WaF8Mk2a4/eyqhQjHVWNrnYMfQyNOjjYzZfsTv+naWKDpAHT5iBgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEzzw8J5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XqGQ029260
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 10:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fl1ygk+1H/NMb3Ro5wivLL15aqHhmZrUJSFbMCh9wRA=; b=CEzzw8J5Btb/DoJM
	414rDABSw/6tYWkIacZ8TQu16IuxooWv1bte9EU4PR8aOemnj6zQYetuMZ5cCaDL
	k/hP1Epet7XDBJcTJE2Me2Q39GRSm7mgiVC5P0zcLJphI8oVshQ2jfW1S4yfOLuO
	FCTozQfT/vdDPBN1hfQR7gwaT+nWZx9k4Zzs5MMZDgdu9dgzz/E1iIb4C5SPO0rA
	riYCber+KvcVqR77U4sL60aTrz/45t9ECIfQYLw7GfErh2Bc/Y3U+aWr9ysCEgtG
	mwpIACE96JFgjqa0mslvRjWZ76aVHHiQng/WpFHfBEGVGNY5A/42Wy7e0m+QZMMd
	08Qgmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmfq12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 10:25:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-242fe34add1so7158875ad.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Aug 2025 03:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994336; x=1755599136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl1ygk+1H/NMb3Ro5wivLL15aqHhmZrUJSFbMCh9wRA=;
        b=pGh/i2hdI84JlcXjAz20twvW42rME9v1QIKuuinFv9L/TVnUhj4pFeyvuWZiokwKMV
         dFlWyEuX7U9IZrhA123eHHC/pRuilGu4tgvZ/MRKTXwoSdl2CGLRCKLcUEoQ9OhZ9sR6
         kaJ6wy+KmQdLeMbwFROlmK4S+NU5Tyl6eAVtqifLVUeFo3KIGhFhkWh0OWntYVHjdHmt
         XxTQX0tnWdOHHPiB1RbJGk0kufCA1DVF9SCFraYhb0Jc4XfssJI9R0vynKto6LkmB+ZE
         4GI9+WXFxl/B5TSVkqEev1TW108RvZ7KIEAuCzhoozrn4im7FWmGx7y90kSYeyxpxuI+
         rUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJ6aEgNlGLD/anGm12j4De/dBJo9AvwG851V9nMVgEIespY7X2KyRxC1y8X/b4lQ0I/CZ11Vs9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4aX5L41AHUW5mANiVEE0OC5DAhibNdQF3nFN+/J00+4Uq/fO
	Oj4g8QAYy8Qm9tJ9ckjX+G1nc8oHpZUZhf8oeSYwmcFktrcKo4JsCSZUCVhuXeZnrL2CtaOmy3a
	5fObbYiFQoizInhU/r4XT7V+7zyjKIYpfCfCpIL1vDyZCphFogEY6wZmT3o3Q1g==
X-Gm-Gg: ASbGncsH+QgRbb5/wsXeLuKZpoK4MtxMCAdDxK+5DQOe1t5mhqD67HZvse5CIkBTQwP
	DQzuY1BObYhaE5ZI8IIg9ZRG+pkM9h8jXlocN98U4nIAaTyPz1hz41BfXlVVDbTX0OUuhOYKErl
	Y3LEJOwG6ECxqOTeqiiEt8zuuU7i5actU/ollc7ZnPIvzIziuf5uxBxLhdf9zW8D6njGF6esfJt
	Yhc4PKwAWwMVtXPn6p8jmAJTccSFM6vWesW6l/ZIGuyS1SSslDM6T+gPYc9MBiKYdbrjTejZWaW
	ncIn+Bl/xviqjVxGgrj/Ke6cky+XEo46C2oa2VTV1qSAfAxKoPIdM0ldExol18HScr7Smp1I
X-Received: by 2002:a17:903:2d0:b0:240:8f4:b36e with SMTP id d9443c01a7336-242fc31a558mr50178715ad.34.1754994336496;
        Tue, 12 Aug 2025 03:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhW84RupltOd7oYpjSDnmy/Z1WFZCo3v4UmpgKw/WVJ1C3vhkkf5vDczM3TxczTksqAgL8EQ==
X-Received: by 2002:a17:903:2d0:b0:240:8f4:b36e with SMTP id d9443c01a7336-242fc31a558mr50178275ad.34.1754994336053;
        Tue, 12 Aug 2025 03:25:36 -0700 (PDT)
Received: from [10.217.216.215] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242ffd9e3besm13858015ad.106.2025.08.12.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:25:35 -0700 (PDT)
Message-ID: <c783b319-3b88-45b0-8a0c-8c3ba9c462af@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 15:55:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: sa8775p: enable QoS configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
 <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/3WEU7MuNRZY
 ubTGmtXtjh82wjQbKU5e6VwkPjnenG9Sok4u2hsf3rbwq1RnhlqCtRkZVAXZQJG/wtI8v1j7onn
 NDIqcnb0dJQN6uVsBFkS8m8JJYyysjmGvRCbcGh00JPQk+/HVQTj1LpQ9CxREwrQo5UTneF0GiL
 isPRhVz9N0FF0TQrbThBig1vLJAxfFimwGtT1WHb/mKxYY5R4ZYaKYwZKiZkVwnoe1cV32IzsGd
 hhA4hqDg/AW/rjzPL4gDq4wR4zbaCTE3NelYzyv68k5c7tfNaTobCoCqcJa/kA3620WHd35HV+E
 qBYdSfro1rh/ysCSqSoTHCha8nVsDrPtDOlncOXG/5/nuBl3+pb5PwDyjy3a0dQh7ftwWgQ4BQ1
 EKwOt6XL
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689b16a1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wifMmZQcaQcT46JyXskA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: n1VdMAI07jQ3aQ1BYjKQ5Jyc0aNc17Gj
X-Proofpoint-ORIG-GUID: n1VdMAI07jQ3aQ1BYjKQ5Jyc0aNc17Gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035



On 8/9/2025 1:05 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 08, 2025 at 07:32:59PM +0530, Odelu Kukatla wrote:
>> Enable QoS configuration for master ports with predefined
>> priority and urgency forwarding.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>>  1 file changed, 439 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
>> index 04b4abbf4487..5bf27dbe818d 100644
>> --- a/drivers/interconnect/qcom/sa8775p.c
>> +++ b/drivers/interconnect/qcom/sa8775p.c
>> @@ -213,6 +213,13 @@ static struct qcom_icc_node qxm_qup3 = {
>>  	.name = "qxm_qup3",
>>  	.channels = 1,
>>  	.buswidth = 8,
>> +	.qosbox = &(const struct qcom_icc_qosbox) {
> 
> Please follow the design on milos / sar2130p / sm8650 and add a separate
> struct instance outside of qcom_icc_node.
> 
> LGTM otherwise
> 
Thanks Dmitry for the review!

We discussed this during patch https://patchwork.kernel.org/project/linux-pm/patch/20240306073016.2163-3-quic_okukatla@quicinc.com/#25749420, 
it was decided to follow embedded structure notation for QoS as per comment for sc7280.>> +		.num_ports = 1,
>> +		.port_offsets = { 0x11000 },
>> +		.prio_fwd_disable = 1,
>> +		.prio = 2,
>> +		.urg_fwd = 0,
>> +	},
>>  	.num_links = 1,
>>  	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
>>  };
> 


