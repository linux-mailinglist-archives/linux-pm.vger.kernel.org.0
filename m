Return-Path: <linux-pm+bounces-41889-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHZ2OlB4gGne8gIAu9opvQ
	(envelope-from <linux-pm+bounces-41889-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:11:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567FCA9F6
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A89FF3019959
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454333563FC;
	Mon,  2 Feb 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgigRAE2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUIK10q6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE2DF126
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026614; cv=none; b=YkRL5tyyCZgJwxyd3z8Sb+DCpZKx4GdtMyMh6Xj+Y7IKopoWULnWkoelgJ6+/OeGP9UrQqno2zkj+xks09RnzV3MK5oogk6RxlnNhXnAyycXR+3XFs/EoLIbvIVMBlilOPcBCSgRLff+jRsT6+QjDLdtPuBz1pK/OhV/vojb2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026614; c=relaxed/simple;
	bh=XEMyZqo6MP+uYcG6p5a5ymcj2O0tjv/y5I/kJu+xHrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoVa1puq6O9YhukQCimORogMf4gvhZ2N8J30ITwl6kfm1ua5vJN6DwDnNV6nL3L4AvYpgXJsRWrZszKNB/QEGn6XvIEyyvxObLiuOoTZ32y3WF/ooH5ysmAcTfQdXzteGh2ZYtkxrs72su1sdTJvmQ4FifV6hzkAeCGl7tHQ+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgigRAE2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUIK10q6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6127aUO31095098
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+aL8yDsraPFT4ypmMjaLgpbPx9Def0W/PUrKR7pwI/w=; b=SgigRAE2+5P01ZnK
	evdhd7XV9RCySM/MGoDPhcHqiIEMm+i9hdfIzzre6vonPoncpuObrhWp+MukOiZs
	Stf1jv1507twTynCF2kYLkm9YW0bSFFI+GAT8fkBcJ8zkVl9GKK6rxFcr84Ath8o
	hUbkd1IqXkALwGS4Z8OHlLoWxUeYh7t5m3RXjS1XOjwBhYLFK0on22sW+8gnUL/+
	rX814saOOX212tA/rri3FW/LwVdZRQv8lk3GOfqO35sk/lCeOBI+FisxEKGHHDKB
	fJ/I84YFxkT0RT6L40qRKmoKmesnLEn55AgcKY2XTTtT8jh6LWGvntVWicpEKqHH
	+mzBaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1as4w0c9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:03:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71655aa11so1376736485a.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026610; x=1770631410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+aL8yDsraPFT4ypmMjaLgpbPx9Def0W/PUrKR7pwI/w=;
        b=JUIK10q6xJwSh9mVP4cVnN6KuWidJ6WCx0c3VQ29oQQuetOU3EJsbtNKFAioH17YFl
         YJQoIbVjrus33YHTmXh63gSO7ZzA8f78hWiMjzWD3Dq+moKQvFAYlnEJFMu6A32NAj4e
         Ztq5x9l5BY4QFoKAmowd3TUZFuFuVEeSbiscvnS8N8aSBPD73dzmTSGGPXixksXdDCMa
         ao1YAuiqA8nAbYOD6zE1dR4/o6gv8MlyTacFBLQ46rQDusesVoBTmwO3leTXn+iLfIbR
         za0IqRtANM6Z4H5G7rp63S7YfUreCuV8fqTUYFvlQgs7zeZ7S3N2+A0VGZSrW0Pxt/dE
         KU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026610; x=1770631410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aL8yDsraPFT4ypmMjaLgpbPx9Def0W/PUrKR7pwI/w=;
        b=lFPVP5TZTS8j7tGMEBDAgD5lkpJAPeZCf3Rh6zuXZWt47WfO4CWqxfe2RFPMKuFXWK
         vWWdGm0I46D0BHyYRzTLVnNmAClYEJqm4FrrGkqMBsrpsfhrsR04+N21FkqX+4YOMYjV
         LeCSyA6ExaEWUsZXMCY+iCIZWili9oE1i2wPAdtaZefiVJD+BYNA8Ely/mnX7AQILRVO
         owULhygEjAvnOr2FYNoJEtPlGpgHMXtTNEzb9lY6XhA29jIEEUPzGY4jyrgMhvp2vbub
         fn5OBfR3PMZd0N9q9bxFHgu0epZezctt7+pZq1G+57Cn0PY42SXtVuAnIoN6SWiKQXpQ
         6/ag==
X-Forwarded-Encrypted: i=1; AJvYcCU9Wcwq6xj5fXAkXslqGnEdP+IY0w/ZmSHiMaamXgRkHRNODSxNDCvK8JeD24motOYreCXEeVmhBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0elzq3bjdoBuY/jt3TbqqE47f8YGRb/SPIpMsk4h6HhNEqA7A
	KMqDmUStBUfJa2YeD53eqD/MH0szPKAXcCprj0oTZ+kC5s+ad7XJrywez7BiirnumRxse5TJA6F
	SZQrVrJTD0kDTIOOctVKJIp0p/4yLq+AQHo51Kpz6uOl3Cz3noAb3AGzh55t5og==
X-Gm-Gg: AZuq6aKX8fQb3cHHH2JRfOZ8KURS8rK2FGelncViQEHtKVlgXUnmuJn3BvrOIO4BRUM
	ZjyUCdn51YQeFVx7SYKI1kpchs49Ilt1gKv2kdWXBXR7b0kPnI6wojkeyNzTSnNXdIsPNrFv7NY
	24iHsX6VnQQ5g7VEUIwvErNdAhaTDdhd3qJVm41gsUEE0MGD79/iVYi/1bdNvhfbQXDDvjX/+xI
	OQa1rUDT5jm01oFxZvvofp+M5mJUM6dcKVCNDAykygFZ+ErCPJNGYI4IV52Zu7Gn2m41XV2mQNv
	ZrdMFhpLa01IeYiA/5POgkI3tX7jx004up2ok2rhLZBNjqIQaeDAFqI+pxDTBMIaKciocqyYo2C
	Ld/tGxgL5iFNkGs8LtTKIW/K2YO0uaZDl1/usPwM8JQ5aiDJOt/i0ePT4eeh1S/c3qGfvcnAolt
	nB/jNfodxjSeVKVaGv3QIEo8/tHr0rDsuWk274ZZ/AW8sBGYMWCrxAf1AA2RYfuhA=
X-Received: by 2002:a05:620a:7105:b0:8c7:1b41:d94b with SMTP id af79cd13be357-8c9eb2597fdmr1242231385a.9.1770026609879;
        Mon, 02 Feb 2026 02:03:29 -0800 (PST)
X-Received: by 2002:a05:620a:7105:b0:8c7:1b41:d94b with SMTP id af79cd13be357-8c9eb2597fdmr1242228085a.9.1770026609442;
        Mon, 02 Feb 2026 02:03:29 -0800 (PST)
Received: from ?IPV6:2001:14bb:15b:d5bd:79ce:863:9a22:aae2? (2001-14bb-15b-d5bd-79ce-863-9a22-aae2.rev.dnainternet.fi. [2001:14bb:15b:d5bd:79ce:863:9a22:aae2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e08b8905esm3302294e87.38.2026.02.02.02.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:03:28 -0800 (PST)
Message-ID: <655fcbac-b39f-4207-a1ac-d97bfde3d209@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:03:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] media: venus: scale MMCX power domain on SM8250
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <20260201-iris-venus-fix-sm8250-v2-5-6f40d2605c89@oss.qualcomm.com>
 <231ae9c2-bb3b-430c-990c-deab6a8a0d0b@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <231ae9c2-bb3b-430c-990c-deab6a8a0d0b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B_gNrdtwyL8CPhpKdad-w85BP1OTaym2
X-Proofpoint-GUID: B_gNrdtwyL8CPhpKdad-w85BP1OTaym2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfXzwVZgsCqbct4
 EYubVqpTQCQYLwtYBDBTLUZihu62lkmDjFMflEEvhKhWNViGybqR4/OFFGw5/H2+XSrGAfeo6oA
 QuU4gbe1xQCUX4/izi9cZ+0+1ufVOb+CNJC0RUeZOVEHksxZRqd2YZqJjaCHCHcbG9gR+8Mmc6f
 JupIvd6qMlUEoz1HlXLoqyrAufHj/0ftC09Il5kSSRY2LnhMkwzF7qBwH7MezRnLTMMRpTj2O4a
 zK87dnwQjVV9kfMGjkxSfuniJ+HgW4dy4L+2vyZb/XwQeNA6ouDL4WQ570PZgcUp6WP5+k6Upqg
 Gin7dCnIUFR0rjd4qjiyhEGbi/iY0tTJ85HvZi7f2+xNJN/6XhtPxhFwIXHYa8GzVoElUb0Cb6U
 q4n2x+HV1wu8tHkfO4mI4RQA4A26IHoRVUdwcTOTHFmvEDUmgnfsCOnORsj1+nZGj0JIXcXAidG
 wsmehpWfYRQfZ/9TOiw==
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69807672 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=HXGjUklKsU4Eq_QyynMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41889-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5567FCA9F6
X-Rspamd-Action: no action

On 02/02/2026 12:02, Konrad Dybcio wrote:
> On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
>> On SM8250 most of the video clocks are powered by the MMCX domain, while
>> the PLL it powered on by the MX domain. Extend the driver to support
>> scaling both power domains, while keeping compatibitility with the
>> existing DTs, which define only the MX domain.
>>
>> Fixes: 0aeabfa29a9c ("media: venus: core: add sm8250 DT compatible and resource data")
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> @@ -904,6 +904,12 @@ static int vcodec_domains_get(struct venus_core *core)
>>   
>>   	/* Attach the power domain for setting performance state */
>>   	ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
>> +	/* backwards compatibility for incomplete ABI SM8250 */
> 
> "eeeh", I'd rather error out since it can't guarantee to have its
> power fully on

That would break backwards compatibility, so... it's not possible.

> 
> Konrad
> 
>> +	if (ret == -ENODEV &&
>> +	    of_device_is_compatible(dev->of_node, "qcom,sm8250-venus")) {
>> +		opp_pd_data.num_pd_names--;
>> +		ret = devm_pm_domain_attach_list(dev, &opp_pd_data, &core->opp_pmdomain);
>> +	}
>>   	if (ret < 0)
>>   		return ret;
>>   
>>


-- 
With best wishes
Dmitry

