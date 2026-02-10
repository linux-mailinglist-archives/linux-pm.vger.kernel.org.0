Return-Path: <linux-pm+bounces-42429-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULp1DAcCi2npPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42429-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:01:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC911194F7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C47E306C523
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450C342CB1;
	Tue, 10 Feb 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODOcYK5b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a2oTzW0c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC19342CA1
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717414; cv=none; b=cOWSPqhUKEBsxyus2kYpyoSE71IpjOdf0mkZDubBUnlFR3H+Pv7gVha0FcxJfjxNgA8XX0TD96++eKQyQ+lKItEDLdWyu6XfrihQHMhHzIy9D2HmVG4yPTzpajmyoiqvDlN/KMBraDsThIyG8I7G54U1BHmyyvzgGFEc3tEuImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717414; c=relaxed/simple;
	bh=sv+dnG3zrbqwAxnVlxZli2DpyFtrlVYKm/TvZD68Dqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NidTRHOaD2Xdt0vhqvacxNinfxWoQq9e+x9ArSn+CK+VH0hHKVIn9OSMM17YmgfoQjpkBEav5cf2Z/na01YbSu8TFOth5IPs4j69gtzUw47k6Ho81lE+iVZFpDG2aYsiLWEFLnetTnlOHKefI1tSPXlKhf1kOSvEAOiV8qWP5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODOcYK5b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a2oTzW0c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A9EWm31231999
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	whNOceZZd5faQiSJBPuPpUiY0cxwZFbeiwvoghwTez8=; b=ODOcYK5bvRx732Ie
	L/e3A27V6aPw9rP7bMQa0LnEPjJ8ndkSdU/Zxt7SxJGlwEIc9Lt6LM+8kalYaTBc
	pshZkVtUNG8s+p35IOZDyui2hRTohpT7dr8fMg9MFdoC5KeXs7ejEH9b7Ng7FRnX
	Q4yGTlgA+0F37jM5agkmMBUmIzqsHjmNFCMLZIIUvBa5V/QbhZO71DtAU5eUcrt8
	JcuAN0DHo6EeFBMspSJQHP2rPV9ltcw546U82qEnjp4FTheVbSly5oxKC4U6Dtgt
	hBnKwaaferAhvKzx5zNw3VOMMUqL+rcaQvQZcG8uDAWnJ1zXlQ5RSZYt8wzaSKSS
	uxXaGA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7uv59bwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:56:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70c91c8b0so210625485a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770717412; x=1771322212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whNOceZZd5faQiSJBPuPpUiY0cxwZFbeiwvoghwTez8=;
        b=a2oTzW0cw+LZHxLl6mczhjPUCSiq0MsF3jhVcJ/dlUOHYTLgKsqf8M56wOppY2hJAA
         FLOhcs6rFDG9lMagLXNP5Ba7i4Hr0k5qGKyLUqu/ExeBSlfrjTkbXS+HXhCv7HvZS+ol
         hn/4pbKUxoJlpHQIgA0MWGvGdJJKA1Ap0H2Atbdh9wFfqXdcV57PZ5vRsgvFDWTABl7E
         BRnx83IceGjHO3OjPUYTrnFYqk/i6r1waNSOfAMWh7gc/fDdM4VmmOtDPwFTewj82zwU
         5240J+/9eY7DWTLJMES2MK7Kz9lySlfd0BPZGG/M/4SjrrDwc5vSoIPVOexY5b52W42D
         WVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717412; x=1771322212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whNOceZZd5faQiSJBPuPpUiY0cxwZFbeiwvoghwTez8=;
        b=Lg3pHwLQ+hBix5eiV+EULJrsIICScNYCbm2iPd61khDaqHSWJmqTbod6+DW4m9qnqG
         SFmMNGXdDZ7Awj8n7dTMDqhbcA+f76vcRYEUvTmulVjWNK6dzfXkQqn0n2gfllZn0C/b
         8tA0ersBItieJhGpdM36VQXAkZRIqaEyTAlNhb7v6JRhn/jLFtWLnksdHHF/6EtOYxPO
         qwO0RQl3Gp2JqwVOABLxYguabj+Sb2hU5JZ2sthoR/W/u1ZB/zE4e5qIBNmMWe+JHT1H
         NqMtUyScRhCLRLiBd0LLD6FHDSau6COU6Qrnk6RJLy4C+CV3rxBXBVYI1Al7kF+MquZE
         w6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuFCnaXWIFCPNLJqZrX8o45U7xt0zzocZyPnEHyRQ4HwIvAi3JZZ7LUi7Kgp24QdN7Rv6nSAZuWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WTCq6OoRewgYJ2Hj9vwCEzD5StD5Fmq8F66VesaVoJOOxhee
	0IROoPrkguLh022xPeyn5bbb7TNJ3JOQ0ijvPHZVh6xY8ohVZlTZoKEiEtPWt/ZbjgfalycYvNs
	ykB9GMO4vDeo786pnw4S1w5kQy9U7AY8Yd6bMVIuedlEwA2TUuTgBdr72p6youQ==
