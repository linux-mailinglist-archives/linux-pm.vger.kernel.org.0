Return-Path: <linux-pm+bounces-41902-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPjMBQp8gGnE8wIAu9opvQ
	(envelope-from <linux-pm+bounces-41902-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:27:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83DCAE2B
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A973064035
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548A3587DF;
	Mon,  2 Feb 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LfeWzLyn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DgM9nJmR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AB3587C6
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027661; cv=none; b=IGOnwCbTdSLNRf0cqGGBxBNfdvz39jtEXBS+2xqDRKAjjWvgZWZnpuC1I91peUm24IU8yozWOTFj9A+GyQ6T2g8m/3HJA67NFCdXapCqHuSWX/Y6IWpEkwIGMItjUdhrQ+FOXwOtRT7rLjswuqJAy0EWRW9u+5J9dYInvikp2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027661; c=relaxed/simple;
	bh=69fDhM2MNSYKxaIMW4WQElFr9savBfG6n3ZiVVmCrvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUE5alcR3AmXQpyo91aoTDldW43yQMTwSjGay/Yl7SYwh2jjVddNEKyGI0THScIgVBSlkRlZCE+AZtu52gqOqxVmJ2AkKRJEkKTR6DKZ2QB/imRJOAQu0lg/gU0f6vovGA4goqiU8833VULvAQ2t6YtaeLcmKzj5y9pny4KPw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LfeWzLyn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DgM9nJmR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61284M9w565694
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lbbM/5o1YHALe2TiY8ThEdvZflmJ7vTUzQzZZ/lJdhI=; b=LfeWzLynzkq8Bv5t
	C5MPnSHxOjq7oh8+tX3T0NiQvQR2iJagb03UIXhw4YYpRldzv7mK76JRIMTT5C+8
	RSYQ90Ruaq/rcLQUwmG+H/y2qFwQzXp2cRq6nipWHxfmUWC+kwiejHBXa+oAx4dp
	CLqb8Fp+4FGZUuI+XYAsW7tLSLrMrcni8rjJK7LQt7HnVB+veTd4Clfb6fSJERBI
	DWfy78k6fBcX9c+TS5GDG0LxfWZtzAAiR1t+Q/103u1cazi70eDoOjWV+t2m4+IM
	8syjT4XJKblKheZWb2OQWqavVmagmNKgLBe3zj5BFOZR4sSNyrxuJmpRkStZO6mQ
	1XS+rQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1b17w0bf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:20:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894662cba4fso10045676d6.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770027657; x=1770632457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbbM/5o1YHALe2TiY8ThEdvZflmJ7vTUzQzZZ/lJdhI=;
        b=DgM9nJmRGGu6UR2y3scKn06pD4TyiNASqJ6XStODlNHZLZTplMSsNXTCWxHkmEWZ1i
         ZwLD0Pcw7Ioiq6fbG3/8icM+9Fsr0uW+MWyQxxy0BTIeRh6kaawbDwbNYMLwlR50F2pr
         cTzLbvWhieTonCMm6pcQaSKdfLXAo07coQiCgby999sCH8FuWIXEaGRBcmeCI82rfPID
         bQIeJGd6l/l5WTXQVzgb042SQBt2Bf3X0L/QaaJzAjp5y9S3ucrvXOq9r9D19jzxkQTq
         X+tU4gblPNaSJGv5z2MFsoJrC4Dt6pyT5dWEfUEK6+gAXxJLhOItZ8HaxlcciDgiHte5
         1ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027657; x=1770632457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbbM/5o1YHALe2TiY8ThEdvZflmJ7vTUzQzZZ/lJdhI=;
        b=wXBI69MvJWFDCuJWFZRLleLkM6DFvNeLTxuDjhH0RElvYdxELJyrbDB+E7xbv/McSm
         0gAX4o3cDUiCWxA6qs85PGxh19k+E3ySNer8kQ3ys5n+ZAwMm2XfrAJOK75BqM3wd+YQ
         aMoac45Ih43r+w8VqQZguER4TrlszWTnCoPBG7BA1waHkH3wh2mtDRS0V6ikkYihAAQi
         mdpN3JjYQhpK25qceNLQhzzXTrL4jIppwoMQCyLyywwGIijOdu2ER6hoLGCPRa6UbXWe
         uQMDqRNBV8LN4pUwxMljuYnngj67TAq2R2Vkxly/q/Y4aeMP4ieLnDMRbRgTVgNEUKhP
         U/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6n4tE74aSuicD7SZ+RCdovMG7h2klc3VG+9QzXbqReMKU9lkjPOoK8dCOZeEjNNjbbTsXAKf0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35TKxPD9G4pV2017xJyd3yO9AUJVxOIQ+kqOll7KLuCajbVhG
	dAML4/A4OFUeKtbyWKjy+LhIZ1D4SYsNG+foJCDbI3+3pW/GOzpirdMMZhKjQxVq0tM/VbnCwQk
	1U20abjZ6Q2mxIy3RGkEHNpOCMTMy9WN/MbItdCOyX2fKcMc9suQdxGyKwNa6Rg==
X-Gm-Gg: AZuq6aJM+bu40jCbDPUZlUW9ZvYrg4RVVCB1JzvgRIOzfFErKeL93tzDzjG/ivVctNv
	j/Vw9p5+YYcRTdIhMVn6MBlglkesHLzDIAOCN42fXNbri51XrTQNUFAa0BuH8hIxBSOF/5PVjz1
	9ieNwAgrl1UCsnxmoSHwD+jwFg3Ob86z5D3LGV1+fXS9MvFgjRtnjCyBxR82Cpe99j+a+gjn0JM
	vIWVgZiajj9pAq1KeefzY/PWuzEXcTHEQrCB1GacSjjzGsDLcOVRqGoBESBmeP+mTv2uXlALZ+i
	x5DPQsoCIjeTEcIJCwHMe5WlXmJQYXCHTpXtRlTDI6anAzKtQkLod1G01N9yi3hglj93iB8lTmu
	0Z2udHQcj17S38uC/lg/VRxyrOCd61s+h1TJI1Aq2uHUecOeliB9AISwfmcRdOj5BobU=
X-Received: by 2002:a05:6214:4d03:b0:894:6c97:691b with SMTP id 6a1803df08f44-894ea075718mr115131326d6.6.1770027657225;
        Mon, 02 Feb 2026 02:20:57 -0800 (PST)
X-Received: by 2002:a05:6214:4d03:b0:894:6c97:691b with SMTP id 6a1803df08f44-894ea075718mr115131106d6.6.1770027656840;
        Mon, 02 Feb 2026 02:20:56 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4453094sm7382716a12.14.2026.02.02.02.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:20:55 -0800 (PST)
Message-ID: <95ec1fa0-5f0b-4dc2-a420-599d61f5e11d@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:20:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] media: iris: scale MMCX power domain on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <20260201-iris-venus-fix-sm8250-v2-4-6f40d2605c89@oss.qualcomm.com>
 <95977a30-616c-44af-ac93-90bae2bed298@oss.qualcomm.com>
 <ace931f9-822b-4756-8c23-f69963ffac02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ace931f9-822b-4756-8c23-f69963ffac02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LcAxKzfi c=1 sm=1 tr=0 ts=69807a8a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PIOu0JlNxAVOzX5nUJ4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: K2MCR55Kk50m56RQSlnEY98iOgr4BKaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NiBTYWx0ZWRfX/6FZhGnncsoB
 7ttPwMNrVKlYNGMw2493MaPmRf5PS+4FHZZukyy/ur9pbFMzbcHzXt826aGSTyRw1aY7c6mMDvW
 mMxgqxLUJ2ae3EyOyNvK08W9Fr75qdiVmIS8rfSQp2ukc7PAGy9Nd6C1XS3ILN1POlFTlqe/Gcp
 /ObggTy/+4FF2zVGc09lWHgEGy3K2Z4wBvmWPfWUoQMJ24rmwvJTlhddY4j8aY8mONFfI5NlDXD
 RRa3qe3KdQvgguLAoJL8pdTgDkD7g1rknTy/OZJrjYVKeA1zVNIrS+StUGoyQkBhVNvuWc2E4P8
 L4c/fabUoWzFJdYqO5HXnbDUsDdBN4iHh33nAJ1fIp2khT/zWyUu5IJbK+J4Gna3bVNvz+u+xen
 BCbQlN2hZChFCpFU/fYfqragzvT5Xo561Rb3beElVwUiuWn4eQlZmW3+bXlTAuL+9bDrDViQjL8
 Vxl+xHGbYeMTwP1USWg==
