Return-Path: <linux-pm+bounces-41940-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEoPBDC8gWm7JAMAu9opvQ
	(envelope-from <linux-pm+bounces-41940-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:13:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46018D6A34
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DE33075F8D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A96396B70;
	Tue,  3 Feb 2026 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtfecnF7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D60oRpno"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211C7260F
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109759; cv=none; b=brem8o5Eqvq57kptNHHG0RcBg0GrcEndjDLDpfUmFMiHS3Did2mJxPnkfk+jqOk4JXB84jvRWyjDC5j4OeRrff/+PrIe5TYJZC1XqNvT0FtFLQJJeRAJoDbndqBT7Iz9bOkrasdK2riDAPoRHoN4/kyCHPtRjjfo5kpKgCQdVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109759; c=relaxed/simple;
	bh=RbnNXqqnHRQty5lgihCl7aAK8zsm6/eeHNN3+SXXnnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWt7eA/lLKYoi7A5BxW+F2Z/BKj0IW6O9Z6aUyCpvYPYjt9PsSMUAj5P28gFrJ7aqtSIsnfjUJQQBYFSPSEF5CMYN+uUJJykEGSjeqP4ZET8m4In604O90cqJWSeQdOQZ6DflRboHaevA71b0dO37ArBx0MILIwgMg7ISp+ILrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtfecnF7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D60oRpno; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6136REb1278058
	for <linux-pm@vger.kernel.org>; Tue, 3 Feb 2026 09:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	128vGHTQSDAOeGqPmCzaWsYzKlabB8tkqK5y6Wcp4Nw=; b=XtfecnF7b6lSPT1m
	Al4z+2S+cRWod1cTVYfLGdrIi3mjdNBnLxfJhRTY7xyoog38AUtwFfVCS4lTvzNQ
	v1Vxn9XbKF+jjOIBgGfoP4q/v8egm+tBWW+5cEPi6qexdpYczhnudkmF1NMH1Wyv
	WeejUw431yxYLAL3wPOCSPD0qForMCau2vwDCx4Y9XB3jJ7jXqmvFU8SSYwnwOQi
	5xCX5eDmgXk5EDhFoKVgVm4+knF4DfFdafZsSGEf93M9iAipt2QLnRDmw7+rq0ea
	KUmIYp5BBiiJs2zhwnjrq5DH7glBfj5zfCWiFNWoQFT+PKx5RT9GH52TAYjVSiiA
	sfJezQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c32s3a0en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 09:09:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-894a207e7cdso13268356d6.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770109756; x=1770714556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=128vGHTQSDAOeGqPmCzaWsYzKlabB8tkqK5y6Wcp4Nw=;
        b=D60oRpnoBnIAqHRvuEKuscbO1993nORDKwbF1EDYFrEJq2dcBkqEIKsWX3J+rhV39Q
         AWg75JrSKcOtxdsGn4I+2ZaZ26bMENP1IF2qqAwejYSEnj3py7cqr2ra8wxm2qZ7IL4X
         m4NqcrG7b3XAeTBxQVMGKEy6S1iqADe0T9T8XE6Ecp5bZo+PJv00Tun4sbj31FPfRDqZ
         NmqrMs1bUmHUl3s1O4PwhubiX6/LlEsIiCR7/OxGovpFXM7ZUharwBcFdH1kZMNZ10FI
         eNBtwXtUKE2HAp7WTDQxdzMQhpkGa64UPoSKLO3CYm5adtZ2ZWcR4R6j9T2DZCuhYEKw
         jZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109756; x=1770714556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=128vGHTQSDAOeGqPmCzaWsYzKlabB8tkqK5y6Wcp4Nw=;
        b=jPvFc/7HxjP71Htctgf2v9rUBwoeYElZDSJ/vnhyW12Ps/PI/i8IYjsgJfgARl2qdl
         c84wxZGK+gkA+oktfhkPqdqgAlrUUcYVV5ToVOgl8nBqzGanVIBGjNjxEXVnzpT1z5Ks
         rUPTesXbldTvGutlxByQoSNiIJydBoqRjZvmilEUI/CRiTHBviWqNzl9JuInyow5y84A
         oj8XQmB8XOl7IxVfkSN059IYF+Uki97XhXRJODNo9bSxl65XZrtTuN039xuqNEiZTdCs
         7BhcJ7G6JaisAqM9NlwvWAlv5u9wn1gxIBqrS8tGFuQGbSPA1XWpRu7ixbizNm82Bdt4
         ek+w==
X-Forwarded-Encrypted: i=1; AJvYcCUOwN8INHQGoJ6xFQvkYZ+qpWrFkxpwVA0ZHV0Y6Ocna+JCxxD/Mr17svORhOXl5Eofpyz4bGrsIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDocUU1Cq05xmrJUGbOAx668NYUzFIAi/NwlRFNeZF8qpJ6T8
	VXHpbRcJUfReXWLyREA3qEYc0S99xAi3vbOF23Qvd/WwP7KgbAMfC4o2uDhyzE+t8nvT7elEQpy
	n5S2YqODouU5ewC9s+AR0towmCTTs0cM6clJJ8ic5AlIC30/YaiJSaSPGLg4ePA==
X-Gm-Gg: AZuq6aJOrFxJpIrAyrzXenyr8nTEXSw0w5DbXHR737JEQIMbEO+Rb3qK37d0UUO5n8Z
	rGVjpxepey4Uf9wgKRYBafJduD04Xa1Y6bZBToDEYOp2NDKgHfT6eyKx/fYvmJSTubeKR+CdPpj
	yyOFNZel2Hh1TWNbgF2KcC8tVSKM5WxgL1htQQv0mFbekUdjbz48iFx4MyzI7HPQO7JZE54i0hd
	af75X1yED/cKfot3mNU4TaW4wGkIZnY38hXOvR/tsu+e1LTgufsc+F9/C39HPlUKFPtmTADil5O
	eOb4FmKSrKcg6XPK1vstdZIm5A4TxiXfKbPz8nNixTyjSsGrdXJmaOjHpTOWMhiBGt4P9c/JlYz
	rPsJ/UxsJVEtzg7oNVOTN1HqWmPlW6w6EY0jWx/9VIJ7cZsx67ToqQVqYpKyOB9DtXcU=
X-Received: by 2002:a05:6214:808f:b0:894:e24e:5b8c with SMTP id 6a1803df08f44-894ea02a720mr145594196d6.3.1770109756598;
        Tue, 03 Feb 2026 01:09:16 -0800 (PST)
X-Received: by 2002:a05:6214:808f:b0:894:e24e:5b8c with SMTP id 6a1803df08f44-894ea02a720mr145593966d6.3.1770109756225;
        Tue, 03 Feb 2026 01:09:16 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d0asm9195354a12.18.2026.02.03.01.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:09:15 -0800 (PST)
Message-ID: <6bce3bc1-6833-4701-b8d9-7205cb769a4f@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 10:09:11 +0100
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
X-Authority-Analysis: v=2.4 cv=Zc4Q98VA c=1 sm=1 tr=0 ts=6981bb3d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=K8E2y3tpqAm5I2OsxKoA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: NkzOc92cr22CWw1OS04ibYWdknWG3ikD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3MiBTYWx0ZWRfX1UoVKyg3CftR
 6HcdLcDPKEXH33aqO8MNk9eyGP/wTVEPspa0HsTUvfTT5uYscujrlIiugpJIcXGvDUKYQobnAmS
 cL5aw1SV1dLUEZxCfDLMP1EfVwUIpD+GwaOpmbdLe0RMAims1UUwBccfEvti5C91dYEcK6ZT0Ja
 80genO5Hw10QLtn+zzpw38Nh73qkkpzgP2AmJCy4o+vJTjL7IYZyzfeTqtRmzlZQiWgmyTqDGNt
 EZ/2vegUeLfcmCYChtO7qgFSjjB34NCYCqjKzB4FEhANUL4GEdOd++wFYF0Hss//2od1PhC45+C
 tx0Xy8mpBE87ljlcp8OtKEMBDP9xhIk3jTLPTsOq3eld4vW1UShVsIBuHDnAWQtKB8rghyo4rPn
 rug7HaDKIJSAv56eQQ513VXysKxchySCyFDrnEeDC0UugeB3uWWeVuwXX90ghjZkyPWX0YQcFhl
 nmRTEeK8w58H/dOTtMQ==
X-Proofpoint-GUID: NkzOc92cr22CWw1OS04ibYWdknWG3ikD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030072
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
	TAGGED_FROM(0.00)[bounces-41940-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 46018D6A34
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

I noticed that the subject lacks an '8250'

Konrad

