Return-Path: <linux-pm+bounces-42450-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INdDM9cki2mTQQAAu9opvQ
	(envelope-from <linux-pm+bounces-42450-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:30:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1A11AD60
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68863305A401
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A2332938D;
	Tue, 10 Feb 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1S59EV3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W21prD1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B49328B7D
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726481; cv=none; b=Mhn5W0BeoDiTnxYi/uZ5RavtuI2R5uTf9sl5hvAs4L/UIKLXCBvIwdco9lh8Bg4GbPEuxhiiCmtTC4jZU+s8v/jYcZiuKw2GMrceuH23vQEWAatunLWM/1f4PTbi9NL4KfT+0DWkYfFL8kG+0a2BYRONzvFUjLLnBW6XKMzpqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726481; c=relaxed/simple;
	bh=Uj5Z1pmXiHe45fAk9E1ZfapXNfkqJAuX+5L4tZW1EaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsHgdTx0fz5QB/k4Omv+d0FHINWcZUpLi8VbD+NuDMPZwwmrnJpYat/8T5LC9lEZJRoJMnb4pZqj/Ba8RdZ84s+4w/g8dxt1cbPSr69Bs9HJgZl8GWvio81zZWbC2vRm1W3rGfcSfHp2UrOeMs69mAZd+aC28lmIRWORQv4XCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1S59EV3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W21prD1+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6oPkd857026
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lucms4tHlGLGGVfdFQ6TD1R6
	Cqq5YSK8Ye7jCm8sfrw=; b=S1S59EV3IYKTyABHbUxwNiMEpDykR0C0ZqgesJ+n
	2GhS2EtmmGe6mK6kqOwoqIB//327EmzSbA4LXM+R5hw3Z1kUTNNbu5Z47C48bvdX
	+OHgF0taVYWVLhKu9eTlL5d/oJ0H2EIU3f6ezIHbhF24N/iLKGNt58JqfmLdu92B
	fmmR6lHeJKgGhBQCFp0V9RZacaQ+gcu9mzVI3AmsICIR8UqOXaZrix2ZKLmiJQxo
	OIE49atC7mi+jBnosMDz2PX/fzNSy6q6id32ip8HoII9gah+thAZECxxNUecXTql
	TMd6hdMlJMt103GU8uVIZ7QlmVAyZutsbU8i6HoaYc1Q7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga645xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:27:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70cff1da5so1381442985a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770726478; x=1771331278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lucms4tHlGLGGVfdFQ6TD1R6Cqq5YSK8Ye7jCm8sfrw=;
        b=W21prD1+a12k1T4W8WWIqlKhijiN8DZL9lhL+JfLAONXKT+XYfh+AWeFPrcrTJg5P3
         elfJe8HygWEzNlAS0OIni06QOUhvP1WlHr7bNxP6n2dM910Gdfpa5wqxZJGrt0pFhVVy
         3k3r0HUCYaYj1p5sFKXejyyHEYoW6QBseZJ6CNwGjSAA59YMngW/B/nALqQbfMOIJTOm
         f1yO4zE6EafDx0n5QavQ5fRVjydLiDcCS6KBdB0FfG17X9I1+TRfo8YOQFcSnGsHci97
         mQSkp3a0pD/MGk65LvfGZw0n/uPjQDLBKLNVdRG9g/AxaYqINPk0Tx52nnlzCSYn8OKY
         d9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726478; x=1771331278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lucms4tHlGLGGVfdFQ6TD1R6Cqq5YSK8Ye7jCm8sfrw=;
        b=qE5z1Kf/d5s4TPlNfLMFUKIYTP1WtoXBQcZ3Vuc+QHfNrhXTV7AMJEs5CWztyDW5d6
         /puX6ccLGHt+Li60RYU9Z9uBHR2jnNBYbKgkFttEkkWPF8gqcVu/BB8ok8ZGaLZ8/fAw
         uQsfKklnGdVFUqwSvaR2zHUu7FI68Zdg8INk58UNYVf15OziUjyBYMsVkr8y3N87L2Z8
         +rhB4JK8jadV6o5B8mIs5FZOlJvY8iF6Djp3yYhIty6VBxRHMgGUkYzeB03kwUWkI93j
         iOp5sTikQ3gyzepA/8WehSikwny9DDdEEBCseG1ClddRY2o5vG7zK/FIEduvyLAwCP+L
         HbiA==
X-Forwarded-Encrypted: i=1; AJvYcCU+xwGbpB05KVITi0cQ270VgZTJFAgqrpO2ToSrdHiR7ylvAJHsaGk7Jq347qVz7/6FeyS0eTCVgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzus6ZqRNB5Hse8LW6DBgO6l63/ORyD+J+xThYb6xWzFRE08Sxv
	pnVJWoPCuSVUc2PW2Hr/+KXJrVsF2dLZlhtiA3IMQRFb/JaTAe1xFA8OqWtJe7m96bGNWUFQo5X
	/NPotZrpCgkkTg/1bRuBHKKf4OAuBgyXb54ARyEFxzTnM54NKQvKQLXgB0Eqx7Q==
X-Gm-Gg: AZuq6aI17eB8nr6Wzo5pakmyT31iuPt3f9hPXoH5Z1ZUJ2phDjQ80UebYdRqpR53weP
	Kqfp8abkx+e+U+hull2q6nRY7L4SiT28Ls+iIAEfunbk8g3oRHa254FPh/QuoQsoQzbCF8ZSSTG
	NNoNW2phosDU8FlbqZhtZ5BElur0fXVYS4L8JM1YWvq9DqXYbNgNtK+Q2Yw1gfqJGSKqW7IyUG+
	ChWtEd3GGGufomtvzEKSm9PckH0atCPtvSPeV3mxil40fkWF/v+yz6N1XnJR/0J3hIyyqe1RuQd
	B1e9Zgni3MLU8DKSdOtRN191h3tknhySJ1WppjFxEGPrVrLSN7k+7NC+23Gd+rEjzWw+aWjLFHb
	F7XQce4alxe+q/w82V2o/eSHTXJd17gPdwUMTtCoomHKdzHBUQ0qDQ38zhGgTRGWW+dPV0N09ml
	NndN7Eomf/gd29rDuN1ZChkAJZ/oGoau+y8uY=
X-Received: by 2002:a05:620a:2682:b0:8cb:e00:8c0d with SMTP id af79cd13be357-8cb1f76e93dmr184902685a.74.1770726478348;
        Tue, 10 Feb 2026 04:27:58 -0800 (PST)
X-Received: by 2002:a05:620a:2682:b0:8cb:e00:8c0d with SMTP id af79cd13be357-8cb1f76e93dmr184898785a.74.1770726477866;
        Tue, 10 Feb 2026 04:27:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm3279610e87.4.2026.02.10.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:27:57 -0800 (PST)
Date: Tue, 10 Feb 2026 14:27:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 4/5] usb: typec: ucsi: ucsi_glink: Add support for
 Glymur and Kaanapali
