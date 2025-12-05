Return-Path: <linux-pm+bounces-39241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2238CA6F4B
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF50630142DE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DD328277;
	Fri,  5 Dec 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHlDQAiZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MYQzE0Sa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FE311C2C
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927546; cv=none; b=o4ULd0p3tuKFDYOeJNopRlLGBFTESxOE3z80t4yLQUHDhBCq/sSnP2ZKQd5kJcUAY2HITmLI9NlGiAKrmnQCbFzSFTeQm6WsRCttdSA6ery2VsP5sVt7jjhkWqmDMbaNnnJ6WQXIVug+05agnv4FY41BU2tmDLintE/HsOCK7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927546; c=relaxed/simple;
	bh=mSopZ5eSMSVh8uu8bPk4hbVXL2B0I8uYCDh36a0qlaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4y0QYfImfq7UgtjjvQTNBNkEA1WfNAUJMv3SuAPWJfnDeBfBO2xnbbhTY0Bu97zaRfKBhTGmLNdUwLlGuCn8FQim6ZyoH1tU8/YUBMZ2pdCGaeiIDsqlLQCQVlhuP4twA27iwxKfIXZ5NwG6AyD+mH5ve7ci8N6GA/LIDDU4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHlDQAiZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MYQzE0Sa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B52E7ue3194469
	for <linux-pm@vger.kernel.org>; Fri, 5 Dec 2025 09:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jZ0G3AW86K+AdzoPnjH3oCDXKA47sYNZSDUfmg5RO+s=; b=nHlDQAiZ7PCB+J//
	4cIJk23UNa5kAPEC7I41Fq9cKGlLvPMbRmq0ipia6EKfL2Asoj8lHF2uvO1lI4vG
	Q8GrDs0ZKPJQDns232BVLhxcHK0SYTl0Ije0nFv/2qUQkrzxKCBfk9NwepMu9c8i
	gvKgCq2FzYTDde+PKpMg/j8wCAaxgCln4+98NqTY2MUF6tmlVM6DA563LxBBxOeJ
	HBfLp9metvzGjiplh2nXMdE5an2RSeQQ1DI5yWH/GYHp1nGZNNajC2nvahqi8POn
	oLL949eQdSNUFi6S25BeNyFGPbWa2C4aS2zeB01hhuGcT/OYsQyisBcH6UDI1q8N
	vwDBUg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aupe7s2qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 09:38:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ede0bd2154so4779281cf.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764927525; x=1765532325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZ0G3AW86K+AdzoPnjH3oCDXKA47sYNZSDUfmg5RO+s=;
        b=MYQzE0SawAgV5fQh0scrbakKOwChrCpwnBoUY1/C+KQOCXRvzmSxo+bHf9+qccIpud
         ZLRCTNFbPwVkOfc3FfSztb3fpUyAIRraa3gW5pyxlvX2CMxIH9jR4cnUUzd9/Mt5hD5x
         ePnQFnMUOiMPezPivuzIHf+owmvXtUPSTJYVnPYpA9hTjmaVUpuzjIGRuHSJGR9YYzg8
         lUaBm3uylZCKOllLCAaqQ7lpkeytw7mogJiA96WyTt08A0+IAZn3CkgdGTuST4ICDTE+
         QT/Bkw2xDaSEztefv0N2Gu/oZL/ymrEuLb4oBWv8cLykbKv/Ds9kYIKSXxXw7GV1EPch
         HC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764927525; x=1765532325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ0G3AW86K+AdzoPnjH3oCDXKA47sYNZSDUfmg5RO+s=;
        b=mq8fa8MHG5iAO8NVSFeIu15Mq/bU+O4RlZtPwEmR87IeqW4CPz/vvkoZ6Us/Rd6tR8
         nqYl8ERj2fa/IpSS66k6G3HpBh0aNsKGcvTwuWmDZGZzd2SwlRt1dV1IVWNI9bIUdsV/
         SAOoqJ/BNf2yeK3VBY4ZXsg4Xga9/K78xYyuZI7yx1MQuaUo0mPismgLAxmZtaWMpDvN
         w7BwHC3XX4sR1uGpbGMx76nRWFIlRf6ppcCRdFzBziwIkcGap338w49mXxzdw3qMiUXu
         leag39dB4+df1Wt3g4pbqp1ZVoY+sYLnkds9ogyhTUqLQ90JpeGfAA/TyZ2RS4FGLTbF
         R/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG3MNDSWylr6YogsZZxfR2uvzniC0yD8sixafppPvGNgmemUWZdDnlKBiJ3B96+tRvY4YnAd0V/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybso/IKSu9HJCrELJqQ9d85MPbqPzMumuMCkZhnlpD583kKAQ9
	INEJLDaCcl9Vt0TBqJ+OnLjLDs7bLjc1tkog+tUIJx8N23pay2uLceikUL+ssjjFDgry5zmRAos
	YHXL/nG/tHi/33TDbUZpfIF0du9bobVU3CQZ7yfo86P7ayg+hw73SEv5cUnJzAQ==
