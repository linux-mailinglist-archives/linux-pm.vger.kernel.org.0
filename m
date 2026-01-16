Return-Path: <linux-pm+bounces-41031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976AAD33842
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48433068DEA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96D395252;
	Fri, 16 Jan 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJkbGys9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8zKz8d5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1133A9ED
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581107; cv=none; b=B0+72KATIkaxDIfcLITbpZHiSe4xWnxZ+ixEmrJZapXrDDvpj6gUyAm/OVgf18zVJlywW9/8goFcoKdwpFoYmQ6Lzujnxd/iPpkFWkvrNRAGBITJWm4rErv0FCy4/FAXBRGio4MtjbiQgN+mrXe/qLPSPNOFTjLdwkEAqwIs2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581107; c=relaxed/simple;
	bh=NIOTqi6bofcOy/4Bxp2+c3lrFeOrx1ZMerXKzoJftWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvIBbzEyQEBOIU5nUiWQlovxiYqhCEZj7RYTHS+gbvE2dtHpiP0eGfoB8xJgugBjPmYrDJ7DKDmN01FVxx9SjX7cs8EbAvsu/hRRQfHwMF8vWMx3WWr8EZSpMqcEWdcIO55USWST13kO6e0zODHOqYLN3fjR1708Fofamop47ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mJkbGys9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b8zKz8d5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G9iTbS007060
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v4bZnyJ/xEnoXZ7oHHzwCG7b
	wxECqYG+sL+dq81P9rg=; b=mJkbGys95rXQrQDCexpDp4P6jNgFdnchI6T9bptH
	UIFN2xn6/bOviLpyX0pn1FfHeWngCI95GrRf+U6mKNCTZKxWFxdBH/EBqrPrtxA/
	Dci5qpDpFW5YFICxtuhE6aujoD6spNq3p46xnwS4vhNhhYF+pxs4nvKFbtjv1UBz
	hTZKGu0P7uLJgYl/88KIInwLhSCEXC6az+iej+kJ/2nmUX12NxNLMn0M8jgMga6+
	qe0GDalBOHRjewOa27rR8pFQAtEsEogaQxKQhF03L0MLiuz3WFwo0fJDweT9OIXS
	Q/IyV2Tgr8r8y33Qkf7SdqUS6IAsxjcgA9knQUK04VIxWA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqjy9s50a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 16:31:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f568048ccso2067986241.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768581104; x=1769185904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4bZnyJ/xEnoXZ7oHHzwCG7bwxECqYG+sL+dq81P9rg=;
        b=b8zKz8d5CYMrETA7pn7L6gQ8r3wCk77v8yuy3O0hF6l6Ha5jT01yNQRxUgm2YSWGms
         j0KwarfnYyOkRbhvfidup5IKBbjT6t2LfGBzxNkuWs+5aJ2zqrkoJUy2cOzxyQOh37hJ
         y5E4+GW6XRZwX0zEskQaWOlAQ5BxZjIjvwUqG/WsR0fGcnbXiBgOBxPDAjFpVcAuoWo2
         MgXfBRO3k8YYGeZYDiv1yiyGJCzsU5/rxyykezhLwMoZaP9CrNvfs2aTl/ovWs1Q/BKI
         3WaOce+V8/72t/9e5CGcvrmHmqPKX7Kh9WOFqjbOb3xRcI+HvRJvzQb7sWyDltmMGuZp
         EXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581104; x=1769185904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4bZnyJ/xEnoXZ7oHHzwCG7bwxECqYG+sL+dq81P9rg=;
        b=utF+HFV+zssuTXWi3Ug28d0fUC76wTfGyG1ns//tN42D/8wiRKpm9KZ/uYCX26I1dK
         rBQ+4g6ksRw6s5FD58LF0nsXBRa6cPQPKbRRR0xBBEIgQPMZAsVCJzdtOVeS1iWczMID
         RuTTkvGnpptGDztN4MvoQjrwjbFRYkHDXvOdwIoV2fwkFpVHNWkQiK0ax/c98e28cHMT
         KyNSMuKdPaJm2ooFCGMOZylQ1IqBeBfW2f0X+b23xbKODk9UP8ZP9WhShhtjRiVtKdfN
         XHmMm4tExp5eY5ZiDdEYLu3O0lZDFOHwDvoyqLOryOFYcvkvaPevvGnL1WChKeOTJULf
         7oCA==
