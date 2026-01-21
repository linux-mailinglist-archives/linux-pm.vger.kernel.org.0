Return-Path: <linux-pm+bounces-41200-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN6CMEUfcGlRVwAAu9opvQ
	(envelope-from <linux-pm+bounces-41200-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:35:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 393604E8F7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 01:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BE427A6455
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21929A9FE;
	Wed, 21 Jan 2026 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQiSWKGG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZ6Pl7fJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E37298CD7
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 00:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955710; cv=none; b=rTSwG8ftzsbjmHuMBMG2fdLvHSb+DepCcjYY4TTWQxQo9/HyezWXbWcY4Ke3ONRwB4xDGzvydZ5mq98Yd1wVY0q/99+pWnxQfeI74Tg2lcEBB9pfRAbLgH7QttdtpwYsOkdVfrRPr3LnC6LAGgXUp/rhXoAMILjD5sEzlIZ1Fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955710; c=relaxed/simple;
	bh=EQVKceUIXOAz4pHZ2vc1oxOTTlsmcuxaZKBtcbKGvqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIF5FppAJ1Uq0NK5xmkq1YiYUqAExxBRfKwixBXjQDC8dbX+rAkaHxfUFaolL4Pqs7NxRzAkjjM1ykgVqdhM9myO8DwS8eoYehhxSflsAVoP44wk1XG42pRgEZa3FGE8gX/3rQRFNgq5zHTwH4ZR28GTdp/Zh0b+NpMYo0ekMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQiSWKGG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZ6Pl7fJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KHrJg42827486
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 00:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7fmizEJrf7GPziiprhDIaK1O
	ofwgZqdaWsiyWaFvgW4=; b=UQiSWKGGTaoWHgDuOzagHlnrqq8Vy5pN0x32vgqZ
	LE1BkbM3ngDEeUEObUOlZ4PbWrc+wVae8WqbTiscBEB6zN1dmMi3YgYe1X774scR
	j+WLbWcIUYCQ+gJi9gnFYxLbUwqa+ElPynu8do96KK0m5hVVkljyHAz2/udkM6js
	OLCESf0YWkdRMAi4QRImDO+SwqSe8l3Crl/uBqLH8ATonDOSLrpW2+dF5ilwNi4S
	fo8AWVSzyFFPsdjiUsn/nGTHrbG4EwIY9PV+Ypcfll0g2n7Q/otp9I6lBJabhC1F
	wdST+lq1eP6HvZpjxWIw+6J35XiGCNR2EvLCvORdk+ac3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btegk99j1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 00:35:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a241b5cdso909446885a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768955707; x=1769560507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fmizEJrf7GPziiprhDIaK1OofwgZqdaWsiyWaFvgW4=;
        b=DZ6Pl7fJxZhZkkjhk8jFTXk4clQqEIEoqiboAknIzwO1yMor/ZUmU/bEg+fu7Ja4TZ
         skP2KDrhLSUJ4fLYUMK08tF+PnoodLtPH5hk+mihT+opb+COGMPgkNcm4UY2F1McGEPF
         KwtMXZaYRC2JkwKsLfV67hci/fOzJQ7k5+fab7qUuznF8oz4Evl6l1AXZfpcADOqgPjc
         Vb0CPasNzBYz0BI1ZsImsYGma08FxCpdYKl7Wlxd0pavDW4lNBGmR44XSpE0P3U28sa1
         yBjj14+U1aDhXSbb8KhmGKiHTZgCRkj0Tx1fFK7cYGjWzUs0WKxRFD2aRrT1BlCGUiHk
         pjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955707; x=1769560507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fmizEJrf7GPziiprhDIaK1OofwgZqdaWsiyWaFvgW4=;
        b=W9AL3mVbD02OYkpr8h++OJZzK3ANeJKI2nV03BEbdDNsB0AS7nsq5DBYa2GJXY0iC1
         vkxNCrWl9G0F3qhNp8zQpHFC/8Mbv8WAg8RRts9pfDSNJQbxcPPdS0mNng/qd3Jx4HNZ
         KNJ9Ps/lNikNDsPJDk5HrBI0C4+/Cx+Af+a9rBep59HyujXYMFND4ZJ/x40rfQ0Se0rv
         hlS6pu4qaUXxKLYsae4dJXDBeA6Qn/wsRWosRSed1Bg+gtWy3HoHdbGHmcQkVCiG9i2U
         CfgvRwMWgufsvwifmxDEm3ivAfoZTHqYgFDRiVwzudBA9MwPdaCiCi90yPzYZNR1EOhL
         KCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF2fdyHRLIHn5oh++gQENm40lP3f1JpOHX94+N2+5HzMyAiCSui7YvcLDDB0pwLfrENM7QSeuRzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6tGkdBG8U+AJv/DqNpFGESTy44lh6oiNVbSyT5MC6btjJKq2
	JPUd6GRfvlRB7mcbGbNxzBJb8qfMUGuk/T6mm80KeCpfP8kgyb4ypmtMjHsTdjo1wooBvSsB7Ey
	UFK8967mhsknOd6AfDmsA6EFse3rZ1KIe+X/EIPZSWpDRorKa2NC3ThqzO5SYxA==
X-Gm-Gg: AZuq6aJGdfe2yzRr0AKm8Loa1olhIlkRssFhvV0OjI+y/pvmTVggHaUOxxS5+3xWRmj
	yIiMW358AwTzofeRteK1OMI3AFimgBaBc6IzTFgpZMDdQFYOBbMOG/3Ue/6uDzsg1rSEb3OAjxO
	IlzSzrC4Ta8UwzIbGlvXxXjap42fjnWMBkMLt3j0jJkX8lIoqmnBv3OBFjDxAMPxO8jiyC10rQT
	isVljN6VZcqHaahQXBWkRpD77qG4gwHdlfd4h3YYPbDatImIEm5dXXls4EO9L9727xxfSJ9h3rw
	T7yw9FnDf0iP1k9lFl/KEszT6BlIC3AmHJsTTbgvcTIAd1Qal9SlwQpcGsyvAoumS34gfWzenYc
	/QlnE03BsWol6mLufd6eqG3Qe527EKC16Js4CDKGcJJh4t74ygjtsABlWpZOQq0Vz0gwdnNV7di
	uhZhSGVe6dtp3cFgo8YW/4W0w=
X-Received: by 2002:a05:620a:4052:b0:8b2:e3c1:24c3 with SMTP id af79cd13be357-8c6a67787a8mr2360539285a.64.1768955706602;
        Tue, 20 Jan 2026 16:35:06 -0800 (PST)
X-Received: by 2002:a05:620a:4052:b0:8b2:e3c1:24c3 with SMTP id af79cd13be357-8c6a67787a8mr2360534885a.64.1768955706105;
        Tue, 20 Jan 2026 16:35:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33ef7fsm4351618e87.1.2026.01.20.16.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:35:05 -0800 (PST)
Date: Wed, 21 Jan 2026 02:35:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
Message-ID: <srigqle4tpq265x2wv3r3h4zmzjky3w3uomw4l3vdh6wyrx4cc@ezsbec5vqivc>
References: <20260120235831.479038-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120235831.479038-1-val@packett.cool>
X-Proofpoint-ORIG-GUID: htGIAKgAX-0o9rJ8MSS-YqvUK6mpkV1G
X-Authority-Analysis: v=2.4 cv=X9lf6WTe c=1 sm=1 tr=0 ts=69701f3b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wTZznuHQeFUpxERF2TYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: htGIAKgAX-0o9rJ8MSS-YqvUK6mpkV1G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAwMyBTYWx0ZWRfX4Oy/+PeO4QJm
 jZbEAdztIfTYZrBaTvWxqEUfZnQKwP0b5LZWpxkbzNDrJJc1QEyoAzrJ6x9bk4PiP7TW7f6tGGK
 DB77j47vWff20SOkByxGPgHXYBemIkpVrMQDKiiUKK8zB0zrp/dHCiZ8XrraTl1n/QCyiEDxsK1
 HgrjPu0tULVuz+UmT0sn2/JTToBQYSkimprugg62QP1Q6DHpoJvjPSk6mlB1rzeSOPcFhJHGrNm
 mnh0k4u5lGQNAkYUkvNXChPPo/SkomNaimmFvje7sThTOe5hEjAijM8F64shVnS7+LYjI4cLuT3
 g/m+fikN4+DKiNix8AybB6RqzLAlnrLOYKEwE5atvtUwXXVHNFp9HmlXb9of3oucqCkKNngdims
 +Z/QozG41xlt48xAOYVo9a9EijoIS3+uX/tSdoSqkyO9we3iH5Y+DPbWerVdOdA1JzTNgXpnIRY
 Gvt1Aynf26AG5E/H/jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210003
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	TAGGED_FROM(0.00)[bounces-41200-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 393604E8F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:57:58PM -0300, Val Packett wrote:
> On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
> for the battery chemistry type, but only all-uppercase "LIP" was being
> recognized. Add the CamelCase variant to the check to fix the "Unknown
> battery technology" warning.
> 
> Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> v2: removed extra parentheses
> v1: https://lore.kernel.org/all/20260117210941.6219-1-val@packett.cool/
> 
>  drivers/power/supply/qcom_battmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

