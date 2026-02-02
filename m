Return-Path: <linux-pm+bounces-41892-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INzCNk94gGne8gIAu9opvQ
	(envelope-from <linux-pm+bounces-41892-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:11:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97512CA9EF
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CA023030326
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243B357A3D;
	Mon,  2 Feb 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SUloUebv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG31Mx1M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43057357A59
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026698; cv=none; b=lQtQWN2HOHOnrspahFuVWcVYDmXID2Y6Sq22f0vUPlbk/40NrF7kbe7CL5J9+Vi1t0+Akh0P90nRdqN2vGST0anJpaLIguGybkenVX8MAIkjuLnWcYYBMs//x8+Anr2uuvauZnfX1V8HAzjvgCF9kjFMzLbriQsEgelY9WJFKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026698; c=relaxed/simple;
	bh=m+Pz+g1MKmpagp4K1y973dUYQLdMnLtzIyPiHxKzHnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnOYmvTAx1jwvJK0Gl+BKcvaqO8rnI5ugU+2o8q+8/vfls8Yr+wunEiLLDupEU8hfyJD/8R3GXiXWUylUbI0kgJsbpCoRb9lvp8KyLmFEaAlo3hZ/tV9k42t4HSeEpT1eSKZ9IL5hbAtpsHHHjj6VbsU4jpmezBuObCi7/4vRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SUloUebv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG31Mx1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61284vKH570742
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PU4kYGujVwJTzzKhrRzpqzSA4ZPHoHG0oriVI8+8rHo=; b=SUloUebv3I3Nsc6s
	rHuIEYafxQ8lN8YW90y1h3SSvFu0Hjm1mB2v1KP0FZYo6lkyeVFtjkSHwWebo+QW
	HFo7L4nDR2TJgpG3QqIt6SqnhzAZaKsfjYvCuUP6E0q/sVob3W8E1poHt5BAXGfI
	YvI5ViNJbjENJ/bWNhSXpqB0/UDepajHdQCI79br7TMDhd5V3/8K2oaUNeYgdlVy
	0NwESNEBCTjUnEJZtLXJJRsEHkcfNcsRTm7MSnori6KrusBjTlLZp7msy7w4BSPQ
	x9xGZGIjXachV7vMFJ71rjW3fN9vYWpZz2IH6LSQ2BSmuqw5g0H61EFdP5UcR0nt
	1JuuPw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1avx4wk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:04:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c522c44febso92578585a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026696; x=1770631496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PU4kYGujVwJTzzKhrRzpqzSA4ZPHoHG0oriVI8+8rHo=;
        b=LG31Mx1MYTQUNZgdCzr3+jqvI1iypNSn38GobdyTACSf3kvXHZGB3dlbDoFwmXdsrw
         OZYwWDUB45YNJ9+MDf4H1n7gXnU8JnOqYQ6mTvr4RvmBwRUCqIjnCmV/MMxIV/+fskdP
         J45dZi/e2D62YPLyzRjginUtQ1kS68XBvgtzspEakxCeIINe51eeXRKz0+MAdc+DIz+k
         88Ors8gpa87io5szhEzPuwg6Svi5CON3hdCpe7Hh/gGZK5W9Jj7MFgOcfiw7Z53BQlts
         62mLeAUk7d1/F8BUccnRfcBBoRwMn1hWRwKgm5V5mrYN/XI24zodP4RBH61Q+zcpph2Y
         A+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026696; x=1770631496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU4kYGujVwJTzzKhrRzpqzSA4ZPHoHG0oriVI8+8rHo=;
        b=N3VTT3CIJ/QfQJ6SsO1uZIuEfA3AJnbkFLWJyAh/tga2MzTpwG7LktD48w47lvFiXz
         4QK8Eoo4lKJ5hk6VZ2FR/ULCP9sfu3wyS0+Q3t9itB17RWoow48pXy0j00O+3s7v3xGP
         eh/DCWsKMbnpIt2joIpHgsN+2piFuXDjrVW4vJ4ZeD8NvB2jaQHqtYzm39VvXGCMK5xp
         Q3eDQlFGLsGG6C/+MsG7BynjceHWlYhk8Rb0q2T6kmUjJrQ7BBTrpF/6d6RV0HZ7dD/k
         O4Jp/61TKrfWyqFH6t6vsx2W51hom0i+63Scz3DTbHRXJwyhji1DYHVD6X4z3wzIdWX4
         tOOA==
X-Forwarded-Encrypted: i=1; AJvYcCXeRHqO+tuVEmWvn7gIwVcuxAe/FBg+h3O3AtPCtKzs3gw4HK5URivlHoz+J2HhHwHjo/h3yqHpBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5s0IdbWBBBKlZMJq7RDSzvEu7pFJJ5SN9bv0L89vQ/QBZ7tn
	8LtCFLKIQuMGyAQ0b7q2p+3tpGgioazD5wil2JZcPwaqVPeMglOR1oEY3KWlRQEZXSCT4z1RMPC
	J4QDPxoZl1cRXDDZ20KdrGAq2AO4F2am5xh5DaerkQIFp2h0Tab+GJmJErE/eHw==
X-Gm-Gg: AZuq6aIN0lN48nF7W0LVTn/n5/gfBW91Q2WkL+OX+TdBD8l4BLCqJD16A8KzJzUCLE6
	Qul9qDRchYQAIP84nwujoBnfaMTKoKS9A3i2RSlPPxjwnuO6S8hS5xt3kXQ65Y8TEkETdO5oxxG
	OeHd0IX3s1EeZGLcmvWyltYnA0iid18y/86kkPsJa7EReHEXB16/lI7SQGCo/0ALo/y0AAlguHt
	NMSuU+gH/z6LhVMK+L7mlKC6sSdj+a/w8xqEW+qDk5TUqEzZUmO3V0iRaE+wNiSHIkWTouZDoyK
	c+7R+kNFraVgOGmjZOQOzH7b45m1je4YGDnJ6coIupLSVCQR/lF3B3CAUq3eriQ/3EHvoaVF3ei
	K5/efSv86yV2F1TxgE+nYh2fUQxBaYVg6Ntcmu/8MiGaBl/iY5FJRZA8OJTET/hiSEgk=
X-Received: by 2002:a05:620a:4506:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8c9eb27a8camr1050101885a.3.1770026695502;
        Mon, 02 Feb 2026 02:04:55 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8c9eb27a8camr1050098485a.3.1770026695052;
        Mon, 02 Feb 2026 02:04:55 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm854116366b.67.2026.02.02.02.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:04:54 -0800 (PST)
Message-ID: <354670c7-2845-4786-aed9-40b08020c19e@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:04:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
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
 <20260201-iris-venus-fix-sm8250-v2-8-6f40d2605c89@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-8-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: N015yPFFBzc-UzvlLEhqUaAbhBcnqny7
X-Proofpoint-GUID: N015yPFFBzc-UzvlLEhqUaAbhBcnqny7
X-Authority-Analysis: v=2.4 cv=P4w3RyAu c=1 sm=1 tr=0 ts=698076c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rhtRbuhOeWVFly8G_7UA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX/a/J3O+4OZPw
 ABuukH756knBPUJ44pFH7juufYRNy7LNJghiulZDr6T3gYxIB7rJl6YcJTrEDySc0d7tP2e+Lb2
 bOTljRAr0X5FjO1+yavaeOPKmYt6vIDOCt7YT+du+086eQOKqcgp1xTt052NPxyMqFLXA6XR6lS
 8qO35IgxiBgz6MXt1yNKgjmNtuJNzdRL5RBSG66gsmHpDiJ//sy9HjQPAEGZxEy6hhRHS5cwSjo
 1fi9DMrtPKc7/V+oxl/vRvE28w6T/GCrLhBQSZSFgeF1/kJNTL/cq3h0iA4kkNBQT6v1DtJNvko
 DCwbIYiZqiiVilGvEItI6CO/j2K9J5RNm58idq9ksWdHe7ijJsApbMLZ2rlbJmt/PH+4yX+aP1/
 UjJ6ULW8lUACvsCYl6NkkW5S6LtAqAbjUfW2U5dRgDkHrhaIRXTGJ0KsrcHbGMfrRJMcQVnP48s
 WoJSaRRWK7tRI5ERcnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
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
	TAGGED_FROM(0.00)[bounces-41892-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 97512CA9EF
X-Rspamd-Action: no action

On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
> The OPP table for the Iris core is wrong, it copies the VDD table from
> the downstream kernel, but that table is written for the
> video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
> rate setting (which is clk_src divided by 3). Specify correct
> frequencies in the OPP table.
> 
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I guess 'reported' is more fitting for this series

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

