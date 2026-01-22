Return-Path: <linux-pm+bounces-41330-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKmdLC1+cmmklQAAu9opvQ
	(envelope-from <linux-pm+bounces-41330-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:44:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F66D2B5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5295302353B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227E3994C4;
	Thu, 22 Jan 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzR/a2Th";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eT26snjK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FB389E00
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111007; cv=none; b=IiUl3ZloB4e5COP/QMGMugOC7s/8w0xHGZYicwV6pxDAHMCim14n+Y/1v+ffapEp96Ho9fOjqKB52ESgd3p5s4vZL1b0884xiaYUCMk7FJkkaMC1OMTjZwnwcgZZdwSEuf0Ty/hhhyGWEGFWUJWe52LwTjFUwGfN/uZMkHLa0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111007; c=relaxed/simple;
	bh=5WWVGM+JfPXRUfkCaxGMA8sshzQiLftp3qEukNNwWwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pylS7ywcPxSGgZhGXoguN9GV9wnuxasBkJCAZEggtW0E7SPwxUGFcKAQLaTGm5XtibFYANMn70V1cVgbuDktbb8h8Hqm00rHcPSd+6D3FML9DFSTqARWlycywcWnVYabN2kcR1e9s1vS0HjwayXUay4gKpOeVtzmwnmrDg9yXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzR/a2Th; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eT26snjK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MH4WDn3282950
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AKVTACrrODqnRD/iKH+1UNXgSL8l5zryD5VIb3rk1lM=; b=ZzR/a2TheSqkRVE5
	39tQxuwqRj8RFe8pjwTpqWDpYqDZqAUqD++1kliVOT4/60Kt04LoGxo5Ge/xIaDd
	KJQHlQ3rJfsUG5jgveKydR158x6kLpSUAYvO8H0T1ny14nXOYTFIetnLyNGebdnF
	iDl38WkHkJv8SpP7vlXk46u4klJzLJ8d88NY4O/ng32AbHMDxWScISBEapa5gt0C
	89wmNJlQb022TVAv2oAYWIX7Aq///mVpNCl0pdj7iWWYCs8/CZWe8HOT9aiHoWk2
	YYJ2j96sZbY4rSXVTPfiAbt10Rsss8hkU+46b7Tb63XFHvD5Af0LqkGRc2b5Tbwv
	AGm/2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp0hyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a182d4e1so32405085a.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769110997; x=1769715797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKVTACrrODqnRD/iKH+1UNXgSL8l5zryD5VIb3rk1lM=;
        b=eT26snjKG3kOobASF69rJOwv2hmzCJlvnwLeNumrwXxkOAhY8ZG+IlxiwwBbVVqu/0
         tALebDRax196AYRQqMBOnLja3rEXjkiNqGYgNqsr55Kj5siw1NP5nCmBI1XRvz9Pt7IC
         IOKpCCQ0PP4hoKNXWdY8kSJ53ORALIaTSOHKQs+TsbpBqIMPWQYo+Bk6+WE3e86qcEct
         kdOpBBlWt5sZ7+OZd9ErLA/z32LEitSvHPxoX6NcTPmOMS9GhWA5RCVlBfD84a+Bhz2h
         KXAiu7q+Xr7RI0WAaxmCzXqBUv71yOVfJfGMigFzy3oihVzDoQmOtqksouiqEr00a0wG
         jFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110997; x=1769715797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKVTACrrODqnRD/iKH+1UNXgSL8l5zryD5VIb3rk1lM=;
        b=tDH3nMDrCD6sj58eQmOTE1ksskgVASeKM2ulBR2n7gt/Nrq2KjbD43djEuxCjPKn4b
         cionVlNYpXDqbxb4jhljhMXf3vwtN2S6GDIyER+Pb6USgwRBnBEG3S2ayMeqU9bec4gY
         Avb42oBI78H8QhwDR7CedwM4xviGT17MynsG5g4VHn8p1tWldNWJOMYU+Le9+Suc0mhk
         zrvR7BqHaYuFzJswRK/aNBSOLHxCXc4RYWQ7G5xonnuP41uNSltxbOdXluOT1nozwraG
         AdXH7MM6E3oiD1uhuE2IgXqlrM232v1VOu6Y6XhWa5I4/weIfwv3OYyGL9UbV2Yx4HdV
         M4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlCziNrOPgqU7PgxYIhrVCnUDuoa0jQuZETnqZqDe45nOdzyTlKxF/tLF7nM7FSyogsrgxc/IGWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXNiiIM/QM/08p/ra7fQ9aeYVz2ZuPTVvo+jdjhRqOQN/Pluwf
	xikyNpNRXLC024GaeiQ3aQjJunL7OTf8epXRegzQNBLkAlTnb4WUcpuR4WmO0LV6gV/QxjMTfPz
	U5bbS2GhcBDvRbHUURHzQGwXswEhGTFevFgsokR6gq0DZqu8mNBmCkzxKjiufdg==
X-Gm-Gg: AZuq6aKyv6SI4Y4zmhieXVn1KZH6+5BQxqpxM3hCzLztem4WRuUN8xj/KAOEZhYl9ok
	xxvCsZfaQW6/Dcyw1FE6AD+punwpAbkIVdznuvJp3WwAPFPllEY7FbZ+2FVySvK0bGJAksomDf3
	fDtdgQX/2o+e/MVD0HVv5Hcip9C5gV0+rMXCw0tEUqmfQbWrBbsr8G84WOfZaTWlI3fkFGTATIo
	Hi9WqjHPWNx3OK5aOGRTEUwmIV2Dq/zsNI4QnKTQR9HikhCktOXfXBmuCb7KuHjKdLg/YqWvoyb
	n8aINyihsytaHamAhvrpft9sZftKlCbLHlj7NvQYtcA3cJ6/MyS2cqMAJJQ8j+LviP6e+t9gTu+
	wCGSzm5jCdBPB1c4Kt4uQ5sMfKYqDul7qYPOUqoOw3aTpqfxFv7GtxCWI2GeVmkf4MS8=
X-Received: by 2002:a05:620a:1786:b0:8c0:c999:df5a with SMTP id af79cd13be357-8c6e2e31c38mr62989985a.6.1769110997539;
        Thu, 22 Jan 2026 11:43:17 -0800 (PST)
X-Received: by 2002:a05:620a:1786:b0:8c0:c999:df5a with SMTP id af79cd13be357-8c6e2e31c38mr62986385a.6.1769110996999;
        Thu, 22 Jan 2026 11:43:16 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm9891966b.51.2026.01.22.11.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:43:16 -0800 (PST)
Message-ID: <9f87312b-7468-4184-83f1-1fe1fc351db5@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 20:43:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] interconnect: qcom: smd-rpm: drop duplicated
 QCOM_RPM_SMD_KEY_RATE define