X-Proofpoint-GUID: K2MCR55Kk50m56RQSlnEY98iOgr4BKaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41902-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D83DCAE2B
X-Rspamd-Action: no action

On 2/2/26 11:12 AM, Dmitry Baryshkov wrote:
> On 02/02/2026 12:07, Konrad Dybcio wrote:
>> On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
>>> On SM8250 most of the video clocks are powered by the MMCX domain, while
>>> the PLL it powered on by the MX domain. Extend the driver to support
>>> scaling both power domains, while keeping compatibitility with the
>>> existing DTs, which define only the MX domain.
>>>
>>> Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>   drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
>>>   drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
>>> index df8e6bf9430e..aa71f7f53ee3 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
>>> @@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
>>>     static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
>>>   -static const char * const sm8250_opp_pd_table[] = { "mx" };
>>> +static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
>>>     static const struct platform_clk_data sm8250_clk_table[] = {
>>>       {IRIS_AXI_CLK,  "iface"        },
>>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
>>> index 7b612ad37e4f..74ec81e3d622 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>>> @@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
>>>           return ret;
>>>         ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
>>> +    /* backwards compatibility for incomplete ABI SM8250 */
>>> +    if (ret == -ENODEV &&
>>> +        of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
>>> +        iris_opp_pd_data.num_pd_names--;
>>
>> You're decrementing 1 to 0 @ this point in the series
> 
> Why?
> 
>  .opp_pd_tbl_size = ARRAY_SIZE(sm8250_opp_pd_table),
> 
>  .num_pd_names = core->iris_platform_data->opp_pd_tbl_size,
> 
> So here the nom_pd_names is decremented from 2 to 1

You're right, I was looking at the wrong file

Konrad

