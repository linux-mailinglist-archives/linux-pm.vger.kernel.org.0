Return-Path: <linux-pm+bounces-43144-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PSoDw6rnWmgQwQAu9opvQ
	(envelope-from <linux-pm+bounces-43144-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:43:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7278187ED8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0860B30DB190
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55939E17E;
	Tue, 24 Feb 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGTLrYGP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWKOXaFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854139E166
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940315; cv=none; b=G3YXgh7NoIgavCq3MPoLYIh0TZCzzuh1PKU5OqXAkxtEPLYDcMT3QHvEpxnbfR54BFi3tEW+lTRWtBSYqveM7gcYXQG9obB4GOvDgU3eql+5ewXgyXusUeyL/kbkmTqtIWpOg/MtPYIrjpbDbRAE5prlkuDnO5ibijG0jZMf2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940315; c=relaxed/simple;
	bh=RRHaJrQjbqVQed8zDQo6wtkCqIAyXF0KnuFmP6oFYfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkVzktLPRIZiyGVs9f98WMs/Q9LHpeEiyI+eG/2ih62PwHS1wuHm3kpYtjyxJC6ghRUFXYDaGeB4H6NMLYaYmvS1c1C4vjKNdLoUGOocWWLoGSCK+XzA60YWYIXluxVoex/IGy5dvDowIuQ4L+acut853y1OYtj/jIlYWUepNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGTLrYGP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWKOXaFk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFSqr3570245
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xoEOEx4Y0WhNvSWyPsfQfKmKDc7kHerfzdp+1pHAfkk=; b=fGTLrYGPR0BQBjM8
	SiirKEPcnhlqnW6SwX6QeC+gtNd2e+8pGPnJMoDLLoAIvRJQrNXkGh3kbc32Lg31
	Y1SL9dHAlSDMdVDwBT1qEs/t7gC+y2kO82vJ42TPYljGUdZPWo+YVuUWZ2i9LfEY
	l/3c6rVnrvvi33ucmh7AQk8MEC+aEvd6i2AT0vw8ioX5MB51Gw8enfLI1u1cuQd5
	lkRpeVPqKV0memmq/LzkOLhj/SeUwuNEDAt0hgi1m14f33IHk78jXkA+WbBQenlJ
	zmGHM+LZZSe3gnRTFlFJn2itJlLs74s2SGUMHcgQxQc9hhy7Lku9GBTsyykbBh6V
	Y+qU3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8rccxr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 13:38:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89496f5086dso56798046d6.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771940313; x=1772545113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoEOEx4Y0WhNvSWyPsfQfKmKDc7kHerfzdp+1pHAfkk=;
        b=BWKOXaFkBv8O8Cl5ijsyw0Vv54Ivo3etvO5p1oKsyTK+dYJpQB0ByuIJ6u3EtmLge3
         ZyEdmZHEAqG1aDXwH6kdxqW0+T//u7IDin+LQBj563X7v+U5kvgTI4LklHCMjN2XK6IG
         gTxSNUkr3JaQ4mUvCzS0BVT4euojglCVOieFMVazTTkm5aTewElWF3nI5i4YjbE2Byvb
         c4Xx7Px/6q+kuMGQrpf+hETQ4Hhq//Ecn8D6/2WyedQ1JhtXYXvZ1IF8Wdq3eliQr2aq
         KKRSSpQf/sHMM8euwSXBcduGP6cVvYVI4XiWHWiq6ZKa7Hy3PhYYsiPuOneQMSnQQxAg
         UsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940313; x=1772545113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoEOEx4Y0WhNvSWyPsfQfKmKDc7kHerfzdp+1pHAfkk=;
        b=g/zt1Tot85X6u6P3Q/tj8BGd7/NiqIvGO6wPhLOIqhuV0R9xGFsi58hCyBtatNyKRA
         Nwx2q+jpfg19sgWh4hzX8gGmyxfkBJZkCI/kGpnGUcNrMOAbbtDyvCNO6tg/oZw1QalP
         ot0MZbCbNsGLrLxqmS7jM3KC8NbmrMro7bg7blvpOt/a5nycySvfItUjGiann52Er0pa
         2U7PgDRjOjIY90PmOCw1frrZ+9+chg+hlyJkI6s50P195NqqS7O1mUN0jLzEvJ9ZQ/DA
         QasH3Ts2ZFvSw9mwANtnBVI1xw/SxGwo0kMZA10pYR53K/6KDnOLcYFRd/REhWYOIPS8
         Ly1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDrQHpRYlbSdf8VTZ60OOYPw68lPdpmr6HCgeJ5bx51ontJ94j5wSwg5QH/tvLIq0idJ+51bBrVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7zeWXi6yKk9T1GEUVGE65vr63tzwi/+2Hl3vsBBIx4mIax3m
	g4WvQ6ydMdQJjnzXBbLiSLYWdlR9mIVsR36HrANMO2zWd3JoBcizjI5n/4XzqOCC6ny6zm4WSjj
	a8Hm+fBhsx3JdLaiFi1jk8BEqt7IsxMRnY5YoBkmpZ1Dh2yw6KlGkelCBSO5C3w==
X-Gm-Gg: ATEYQzxl7YnrwSYjf4QT4TILhoNRjn3/F0wG8REXohhtEkM28uAjf4sXl0KFUU8+9Rn
	mMFbdQLG3rxhhA6faBJMhgnbqi02lZIEGE2MRXSptXQT1PSoLYpBBwjTMuzktXHxt1eTtt8l0Ak
	5Gml4YggLJvLUZcNHMvJYSbpZVrcqcSz0+jChl7fdHy8//iWd7XLxLykA/5rnVDhalsnEn4Ky29
	eKH1rZ8dniGXITrpzLepDwcjB34c7XS5syfY+APhYU0CXOJh1oUL4iVUY3qHfuAylwLFtYvZcFq
	fDrRicjDuaczTcMHfGdfYjCOgl1DNpTREMIc2oyKqVx8eF1a2kaqm7Xza5Pq+t5HKk4PTeesnac
	cRjAYHe7ZmtZOXtahEcK8+aErj+hZZQUGq/cJ2Muk/+I8Js7btdtQTGIfptMMfU6O9hLBmNIJOl
	Bws44=
X-Received: by 2002:a0c:ef86:0:b0:899:a83f:a8bc with SMTP id 6a1803df08f44-899a83faf34mr11450366d6.5.1771940313088;
        Tue, 24 Feb 2026 05:38:33 -0800 (PST)
X-Received: by 2002:a0c:ef86:0:b0:899:a83f:a8bc with SMTP id 6a1803df08f44-899a83faf34mr11450116d6.5.1771940312552;
        Tue, 24 Feb 2026 05:38:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084caea29sm421594866b.25.2026.02.24.05.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 05:38:31 -0800 (PST)
Message-ID: <f52f3f86-5ec2-4d3f-98b2-5ceddc7b71bc@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 14:38:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power
 Domains
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com>
 <20260224-eliza-pmdomain-v3-2-6e13d3aa70a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260224-eliza-pmdomain-v3-2-6e13d3aa70a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2QnYLP4O04LxwB8sRI7x0zyFslo41thF
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699da9da cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uL3VJkIVk3A2ITQRuggA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEwOCBTYWx0ZWRfX9dw+dZz7HPbm
 FbiD4X0gtKwXwdK1FmzdJgiehe+pILysdXi6flehQpURF+3uIJ6XO2Fs3eRiMUiQVJzWdQ2k1QU
 O1uMigEt2UWrGcK/Y3MiuyYb0Rl4/q1Pm9CfhfADyYbNfR/tkgfsDwDOJ0XrLIwgJfk5yp4i2fb
 wGQA4AAYDBvFzreNrc52QeLhNshUQ0qOBY0LYo3jTxY4LzN5Ibo6LNSFlXWXs105f18NSyA61bv
 kbdsDBty8xpFslUlPVOmrIJGE3XrR9Zc0TG5W0QIXxwj+1ZJ3I5NQO6PFmwbuAq/aijea19i19x
 jkXJHFp5w1sasIagPhVS7+EwDfYUSPIS9GFq+Y7/0hGO3o0J5C0Tsp7BYv6MtI9U9QcKIRjZdqE
 MlEfukxJtV4iyDdm0ww21J8IxOacAtJynB5i+X5u60OGlgPX/Mo4bnrBmo+iWtbBCNAlVScjyXT
 KnKc0qKtnLrC3tcZvTg==
X-Proofpoint-GUID: 2QnYLP4O04LxwB8sRI7x0zyFslo41thF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-43144-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7278187ED8
X-Rspamd-Action: no action

On 2/24/26 10:49 AM, Abel Vesa wrote:
> Add RPMh Power Domains support for the Eliza platform. The list of power
> domains is taken from downstream. Even though the cmd-db does list MMCX
> and MXC, they are not used, so they should not be describe.
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 19849703be4a..ef2e08c6b454 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -217,6 +217,27 @@ static struct rpmhpd gmxc = {
>  	.res_name = "gmxc.lvl",
>  };
>  
> +/* Eliza RPMH powerdomains */
> +static struct rpmhpd *eliza_rpmhpds[] = {
> +	[RPMHPD_CX] = &cx,
> +	[RPMHPD_CX_AO] = &cx_ao,
> +	[RPMHPD_EBI] = &ebi,
> +	[RPMHPD_GFX] = &gfx,
> +	[RPMHPD_GMXC] = &gmxc,

GMXC should be removed as well

> +	[RPMHPD_LCX] = &lcx,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MSS] = &mss,
> +	[RPMHPD_MX] = &mx,
> +	[RPMHPD_MX_AO] = &mx_ao,
> +	[RPMHPD_NSP] = &nsp,
> +	[RPMHPD_NSP2] = &nsp2,

And this one too

Both are OFF by default ICYWW

Konrad

