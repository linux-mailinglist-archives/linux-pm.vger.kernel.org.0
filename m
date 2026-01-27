Return-Path: <linux-pm+bounces-41527-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOMRA6iieGmGrgEAu9opvQ
	(envelope-from <linux-pm+bounces-41527-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:34:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382293A52
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD953029E75
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BB347FED;
	Tue, 27 Jan 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oz1MasjF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S7X5vMV5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F1346E6D
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513613; cv=none; b=QjooNkOyNS71iPKJsXVQt7rGbiord16Ti7iSmcHtQaY4QOS7sA8ACWeyk6/q31gGUQT7KfQGdDF0rbQVZ/BZQU2NOxLeGl26AOo4ZqqnderG35b4h0TQjcn0TRE1DzfTWkDgGAZ2kf645jx4V/7mD0p0+5UARLTt0kdOPe8q2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513613; c=relaxed/simple;
	bh=59jZC3zVM0ODzHrMCPvgBuMQDB3OwB67FU4fWRwKHGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPUxoFDClAOq1dVHaMQq7FsPrko7/GveZnQcjl9JCrDC5Hm07lrjDEHWZpcwLJyp3dl2uVCjt0Q7uODc8Xn7fcx6vUNQNz5sAlJh8s4x4Lul/eNDPylZgGLug6Xm2hVCiTGUpKiNeJWy8yZvC7xm8Hfayr0jiIsxBLm1VCjTego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oz1MasjF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S7X5vMV5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R9rUOX1268745
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=; b=Oz1MasjFcfJ+HzqG
	JG1N6hIvA9asjg/D/B7L6mjOg3AMtntgb3oEwn9VDRXly4Ny/TDS2XSWkENEPe/v
	K4k7KGYiwmp74ip9orB8XMwLYeTV4P0G3EhMLGL39jyFZn91pbEVk3wmBj3+r7i4
	hJrBOFN3+fudWQ5rO5sn6AhOCAyDpekr5w6YiejMDMJ2ZhpbadPyCNkw3IQWjn/J
	EC4GC2xP5cGSJFW3Jb6fVYqi7op29MT9guvx6Tc7mYSioYfl5FdPYYGrSuCh/YsO
	L5e91FpJkkw87U/G2phWnK/fBKtsGzbyo9ECOvhaEMoL++ostFSivf2AU3uH0KzU
	1NwtbQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyasg8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 11:33:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2e518fb75so83517985a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769513610; x=1770118410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=;
        b=S7X5vMV5JW+zmClo8lQwHB4vfVeZlCiWoKZEylEeNjo54v1kH4VgmhQvB+Jd8CCNfz
         Ohe5BEFttEmJWngpeC3+UKC1zSFM/AMf6qvyetD7GPonlZhQD1oEJPjsX5cx8i3dRZfE
         jRPagXgsUX1NcMJJbOPN0VUpvOfoOs1yKCHG2C8Se3i44VY+E3c6quywGB8nIqbNTi+x
         axXwJVhQ7IPhChXHgKB2mgCe2L3HJybOlREgV4vmAxDGebVS0n06YpsZb9ieNfS/7W3y
         huZfVcOaI8soz3dWybVeQcn/ngG1JqIsBH8cZak2uai78YgL2QC58yOFdxrOhTM9b+bj
         5q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513610; x=1770118410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=;
        b=Fs+71+q5GKbNnnrFx6IWKs3bmKBnw+btn2mMDao9JZsn/CK/HxmuwrbPOKDQ9AZPvH
         6hxeUowhBgYGpvuYXYkmWqWZGnbpQ+e1PPILWaGQxtNpvwGvkF7yWB5LvrDZ3YrMTK+D
         lZX3RaIbhUweWq3WFRmT/29s9SUBfOWKEWZPSzkYpcoAPPHAadHtLEdqmYvOK7hngH1W
         W0IMsqyyYqowyiq5uGNsOc60jzp+8J6lq+LufZcvwijVtziGTgUVeGALnLhKps6pN8/n
         5w1RxtU3sR2f+IFeb6FeWyaQNQs91bRZG+FF7iz1d562bBrhxFB5OjolGAzKAWLktDZI
         luEg==
X-Forwarded-Encrypted: i=1; AJvYcCWGH089NHskKqyNprEFYn2VxLLANbJP5lDVnnGaj98WOCulhl8N+HF0eROa8yFDERLWxqcD7yhrdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygHJPUX6otahYMUbDBvElBv3YKE8EVm3dKz2OKPUQrzDPXXGDS
	9lI9WQvx0Hx8aZXwbA9Gafy0pEtgCTyzLB0oAfRy1/Gaj0IPQegcYiFBXpKkEOJb64yHisHn231
	j5BeGx7drDBzZ4dOi1woufhknbm7gOwHfjdbNq00etOpl+9mQyhzppI7KuiHONw==
X-Gm-Gg: AZuq6aKKVcHmyOuVFjhyVxdaO/2xxFUHdOwBbHXTr3LtDMAtg33lkDcf/i9p6DbRMd6
	sNWn46qNuwseQB0JIPXspBgnedyLvriBI0dWNDugHEE+polxSbxt/3UxefB+lZqVlX29bcroTAD
	82gRK/r/4QvAjXMqPBGlhQazG2z5yM4bBj0ncNstaBhW5m9m6bZ9GUiNiClMDzIBp/sNxaUEotv
	bAtPXZQsoJhrjh/SQ67yIryJy7Luy/urt0pODHSTFwWkqO1Frg42KRj0vb0L976kE9x95vinJKI
	+38C7ijam+HiVszq3CvT1sbi3vspJCfGidTb5MlrUKu/aeBrsQX06daTkYO0DHnnIzXxt26qY+w
	3Ic0SrKEk/G6K78vcmolDs4g5yZ5z6eCfFLjZDzdGnr22laovJRmXfOW0x1Vo/0hQ6a4=
X-Received: by 2002:a05:620a:2009:b0:8c7:eb2:1c3a with SMTP id af79cd13be357-8c70eb21d8amr34148185a.1.1769513610365;
        Tue, 27 Jan 2026 03:33:30 -0800 (PST)
X-Received: by 2002:a05:620a:2009:b0:8c7:eb2:1c3a with SMTP id af79cd13be357-8c70eb21d8amr34145585a.1.1769513609839;
        Tue, 27 Jan 2026 03:33:29 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658abcf999csm259777a12.2.2026.01.27.03.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:33:28 -0800 (PST)
Message-ID: <e9acad0b-6088-4564-9169-96ff2c453447@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 12:33:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: glymur: Add Mahua SoC support
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
 <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xfx_jzLDJ3O7XpfTkEXRqOxnA294lhuw
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978a28a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GtF0_HNWVELJq49vNZ0A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: xfx_jzLDJ3O7XpfTkEXRqOxnA294lhuw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5NCBTYWx0ZWRfX7yfeKtGBfLQO
 VfCtEUD28ECNyCYRrW06DTVjV1R7pAssr7B3Hl6TCWJjaLB3wxjeWoTMyWJg7Uc/bFqTqC5cnHa
 2hCFnvr6+2G2/u1bC7ZIEKrnSGorxHWPzz5gSXxUPJW3E5Ab+qpU8Ul/XElobirLVZehhBYTrRI
 qqysORqghmL6FV59GnrK5JDwX5fCaYf9k8PO+G+mOvwTQ55qnnp5AkDVrL9yCxypfgRoDCwINii
 P0Or3bfao2A5kQSeXLKuyBmLcOGJl+ZxrhEX/6RJctNSsLc7wnhc/F1VJwBaKnI8N2L0QNwH2Ns
 Po5jBRR7yho5ByRVRbxpR//4yeKdBYEc74UD/fmtq7Tn2fPy328SZYc+RGxR5EDGAKViBwhcihJ
 6kusyIT2VoMew4q3xlZlVBX9rg9zz2tjMhkRuT59IJYpAutUEDfPMaJXtSvCDkdHoN1Lklgu9gR
 7YeLSiZS+fAPjGl867Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41527-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5382293A52
X-Rspamd-Action: no action

On 1/27/26 4:22 AM, Raviteja Laggyshetty wrote:
> Mahua is a derivative of the Glymur SoC. Extend the
> Glymur driver to support Mahua by:
> 
>   1. Adding new node definitions for interconnects that differ from Glymur
>      (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
>   2. Reusing existing Glymur definitions for identical NoCs.
>   3. Overriding the channel and buswidth, with Mahua specific values for
>      the differing NoCs
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

