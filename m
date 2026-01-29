Return-Path: <linux-pm+bounces-41689-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI0CFiBPe2n9DgIAu9opvQ
	(envelope-from <linux-pm+bounces-41689-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:14:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D1AAFF97
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 174DF30427DF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364133876BE;
	Thu, 29 Jan 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B95IW1OP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoNrpU8K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8143876D6
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688784; cv=none; b=T0QEwdTG17wvWBpcjhetEsgFmRuU4GuIVLymH9js5DYgaDKdxNND03m3l9hZmDB2R1XQ6u57Bbn4V/w+tPnrSHqxDC4PbyQEQPcNFHln+WGP72qvWjT3v0PNibihnero/nWHVT1NCGpnptCelVVxoqwHjsKGBKR5VTaBIKQGNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688784; c=relaxed/simple;
	bh=dtmoChLq9bYfeMzJIehxXzKt1+JwT+SEt6J7IM1hZgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8V+cTwQ2pp2ffwxwwCjLgwKf443GcPiIRjKdaZDyTqulpA6izYybPq23F6u6LrzejcNvp0TYJgYVIkvL8iAqxZDRa0yIFhDrn/WJid5u8iUBbNZSlGCeII7PLMg2QpOudk4ochvqwPUDK2NlIuEDo4Q/cuV9eJBtuFP/hIayMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B95IW1OP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoNrpU8K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T9v1sp2150660
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dtmoChLq9bYfeMzJIehxXzKt1+JwT+SEt6J7IM1hZgE=; b=B95IW1OPyOzoXhq4
	1VsKwzxQ2S+zXbE9+g+7sEXdIaOcpM/LgiYp5NL7mAxGWGhbW+OPT60Qiik0qFNo
	RdFvD1FQ8zKlnzbw0WIKTeMroToeWZdV1XMhAoFGn83HPSA0IjiunnczQsRiKDkO
	7eULHsoncGxEHLVo3zN8Gq2xCewedADZBklJ2Iksoc2v6ZM9IvMNqGk6Ha/0BXRM
	X0yWXv3KugwR5IiyNJtY3bsVpqdBN4dlnHz6SdVimZ9BrxupBbWDiQF9gexKn4s2
	Aw1M9yjKX8WQwm5lBQ4nG50aWzQ0RiaDAv8N6Zv9LRrFmiqR6bwbkf5JnJKuYEPu
	M+N2zA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byph3bbvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:13:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso1456472a91.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769688781; x=1770293581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtmoChLq9bYfeMzJIehxXzKt1+JwT+SEt6J7IM1hZgE=;
        b=FoNrpU8K6nPnfHz6t+NGvF59cVsa/01PlnvOq2yuQ843W4TRQIR6jKIQ8kbAB1LsPv
         ToKl45PkHuHDqSTDfyeQx3DQ9iaUa3IzRc702em3cNUSFqMWhxDy4vt6mDsT30tNvdOC
         Md3NgRcO4z3SFMyk57Ut9wfw/sHrLnzR7a8f5tf8bqGVzS+X9lmZLVGPzCZL2qO1njle
         C2VOpqJek+j9tnXrM6O6WKOnXvnMx07psnmFISH/t+UIJLY5BF8TLHEilqgnLXs7coga
         otk1ApCWlftIn0+4jxgwzl6usfGcFCDLEV+p0foZExnu6yBnWDqM+UYPXZNJkYiqn4tT
         wvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688781; x=1770293581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtmoChLq9bYfeMzJIehxXzKt1+JwT+SEt6J7IM1hZgE=;
        b=R83PaLuYTISSQJdZxlyIuAiwSQoyU9rDgkVApArnOcafSDQZYPXE9asEfvynf11VHS
         NIPbEYnTjZYzMc3d9dnAvPqSRQP7j7njeSZ+opFxcEc2qcnCFX2usAEgDIKpjZzYJFk8
         oxyDtk3D/qktmevrAr606IQt9sRapOf/aNHU5kzrKtUXNuy7DlP467Eac5tnRvlWDZJp
         y0h0XvV8tUIru5dXxv/PRRmly3cCroUvKLg4jK0OO0eUT717i2X/SSLzWaEoiUtX7LTO
         gdIEyz3paXN2HPWe5o1DXWJ85hfUKtpyFfk1K6n71CdkaNlTcjx//zVvobXsQp4upbBW
         rKmw==
X-Forwarded-Encrypted: i=1; AJvYcCWSjcaOONlbTGcP1tuKv3OKH1k3ZPNr1ixkWfj3CouzSL1aGQZmhinNoiZX6pumh0qLqoGGh+Abeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuTVcVjvE92+93JbgsBqjFZS7LoI4Q80/0m/j+8wbREIStaQq
	h5le2JUevxRr9kDwc9vM+fGeVDCsTEi+9RyX2WrCNiIlSe0SLJaBHzTmkhz5svCi1UsY7r+lmlt
	wGWcWIWEcL7NuuzRiQm0EDyG6Ef4s4quGq75RCcnBdcOTysnRgM9xOMrEBJYWhw==
X-Gm-Gg: AZuq6aLJpgzwjNVk0AclUMDTe4sKKtykf2fpoTo5x7o1SnIXeufvG516FYcYNzyMtH2
	MevSZaMvr6nE1LY/LRe71Sk/rpWD72x1CVqqkzddWLz5imzOnhRww6rNWqB6eS+FJ8zZK718wFy
	hY8BAGK4ohTknU09fifo0111Aw3aepH43y9iV66Ho+3lKv99h8ySTEstdxp+yvgRy8D/6ziIxzr
	J18SMRheiPwk+0nCaycGMDcokIkeEQxIgsyY8YY6OM7bFPvAbfX5H7L/jeu2DMzseOO546Jkjna
	7xMF3tTVulhiXf9QFGqfg5Qe7AaXXSpydse2oiU4nyhzZc/TDOYwni5lSJWVQp4rb/7ghdYdukG
	ml7SftJrSr8sS99yeZfBjrh3a0xJHFxa3Mpww3/CZ
X-Received: by 2002:a17:90b:574c:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-353fed5c8cbmr7454783a91.22.1769688781472;
        Thu, 29 Jan 2026 04:13:01 -0800 (PST)
X-Received: by 2002:a17:90b:574c:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-353fed5c8cbmr7454761a91.22.1769688781012;
        Thu, 29 Jan 2026 04:13:01 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f612917csm8140533a91.8.2026.01.29.04.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 04:13:00 -0800 (PST)
Message-ID: <94665903-b1ee-4b14-8daa-6646bd747d17@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 17:42:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-primitive-lynx-of-virtuosity-50a190@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260128-primitive-lynx-of-virtuosity-50a190@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z93h3XRA c=1 sm=1 tr=0 ts=697b4ece cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=zsdrpAE9SYd8J0fU1NEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: k9SdE41FzZgb8AxqpgvS-EHjiYp44YKv
X-Proofpoint-GUID: k9SdE41FzZgb8AxqpgvS-EHjiYp44YKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA4MiBTYWx0ZWRfXx5nQJpOqqUiF
 syD+GurB+End2sTxqK08Jk2HkZMDYeYpHlND2HeJG8BTr9m4pgDS+2KFbNiXHM695p6JRjD3vUu
 V9rpnZ0tFf07sKgBm1Rp0MR7GyZzIakf+IL9pVDnSFgVctsflHpneOt5pKO4jiWGFE3lIf5fFks
 Wf+eoQe+fuqGv/ePhjn9qIMN6aXh/PHDVn7RsRE5FGRi4IlPXGAb1eNxCVkmqSBYk80H/vFLckj
 piu21U0Etnr2joD14hyK7AAbgOPi4xq+Nr97ZisLPzG2UG28pEOnhP3UWmaitBHwMgZbhsIRXhC
 yBz2mT4YBulffwNt2wQuUQt7K/+2vyWSTvXoBBF2DiX5NEaQOgMn/fWurr9cWLuBIZ98SH+j+pq
 4I57M2Dsfzg3oFhlbyFm/iyOgsstWO3KnqPZ50eN8bD1YHt685uZnBQV71ZAWceb+64884+db5M
 mdGYDhPqa93xYKXiR/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290082
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
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41689-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B0D1AAFF97
X-Rspamd-Action: no action


On 1/28/2026 4:58 PM, Krzysztof Kozlowski wrote:
> On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
>> The cooling subnode of a remoteproc represents a client of the Thermal
>> Mitigation Device QMI service running on it. Each subnode of the cooling
>> node represents a single control exposed by the service.
> Subject - almost bingo, you hit two out of three which you should not
> use.
>
> A nit, subject: drop second/last, redundant "bindings yaml" and whatever
> else is duplicating. The "dt-bindings" prefix is already stating that
> these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


thanks for review

Will update this.


>
>
> Best regards,
> Krzysztof
>

