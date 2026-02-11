Return-Path: <linux-pm+bounces-42481-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPOCCfLki2kVcgAAu9opvQ
	(envelope-from <linux-pm+bounces-42481-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 03:09:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3A120B23
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 03:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 635DA3012BEF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BC2F83AC;
	Wed, 11 Feb 2026 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/SNLN5A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RWVR/hb1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C2F5313
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775789; cv=none; b=bzZ9p3zXuuroG3GRmc3+yYKihn3joQcy7mAw70zOTLdvqESZpe4HdqLBhtTsdmYN3PatG5eO02ToDSPB/GTbmH7UZ0kpVVPJPTQ3EsmT7BR/APoFrdnX/DC0I2oOA3oo4Ze0/TER8EkEMZ8ZzGyl1NkZE1b6mTcmAuBD3Ry416k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775789; c=relaxed/simple;
	bh=CL0jSb/x5mupyFP/xbn/3QT4Whuy6K1BOiO2UvAbZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlcwvCOnppvWAg8wyQHDgRD0SxVdGXoNATNgUR7asG8sl+lW7c0gQmV8yO6JoqId3GRQNylrNrAZ0D2zLeWp8Qoj64Q+ezw7MD0BGkkFXAS+EooJYRcm5M64+Cgik4o2BKm2IQzdKaYErTo964UII4o47dAYU2+Nl6RiyAcQCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/SNLN5A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RWVR/hb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AIoauo4013766
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 02:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FvEi9aj8WNc4PE/SSBlGvqhE
	isBuRuKk7oHbw7T8/2Y=; b=T/SNLN5AujDX8zuy7RoL6MDp+9dxEds6bj9zRi9S
	BUsRpXrHNVzSqj4glbqYyM1QwZbo35MAwR35pjXVFzXp80IOvVyHDtMHQDF10+py
	K+qqq0MnldnxrCuaJQdPNWb0xJbO0K4HFRAm/U+EpHEVQwQT/PBThZXHDPxWpig7
	Uz6P7mBFsO4J0tlkdbwwhHobv+Bth/1anwIJ01pUl72YfIgOQeKnR9uB6+MRfF8n
	c9O6asvSxymGtxY7GjenuFoYVdSNhD2BTQ+/Fn0kmkLwvPH9KOzU0xKuLmOqE2Ou
	Qa4t3KIFICK7Il2jsbbPUr5RiFWYEiSWkErAX1a2D/H2eQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8aad97ts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 02:09:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71500f274so173613485a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 18:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770775787; x=1771380587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvEi9aj8WNc4PE/SSBlGvqhEisBuRuKk7oHbw7T8/2Y=;
        b=RWVR/hb1QGqQvT08V5PTA+CT6Kg0n2AzKakx3JwsDWRqvtcIc/712TRDmSlJe/Umr/
         0DvJB1yPvoxBgwiziSaDZZb/VQQs8AdctM8P7VkWqWlh5wUY3RX42UqnJtoFLa0oKUZw
         Y7cUJfIpUk3BemMFZ6t77Xv3AhVD9aiU2R0mfxmV8gXcCKbN/eruAshlKf+oyJWaHnnD
         x3OpkNk677A5jn4BACMWXDngrav+sHEKWe/aGBtqb4yZHjyJF32ML4+o1GcS+xrhB5IO
         wvsNtp0XyqISydvtAfW2rUEeFcKgxkfjsEUAIjb3xXZMf10F2iYQ1J1DfRg/uEVmLczF
         jJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775787; x=1771380587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvEi9aj8WNc4PE/SSBlGvqhEisBuRuKk7oHbw7T8/2Y=;
        b=OHZVvCCgaXWc7nOGQTnyqB8nTDre7bPeynqZ+O7Q4t7abrjOC9IJgVDvHG7xmdWYAT
         fh09Z9niHuw85MtqEGvjUsGwleNolqd3kGpeRMLU24+EBXxNY5CINa7cihHRdpo8XleP
         fGEd6GQrB4PjfDW4Omlb6Q9hGFjZZNpmXC77S2JlVAakCTwcCVjzALZF/bmEj5eYecZx
         /0f1kDMgLWPiJDudlx8gitlHMJ0sWvTRv9J4YiGt+7CYawBFdxQoEz9AWYPd9ueyB17h
         cipesGxDFw9SXZfpcuoeJfrE663dbYizxMHZu8+WxY0zZBmvhpNnsrNpLhZ8cqAxJaOY
         R85Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCQSwDJmYpbyWtXNmDo2/JU9UnetAHLr/oTcJ1EU7q2y0MYlmwxOfmOxsMtMi8UT81cDb0Ea0n6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOr4Qo6j8+Ya1Vow3i9cqV4N4wqidnCL3oVNN7ZftSvOQlaHg
	s/2I7NjfdGcQFJj3GtcnxPYtnXhtgP93jRzBSBAYoxu4yZPfFbhZa8DnO2DoNVGmT6kMOVe/L6u
	gpcdQigdOiI0tziVS0/owANZoMk1pKR7zLzVn1bFkI9wipj+AGKJRUlj/YZNjyQ==
X-Gm-Gg: AZuq6aIU+4Iltdx/eqOLEteMiSWUyW6MMs8BS/KXz6+bofz7njbhmAiCMTcgMzQamVL
	IyP2xHBuPREDmS5K7itILQ5AJKSu/CmwHKzmyrY5ZV7IYwy1Zbf5dTb2IpLW0+kvK6dXwnHFYc+
	bgkbDhVCaK1NkmiMG32x4BRI9jRf6JojtzVxQu4OAKVPEuzKIWyoD9+tJxZN9iNTnDjrQAzsPIB
	zlbStjtYeYYu4O14qha4gA40S612+t+tEGQHPIRtvsfY55fb0sFKmH9eCnijSJhNljnmETT0qHc
	HGZuync2pwBKN+Y9CxBTmbteTAJDLKLPo9bgmAP2sH4SriSCN+NJknlUFghkHmjgVT65Ghn/edd
	EW5IdgXb55PQPdhnuAYXAupaIQWlrJxyygATUkh08YcEeciv19aLI3SyRXlRAJti8iba2qHFC+E
	KoRdJ4j1+A0s7NOgvcPiw5Ub2Mm+0yih1oWuA=
X-Received: by 2002:a05:620a:46a7:b0:8b2:6606:edaf with SMTP id af79cd13be357-8caef5f3f53mr2380200485a.37.1770775786664;
        Tue, 10 Feb 2026 18:09:46 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:8b2:6606:edaf with SMTP id af79cd13be357-8caef5f3f53mr2380196685a.37.1770775786106;
        Tue, 10 Feb 2026 18:09:46 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068e5976sm619931fa.27.2026.02.10.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 18:09:45 -0800 (PST)
Date: Wed, 11 Feb 2026 04:09:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: qcom-spmi-adc-tm5: Correct the voltage-code
 scaling for HC
Message-ID: <ta5hqi4jqmxinm2ykkdsoc7poq7ko4jv3qjuhibzm3grqk5ael@uawjompenmjk>
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-3-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210021819.12673-3-mailingradian@gmail.com>
X-Proofpoint-ORIG-GUID: Ol9DIXFUDlWiXoDOqZmldDVGPCKsnY6_
X-Proofpoint-GUID: Ol9DIXFUDlWiXoDOqZmldDVGPCKsnY6_
X-Authority-Analysis: v=2.4 cv=OoVCCi/t c=1 sm=1 tr=0 ts=698be4eb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=IiwsIYU8Yi2Zta6pR6oA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDAxNiBTYWx0ZWRfX7jrBfL035Ay1
 fNC2ui348vQk8RRl8H8jjzAmyHWUTfE2O7WYNeybr+KOamxDnqqEMwOSIUPNKX2ctcTIs8fcuwP
 RLQnM8/wmH4fh4uB+Nvme+95XXT/57JwBAy0kGelGnprWWo0Gc6pmRyIW0zJuf5nUrUvqZkabd8
 GRjlMiihIuT4Qg81nx1ExImMDj/+mrm1k2y1H3+C98kjfIndZKG/4eERzTPUvP1EyuBmSK+HjiT
 MXLjnSXTMZ1qUZij1ZJYQn3eh7NBEZadHb8TtKknAXsYNUV9KYgK6t1SM/Hs+iXUtg3N5x67Gmx
 RLG4fG1NwAjwtEiU3yCl2O0G+Vyu9KxIhoE8JFXNyVgYDebxJrCCeCm2jhILk7BBqsI2pM4VFSH
 0BIR3tD2F9nXNvnXnOGCUfTdu3/yCZaZ7+mlrJroyelun+SzC2TdM7zJSTR5og2YFDz5lDGinHQ
 8wO+KQIMNePS0t8zJ+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42481-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8DA3A120B23
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:18:18PM -0500, Richard Acayan wrote:
> When support was added for the HC variant, the full_scale_code_volt
> value was copied from the tm5 variant. From the downstream kernel, the
> scaling value is 0x70e4 on PMI632 (tm5 variant), but it is 0x4000 on
> PM660 and PM8998 (HC variant). Correct the ADC code to voltage
> scaling factor for the HC variant.
> 
> Fixes: f6c83676c6097 ("thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
-- 
With best wishes
Dmitry

