Return-Path: <linux-pm+bounces-42119-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BiFhNz41hGlB1AMAu9opvQ
	(envelope-from <linux-pm+bounces-42119-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:14:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72AEEF66
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 07:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC6943010B84
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 06:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF9434EEE9;
	Thu,  5 Feb 2026 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VxVqCf7v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sd++JIVu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2FA34D393
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272057; cv=none; b=LGehzAYlPhN/pw8eQamWDuVPEgsLK7Ad9F9SBld/3kx64aQgKebO8Zkydfu3Wf/F7tjMqtn3VOjaBx5dEuvE1WD/d2nDtQH7hYZDIlhSsZhB2Dlxcp93Uf8mLoHRu8e2VYmx8zEsEJkEi8IO55T1la2WraOxTFRkG2iDm24Yu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272057; c=relaxed/simple;
	bh=OJf6f8Taxi6QOEgmlhsRr+6m2MXOdVQieZQ11md0xFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms/6geFuBmomGWo6wXbSmpGda4VIwZKK5qg7zr9LvQQF6LjAfHGBDd1l08GUKJkBfllQv5ZAYUv4hmnjRIw4ipM8ABnpNzkCVjbA0pDRwt0Zf4Q2UClhesaiDCd/hzSCwSTW/LGG46AWwGoNKnhMHwGTXJ40u+q39nstbn0oakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VxVqCf7v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sd++JIVu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153ec6h2074967
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 06:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Km482aLxNMQP2TLDNx1rI3KOJm90y9ROgBYYRaL9njM=; b=VxVqCf7vyqXfIWZs
	PmaSMG7Y/zv9/TlOdZiAMiwLAncIXDSSmZHiQ9xhA7oehdY1TiIIKGceldkFePk1
	1xLkDeVd/9hwMFXDQwA2VDMjIDHzQiDCe2UYqzmffXr8kA2VI+ciDGMCZbQKj4z2
	34pI0WaWlbPPpTcJ1G8YmRL5vGd2p21wW+20DX2Q5+BEJAV8Mx9JISzCI+CitMqN
	WbVdE4mugNQZXcdWiSbp00/TLEG3qaydHylLJNGvbaPKG6X2/zLMx1whCGqolbmn
	yndFzPgcTGXddBjI+I3SwonK5Fg17pxux0zcTstkKGvW20nFVR/SfuGl6LmYMN4T
	X+7hvw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c44kbk7r6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 06:14:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c63597a63a6so351890a12.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770272055; x=1770876855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Km482aLxNMQP2TLDNx1rI3KOJm90y9ROgBYYRaL9njM=;
        b=Sd++JIVuXm3GzVj/kBJzulTSSx2OrVJlSHQ0ai05tDvsxgUbN2y+wHd+gUsMfgl0ly
         f+HsosNVYQvV2yYRDxtE/2E76i3ivvKgg/v8USXstP/kYb1o25oOnH3sZR0U4mxG2qBS
         BctW+CedwLBbbwvvDnetd+p3MLCyCp5VSJZU7j8jD1RZp9ilzah85CQb765EYOpUJihs
         1ojKtp9aTS22zglHhx4UfjczDcDUPJtJMk3A2s9+aMW0kztn4+nlDNa4hSnR0c/K6b2/
         q8pMu2123AxHZhoNYGT9lBZiBgTHOCvNGenm5lte2moshxKi64+CxLQMKfZOI+6P/Y3v
         HVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770272055; x=1770876855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Km482aLxNMQP2TLDNx1rI3KOJm90y9ROgBYYRaL9njM=;
        b=otPm19jIXxMI9F+6vjxGiNC7OW00f4xW+5gnnyS8yW4ECX6OqX2suGoTKMdM8po9MY
         9rq/qnAriUKvh6fqh2p/M/QQvLhDuqa3Njc4n9ewoAk6s2hOlHAYfZLouaQnC08sx9TZ
         Kx4waLm7bGnsAXhmU3LAXeDWDBENz4GN3K82jaGPlpxFvKrIXSoyOcMbyPwYwG92w7eO
         wN8kT0XvZsarDeHDqYjV9hW+XyYEu4hCAqF93tRlLcdgWrm0UWkSjypu/OzMAnzDu1wn
         9PMsbICuUKU35O32/FSQsp1RhuU3+S4iUHvkX1FEv8CX+CpI+wkEPKUqv8MlIXaJeTrR
         ZnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8Qr8JGzQ0R52RhNxTj9sWgq7F67bBUjdzXv9Aj77c87ge1wp7+r7LgyIxIpRyVgHfkpnqegneg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpU8VDlFZcsNmuRcTqPQtmS37ACrUpwP1Lj3q0uyvPjEX3/WmQ
	CBKJDX7FWM30+gpyxAm0mUnc2VaRv9Moz9xpeMElT0N2tlSfw/TXW3Zs0EwJXZP7kJATiHXoQHD
	p8F2UTzrL5EIViq0LDCPocBk6JerAQ9rquL9CcM0d45WCXDsLH8Hh63qozpk4rA==
X-Gm-Gg: AZuq6aIe8lRMVN2pWhSnyqR2hvykbgeLqhHnsL3WnDtbpg+o2gAlUpr9rOoK5k32Ct8
	9KCA9Q5iisXtKUgXlyytk9VT5kB9syM+KCsLExFaKsHyEzWlyJIERPWb8lpw7ScHjjCCtw0Bm8y
	MpBgyJf+fjverMeTKNDMQuQ48hvWIM6mOIdsCXsRwF+vG4cxqtCM7+ViXKPufm/8/NxV8du5GwL
	9Z197nBKjFdyUhywz2Qvnb5FjOdKm+D5U54Xm2kttm9SbNGh22sE047ftWZ7WMW+Ac6rTNjAyon
	VdxQBbgBGPN8Mbqd6EVwcL8jJg5YPX8bWrCa9W6KHx+XCUterTdBeoKQpUB/GMzco1iTo/4/OgV
	9+Mx3I7E6nIDAgzD/08mQAUI2whe/FWigQPcg00lmOQ==
X-Received: by 2002:a05:6a00:1253:b0:81e:5d52:53b8 with SMTP id d2e1a72fcca58-8241c719536mr4673867b3a.50.1770272055434;
        Wed, 04 Feb 2026 22:14:15 -0800 (PST)
X-Received: by 2002:a05:6a00:1253:b0:81e:5d52:53b8 with SMTP id d2e1a72fcca58-8241c719536mr4673833b3a.50.1770272054908;
        Wed, 04 Feb 2026 22:14:14 -0800 (PST)
Received: from [10.0.0.3] ([106.222.231.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4af780sm4291642b3a.67.2026.02.04.22.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 22:14:14 -0800 (PST)
Message-ID: <0dbcc8f5-d86c-347b-0289-ae87587f2e2f@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 11:44:05 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/7] media: venus: scale MMCX power domain on SM8250
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
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-4-70fa68e57f96@oss.qualcomm.com>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-4-70fa68e57f96@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8ImklonWUxyEij4jSYk5YfhFy-ZX0Xnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA0MiBTYWx0ZWRfX5l74p8AsLhgJ
 SAYIo6p9bp8YE622etQnu4vs/I+pwV8Sp6RRoEKUc0mXzG2QMpCO9cx/28hMLdJrLvP6NJ8IkkV
 QxeNwvgrmrk6aMFO8minbtWyeBy1XANCWYzuKAMxxgWutRp3EvkXtdgQtcS9jqeoOKS08TQwGD7
 JMBZ6SlEVqUnraGRBYUU7GvSnBPKYFQfU0aan6uGI06fmSTsiZEdJ9ZsBq+JGQjWWCYTApKRhgx
 EedsZpNqaegUvMGDOu1pE3HYR22G7hYRDeIa3KIqXXw4xHmYH6ZGyqLmkjrg2MJxR8QhPUQJOSY
 JfxEFyFiJVCayHaZQq2AoVqXSliRj6fk4qRKbAstKU2i9Jay8jrJREHr00qswM8t6eDAIPvDEZg
 UWGwblHlhYKXxVPDXcE13R5ks83AOyMHo5SguIHcivIQ5xFjvmtZpprTPOTxmZwSu9+ZizUQIVZ
 ACONN4GnZdMiXKAClMw==
X-Proofpoint-GUID: 8ImklonWUxyEij4jSYk5YfhFy-ZX0Xnv
X-Authority-Analysis: v=2.4 cv=HN7O14tv c=1 sm=1 tr=0 ts=69843538 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b1PTopwMF4WvgfXJboyTWQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=KVxuT0oUQXmADOqZyMkA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050042
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42119-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E72AEEF66
X-Rspamd-Action: no action



On 2/4/2026 6:29 AM, Dmitry Baryshkov wrote:
> On SM8250 most of the video clocks are powered by the MMCX domain, while
> the PLL is powered on by the MX domain. Extend the driver to support
> scaling both power domains, while keeping compatibility with the
> existing DTs, which define only the MX domain.
> 
> Fixes: 0aeabfa29a9c ("media: venus: core: add sm8250 DT compatible and resource data")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/core.c       | 7 ++++++-
>  drivers/media/platform/qcom/venus/core.h       | 1 +
>  drivers/media/platform/qcom/venus/pm_helpers.c | 8 +++++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

