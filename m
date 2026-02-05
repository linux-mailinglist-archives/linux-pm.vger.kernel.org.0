Return-Path: <linux-pm+bounces-42125-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJypHkBihGng2gMAu9opvQ
	(envelope-from <linux-pm+bounces-42125-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:26:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5FF0A5F
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605D230EC05A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE0936EAA7;
	Thu,  5 Feb 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+xHztOu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjNz4igr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8973624B1
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282621; cv=none; b=OlrKNNDDdLIcEfwi1VVmUUZN4ijgeA0u7+ASLFc7FvBuqZ6hVRlV7/grCCxbTVXHK6KSGcQB4BOm+CTycMHoJYyvAiipvIia8shklJelcPdGbIQzPI7Q/TYAOplk0fyWMf0bFy9qnEZNcYvVaZyfnpv+Q0gYLng6w/PPA8mmY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282621; c=relaxed/simple;
	bh=J2fyxizp0gxgY9v25dFNE2aqa+rNAOoNMdBRDI/c57g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/dx0Z5hiLMWDRAgqnfqqp9GSpSopfdPaqvbVyZt7D/LtIN398GRnDn/Kw6PmEcQPvQ5u+Bddz1bmjzdLH53pfslW9t4tYWMRRVLpa1YdW+b5hAtJkGT/rRZL3TgG+9QrFD5/zdW9S9RCyCxNP55gITmHALFmlcyPQGLgOYe8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+xHztOu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GjNz4igr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6157Mb7o890171
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 09:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOBUWSZfBN3uTZONHP9txNcZM555pQKMxMWdmZy2n9o=; b=Y+xHztOu2Zemu8OJ
	Ge6MWc2V7DWtdaGQaPm9tIHZzIbu6pVHitwuckoJ1ZGkf+V0jSE3MFN9lYZ/ljwT
	P9MLCkTk+xWiZinZvPdz9h/DQlKBch1bLNArEqQZTeDmJpjM7JF48yI8OeKLgJuP
	4+Iq7y7Nf1/rSb+qEnEPMl9xCmNVHwewAMNg5bbqypzVKQ3catocBbPcNomNzre5
	XIluk2DajnX5hNZj+Phvs2Q3V1u5ZkP3xx6fMak51AMcQ3vuKqxZ+n/x2k6TOQid
	Ke2c6UB7QVdF2o6V9H8Degq/RQ5Zcn4N5+v5Jfrq9i1fmHVkvXAJikfiduU9SWu7
	SngJvQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4prx8ax4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 09:10:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2fdf3a190so8310285a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770282620; x=1770887420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOBUWSZfBN3uTZONHP9txNcZM555pQKMxMWdmZy2n9o=;
        b=GjNz4igrzdH8OXmHU5seivYKh+tAo3Q7LZQBo7SS8Q9oQE65cjf5W2kFyL1VK7Ij4t
         c4OWAk7HXBQs1QIuSp92lt+liwke9vI4G8S8isO+5+3hTMLqEnPQiILDXIcmoA+qfCOU
         8PqassCK/ChRsOGJK+1i9aIK7/sMWvlsihKeaqNu71NdbjeFiTKw54EjUWXIT2ILHql9
         BS671HX9pwYqeW8sqB7UHMacyXhVfT+be2Qnw0NWLKVXV9dK5rNAiNjaKhN3HL0DYKfU
         b5UXXMmmgLwWbYSl+qXAIin8wP7tggUVdrlvWD6CqnliqV9kDABe5Mqt8ktJfUZNJsEZ
         7nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770282620; x=1770887420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOBUWSZfBN3uTZONHP9txNcZM555pQKMxMWdmZy2n9o=;
        b=mLc283XRRPUsC1KKpLWJ+Nm7GQBB+6Y0+95Ey8Utndtj3hEaT/G5UEum3b164zDWwL
         sTx5GQ6SAKnVJUVddta/zpO6rZtUrowgGZ5UEonWKIZhCta1xLg9ARHaySF4PoM19PXy
         tAI9qXnPW6MjsQHgJA2VygmoAwCVoh9ssM/NZnBhncHNegKezmqPg5XfM3ge6twECwl0
         DtI8D+YljqBjGMtZQfLF0EbgrEhgdZ2E7iq9sRAaloa1S3TxF5UbxwmxpMUwuxGSvkPu
         4QWYUdTU579heJMSSvnnTy04ufVYQ+lwpj0Wkr3sW59c2aoi+t9pe1wiXV5iN5Nh0977
         RhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzO9MOjZGfHwXjnSNWy4Cy6yYWovOhByw3HnKLEwzx7z0AAPfj50tXVwhvgE33Sc7ovUFUfZKsjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWY75Uj6ds3qRuHTPH24N52vJ1bGgkv1RGJUOUnWYIouagdtDA
	D5IPMnKwWvmD3V9RvOEO3r3wDSeye5i157+FyuMPyGrSbtnHR16m/YSgeGYGXa4Y2JOxP87K3Zu
	Y7izY2qPMM4kyqrKFEZiNaqLwE4L/ekEhxShFNHa6AyImwBGt9f2vnA4M+zZgNQ==
X-Gm-Gg: AZuq6aJ8c4bSaEXetcDtpCO9xQPbs/OloXibMCgb93SBZixiV6K9hfzCDw43fZZ0Bsn
	HcXQNlJv3AB1vmpKrm4QXu1SzD4mFWNKURwrAIzohU8zNbn8EDBlaybzoB315mTcgUeqen0GLt5
	7W0ndyrmCK4KnatPIDFuNco5bJjpskghBf6ZufsEeCkoLx9bREAAqqxRLw9MVBub536Jp2OY/Tr
	4+TlqOpJBRyFIYG10KI0Ti4ZJT3ClQNunvM2VZP5h6F9b9PUq4aHgkcJeDT5yZ1j8IvlDnY9OUB
	sBMBkcyw7GqJ+wMVFbw6T07Y9y6IZHyF90HnbjQ3bdWHlfdcQQTh/zNAsZ6pQy8xMU3Tf6NEc4s
	eTcld0MLCqaJGOYHKJcBDylRqytW7Ol1wEpna3nV6kZs6ltQAQVxQg+e5G41FKksX5JE=
X-Received: by 2002:a05:620a:3193:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8ca2f9c4d4emr526862185a.9.1770282619717;
        Thu, 05 Feb 2026 01:10:19 -0800 (PST)
X-Received: by 2002:a05:620a:3193:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8ca2f9c4d4emr526860185a.9.1770282619268;
        Thu, 05 Feb 2026 01:10:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd75d2sm210270466b.3.2026.02.05.01.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 01:10:18 -0800 (PST)
Message-ID: <e8ee4123-b94b-4d7f-b7ae-55e02c18154f@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 10:10:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: qcs615: enable QoS configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
 <20260202070534.1281652-3-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202070534.1281652-3-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nF1OlXAOVVVGzJnM6T6OaUIk54xsRiBh
X-Proofpoint-ORIG-GUID: nF1OlXAOVVVGzJnM6T6OaUIk54xsRiBh
X-Authority-Analysis: v=2.4 cv=eLkeTXp1 c=1 sm=1 tr=0 ts=69845e7c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WrDRg_0m88nTcLYVVW0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA2NSBTYWx0ZWRfX/14IXGZz3UNp
 jVrG8RUTlbUbKzEiYJJAUDNIn1oP47XGW8qQ7Pd/bjrAeXnag+vsXtvikxQogO+qEvY3TT90deb
 3LgM7/y9RrnB4cAlKrMa/8tlSnbMxz2eeD8JyoLYm+KrjgEHqUwPARs5L/+04/6prf70FPC1uuq
 ghVlVV2eF3NbNaFfnOggJ2GTHglxGyLBmkSwx596hsbtlNgiWEdxXFFtKwbPrnVjyf9diZtLgGu
 tZ6wZYs24k4cE437aR24C4Q+qMMJ3YWAA+7ohfJE3LZ5riNzmkft4MgB6yR3n+Hx8q5M6QMfJgE
 jJUbuSN8aZwalfudAMaHSBErHpP24PEdSdiGMeT8DCRve4mX8P/NKnJXi3q4lcDy3o8Zmu2pDV4
 0JmAukC8myAtYULzfURb/qnomDT/ZW1EBKAKEuKgrk5xC8/xMDH+z6h4e/mOjIJbebogO64x+J/
 w8Gs1HJ7Qj9N337ysDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-42125-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 06D5FF0A5F
X-Rspamd-Action: no action

On 2/2/26 8:05 AM, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

