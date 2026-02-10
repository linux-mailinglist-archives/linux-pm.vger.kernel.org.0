Return-Path: <linux-pm+bounces-42449-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOpmBrEki2lyQQAAu9opvQ
	(envelope-from <linux-pm+bounces-42449-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:29:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFF11AD25
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C0D43034664
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B290328B4D;
	Tue, 10 Feb 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tos0V+pK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUTvyl+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6B327C12
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726462; cv=none; b=e139LJw/G7LxqgAzGrqSdXLNSJ8GjHtnkyFI5bKopQjg4/hBTDv0oiKvB2lhX2vQwLhrGTYGZPfuMrJjviQMTjxY2ZOtdUxZY3mSuZlBU+Goj8Fb/pAfrOTtWNThdguSDmVpZzyxqWoe4KhHPRklDDJaiFSMd0NXhWflOv/LCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726462; c=relaxed/simple;
	bh=efhsIlUcgrxJHBgx9tFahFZW3O2XY8N52nafIZ7BREo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH4yRLqXe8oB3De2wt2+hR840UNCWnoFNwuW7GaU8bG5tX1RMFU1utzYnH7O7Fb3rad7NFjaST0N2lRxXTGDoyj+gLEJZ0F4oBBFDH6p0yh2srG9BlYJjlPCYFM0vMo5fxZ3GUXWDOHxdA6nx23D9CAkwWml3hLA2FcydAzlSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tos0V+pK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FUTvyl+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7ZC9F2169443
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0MYFCYT/8/l+a8Upz+OX+GW9
	39DYsFckcT2Q51X/lXM=; b=Tos0V+pK+QqxYCJJ/XXhqh1NJx/89Dlp0BpLQ8Ni
	EBlOooAIaKNPikRXakPaLq69GB7Zk17z/P5iGDezAxmb99Wj0w9fB96VV/4HtDm3
	T5gFT8fI3/0tB19gIGg5meqVh0xSStFlNf4ZO9CscLdZkAMzcG1ehIALzb32AtA6
	ia+yF8EwgdPxPctpyMfplpEi1AT1i/2Fn+kGDiXjNpwNCP7lHaKPH26ijVeVo9qe
	Xwwofw82Yp7Heq1xq4Lk9g3InCUokhVx/PqfhvjYElfX59grIOnvlxyNhn0anDIv
	cf4aL+1thUBtbw2Ec6uaqg4iAbQ212Qqb+wrc575Kih12A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c80drrxbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 12:27:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70b4b53e4so1733216085a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770726459; x=1771331259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MYFCYT/8/l+a8Upz+OX+GW939DYsFckcT2Q51X/lXM=;
        b=FUTvyl+C/XMJbwU9l5bS1hQG4bETScic9RyEXpJYz1zpPpGg8nBQVFZ/pfmEIUNAK3
         0uW8VlV8sgCocFnKC1sCRf3gam1yhclkwp9mLnjRtyWuYvv1l1AODix8liNm+adjdWMR
         3/YFwXBCTDecgjvnAvf3zj7kgbrUzVQxD4uTdO+xvdH8G+hxDv6LORRPmDHEx9zUzNup
         DOwt9s+myCH5xIdGyIkYkCiODCkbcsAUMCYddF7lfbXNWYkJpHWbswydkawksUs8D6Lx
         uG7LmcT3BGCNsrvqMc/TwZpKL4S4qbAdOU37P6vLFS9LFi6+A+hAcEJd/fkyLqF2ijop
         csOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726459; x=1771331259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MYFCYT/8/l+a8Upz+OX+GW939DYsFckcT2Q51X/lXM=;
        b=GutbttRTDdyi+fPiJzssJREPzdSVHSF6miJV0DD4EKF/QWxnWxGNFurOMP1cvWqHqG
         uuohZLuawFfq/gDDA0hho1mXmF+za3T5Z8/2oNh5htVxtWtVYVOETEMcZGOnU7bpbzPX
         oVTE/3brdmRSh4OCJHlofDmS8zEhMENBF9sYs/foBbtrxlELrrKinpEhS1Y84wXnDzjE
         rZcNClwhPpRxKnZLCJKhkd5/4DdNR3gQcAdtGpQsrzAKSe9lcdzKwmLtwT05WCIxw/bM
         mET4Zkp9uRhFxxYXiDfCrBD+JduccyHq5cIMlx7xb5Muord0O6Y0gSJhaLXYiCjeInFW
         aZOw==
X-Forwarded-Encrypted: i=1; AJvYcCUmbLXBMOBYDcy1v5NkXJwlBY0PIpNLAFgJNcnsxF0d9P+qnghbLD1JKjAi1X84RoFtkddjU648Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm413Z4EkmACthg12YD/BxXZTPr2195lV6CQE0odXq9rF4OLVN
	2G+D1CpZ1vLYTGrzzNpQMU3aNIyB9ZPs0VbKtA7wx2F82ecgigNBL7dedA6H6HzQDXh3pZtBRY3
	dk1H+AZNxdIemlOH4AcUFAjUOTUfoofsfZQR7yJL/9EzB/Eu5QEcCIBAPBauA1w==
X-Gm-Gg: AZuq6aJYgiDVUM/M3wPHBt3YjYBxAt4uS917o+gWSil5VGtiyEdYq5I3cWRjy6G4Z/q
	PxNOcPC3csUdrbsCjHiQvSIYERM8ytH+hQVRZ0crh8FO4oz04kQlevs+9H+kEQO25++x3kiMXZm
	TMIdkp9oZ4DHORXktNqlsFc6URofJHha9r9rSAjSKSym6NHJfw5BztSgtoAFwl9iE5XSA9S8Ppj
	Schsz4Ra3Eguf+35ZJG2RSYR6Gm2aV8HxI5ZLbGXrzn1czHci6/R9s5YoYOyKTW7QMeprGZtwk4
	N/SOIDTfMetBD/tfjwZQOaXaGBnu6EFY57J2/aFkmWQUcHE14CYx1CX6uu6QE7BaqlhUKLSzeUY
	5E6JUoHO01DXIzhwhbB6fe4YFqrYRNBDRkow/ydzS8fVIDo+12FPILqwc2TqA0DlVN6T9LalHG3
	bjKLjabOOsGeiQS4ENMovnwhCRsR10/m9DGrE=
X-Received: by 2002:a05:620a:1a9d:b0:8c6:ffe3:49e4 with SMTP id af79cd13be357-8caf10244cfmr2024235385a.52.1770726459348;
        Tue, 10 Feb 2026 04:27:39 -0800 (PST)
X-Received: by 2002:a05:620a:1a9d:b0:8c6:ffe3:49e4 with SMTP id af79cd13be357-8caf10244cfmr2024231385a.52.1770726458913;
        Tue, 10 Feb 2026 04:27:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b6236383sm32602591fa.10.2026.02.10.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:27:38 -0800 (PST)
Date: Tue, 10 Feb 2026 14:27:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 3/5] soc: qcom: pmic_glink: Add support for Glymur and
 Kaanapali
