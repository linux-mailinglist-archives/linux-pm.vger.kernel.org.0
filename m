Return-Path: <linux-pm+bounces-42745-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKwWAJJmlGkFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42745-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:01:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981F14C41D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F1A0301513C
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51530356A2C;
	Tue, 17 Feb 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTzlayDl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9uJw0g9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6C339B41
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333227; cv=none; b=h55Fcj9KtFu/hNyfByzGoVOsPupZ+fLuOAJCZjc/z7nPaB7WiJNnNwoOmfZOHXjadx4qdcfXNLO1DSo4zlH9ZQp8uIJdU/Uc2yFksSTFNuVXVqqEu25d2+K+6yXYuUu0ZRlsNozKQE3NK7W3liMSwNryAXgZlAeWIawEWd5sMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333227; c=relaxed/simple;
	bh=38zneP+037Vy7Mbk+7KlLjFuG+3hjob8r72QOd9MDa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pww32W6+Z2kQcQSA6wqfFAmKl+3zxX6suBucwOtE3nKJpnLqtn3Ehwb4Gn3bukwgWMSij7S/74GuQyrisO8i4xzf4goB7yelOjmg4AWEDgV2Y9K87NZSu1bDEowTjCNNhxghzlsBhI637K0GxQRc3dA6KL5KG9fSXn3FYJoW4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTzlayDl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N9uJw0g9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9MYo1985641
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=; b=DTzlayDlGdYju8fa
	yAFmDByAinRgzVfM6SWSMPjFxaivGX6MaC62mi/4vJNmg9s6XeqTrmXRUUbv7mtr
	9dB3bd0Octj5btmEE/Ad8cpF1BRoB1IPLak7Xop6n14+mguArVSQdTPOMC+mqNBo
	eQYg7tRT3tUredzttD2SZQ3wViNImzbS2o6Xzwb78imntNPA+AgfzcWdELY0rZn0
	57Zm2zmby4uBtrtWNcdTI+E64fjXD/ibKGwZ369VOgipC3uNsm1GET1CZaZx+3NE
	yFQQT6tiOW0nFY1+C3XJhHjfTzNqgrRUKIFvzyj5eTUdbVFDAISE0doaGJGQ8VyP
	VXhxgQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap2a19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89547ddf32bso31559896d6.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333224; x=1771938024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=;
        b=N9uJw0g9CoCHNeZTIOXZio5zIPgU4II2BE2quZY3UXh4sIiHFw4h7bvTmzWF26qgUr
         CLhQAGLFHIhywZYORfC7BoPZMxZ3cWHl5ESfNFiaPq4l8mX8R+Kz6D9YZ9UcxjuKU5Nj
         nh20bjre//W8Z0zNL2b60A6IuPdTVvGUspYcdqfp0CX1bSj8PlyW2PZmnyeeiRitZm4/
         TbR/IyjXf48c7lMO0gl2kXfoWMFeU9blptcoEh77Nylw1w6ffcNApbZ2wrYrWRlg7eO7
         gG5/uqm+Yuc2/HIt/8JW43mkfWUTmnAt1JsznmX/DdGhAcl018rfizcR94dsvWu+q5lP
         uC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333224; x=1771938024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n30d7bzwJAIRQwkxdoxxpoTkiSLbasbG65uhCKcM8aM=;
        b=w4kNm2lU8duI36UjylTVZtJeGSvXEOUQq+9kzy2aY5g99xCZvr4QSR6autD7YvWS5o
         AWWnAq8gkHrlkTO1q4VAFtTr9xs873d3i6I/Kk+sAH5xfSV8Kfo6M0kRaELB4kMBBz8U
         vuaAEW0e/or6ZO8QhF9SH3gCx7DhIZLEX6z6d0eKofFUqK2l4IlQNA3jO7lxxorF+VPn
         uHDRyOfxApfcxa2UaH2zseyvaHE4Uw+mE99TdnWVs1kKVS9hvYCgFDiFFrADFH9IjIgr
         0BGTeq3HwmwkVWBROUStYXbS99+CMTYhhU9TZqeIrvKt5pY4L8aA8Xxlxo6ETbl/wn6t
         cFBw==
