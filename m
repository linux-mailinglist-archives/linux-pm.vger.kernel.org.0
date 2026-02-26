Return-Path: <linux-pm+bounces-43242-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM7uI4E5oGmagwQAu9opvQ
	(envelope-from <linux-pm+bounces-43242-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:16:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CDE1A59C4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0597B30A5EA7
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091381E834E;
	Thu, 26 Feb 2026 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADcYTt9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCtpEsnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2A1C5F11
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108154; cv=none; b=YeGxDTxNT/Vi0UsOH2wHUW1Fw1YWd/6ud9qlaENjNtadA0bxYYebv8a5QAcO/2qw4h/NzGCv7IVP9PMjatevpqDI5u5An8uH58Z7RPL6zouviXepjpdXMnmOR/0p1svOsAL4wrszDHGWeDvpMR7iyjtbQ1e2aWoT0j04JVGSUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108154; c=relaxed/simple;
	bh=lXFzGCAdVLAd5URIMznq+00idVT7o2TBbY32aarIi6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHfsvezCG5i2LIXxJPt/thF/0aiFy6VXhOKhwbopPpn+VeH7t1+7MjKNIde4jMx4BiFwLD5vs9SXSO9Oirq7pgPRhZ8CDfHd3YuNbiPnxiOdVTnEwzEor3WR5gfItBwHnrASuLACFGS7qtCT5InP3xPppUOc+n5Rytc21WWAN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADcYTt9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCtpEsnB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QALBNp1681189
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 12:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=; b=ADcYTt9EN+VnIw0R
	Dh/Ko51ROBcDi/iTPY1WnkLkbIcU5ge9mLTPCkrH7rozcUjU1XutnFQ29dN0ZVqE
	pqZva8W4vSqiIXXOp2HIlydTUmnBeqBYCVSw2aqF7l+vhp62muO3WmP+kY9RYTg6
	q7DuFbcJJCSWpvwPqaEvBDqtNUqZesWpnUVgu/HtTwOeOMzS1x3EatxV4hRdb5hX
	B1DunGyPEvvY2qJNL5Ytg8w2bcLG017pKxofNTh67B+VMWOCI+A8xg425aA6O59X
	A7jrUpj72msLsF2vdaAziKXRRlMCm9JEZJeYLHqjM6bS4g+EVJG6oQUbxOsEbney
	5UzusA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj4w4u753-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 12:15:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70c91c8b0so60840385a.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772108151; x=1772712951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=;
        b=iCtpEsnBip2djZdCyU0i3i0dFfD02m3Pep9+wWKeDs/8TynAHHCK4gvfhfOLXUqYzl
         +q5f1f5zNgOpBH4dwY9GgLsi6mJhYccHQBHNBpTZYcKqTK/49p4TmRSeakEbm07DxVCP
         by4MRj5CWMDJGSeE1qiANNgKbcwzKepr+aicwttJDsBDF6oThWFpFiw+x0tPPP7r/lmI
         ojijlYUtW7AKuJsM2snu+78ZIjb79hgEB5zZaciGK3juOVmWy0pkiUewLZh279Ce1Zke
         NPtlOWEh2dUFd/7BGF7xd7CtuG/OXT5VDQAvUrKnWMG5uOzGjINV8xhLvccpHpb9hrAl
         jHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772108151; x=1772712951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=;
        b=uyfj8KW14Lb5EZiskr+JZLHdRkk4NVo+5HALK5E4bYRTvgeXyi4RbVttUx6o5dGCzc
         OXxVyXNpOmqDyv0x7OD8TuJ2EraXww0ap/IRaPBIGo11AWbSOGs8JFYYuJ7H6lKSIgWh
         ka4gwFh//2avmrFfO6APTxQgMULOSvnAmYNTJy3rxd9HR578a2KRtVrkf7hmeS1xg96P
         uiHES9b4aqJtn5v2oG0WAqkXUBeazQJy9arrZc0D8yOhQF0su6Vlint9YZWUc9k8q6la
         o1YKG3oJKDcWXrKyXHkhppadXzxpv6YWjZl9YUyUZVArSm6TqhgqB/g/D6Rr8HpBsz2o
         7ZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjocRJ/bwLbD/1khr+U9uEGBAlJZlzB5YkoGBwCAAtgzcesCGVNJJUOvVea5OTslLxxL+qlITb8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqeAyK+lsUcLEq/YcWs6U8/zmljhpJ29yPb/bx3eExyQy6b7p
	KswEUFtdlc7Eo++N2X0p/oaQCFWljkeUJEYlFLJryuJUyQMKI8Z6Rusxlf6IQTKOKVBADEETH9U
	J0k49l3lQRIqnEMv2VDlB5CquNcueshh5vGjdqkPCUbet+ybek9ZDKs1u1KkyB/lenZXdpA==
X-Gm-Gg: ATEYQzy27Hl/3GuW110u1YAwD44XnLUUVx7CRtiduMRFXxRZEtmFsCrX+fcSb21zXQV
	PtOIKHW3WGEOf14yq6zVWK4X+iPblkt3DiOGxcp2z44q4jKF/nWilRhGF7FnXrK3tv45balpaNS
	l167Re6Z+TOYLOXvunwr0Scn1jv4FpyC9fiCPim/TFRyRCC/yZpiWdweH8ZsjM2tLNgUtCdZV7f
	bcQXDtofAtsfq1iiosfzU4UhK7yqxapplWUWL+AvTAcrR6SLkJA2PoRFAaDOLIM6A/S/Tc8n+gb
	w3xy96UTb75qrcB+NrFru3lfN9fZaH/sCZCIQuXiLftCYEfPHyIoyWTQHu8Xn6Ggnhoaqk9mHkB
	/v3xVp11rDRYaQky0uKa80DuvQuiF6XOOlc0D7WgDcVXw2aq/depUnkbfIYmo8kg3FtbO/Ekb5F
	H1U4M=
X-Received: by 2002:a05:620a:4706:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cb8caaf296mr1765671885a.10.1772108151243;
        Thu, 26 Feb 2026 04:15:51 -0800 (PST)
X-Received: by 2002:a05:620a:4706:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cb8caaf296mr1765668885a.10.1772108150750;
        Thu, 26 Feb 2026 04:15:50 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd4695bsm436468a12.12.2026.02.26.04.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 04:15:50 -0800 (PST)
Message-ID: <e544645a-e113-4ff0-bb1a-3a6577d6a83b@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
 <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
 <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EOEgbqUOlMLn_v5gPhjv1qo3wVrmyAOR
X-Authority-Analysis: v=2.4 cv=IqMTsb/g c=1 sm=1 tr=0 ts=69a03978 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_q3aKey68L9-M7rtS5oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExMCBTYWx0ZWRfX4LIa//Di22Ng
 6Jvlp14b7ws+jNOApB5iNdGTvb1HNd8PuiPy1fSNQ+V9l2mqsWZgWRBT7PAPgIiv9l7yW8h52xh
 2KElan+8ykGbu9Kjt+aGCPm4sbo5evkrklVHT4yF7NUktkAe42DkuFhIsoDgcQztXevVvVV3YH2
 CKSgwxZeQB2TP0ENRFwnUYoHNji0pZdR4tC/dpTIiE2AHZMuCE2qF+uwSnskcerT81HLM045fVq
 IBE9ium4ZSmp7lwSFczMKr5LztKjniMeOloxXNvfAufjCWmkPaRkNuz0GJ24Hwo+ukHsCgnQoy+
 VdPOBaWgp/aduWhb8MBRFnf/Ef6H3kIll1gVnr80nNLkpd7ndQYmza0VsCmiIfYqDKbFhXtEFx7
 YavxYrJ4AlrCZ6TGtHa3IlU0gG3Z801yZweVo+PkMtHk5lxQzS9OYelyj0rh48J9jYpxgRWsww8
 QmRYkbFBI3yN7nm7TDQ==
X-Proofpoint-GUID: EOEgbqUOlMLn_v5gPhjv1qo3wVrmyAOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260110
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43242-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0CDE1A59C4
X-Rspamd-Action: no action

On 2/26/26 10:14 AM, Wei Deng wrote:
> Hi Konrad,
> 
> 
> On 2/25/2026 8:27 PM, Konrad Dybcio wrote:
>> On 2/25/26 10:17 AM, Wei Deng wrote:
>>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>>
>>> Since the platform uses the QCA6698 Bluetooth chip. While
>>> the QCA6698 shares the same IP core as the WCN6855, it has
>>> different RF components and RAM sizes, requiring new firmware
>>> files. Use the firmware-name property to specify the NVM and
>>> rampatch firmware to load.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>> This patch depends on:
>>> - WLAN
>>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>>
>>> Changes in v3:
>>> - Rebase patches
>>> - Remove unintended 'output-low' from bt-en-state pinctrl
>>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
>>
>> Only now did I realize you're the author of both patches!
>>
>> Next time around, please keep them in the same series, for easier
>> tracking (since they're very much related)
> 
> Just to clarify — are you referring to the below WLAN-related patch and this one? 
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/ 
> If so, they are authored by different people. This BT-related patch depend on it.

Right, I seem to only have read the first part of the name.. sorry about that!

Konrad