Message-ID: <hrlgydepwoh6jwrxi7if6awparre2vhehxywshtxv6s5km6jkq@2hkh7qhawkxe>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-4-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-4-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwNCBTYWx0ZWRfX/KRABls0xo99
 JM3KwnDHpnpp+f9Wp0iUn08ppyztEn1gxPcVp9xF+aovkD5sr5H7cJv8XUB2If8Wt/BehrNvDqL
 qC5rih9EjM9i1NCqejp36lHGLbgjVxpTVtSkeIGtAbcnzfY9uWaG9phFX/IbekFy13Y2KgCmEW4
 vm+v/zERRrnYxLHWULomK70fsUwQeLkU3aBzo1hyyEuIEKCJCR/YbDG8oI9mV0R/KXkx57eeKg/
 8Gik8crS2Xk1K+8jKt+a5P04W9rUHhvgHJfks/ZCsVBEDuWo0tacCgphKvSUZF0m6D7IC4oY2fx
 aU/njZWlUbnO4IhgTaEgYq8TXiovFvxW8lUtWBJqcsImkRDU3XkWkBbJzd8od5fn+Nn98Q9ACov
 q1PqlvyNnA5JcfRbyAU1R36pFGJHXUqHAJdj1TpyRlNLl03E1uMHhZwsynmvYCeVfXHeb7BGwEL
 T2BBChaxDs39vCvnk3g==
X-Authority-Analysis: v=2.4 cv=fd+gCkQF c=1 sm=1 tr=0 ts=698b243c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=_MtkEuZf4ZNMOBkvimgA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: FVQYnMzamF2hEiFuR_NmnWTrFIGaqhdu
X-Proofpoint-GUID: FVQYnMzamF2hEiFuR_NmnWTrFIGaqhdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
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
	TAGGED_FROM(0.00)[bounces-42449-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 69BFF11AD25
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:49:13PM -0800, Anjelique Melendez wrote:
> On Glymur, a compute platform, and Kaanapali, a mobile platform, charger
> FW runs on SOCCP (another subsystem). SOCCP does not have any specific
> charger PDs defined. So, add support for Glymur and Kaanapali compatible
> strings.

Ideally, this needs a brief explanation that they are not compatible,
because of foo bar baz.

> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/pmic_glink.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index df2fd03d3b33..3042261578aa 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -397,7 +397,15 @@ static const struct pmic_glink_data pmic_glink_adsp_data = {
>  	.charger_pdr_service_path = "msm/adsp/charger_pd",
>  };
>  
> +static const struct pmic_glink_data pmic_glink_soccp_data = {
> +	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
> +		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
> +		       BIT(PMIC_GLINK_CLIENT_UCSI),
> +};
> +
>  static const struct of_device_id pmic_glink_of_match[] = {
> +	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
> +	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
>  	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
>  	{}
>  };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

