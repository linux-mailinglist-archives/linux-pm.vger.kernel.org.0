Return-Path: <linux-pm+bounces-42744-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBzaLkBmlGkFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42744-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:59:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7F14C39C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54C723006082
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD683563DE;
	Tue, 17 Feb 2026 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbm9vUVd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fM3Gvmk9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B43559F5
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333174; cv=none; b=hAP1WeSnqKqAD5Py5ncVL3uWO0uVLfKEBICbtiJZpM99dWsHt7ubiP67Che9qmRXZJu9uHoB3cLC6WuhO32YOE+x9BHn0ofVcmFt/9/IVQnOaDijGdkrQ6FYsUoa/BkrZx8JVwz1D34p4q80N9ftYQ7T7DJZjuRZNav8U8VHBjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333174; c=relaxed/simple;
	bh=07Lznw38VOaBmqfzu3nsHO93NfWoeBWCtQxbiuvZhz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jgm60l8gYpbj7qknzNb2LnYbuWZaK0v7Xw3foDNMGUNge3twGkpqBFdg8jQppCxOJzISHYOUcC1ALCr++IpCSRHf8wTnu4c2r1DvXGB08Arxmr9Hi8znPJHMOmrQqCipZyWBilHfklaCrLhLkT8VjNoKyCddGwR5VBWKS+y3h2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbm9vUVd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fM3Gvmk9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H97kWU985305
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	emurCib0iNTs7G33GRB8o90cpGK6hrywRf8n6gSfwpI=; b=nbm9vUVdgwuIfycA
	G49Zjg+s/cGuGfqYi03cqbJch/EAYo4IEJXoUyrzOPWh3ASBnajw/UAlc+D5sKWS
	9p+qQqAc4O7chRkdlHF5QnLE3sI31bYW9b5MjeVKX6ua9Clm55k4yjog/eMvT3cY
	ZfYkzJ/VdnWR+svl8qY/qbsSeiK0Tkh8VaWmfFXwekHnLf5irAsYUYjwpOTY9fAG
	eGsdjv3owlMN3Z6Cxp2Wd3uQg5NGydSsICbLzP9f6hAM7lnNrSYQNstv9u1Nfzry
	8UjeySMzvw0Miq9kS2ngnQb72QHk4mve72elfniDR3UpElSjxdWwqnT8gfMcadvu
	qMe3qA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap29x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70e610242so2683257985a.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 04:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333172; x=1771937972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emurCib0iNTs7G33GRB8o90cpGK6hrywRf8n6gSfwpI=;
        b=fM3Gvmk9jWAUFArH4n+TzFTo9mKNloUFYQ+bgC2l8J3fjeR93IrlpIhjys0G6raOES
         37eFgSHxXyitJd+HfXyMkjqQgYOaloVnU4l5WiP76HMtZcKgjxC2zjtZEywoOYB0O8VW
         1p6OYUpDY4lOdJCu+hW6ytwkBSXrpziDevAuKPbNWuqcqn7uRDT50pH+0rvGKgTnJDxk
         aITXJpL3vInhWsZjHdkTuppzUV51eF//tev+fbwn3XuBBNwdWulT29TO9yUdzoWdd1me
         cCiMRd9iVGRekU6xji8PPPR30hEMf6kLIRBhIdef0MiYaVVVH7abmE9r8WkC+Qm1Jonp
         v7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333172; x=1771937972;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emurCib0iNTs7G33GRB8o90cpGK6hrywRf8n6gSfwpI=;
        b=qfCYlFfFwFwVZ8e2mWEDUoOszv+ZXhyKQmcBtdM09Lgr2G+V9PMNPUUABtdSG2RmBc
         Py4lFuNKyNFJGJITh9Z7E5sg//Jl3Ma0o074EpKpYXmGq9j9NVN3Yms5Bvm9A+V+CGFs
         red5UrCiMRIr1rkfFnv38A+ApQeSK5wOMxeodSGd2u6mk5s/BNaQqzZBf0euj+3joN/2
         sCSoQzQQlxzdaH3DEqfo3J9156+vzCHg+m+zLGJMXheFFtYsIASkWhh+eANFODEZr6NC
         1jd1WWBIaOLE/Wfj0kIPJFqUzogIWZ6S0UyCJnj/9rS3BZ2VZ825fBvQhyKBRJ1U5a82
         J3gw==