To: Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
 <20260122-icc-qcom-dupe-defines-v1-1-eea876c2d98f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-1-eea876c2d98f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69727dd6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hXMO4SuWbqAAnYZNQPcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: f-dNbTtnQ2jwOV1wjcWZAcTJrWQlKD28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1MSBTYWx0ZWRfX+Be5dyykAIEJ
 iO2mmDIAx5ypC1rToieCT8vPmk5PMRmtgRqxNz7qZjXUlfDKgzzjEzvb/0YxmL1ALQMCRo1cTbj
 Kcvlq87netrg/zE+MahjdA4i2DFWDLot98IuUt1KZqGckWYLq4PwP/4sAX93d1yo8axCNOY0/bA
 0gUn2GcDyRPs7LqDGXm6HY7jxeNbmBi+ymRUIQcldvuUcUuvtmbkwe/ST558Gw3Kl5n2PStw7+t
 BlLPcLsHNcsZ5eOEb25CQtsoPLKrND1FESK+WxNJhPfKFP6G1VAfcxBe4R5HgpMN1YX9HqyfCUj
 abxs9Qqx2TtmWQ3BXQvjIrueL0yAhojSJU0BYXWEjHh5jJiP31lxCAkCEG2VOlGdL1VQxe8eGvl
 7rlvgZeK3J7esy/5TFT2eUT3vthHcxXP8UYcgjK57YkEaZP0Si7tpX1vKaMdBz574V44w8ZL3uH
 ymjR6C/7BDXK7Vr4dSA==
X-Proofpoint-GUID: f-dNbTtnQ2jwOV1wjcWZAcTJrWQlKD28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41330-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 026F66D2B5
X-Rspamd-Action: no action

On 1/22/26 8:34 PM, Gabor Juhos wrote:
> The 'linux/soc/qcom/smd-rpm.h' header defines QCOM_RPM_SMD_KEY_RATE
> with the exact same value.
> 
>   $ git grep -nHE 'define[[:blank:]]+QCOM_RPM_SMD_KEY_RATE[[:blank:]]'
>   drivers/interconnect/qcom/smd-rpm.c:17:#define QCOM_RPM_SMD_KEY_RATE    0x007a484b
>   include/linux/soc/qcom/smd-rpm.h:52:#define QCOM_RPM_SMD_KEY_RATE                               0x007a484b
> 
> Drop the local define to avoid the duplication.
> 
> No functional changes intended. Compile tested only.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