X-Forwarded-Encrypted: i=1; AJvYcCUhHc4fV+w7HBRae+TKGToDQjqayBxEKJYEZqt1hT77SCZRPR67RmsPc+tmeEB8EWFsFL7BOC7xUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwR12tE960Na1E5K31NFmIvQ3PRYabwhphfcWdJfme0xXu3q8
	PcSp44CJXx4eXdKoun6/mgOn04Cj0bH3qhudEaD/MbtYwHaQOsjKlQzz2To74z2qWgt5ggUlP9a
	71iClGYtP8gjoCfe3pWGTyBi2Z9dlkNzkQ4LHag3IEO0dhG1mLSKfQXSofZKatA==
X-Gm-Gg: AZuq6aKpVokJFSrY1r07kXgvu9NGsDwgTJMKzurP8EqtGCUj8EKZmRS7ZK5S3eZyEst
	YKcdtlmEWBGAJTJl6EE4SoYQ9yLyY/AdlRukgRheMIbN9z9lZEDudiKjQzYelgGGDxq78rrUs2g
	VfsBf83schXW9B7EH/S+/Mxgd9iIeJPzJhTpUJqoULEAk0SsujbhQtRNU2fDXUBc6GwjXU5SCs8
	sqNqeLBa3ShSU1yyq+LCli9KJHN4gG0tAQ/E/hnZO0TOiAGm4oUCmdzQ8544ral4rjBmO6iaM63
	7zzqoAaPfnZlx0SBUmRE+Mp/0eHg2KPsMaB8kJilEjJ1132DkhGVU6hyFy10+lVRcr3cyjt6EKu
	dkG9eBHpGnkiqTeioaUFB/NF9e6Bvj/DTV45f//9YRjJozM46IjtjBIuF4+75QTNccLkZq7kJu3
	qYxvg=
X-Received: by 2002:a0c:e002:0:b0:895:3b2c:7708 with SMTP id 6a1803df08f44-897346241b8mr142991876d6.0.1771333224373;
        Tue, 17 Feb 2026 05:00:24 -0800 (PST)
X-Received: by 2002:a0c:e002:0:b0:895:3b2c:7708 with SMTP id 6a1803df08f44-897346241b8mr142991386d6.0.1771333223961;
        Tue, 17 Feb 2026 05:00:23 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc73f7b8asm346310366b.27.2026.02.17.05.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:00:23 -0800 (PST)
Message-ID: <fd9a728e-51d7-4c8f-a54a-a45b2ef0038d@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 14:00:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: De-acronymize Glymur SoC name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260217125819.281209-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX35hHGp4DqI9E
 U9ekdJw33T7GeUVinO4ndB9cNtTYfNGONaYza3ZIpBe5GDu64kcNZBNli/KckhF1IKESOdGg4jp
 s/ljNJZMjMB4eH2bQI7u6iGZihJTh3tVcFyIumJ1v4uOfAi3JIyguxiCoI+eH9WTTnbjtiE/lZ4
 KSDXKXgOLt4X1uEJbKrd3xA7GRXIHNUko3ADOmYep8+CCd7Nqy66weId8YcIDPb9Xgd1mSquk6U
 yfOb5r7qezwI5CMXxPQfhb3IPe94jEN72qkGmg8FcN7oYv0395LuIo6OUN8rZ7tdjPk0jwjE4hF
 RdnZVfu/b+HnfmR8YFr3zE9kUiE1hl1jVZpO0VlseX4FVJRokvep/nXLcLVC3Sk78SJoMeJ+gAA
 maysXLsdEDHxBQE+12Yrr6CDz+fSt78VvOqx8zmCbtaFRIh/PeW4jhNKbUzYESi6s6ihGMrtg3i
 v8KUozxSvwRbMyFP8kw==
X-Proofpoint-ORIG-GUID: gjLb0Z9SXR_hwhlryq90Wt2R-g1YuCvV
X-Proofpoint-GUID: gjLb0Z9SXR_hwhlryq90Wt2R-g1YuCvV
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69946669 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Rh8BIR2qzSpX2dRZ-WwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42745-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9981F14C41D
X-Rspamd-Action: no action

On 2/17/26 1:58 PM, Krzysztof Kozlowski wrote:
> Glymur is a codename of Qualcomm SoC, not an acronym.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