X-Forwarded-Encrypted: i=1; AJvYcCXHSYJsNRd4dVtujqHGGfC2XiE44e8hgH7pc/z43G6mL1K4jcHFgp7Y6bSFrOU7+QIDP6ZAPLyCqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZc+I9VEx8I5WZqaDLyhxdwvAB5YB1ZAJz2vcItvlK0VZLF6M
	DCEOipYtW43unVBW66vzVQPduE5JrhXagO+ieEuhTQ2pNu431bDNBAsza521IqLbxi3m96lzGhj
	bf1dtrIs2G4J3cayl9MN8LoZt4zwiX8RKj8+8S71iuTgqukrLrft3AJZJ9wcY4w==
X-Gm-Gg: AY/fxX5ZiyI9ykQK8EzVGiq5YBRO1KOnRbHYalwdzB2mCSMDCmusVZe4Dv6Hp0/bNDK
	nUzN3o95QWPtpKJKDKvR2YaPZh3WQLEweUcBWZaTQujC9aI+Z+zJIIdaB0LPX9/aGB9eS5hhgQs
	KEpNq0Yh7+/l+x2kIeFTXtiA5EqeKsLWMp5ep2ZUwjFaqy8YUCXzOavLxOTpBJ7nm52unZVAoG+
	cbnbD2Sh2Nq4jzh1Ot2lvzXD7PsmsB31IYHhCYbw5U0ioTE8sPWE8rxRNofSCHrOAVB196nWRhc
	54m6eJBCctmeI5qX4FrHsXEp/SuYiKpLikhfVid5GUH6L0/kzfDkUJX9dNtVZHP7HBPsEkTkJlI
	YyCL2pIhp4uK/gOpp7Ubdpcdta0JWVzpTvv7WvckSix9FU4nLQ5W0zCjU5uPz6PQ4CqMX6Q8thL
	p4tJRbGBfwjaUSpjXfQWjaET8=
X-Received: by 2002:a05:6102:4429:b0:5de:93bb:c53f with SMTP id ada2fe7eead31-5f1a551fe82mr1128892137.25.1768581104316;
        Fri, 16 Jan 2026 08:31:44 -0800 (PST)
X-Received: by 2002:a05:6102:4429:b0:5de:93bb:c53f with SMTP id ada2fe7eead31-5f1a551fe82mr1128855137.25.1768581103913;
        Fri, 16 Jan 2026 08:31:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384d8dd5asm8375861fa.14.2026.01.16.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:31:43 -0800 (PST)
Date: Fri, 16 Jan 2026 18:31:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] interconnect: Add devm_of_icc_get_by_index() as
 exported API for users
Message-ID: <ms355zigf5jkpgzqyq2dtqr6nl2kbcbv7engerqsblmgm4643a@avthixosdvlo>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-1-400b7fcd156a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-milos-camcc-icc-v1-1-400b7fcd156a@fairphone.com>
X-Proofpoint-GUID: _rvVpMU83_lDh8354S2aPsqpUXQMBMpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMCBTYWx0ZWRfX88Bd4+Y8DarZ
 HJABreTPnt/b6UpxKpERhG8cN9SZV+TYjou6UrrHkbWF61KmSixrnzyjqJuxcZBhTKy0oI0Ew7q
 soLzWdrjuWUBrbMlzSIp6hqxvfVI//MH9z8EWHXXludMmvybOmlrsUD+8SjlAyXVKdq2rq749zT
 tFs66gBo8OlV9FFzvC6y/tteRBx7+C9GzkHWYXNO5dpMrwzRcadUha6w/8CrYQcP241mVPBv513
 ivyyBkBQnWfpLZ+fhnBujLkt6vuA8cwOv1soa9I4DwFr5j+aCr8ZbbHA9gSHaLzj/VzpWMH54c+
 Vh0GI3g3u7TCljxXwmi9DynBt+z34YvZDLPAXQWmINyYdDhuIv8MTXE++v1VvSMIXCDxQ9rNWf5
 kRsfVKX+zgDz/dXdS54nx4B7M305HlbcnbMaDZLYnv9RF2xHOv9gF42mi+n/7oQZC6Zi6W0f5zI
 5TZ3nzZd98MDYAlucGA==
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=696a67f1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=a0Fvf8Pi2LMrmEsLjo0A:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: _rvVpMU83_lDh8354S2aPsqpUXQMBMpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160120

On Fri, Jan 16, 2026 at 02:17:20PM +0100, Luca Weiss wrote:
> Users can use devm version of of_icc_get_by_index() to benefit from
> automatic resource release.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/core.c  | 20 ++++++++++++++++++++
>  include/linux/interconnect.h |  6 ++++++
>  2 files changed, 26 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
-- 
With best wishes
Dmitry

