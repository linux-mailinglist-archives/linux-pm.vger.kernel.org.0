Return-Path: <linux-pm+bounces-43084-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD1/IdQUnWkGMwQAu9opvQ
	(envelope-from <linux-pm+bounces-43084-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:02:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C211813C6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F54C303EB80
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FC24BBF0;
	Tue, 24 Feb 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REchMWN0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jECF49Ar"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE726A0C7
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902159; cv=none; b=ehL4fsqHBlZgyiYctgNvKVi0EXvF0PHF2bNIhfeOLqnUth+pQX+HMOMFdxHcqOTDfdUhKuO7Jst03J8gxYL8QfpiSJiyqSpSuXj7jBmkG6uow2tPl1rcbJRokyddLs1hlMtdS+SFBMZYFZ+SuaE9OCgaWrnZFwL7DrjFuznI1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902159; c=relaxed/simple;
	bh=GO/u1prp16seK96r3KI5iXXMSm99vaPLp1pCX+ibIb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RERJthp0aW/hbsBRIlKZFiZLKXrjtrzs7dlInxU9VkDQXj+xN0US1LCiXxAAbR5+OcLOlPpMADeiHTmaZSCq7os4wn5z/Varra1kx0E7KDAwmOp5iSTPai6lSQDQldeN0zLKhCthKumuztjKKyeZW3rDpmm6otC17Br2qyyatvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REchMWN0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jECF49Ar; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O2m7CM1265689
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HrTy39PWaXTC438yhpHEFLsb
	zyunpBoR5NQZvAr9AzQ=; b=REchMWN0s8t5ugMR1rbIF5uzO56kTcguYoPRN3yx
	hsWNx3SYhbrF7toRZCPlgeowXihawVyY7LCze5QYtJv3n8nmYe5QoBd+f5QGDgZm
	MMGJM0XecovhksAImBRAVBLPWa1t/YayPLpP4GPPcwjLA0nUeZApiS6kHtmE7JKY
	AULbVQypuPI6Y4ndEzOONurRuBHBKiQkWDLD3o/JyFcJwck8GrlAUj969cZ8kKkO
	II8Ks6CojIM46cJml6uTISCP/tkRwvjCZ2fWEhAgFlNGAXXOYcwIXmcFrL3y0/MX
	6An+AlkrBgal9BnShrF0EfJ5S8GPSGCib3ysYAF24c2Fpw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8ttnv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:02:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c7166a4643so5019179185a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 19:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771902157; x=1772506957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrTy39PWaXTC438yhpHEFLsbzyunpBoR5NQZvAr9AzQ=;
        b=jECF49ArC4XqapZGjyH6yjDtT9EDa0F5lmSiADSyE37iRGnXC6BlMi7aFpOpnsw45E
         8Hf08lpDCmMAUYIMmMOEIFIRzk1CtWlt27mxnoEBZsLt1Yd6hUY/agm0FgFWUIqiuvqM
         ZQ1e0floYrtEu4ZoiVvbsBXXcBlLSkMkHtNXhI78sbQ/eA9s1ybbFfJdX6eIKj2IhVAu
         rFCaD7n5mFpOPhulrDNGX8dhJpFAaQDcs3bOM1hAVvINTW1jkcX1J1vVZ4WjloVEgdl/
         hdLlzQ4k/sIeoLjOI3w1l1v4WOfDu4bXTlvCGOljdC5YxmSmJORzi0Fg1CEkWETn/TFh
         kHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902157; x=1772506957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrTy39PWaXTC438yhpHEFLsbzyunpBoR5NQZvAr9AzQ=;
        b=CUBPg8h/+YkOf2Mw885c1pulUnWMOtMqCkOhM+lGgTEjTzzfFoka+Qg2qNgVCeiq5f
         mJMTmfPs0l9QwfpeQmimg8g67ylsMBRz1X1mqlrUqXrXZZnMbXWTnjLyhU05GvDZv7D7
         PMXI5bQ9QyoURONikesyk9RyDnJbP/aC3VcMImb22pBSGf7jt1ukD/9SqHJRsx2+/QTW
         MnDxiLjTiUZd+TasnC4FLNgjWFaoBLjcFcWHOYbdpK/+x8HPooitLbIx0Mpz9sA0oamr
         WdVyfF356J18mXSTJp/k3n4e5h3QhE7VRmv9iET596Y7SawBzwuiJaVYcmHsIj8qmGtA
         6UeA==
X-Forwarded-Encrypted: i=1; AJvYcCXGlkuZFvYFepvCCw6xQdCnVp+5gFfC8keDl1qieNK3h3bwd7sbKVKLSgy4QqpQg6u99C2KQ21Lvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnIZRskZxFI4sjXVksGEBQmYyrh2aFvBHMwQkTD0d9osNaMK7
	Ts24IDGkUpG+XbWT3TT9bDtRsS2zzdg7rN/kiiAh7eF9mtRdFyMgSSLSxUHrtefEOl6FZLw5ftx
	lKqqYXkuY/Y+Cn5plx9tzsjMU9crCqCAwTA/BbZhcBd3nSbfg7uTM33z1aT5l7w==
X-Gm-Gg: AZuq6aIMvYc9B5I6bmNsI4+3ypwjdqDECQCD/AMARrn+TXHfWWzqLVlTjxgrvul7E/7
	4cC/qd85Z/FUwGsTM+Ll/bRplFlfofAlLp0XIqCwLWx/79vZiNu2Hk/ayxlCyWZVtgHOVsQHzdW
	ZaW2Trpi1DyxV/36bnK010p5hkIU7fCkEjluUzAVNWdZnBonjOfjM6Cvlls1rAlBavCyh/7Yv+N
	ShEJZeP61mXfjPwcVjDQ2Ut/0U9u4PJkqhE429a5fJf0kgtkB71JZfQ/OFpgahfswTNmymNA71H
	x0yUhxwJzsAeXhVvR8JCoMdzIpogGRbXCfAyJjvYknygZrTl/0fLEKURTz+mLcb0DfdbqXJDG+4
	uR8CC/NAEF46hwAuJhWZtRCU21WtlMtkTdtKeko2+cCmm0FGkj6c1qTTU6YgpRQq3AKimXkH2NJ
	GfmJEKDit5+WCTVUByDvUmo8G6IayPlRynfsc=
X-Received: by 2002:a05:620a:2844:b0:8ca:2cf9:8198 with SMTP id af79cd13be357-8cb8ca6ea22mr1311339785a.40.1771902156699;
        Mon, 23 Feb 2026 19:02:36 -0800 (PST)
X-Received: by 2002:a05:620a:2844:b0:8ca:2cf9:8198 with SMTP id af79cd13be357-8cb8ca6ea22mr1311336485a.40.1771902156299;
        Mon, 23 Feb 2026 19:02:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7af4cdfsm18395151fa.44.2026.02.23.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:02:35 -0800 (PST)
Date: Tue, 24 Feb 2026 05:02:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power
 Domains
Message-ID: <zhtowrwitid4faxcfyixp4nkwmyoc7fmjtldumgqpedbtdmuqq@wqxcphyud54p>
References: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
 <20260223-eliza-pmdomain-v2-2-23fb87eb70ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-eliza-pmdomain-v2-2-23fb87eb70ef@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=699d14cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hcFGLVdanMBVBe-XHWYA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: AM1eR0rU1kXaxTwI9f7DQOSUFkv-9ESn
X-Proofpoint-GUID: AM1eR0rU1kXaxTwI9f7DQOSUFkv-9ESn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyNCBTYWx0ZWRfX1/mlyoKjMk37
 robJC3NTjt9GEaW/8ONYK3ulckN/C/8vLmWr/OGwYkfTWc8NX6LsFEE7Yln1OHFjXuFOMsOZhOe
 oHPQy8o6DtJoDLNNKb9/2vmg+6YYB55aBOfJGLOLhgtk7omC+H2HuHV2O9NrIK1UAl2zEWTcEDP
 2N7d+kIZF2uNXYRl36cJHD4D9r5ArOBa+umdDGQMltw8JbUr2yq+dxZC5IvaD8RiPX9LZpXJ/tU
 EVTPAsg3L2vyUI2kw7+l2MGnpvOKHaRrxhSu4y5mFZn9SmF1AZsioFtFFjERGsaE0+Hg+i5leXC
 Th/IqjLTprEOiuni8W+oEN6Lt1z5Ctyk3WnvfjMpC285pawmqnJiFjVneccO3rTHzrO4ENn3R8w
 xEiqt/+LSvq2e13uocOXfA5M+xm6irvM+RDTbB6IJ7b85Th/X4ix9syXKuXburhydIb0Vnm22ji
 xBvfUJUDX143fQmpf5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43084-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F0C211813C6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:07:56PM +0200, Abel Vesa wrote:
> Add RPMh Power Domains support for the Eliza platform.
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