X-Forwarded-Encrypted: i=1; AJvYcCVpDVsT7gZJK3hx3xsZExiiqHNKWlcM+SY+HOSIwQIHa8VyUV6eX3MODcLKFCXqJmk8lFGJh6Qp6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwER4fZilCoXnUg3UHqZAg0DDoaKM0OplxiWUGOD6BdheHezFu5
	1pyyYBjz53ve5eqACdfbJxHrvdn/TeDCrHhLRbrnwrVXun13wbvxqlSUnP+vs8jZZYQDx95qjzt
	40VSeQS0omu3RQc8NCQMIKwSzVbPLkb+mQWRsVLlgs0ZeQ78xVlHBLKgY6aqXEA==
X-Gm-Gg: AZuq6aIkfbKCNNqj5WBRHq3giIEOORpq3cVb/lKToSTFKDAUeE4MryQQD9N1rglhijW
	9Yl26dmXep4MaW+cy2K4VPiMGkYlghu1A+Kp8Pwruz3WqoE48CQc0XpWaouUuPfV6BQvkwg7mXx
	NqCau0/wrtE0+qDG9SuFWbSxRFUFvb0qifhyanK2gm9H3LNMLZOyqeISTTLyGViPOr/WCloNvXy
	50qxgSTwVIO0QkNFJpq7rqV34iyfzGo9hCX9I1KZXhzwuRsboQmL5LoY4YEvJIVTts7Fdf0JQY8
	cE05Y3aRSbObsVZUJEZ8w7fZIjoQu1IwKXejKweKnoJ3iEl0099sFS1FeTRspo6Ncw549hcmDbH
	LvhhW4oiJqopiHhInTrZ0L5axIkyrLvjVEM6L8i95EsDoVF0QBw==
X-Received: by 2002:a05:620a:3f97:b0:8c0:88f3:fac4 with SMTP id af79cd13be357-8cb4242a533mr1744710985a.56.1771333172259;
        Tue, 17 Feb 2026 04:59:32 -0800 (PST)
X-Received: by 2002:a05:620a:3f97:b0:8c0:88f3:fac4 with SMTP id af79cd13be357-8cb4242a533mr1744709185a.56.1771333171832;
        Tue, 17 Feb 2026 04:59:31 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a34d66sm129927125e9.20.2026.02.17.04.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:59:31 -0800 (PST)
Message-ID: <04aaabef-c8ef-4e58-a174-4c5ab619ecc4@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: De-acronymize Glymur SoC name
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260217125819.281209-3-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260217125819.281209-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfXyW/E5DifQhhK
 0W0XwhanFk7uXh4UIjM8V5SHZL65ocvyTzRz8M1APEx6w34bcr/v+uXNpF/LF1GzJLG8uXTgmOn
 BB45svlN/I7QR+AUQi+6Um1qO+NRqXrHi7DBaPF8yPdLX+o5asUVbw/VDtvPBTk+mByHwzrAwnA
 WhQsBPv387ezQMXtLR5q9uOFaywqU5b583z4AcC+PQHWWpolsv6MmmvafzTn9+9jy2bpii6riAG
 UTvZtYX4OFt9oBJWGyRK7WQYp01c9U7mhTALarQ8kSbdIWI5HGy9eV8YDvaA4wGlMcHHkBsU/bW
 to2v+KXkjHy9XOWW9Hwx6a0VmqfRPn4wvaC34ZeNLsUJj6C52pEQRC3vxqGU7SmNZglkDFQf9Op
 d3CFbDGtgBRdwYXTkUajadjYWvOCDmg9U4ZD9D9sZJxZ2x5Fz9sGpe6FhZXCKQWeokP+LzUHZ7n
 AZM+hAggiWNThk4SCfA==
X-Proofpoint-ORIG-GUID: PsxLEf7NIDlvRI_6j120iTogatMsMU5w
X-Proofpoint-GUID: PsxLEf7NIDlvRI_6j120iTogatMsMU5w
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69946635 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Rh8BIR2qzSpX2dRZ-WwA:9 a=QEXdDO2ut3YA:10 a=Qzt0FRFQUfIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42744-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17F7F14C39C
X-Rspamd-Action: no action

On 17/02/2026 13:58, Krzysztof Kozlowski wrote:
> Glymur is a codename of Qualcomm SoC, not an acronym.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Uh, apologies, please ignore, wrong patches combined into one patchset.
I will send a v2 for this.

Best regards,
Krzysztof

