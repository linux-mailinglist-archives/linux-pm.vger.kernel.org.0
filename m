Return-Path: <linux-pm+bounces-41242-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFK/I4wMcWmPcQAAu9opvQ
	(envelope-from <linux-pm+bounces-41242-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 18:27:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 436FE5A848
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 425A0822713
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B134963D0;
	Wed, 21 Jan 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8GFuoc3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dpk6byiQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937184963B8
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014358; cv=none; b=Kvn4WQdWG9xoJbyE4rGssMJpAIXn1l3+7tjPbX3WEbU+93rIqcu++YQDw+I7zFBTUGgYycAaezjce5AfeNv41+VJm0h44Nb9tnI4pryPGbAjUjouRBEMUSml+4rXm9firSJ8idfle5y7ia+HeC2+cTVj1EiQaO5YZgXAEWZXrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014358; c=relaxed/simple;
	bh=WIy1I4XbytZXyMT5K0uzcA7QaKdaKY7xEiRxpEesxRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz5dK645bkEIKewTTxmi2awdwX9clyyx3Z3FJMZVvMJBq1jMlQgDNB6NRzhZerx2i4zR9JxdJGL+c2YZ9HhrRxDi8ddRONE5ieF8AsacY4zX3QFf7eHNtGzZ86hnMl45TuYS6ENkIkVFT1BghTOx16pdEh1/Txs+TIFTsKh4IDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8GFuoc3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dpk6byiQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LGG1nu3991326
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HyR+YusWrjMwZEEpsn6at4Lj5Jd4mxdPjF+PE4Y97B4=; b=o8GFuoc3cRcwPlvp
	bNkN/jCRGcxbgS5lWWqD6wj7wMtfEqxuuC07z+aplhh8UU7aKVVussAPoolFtOEX
	QHs1wS9IM1G5choTAPNw85KkbuYZ0drzc7H2VGWdtGb1jDio20T/dNwteKhbOja8
	Tar9SYGoj+H5UBhZIJRIh0+B5URKrVmLqUf64eMyck8Aw8rOqyIdy0L4877LY6md
	VWyuDssbk3Ft4x53ebQJfeykTa5L4Bj/nTBFXClezfr++6BhlS88eq2k/5K8UgHX
	q4gm3CeJEq30/bpCtkAf2KWDA+16UBr98Jx/1uP4jqJ34qyHVsv9caAvtnQDTjnb
	3ApzTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btpm432je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:52:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a182d4e1so1227385a.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769014355; x=1769619155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyR+YusWrjMwZEEpsn6at4Lj5Jd4mxdPjF+PE4Y97B4=;
        b=dpk6byiQ3xUEk5js+fJcN+wXcAJEuloJuL7ZhLy4x1ULig9kg08rYgFg+BtixCmeeQ
         oT1l0AAnj2jl+j9ndYpvqrB0OO7MxY8ChWnf7GjKHZUKWO8dKgyy7kaAbP3LTIsDg4EC
         vQWjQavHs2g5eSL2ipozkiU1MBsLk/VpN0ya1r5V+iWRDO9s+umH8Ps6C+kqYOl0pHnX
         Lb2HA42gZDDa6ke6UEUsn8+aex7oCWH5NsYWyO3NDy7iX9LWmm3u5qX4NqJRuTS+Z7LD
         9Lh7Z312z/kTEFDgDdCUUjA6rnADnGjD/BIsjsec1E4T0IUKiSM2VFTWfyj1V6h2Uui3
         75Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014355; x=1769619155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyR+YusWrjMwZEEpsn6at4Lj5Jd4mxdPjF+PE4Y97B4=;
        b=ZHM8yrhEg0TxBmhQp6y4bw63U6nkfUWZFdQ+2uuRifnVU6Tb0vVhsUnw3oxqE5MXdo
         +hxtuH8iOzZ5QoremREdjffELaYSRk6A31iQrsqqa/hzeJhUlEWefkpwmFkSdOoNGyRn
         9MJxzqNZixgytnNBUtNdtNEuY2VvZ/J0doHTC43Ud8a20rjNgJUaBVuJktIN2Tmtdugg
         Q8OPcOoTva7l4v3kgFMtuVcKXJFmVigXtBwOC9qghmV/G+glMUleJy3AViqbobkfYreU
         9qyr8deakJ3L8BcTb6PUrTDGvzsYKEzvtywh0Fyar1xP+iP79mnglx9NH/0IREMsI+V5
         Bdmg==
X-Forwarded-Encrypted: i=1; AJvYcCUSo+5ZROcxxSwLhRs0LlxPxbDHeMHm2hGvcwQxDVSmA4pcSIEY/mnQ67G80/0OInNedGz8W1CZLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZppNCB0f+kmAPwv2WX9no4qBvK1yCbELfqkoRlNnAYYxqUNjz
	Fm8AGpZ1PPRrrLlKrSKyRTqWAzDcvdTY7aDda2GwVp04cV8Co+XSjpdcNUJ2w2F/J7qaipJtl+i
	g2zjGLJuvd4WJEgYqYCuTg4WNM/4A5WqG7ZBuvvGJA4//EidUJEsu32Zrk3CTGQ==
X-Gm-Gg: AZuq6aIWMninOL0Ekez5AscmizTFPy3kDyVba25FLzyFLOj0Mco1ydFvLkYAS9+VEsc
	AgQ5FISytlRupr7j5xTxqAvaCqTymPkyagiNhvGyHrpydNScwFKLihuwRQEwYXx/6IaKB5Es4PC
	UPNElDyjCVntQXH72gpoe9FE7r/tgRymtl6RAnQWA0JO37DmNnHsR+V3PM9kRXKSAHELYvLH9s7
	jZclOvZcP1S9pGRz6KeAsoW/BWG1H99t42y3nehNGTUjufCWFiFl7Qggs6SD7uAc5tnymIYaNIQ
	0NUDSkagXYGaBF9cLnVzlPqb6T0EeIr+9wqvERQjFT3mxZW+/8ofU0bMKmoCwHlpb8y53nNz+NS
	Xsx4tW0SVhZn4HNENbcpSEK0XPm35tqA4ruyBOteHvn2ziPw3V8QkXrLtIEW7FZ8St68=
X-Received: by 2002:a05:620a:448b:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6ca44aa9dmr674464985a.9.1769014352487;
        Wed, 21 Jan 2026 08:52:32 -0800 (PST)
X-Received: by 2002:a05:620a:448b:b0:8b2:e177:fb18 with SMTP id af79cd13be357-8c6ca44aa9dmr674462985a.9.1769014352055;
        Wed, 21 Jan 2026 08:52:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc5ecsm15073959a12.16.2026.01.21.08.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:52:30 -0800 (PST)
Message-ID: <48881f0b-be93-4c0b-ae7e-49a404f20232@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 17:52:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmpd: drop stray semicolon
To: Gabor Juhos <j4g8y7@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260121-qcom-rpmpd-semicolon-v1-1-9bbdd9478ba8@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260121-qcom-rpmpd-semicolon-v1-1-9bbdd9478ba8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=69710453 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=BASZtaSSWwGD7eeZ37UA:9 a=QEXdDO2ut3YA:10 a=bDEiuqbIbRIA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 83aRoUjLwt1_3NetkziArCG2d_6IgoYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE0MiBTYWx0ZWRfX7UmT+PxFtuB2
 muVfzbJGXAwJO+FMIyVgm66xoqMLd8MANf32F5JOFb8BqNUz1LKTIU16iZv0A0sUy9OmQbTTMi6
 yI85zv0PHbZBHXqqS6CMcQoSNulwc0/WhA5RJpBimnOerpV3xmpssu4/FPB0Nido2h2c1ymnkkp
 3Om2HjTxzT8o6QZ8ppmnQA+znXwcb98Ribs84C1rEEw3Su72lvgeHuPP8Z0LHR2uxdnvuSxTQPl
 OL8mL0GuyBFf2Q6F8DQG6DSUwRv4DoV2InwDVD/tA2uWlIRFvFDlL9o82hOLv0gasMH+a73Ftkc
 /p6nW5MBS3YBJ4qutH2rJ+1LTl5tsYsLoDqSbnr9oyVKruppbPHdc89yS2clqy7Sj5VUWbNjAkH
 bqOguU4DgbA0P6LpQdDGowDZDTrkP1XsK4WxMmG2t9mywd6a7RAfZQDL8lTAytCmhhart7u7jG0
 7BH8OhhceczH0IjcdKA==
X-Proofpoint-ORIG-GUID: 83aRoUjLwt1_3NetkziArCG2d_6IgoYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210142
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41242-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 436FE5A848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 5:18 PM, Gabor Juhos wrote:
> Drop the unnecessary semicolon after the rpmpd_send_corner()
> function's declaration.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