X-Gm-Gg: ASbGnct1IkR0Fld6b77yJaVi1TpJGuwFFiEgyMFOXE9IQH2STN+7rEMmA9TP7Kj98Uk
	Eu0MV2gyqmvb4cWnS6uVUZDpnkfWt2U05Vtgw5bjJlYG2fU8hC1K2+3XR7q6kfVfykAGDC4YHd7
	GgtovgAVK5iemjoxzNW5tpPXZ/KgcK6mgO1+5zQ/Yd9A1shR7hYmGZFxdLkzC5YKhDRZ15lUOAp
	Lr4kwovxU/QZcAtXD07q/l/+C3l+P8lOXOQaYHq1GeCkiIH0TPVm23NfolABU3/5w192mroKLDf
	QnZ7yo3Gb7lC99/YUDn1/W+0xzHNwdf8VlkvdrKtNhRa7MD/K+dkJIl/Ow4PSMtYNBOkzMSLFJh
	eEQcfWzERh6JlJ4gQHc7IVwhdY9lCqiwoWCuYWMYwqig5MGKlGk8Kyhdl0AE0CX2lSA==
X-Received: by 2002:a05:620a:1985:b0:8b1:a4dd:3d66 with SMTP id af79cd13be357-8b5f8bffce1mr887368385a.1.1764927524590;
        Fri, 05 Dec 2025 01:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzBrsVxpYEbBThA1XLFHeXzcz4UMqBEAYiaqakzQpeNSyG3w9AymeEkalDnuQH+VGWH+ThKw==
X-Received: by 2002:a05:620a:1985:b0:8b1:a4dd:3d66 with SMTP id af79cd13be357-8b5f8bffce1mr887367085a.1.1764927524155;
        Fri, 05 Dec 2025 01:38:44 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49b7177sm323152466b.50.2025.12.05.01.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 01:38:43 -0800 (PST)
Message-ID: <b36de004-25e5-4701-9778-3ae02a1bfa87@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 10:38:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: qcom-nvmem: add sentinel to
 qcom_cpufreq_ipq806x_match_list
To: xiaopeitux@foxmail.com, ansuelsmth@gmail.com, ilia.lin@kernel.org,
        rafael@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
References: <tencent_D85C91225CB9F5A85A2141BD8C4E12E6D009@qq.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <tencent_D85C91225CB9F5A85A2141BD8C4E12E6D009@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ayyXaIyl02dOm5iztlifVYTs8ZevtGMp
X-Authority-Analysis: v=2.4 cv=Uu1u9uwB c=1 sm=1 tr=0 ts=6932a825 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8
 a=NtSJXH4osi7-RDkubBEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-GUID: ayyXaIyl02dOm5iztlifVYTs8ZevtGMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA2OSBTYWx0ZWRfXyqFreDNahG7a
 Td6/IbS7fzTdeRYelVabPZLZXDH8bBO1oBuAQPS218D1Z3Y6GFFjE2j3JS3qdh5OJk1ofvrx7eP
 SjIFgY9aRGBapiVs2NMqydOqXBS1YlAKeWB6dqCmB6giomt7h8X0Ta5RgmdGkA8DbBGcxbVWg8w
 MJVM4wwxGM6qRbSglOYQWO1OJh/ztNBId5/WFHfzpee89Sf3AJAjWCCianZG5powsrRvxPGeRRb
 iubON+fasvdTTIDahFuoUq7Mz+7+51BDPBSeYs6v/QG/+vM+vJZl+jsW13of7QdLFDtphkSNbAB
 TnGnLJU+Y7XZJuGtI3L/bSWyVqO06hJ8NVNpyp84tCmZfjHh4Jt0HUK1B3LaiebXNduaK0oQiut
 szFbjVEU9I5BVUhenQu4h7Klvwydvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_03,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050069

On 12/5/25 7:38 AM, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> The of_device_id table is expected to be NULL-terminated. Without the
> sentinel, the traversal of the array can lead to out-of-bound access,
> causing undefined behavior.
> 
> This adds the missing sentinel to the qcom_cpufreq_ipq806x_match_list
> array.
> 
> Fixes: 58f5d39d5ed8 ("cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---

ouch, thanks for catching that!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

