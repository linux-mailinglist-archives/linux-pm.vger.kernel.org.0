Return-Path: <linux-pm+bounces-41750-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKsgAOdSfGmwLwIAu9opvQ
	(envelope-from <linux-pm+bounces-41750-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:42:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F76B7ABE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D820C30058D5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACF33CE8F;
	Fri, 30 Jan 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fs68VRF2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CiX+GxHn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169B27586C
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755364; cv=none; b=UwWb8rpDbv94Yh7wltctc6seBUjfvOXlPBQTjV3K8uW7m2kMRcIi7gcjxxESyK/VIsBJ6aXLfzR/+P+iU8bTcdC8IAZD7GNY+mjwNiRqcqYnE3wweXMbVR8dk7olsy7u4xzl67C+7lNGEosuXYenFkeiark2IKJnFD+CrFEyrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755364; c=relaxed/simple;
	bh=jtw7KOGqnd1x5l3rhpf+dMbdDDnSOzeycNLqpZCEhVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJXEGxd9GbRBmesvxcCZ2pd3tvHv2S1Z/ooppH8Vns0RJZ0EpVHvq2ECpeBzBc28WCVMjttPBF2KnxUNQ/g+YcGVa1ebl6DxZ+oYwbBFB2aWjE3IpkzcXtQ4iXEIpWxVliMyT2zt1Z9wOWoMSak8OEReZ0vo1DWuhshqv14FkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fs68VRF2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CiX+GxHn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3Vms71488312
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 06:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJ6t4kgrhe1eIPNb8YLYC7/0mcFgobKjT0RiB3Hsnm8=; b=Fs68VRF22CKmiccx
	FmOmRTIFBnxljUXUSnk3ieaPwfoIXFl1+Hd1gc3S+/mjm139hniRlsz1Hnvijq1R
	EQtlkSNqnaL4FY54ufY7nf3Xn0ILrHSW8uMwlU+XctZkeoeqZ0klBxPnH48rHykA
	BiqewU7v5Umm7KL3TlDH6JEX/FAm5kyfU4b1k9lNxvtYf2SXZUBrG6eQTELVpCFI
	yVkUDY0PxNh3B3OpE+KDmvsr4eS0nI80orvla0zEBVE+0n7KOn9AYQ/FYpqGjYOT
	DklKDXTRhzivgwbXXhZo3qPl9mfJjs1RHpZ4gHYe+mQ78E5iluQ8lBxN4SCIqceA
	aWqGsA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3t3y6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 06:42:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so3511412a91.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769755362; x=1770360162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJ6t4kgrhe1eIPNb8YLYC7/0mcFgobKjT0RiB3Hsnm8=;
        b=CiX+GxHnORvNS8Guo5F1IRJneTyoTfW9ugHNFNXCrGIoAjl4N3gLo8jcIqKeWMUzvs
         tHOdABTE20ZMx72XiBLqJtvDdGHMhqr+EFdDRpzjp5R7CRZMMuzF9Ql0fuNUZxcvQ9FN
         4WcC1o+ZZMUL40+uztc9ho8vUkmlnD9nqYJa4Jh5mHmAAfSleVBqiaUnrfBkTkkzmUt7
         8ZcHdZn55oYLXFvcV+KaxtPCKj3Ce1XRzbwR3h3HORdscKFcKGtu+swID8CFHHkfLYWY
         49Zt/oLywjwMwaxFy8BCnzLjE177LHc3E+N2L/uHc1V+Oh0r4NfZLx65A0GxqWbo7Rqv
         eSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769755362; x=1770360162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJ6t4kgrhe1eIPNb8YLYC7/0mcFgobKjT0RiB3Hsnm8=;
        b=K1MtETtKkhdP1s95qFljWTpDM6HOhk/9YL6U9hQZZptCZb4X9FCwzCbeub7xeB3w/V
         ZrSuKbXKvRykT+9deQUloXl26wd9NaG9eWSIV9H6Wg11S7Ujjvmmnw2ppqem6XDQc0+2
         2Br8ZDsv7fCkxBNxMT3B4HL4YzI+XePe1RTDEOoonN30RSGL3u/zpGWW+ay5v6HupxFt
         lcHol6L2wHUP9bM/F9PMkgqj8yQMFyIF5tdRCklHphkKmv8A3kwZXF41qhPnxNfQvgNK
         KtLNVUP4u+AP9cZf43KJeFRQJYKDLO3ipmAYQcyEjSWyepn3hvQu8TB1NmVRwNbwDXFP
         l8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMyw8T7XMzj+Jy2QPk+UKZB4U0tM0icv4rD2a4U4LgyIY/cYV2EEUhMOLaXniSmxRqMoleM8EsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjEHFXYOeMYjtwAZLUfuimGr2aBtCx/R1wqfLIamxjevzvjUg
	61HOyAWAFu6J+SqgVLgkasm9zloXe7L4d6cfW1NMKh7NsN+Gn0qB+ZETNSy/BZVcxq0y6qBPr0I
	zhYXibRvgJEL7XiGx4XMqb8XrMIlVhoP0uvF5Y5IJvwVcgIk1rVy1xhCfidryjw==
X-Gm-Gg: AZuq6aJ2gv034dD96W3R1v70PoZ4l+Xhoo/ycgcgPw6nU/fO3z12zNfeSNs5zZ34maT
	S4fFQbcNmzBHdMx5t9VMZZjFo8jGZxFuLCKOxUw8iNAu7hR0TWwNfm+3JNlAKe6HQLhIjlQRER/
	TMIHRua73tva7jMY4KFkg/mC3yPrQKUYZcLoEAHwXLBj1zFGFmUShbZkebK1/I30HH4C5dtQsYI
	wjRJEwNN7K9WdnPErAn2DOnqrqGxDHz6i1osPZcdrVDwXP6toCgy+ZKZC9YnIGBseaX81RfhOWx
	8gbTBLRkeOTAliXBtGO9jyaTrgvyCCFwbV46e9/xoBMOxdwvI/NIWhQoZgY2OAtJJRwMbX9AxDk
	Y9BKml54VPseHZXHPn/GdlEARtl5bjtKsHQvOAKgM
X-Received: by 2002:a17:90b:1c09:b0:349:2154:eef4 with SMTP id 98e67ed59e1d1-3543b2dc04fmr1791626a91.5.1769755362098;
        Thu, 29 Jan 2026 22:42:42 -0800 (PST)
X-Received: by 2002:a17:90b:1c09:b0:349:2154:eef4 with SMTP id 98e67ed59e1d1-3543b2dc04fmr1791592a91.5.1769755361608;
        Thu, 29 Jan 2026 22:42:41 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb419sm7086345a91.1.2026.01.29.22.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 22:42:41 -0800 (PST)
Message-ID: <07f0515a-8c1a-456a-aaa8-1533717573ab@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:12:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
 <20260128-colorful-caracara-of-persistence-dbfaf2@quoll>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <20260128-colorful-caracara-of-persistence-dbfaf2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: roSoYdupZoykOvl7XvcJois7HHCILNUv
X-Proofpoint-ORIG-GUID: roSoYdupZoykOvl7XvcJois7HHCILNUv
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697c52e2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SE6imBzcV5aIF2VMCmAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1MCBTYWx0ZWRfX+9gkslNBgGjE
 GKrmA+Df5s3zZHipwbh5Hyeiw3r/l8rw24Tjw2HZFErEhfmyJaRuygDa8NI1Nbe8xGh6w+FFL9U
 T4HLdtB554TgzgkMIYEuwpYYmiNghXDVMz81XomHZP957NPSui9EEuwJSPwifR8C8QPhoPKEpb7
 gB5040vmvR9v0gprJM9YFnEHyqyTyrEyRQDJhn/INkZRrXvgV4ZDNOkifY9fA9KdmyursvO3WHl
 NamQ1asZapboRa59nb4uwQY+kKkJnUg7rQczPPx7RV3gPjcWwA1WBJkwF+0FVhRasgtfNMJHVNa
 qJPyk2QsO+LwmE1NKL8V0SbC3PB19lo4koz6Qa1wkc/sr7PmfYV7nZ/zH0IpiJXeUy0UPx3dV4a
 BiTtlE46wECguGebXKfgfy882/5Un7crAm3ke4uSVq3O4b21aaHBborhdIY26EUYE7X6RxJQhp2
 10W8TojQQ4x+hFkvlKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41750-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95F76B7ABE
X-Rspamd-Action: no action


On 1/28/2026 5:06 PM, Krzysztof Kozlowski wrote:
> On Tue, Jan 27, 2026 at 09:27:15PM +0530, Gaurav Kohli wrote:
>> +	if (!name || !ops)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
>> +	if (!rproc_cdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rproc_cdev->ops = ops;
>> +	rproc_cdev->devdata = devdata;
>> +	mutex_init(&rproc_cdev->lock);
>> +
>> +	char *rproc_name __free(kfree) =
>> +		kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
> Ah, you keep ignoring review and sending the same buggy code.
>
> There is no point to spend any time here. It's also fastest way to get
> your future contributions ignored or NAKed.


Apologies for the miss, will make sure not to miss this in future version.


>
> Well, ignoring review is obviously:
> NAK
>
> Best regards,
> Krzysztof
>