X-Gm-Gg: AZuq6aKHke05P5tiBplZiEhafjmCwj8xwMsmXxhTc3MfuBDbdDiTj4zJq7d7bruESDA
	H3yjjzpcumuSFp1DBgj2UGvdGgQUpNTp/NPX5aTnXHJNrs86gSJqe+EFJNar5UveSJywKdAb/Lk
	4A0nZYlFANJMF+ImtxuycqYRE3MTafNYY5tYFHk95YRpofw4lYKy7e1i3q8dGa2qRz3zurwSiTl
	asaU85KHSGmp8zJiFeMUU3+jg9eroj2zi/+DdQ5cmz2lPJO+C5RpEcAWshEAy497rLlYX6cTsWN
	AsM9uaIGLKnLmxpO6sAs1jQ1wZTAhe4XILp6QQCFrfYxcqJeAKhQrcMSlOD0KeDkywRe+lpgd6K
	WcI2MTCd2oj2MkR59A3YKRT0tp/uqUIRiw6XmCUzGNXh5T+AD9IaRkBFz408K8ZmrciQgvouZq1
	Fzv5Y=
X-Received: by 2002:a05:620a:29d0:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8cb1fee5291mr108065785a.3.1770717412017;
        Tue, 10 Feb 2026 01:56:52 -0800 (PST)
X-Received: by 2002:a05:620a:29d0:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8cb1fee5291mr108064485a.3.1770717411578;
        Tue, 10 Feb 2026 01:56:51 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacf1564sm501975566b.52.2026.02.10.01.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:56:50 -0800 (PST)
Message-ID: <b91ea09a-8a3f-4acf-97f9-3ef7e1d35bea@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Allow PMIC4 thermal
 monitor on pm660
To: Richard Acayan <mailingradian@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-2-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210021819.12673-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MyBTYWx0ZWRfX2xZS2urejDJ2
 hX0EtOFPwmTiZ4IaT0Gr3Xt9HtdaMFwzgxYxmYECCc8C1vM2NTXQLqtAfNyvPsuoeT1PnK/wt+B
 odULFbFxzKxnzJmndogCqKWekMFgeWfDEio7kpLOJQH6FQsw1yvacbnQcMtRd2IV+UtAihgqIjD
 C4g0NIWLFaIDA6FJ/CLVmJMHRLTRBNgu+tmCxU1HHC8ajEpB4GeRI18LH+I4F/VvNN7ZC18QQYl
 s6rgYYThibbQIZfMd9NhhGe2ObhbYbQY/scmxst8lDHDwS91uU1kDqCEp4PcY5WUQeVlSSdjIdd
 IdBH5tPZZmPSE73JIS3iWWkcSF21btP5pCvzFRmI5LKyvUBLlZjdctHKsVpt9OYLh7jmASXOgMN
 zi6MuAdbYjZcE349QB0uu131ZSdVy7KBMQrsBlA17OqOTcA0yEQf4s05Dp/bmwyueUNoOdTiF/v
 D552OhLUr4h4fZnGNBA==
X-Authority-Analysis: v=2.4 cv=P+Q3RyAu c=1 sm=1 tr=0 ts=698b00e4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HHRwIaEf9NpPtzNnbr4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gH-0oQh0NS-Fcg-eGYXe7tsq6cZ3mgAk
X-Proofpoint-GUID: gH-0oQh0NS-Fcg-eGYXe7tsq6cZ3mgAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42429-lists,linux-pm=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[qualcomm.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RSPAMD_EMAILBL_FAIL(0.00)[konrad.dybcio.oss.qualcomm.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BDC911194F7
X-Rspamd-Action: no action

On 2/10/26 3:18 AM, Richard Acayan wrote:
> While newer PMICs are compatible with PMIC5 drivers, the PM8998 and
> PM660 are both PMIC4. The PM8998 is allowed to use the PMIC4 thermal
> monitor. Allow it for PM660 as well.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

