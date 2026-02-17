Return-Path: <linux-pm+bounces-42737-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPuPCc1elGnODAIAu9opvQ
	(envelope-from <linux-pm+bounces-42737-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:27:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCF14BF04
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99B2300F10C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972FE33A031;
	Tue, 17 Feb 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5H+jIen";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1LMo8BT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C44339857
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331256; cv=none; b=agKVTp85H133LdmBWAwMWFw8Q2BmIT6aI4CTwUM72j8L7W6BiGb1Uyu8AvnmCIXScMrZ6L8PGOU3ivWrGk31kgWUuaLU5rO3kVep+/BxqlLKAVGffhsZXrj4zbCjDq/LsgNP7pK/Dkn7KkpBqq95TuVw0iBNkQ0wjTlL6/Hr8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331256; c=relaxed/simple;
	bh=m0NqDjKQV1IiIKGmVQ+XSPW7frvUNll6XnPkvEFYuys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHhACNLSZ+fviLMpIvVAC0u6O8oE57+nHoskVqjdfEgXlH5kx7gsDCu+GqFd0YbvhulXUiOFkPnpLv2Ytrdnb0UC+NJpZHkpFhMF7PwKUBSsCMXOLAyxtbfqLtIq0Nx8ruAVBCqF0gTxDQlu+DBznFZHEBKwHwd1YfBbkLvE5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5H+jIen; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N1LMo8BT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H54hVN2111937
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=; b=k5H+jIenj3/xVCRl
	FEZ9XE2GHes6V4FXR0DYes1R71c0A/zS6JptXpxlzpRWdqVWbxADRG/w8BrFXWIt
	ni8Qn4hfH7d8yBSAUv4uHXBVxysiz4j33+9ziCkXlPwZQtJ+3oqZ0zUcfFI2azHs
	iX1YWMtEjqpX+djxKVs2Bb928D0fuVkQKuJBtCOD8AsgkzkLUagW0DbIKKeGNeyv
	QqOfeCOQDkVD3XJxTZF164XBVsbsY5tlBrIrZTbP57To0AfBGHSYV2p34AqlUYYs
	srthpdRECVm5jVWejyS0wjOeQSDc4UB3/Xcfc7ChycEfbbylK4tQ49AUvFtLEoBR
	NCIZqw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4h1cs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:27:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb38346fdbso336726385a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331252; x=1771936052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=;
        b=N1LMo8BTi2NFO/K58OTyGFIIPHZtDTbf/+4yWD2yp9zdhL0jXghdF8LdGdhNU3b1N7
         bKmxVDO2brrWn0PbykX7mPeb2WLg2indykGXTNBhE2KC7OoSFt9T0tPHjeHZBoCbvi5V
         oVWSP5VXizFFriCDNd6C1AtPiOqdGJF4EBLCGCY8hBNF8yaWFTiedZo9YDCP9yNl1XKR
         WtlNvNyhsBpKphdhHrF3C+waNe2u0tQaZGI4YX7V3YkN00UZ2aSwGvhM5+s1W8qew5e7
         Z5iieeuusBIBauV9ETsCZkqkMQ31PNc+UWNf1B5ra9K23Mdzl23pg1gP8LAADmY19kUO
         5BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331252; x=1771936052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LfJ7FA1LOB23kUU1Y4jX3YyUXIsEdCQIqdfdeeOUEo=;
        b=e9jjuuTftDfehc+RhX/SsOJybz7d3elGArdJv86cHqii49g+GA2AnvAmG4WmXYeW05
         fy5Uuk7Vs2I/QvaQ5zk+q+RXp/2fYXuVC/lZe0KpUIPNp+iSn3AmzSPs/Kz7LWbkSGAf
         YMHaAjvHCW9EPZ28zdSjMqHLr2IjvXI0Cv3t/fqxd+tGPEPZ+c5R5kGj1Oba07RBtaGG
         7IoWFSZ10tyS/bW4i9FuYvFtKSyMYCBPceKQAYNUWFi+kMlme2K30w5d69UvpWPISY7L
         Cmie5XuKa6/HZh7+pPHHFpV0zQ3SnotmsLKvj+8YEDd/tmKHobdP/cVuuOSGzS9Vpb02
         VFEw==
X-Forwarded-Encrypted: i=1; AJvYcCUlOoI/6GEzq7AW93QT1D2mWyZLBzRLGLEx85u6eci1eP4c+b66Wc+FG+8H06ce1GrLkmalukokRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBt75TW5GTrFVERDkNRlC0dqFhO0s17clAXQkCKk1IEL87vM/u
	E87Rm4tqXfnyw7qPbFmYl7tmMiZttyAuVV4f/DNgcbTlsZut7+2kBb5m2ziZJsmRnh8jbTNNviN
	CH/gm55GZbHd1G5ZPi/FLOHt5cmeJsV2V3hkb+VfcoOjz0fwUne4tQ95rNY16og==
X-Gm-Gg: AZuq6aLyt6OV18Uy5c2yfaWRuOfwcy9JJAKS7iiewPZhBJ0Rwht8aeqg2e9K4zDjJec
	9xkPeNhtRqEeRAVQwiJ/4u24uMYVpoeFZxp/A1WjpHnREyEERgD1N+0jEKoa0OxPeZ+RYw87Oj4
	Py9GSO8JwRhXWjlnE+S2owf7Sv830COuaNbWQcFsQgCChhXh0pdCWDqWpiX8U+D17O+97oPi/w2
	7doOPwtm61kGT0vcSMdkI079+KAVuXxpIbdvbsC70LIXa7Y9ffGUg3xCGaenRt6PT6I8FbErru4
	oO8f883pkfORre7O8rKdD9hJ2s+NPtJ2HXic2JpMNmFPS+gcn1kbgiUA11H/za42pPh3TQ9vEQr
	b65/coNTKdKxjWg/DD3eNzu4lSmFJCIkTyExF4pNxzm8yhIRqKH+c468R6VpBA57Vhg/SLDXffW
	brHuM=
X-Received: by 2002:a05:620a:28d6:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8cb4074ecafmr1366940885a.0.1771331252643;
        Tue, 17 Feb 2026 04:27:32 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:8c9:ec71:b224 with SMTP id af79cd13be357-8cb4074ecafmr1366938985a.0.1771331252148;
        Tue, 17 Feb 2026 04:27:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7691f26sm344142266b.58.2026.02.17.04.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:27:31 -0800 (PST)
Message-ID: <bd10782b-444c-417b-bf27-9fc6a2117567@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org
References: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
 <20260209-add_pwrkey_and_resin-v2-1-f944d87b9a93@oss.qualcomm.com>
 <b0ade3b3-f2b3-4dbe-9e21-920bbda1d077@kernel.org>
 <20260210082612.3xakor2yo4h3dbra@hu-kotarake-hyd.qualcomm.com>
 <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <k2eu6lvokuh6pilmipztfqufffkmxa3zylsxz4lad45ow255no@fvocedpr3qwp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=69945eb5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=TmaBVuYMn6Vj7WTXxxEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMyBTYWx0ZWRfX3NMYbUG6Gc97
 LsIhKIu80oIZHwJG2XeNyVXowwCI2Ua7Wi/2mAnTyN1c45ARCSr8+EuzQ9ijaLrcmPlle0NU2Q9
 G5C+ly12AuFeUZGTTPbLklB/0DlvbpDNgUl5mhluhCgWcPflQIiB+JHUIEVxBA+RERLtTQRAUqy
 KZXcqzoc8kwHr5ilpkMhDmh4ZFnKKgF0x9rwqUnqeXt2OprmqyQEaqxQ0K31+TcXFUsAbXAPuvV
 skMgdCk2m3fxQJesNT+JWKA8XUxQQu544g8bznSbOBYRIuY2J7Xh857FGYSgQXdeyBCxvvLp+Vu
 X9iLEtUYoeyb2fpoksNItpN6j2F5hUC6sdgnb4srlxvehD0PZnbJTXonO3tGqE3TTZd9Dk8L2MZ
 OeHFZxfyxB0F7HjF7fZj0xoAYzOTh7Yl6zaXeqpAK0zwX3i6HhN4J5TxvcVNhkMBGGc7Pul5bdK
 N5khR8h6ocl3L5Ei2kA==
X-Proofpoint-GUID: 1YfBBlXWx5rKAT1ptpLJcqNgZB3MbNgU
X-Proofpoint-ORIG-GUID: 1YfBBlXWx5rKAT1ptpLJcqNgZB3MbNgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42737-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sonymobile.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B9FCF14BF04
X-Rspamd-Action: no action

On 2/13/26 7:17 PM, Dmitry Baryshkov wrote:
> On Tue, Feb 10, 2026 at 01:56:12PM +0530, Rakesh Kota wrote:
>> On Mon, Feb 09, 2026 at 02:49:24PM +0100, Krzysztof Kozlowski wrote:
>>> On 09/02/2026 14:23, Rakesh Kota wrote:
>>>> Add the compatible string "qcom,pmm8654au-pon" for the PMM8654AU PMIC.
>>>> The PON peripheral on PMM8654AU is compatible with PMK8350, so it is
>>>> documented as a fallback to "qcom,pmk8350-pon".
>>>
>>> Drop everything after ,. Do not explain WHAT you did. We see it.
>>>
>>>>
>>>> While PMM8654AU supports additional registers compared to the baseline,
> 
> I can't find PMM8654AU either on Qualcomm.com or in the catalog. Is it
> an actual name for the chip?

Right, I would like to see some clarity on that too.

I see there's a PMM8650AU and there's two variants of it, perhaps that's
one of them?

Konrad

