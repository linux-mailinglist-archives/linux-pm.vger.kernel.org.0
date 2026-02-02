Return-Path: <linux-pm+bounces-41891-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJdbC5F3gGne8gIAu9opvQ
	(envelope-from <linux-pm+bounces-41891-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:08:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4ECA904
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E95A303D9CB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8576356A2A;
	Mon,  2 Feb 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WWWd6cfV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVh+sl3x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528B3563FD
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026652; cv=none; b=nHkckzH7vdITpy0yKRtI1K3JUWG5PZYOMPcx+1iDnDMy61V+MtTcPawAdLjOko3bu25kN6Q/xaSy82m8iRL/Hxw7aZF2I+RqxB6WwxQ/98WJMacRq9JC6uxOsx+ImmwVzDsCrS53OtJMtiVxfMELZdCtoxWrx7JjOhSXpsypQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026652; c=relaxed/simple;
	bh=L1rHivF6NBN0lD3cnyGkyngQEuYOKTLHrhI4xu2xf8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcYrECnlduaco3Y95rXelPPjLghOS//x/4ARHoC4iPsTwwa34CyDCkoZYpWxZBvsTJ/jwa5WwTn7BWaXEIScKY6GJN63OFfyqnZC+NuGBYDNKDoT8OqrxwUyIjP+k8GasaqWWRcdELrhgjpdopQoBBkIl7tShbvsiuAIywMTQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWWd6cfV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kVh+sl3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61285bqH582712
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kbYmq9la43Ch7Tu6ofM3MTDu6ZiuUveyMm3+/gY6fH8=; b=WWWd6cfVNanH3dy2
	orfJK+gfTsIc3Yao7eMqWaOKPwn9GwVMQTDRHBBtoHYJXvklyBXxqZVRCYNbLo45
	JWDPl0zuTVcoxDwds+fzYgwkVqaU+VgwaTCqzKiVfIpWzLbIfqeBFK7Jwnh1cR+e
	kR5RnahhJL/EJ0bYZP4pmMUWpehOF4V94O2rGUj1YAOsIjKSrbbih7obloXflp7m
	iRCJkiKNwRAV5lN548PVW32GnQA91dCTNAQdFjNSg+585c8Lr65IpQXfwvxVbsCp
	zsCTQUN1r6LM+zN34nAn+9uTdCNxG9Q4/o8jxxev+PKWyBLE0NLaU41SPeMFXZ7Q
	vmctTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arecx7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:04:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88887682068so13019866d6.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026649; x=1770631449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbYmq9la43Ch7Tu6ofM3MTDu6ZiuUveyMm3+/gY6fH8=;
        b=kVh+sl3xxHqT3cNPpft+KMV8CKay6wQjaV6Peg/kT2s6SddIygZ4eK0ssshy7byPla
         g5m5bOl/mUsxX05NAnU64MSIejIY3wk1CPyyhYrl0MAPe4lMYfLq7OIXZ+1i9MRr4ArK
         ESPFWIXRdgCIFGZRV1EytjjwcMnQrUZtLrzIJKYWIEYqTmvcTHsq3hhjtmVMo+U0J13u
         l8IPnPrmZGq8DLF2/syh6ZTRGl5iUqWddQ+8OXqmPGv/r1kZVq03dkAnxcWHbjwks/cm
         E3TfFozm0NaHXDdTlJkUHZHAAuR8bn5l7ig1nPdzHck3QuXIv/EtfpuJPTsAlo0VHYk7
         43ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026649; x=1770631449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbYmq9la43Ch7Tu6ofM3MTDu6ZiuUveyMm3+/gY6fH8=;
        b=cXXr2Eo1A4GzoUNrCu+gm3ksiKZg9KPMNV5RcVfXi4ehthLBwp1rlyJjLsiYI4Rr6u
         dZDFtTYihYs90yBxB53kDci9f2U8p3uMxntciSBLoH9ZxWUMcPHuEowfntaX7xUEBH6b
         AH9hn4pPwd85yfBZQmJ81tWIoFZKSrLY+PlxMm7egyjCxJNBTWvTgpyZNjncKQJiyY7V
         4OoKInUKT9gre7DIFv4NRN0AybK5vR9CRBvZdpYjgmkDD/B389yJjgxP70F45hMFoTsG
         0gfZxR9++kZlg6YADZs793p6iWx4fbs1uJriGu+X9ZHXjhk/jZZXketkBTsU3+rPQwlP
         9wlA==
X-Forwarded-Encrypted: i=1; AJvYcCXTOEGvG59ydanCLMXDls5l+cH3nyrCvLQt7VGr0FBUAPcLPgqCbRfhgKHTaCxv4xA9MNmyYCifQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiTndKQBPhM7jpO7h+OiiedRp9MY5M2F35q8D51JucsGVNOK3
	XFIEpATIPYzpnH4WS7kTTDwE/08TJm08pQOzkEDW4rKE7d9QiW8RmTO/yWGxm/XjCjoUCWI9IwN
	L+eVEcvdL9PacVJy7UoQU70hk/UCJPwQzvMr2dk1K4nT9JgYQ5JKZJ0oVK2VhwQ==
X-Gm-Gg: AZuq6aKERAjSEpDwNbUiWgnvJFeee9TxDsf0hwFRw20m9F/TsHRx1izMH9H6bwmI3HC
	ekyZNTuPcJwhPo75oSj447KCG+pFFsYDNo3S6J7Cj2gtdFMGz0+UdxM2xTQEFTtoNXONmZcgjxO
	UUSXdFkEd1O7xOMrUoIwY6CykOp0Q2OqgL5fxMpaYY/kee7Q2nZWsumg6bEpE7L0TbSjFbHVHRu
	bkAaB1eVMo9nFo0svyQJ2qXNurhHcx4/aaFzsVP+qHJRLm5JnptXfjWfeB/NbKNn4rEGsHm9+Nv
	xoSCWsJ8ZiqoOJXgVaEN/v2IcYakTQCh0lqkv+Ugj6ktkwWr9SGmy2GMyMoxE1g/tSPHb4eo3RP
	ww6T3Z4elQLT0qyBdaLEpgcOZsvtO33vyvWxg96mjtAOEwXdsl7oeSyHCZXWmpQ4kX5Q=
X-Received: by 2002:a05:6214:4c89:b0:894:9d19:d632 with SMTP id 6a1803df08f44-894ea10d5bfmr93866326d6.6.1770026649356;
        Mon, 02 Feb 2026 02:04:09 -0800 (PST)
X-Received: by 2002:a05:6214:4c89:b0:894:9d19:d632 with SMTP id 6a1803df08f44-894ea10d5bfmr93865826d6.6.1770026648930;
        Mon, 02 Feb 2026 02:04:08 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4452e73sm7211223a12.11.2026.02.02.02.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:04:07 -0800 (PST)
Message-ID: <32c68db0-8798-43ec-b875-563957053154@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:04:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sort out Iris power domains
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
 <20260201-iris-venus-fix-sm8250-v2-7-6f40d2605c89@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-7-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NNfYOk6g c=1 sm=1 tr=0 ts=6980769a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=K8E2y3tpqAm5I2OsxKoA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: G_OCRT-ss0XUXFIY30DHOVQZpeTFLfUr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX2de2NtZHK9sS
 jXnydisf1pHUbSLLLdSJ/hokqfxpsTA65hEnWAmrRMNHDogB+H8gwx4bXD8FtrIAwKADg2E5A1F
 2IE2nbJatfdlBRdZWPiJ64cYy8y5g4OeNEYa/LxLDFZg8tLlVciVXMcewJpI6tLcYuae15znbk8
 MyO6l7/bo9lNgfzojIPaBvCB838rAUJfhEbnKPQl8n8uS7F3/WSewLyjf1/YKbXbiGDGg/1RqqY
 3jIENiPMApOcJ1DRkJJfBCaVkfwxOAdebF4cnOaAnll9c2VJE3XZ4mFXY+XFRx3OXtaXR2es/JE
 DdccuroK2CFueu/K4ayuFRglkTkNpLIZe+jxeGBLtKyTmRROnwFXvF9kWVesKUftJIouVun45ML
 /I23814gxb25qtOTgD6G3mOwwk+esrsIQmGuFKBq4vdwR40h2dMIK8qynercRrggJhhfFxQ/s1Y
 iN8XFb775vL6VQ1RdHQ==
X-Proofpoint-ORIG-GUID: G_OCRT-ss0XUXFIY30DHOVQZpeTFLfUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41891-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7BA4ECA904
X-Rspamd-Action: no action

On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
> On SM8250 Iris core requires two power rails to function, MX (for PLLs)
> and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
> qcom: sm8250: Add venus DT node") added only MX power rail, but,
> strangely enough, using MMCX voltage levels.
> 
> Add MMCX domain together with the (more correct) MX OPP levels.
> 
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