Message-ID: <gb2slgpdkrfqdkgdwifqc73pd2tbc56yju4n2xghdmxbbyd775@gzied6s2gfwj>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-5-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-5-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9j5jM1KywH8QgcGPQL_L1-Zyli9czDXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwNCBTYWx0ZWRfX4nEvxPrI4DjW
 kPw7V2cgxP9UpWzS5E/0SKd0Py3zKdOxxVaDsZAwMgbY1hz7okvQdIbVOOklzghMskKGQzo5RGl
 r+vhQrPoYgM/gWKUVH2a+VXWhiegnBkQHFBTllAU11vAULE8T2Neia6LyaGTRbQCLkI8rtiDXCB
 bRfFoPudDa2RsCiu0hxUDza8L2LYtRox3DXMAz1rjMORvxOFOUL29if5TgrCcawZiNaJ8fdJNo/
 j+v/kzR8vqGHdFr2ZmgF8F2n1Qu9b7hIdWW1wK0Wip5lNH4wJF0nN+9Yqa1UEC40neyh2m8DQpg
 X3039vy4D7KkGhAO3EibU+pp39zoDTpQp/zssuVfHnhf7uin9Y4oor/6eFS27HEBfIAoDRY8awg
 rsWWYV7glrwaQzXUBF6eyFLvLTRzgnG4DsQ5YKE4zZypnKNNYY1VghfMJ2mEOzIcA1J2B6hx8Fg
 S7/D/2kdrqmyf5sF5IA==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698b244f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=401012Ij_cZx4E-EtZUA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 9j5jM1KywH8QgcGPQL_L1-Zyli9czDXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42450-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35E1A11AD60
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:49:14PM -0800, Anjelique Melendez wrote:
> Add Glymur and Kaanapali compatible strings which both need
> UCSI_DELAY_DEVICE_PDOS quirk.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

