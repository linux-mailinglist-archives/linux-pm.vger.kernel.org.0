Return-Path: <linux-pm+bounces-39909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14ACDBCE7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9E8300C6FB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81833332EC7;
	Wed, 24 Dec 2025 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nr7sUGrI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1+icLID"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93F3321D3
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766568711; cv=none; b=aL1Bw1awfFTwknSQlGEQ1bFeb0Qb07FzqkBHaKYph1f9GlFGvsYhII4Y1JBnD8DQI6k4OZrTeh9P2maC6L99/X3smer0/vuZj5t+8hCdfRNudRD9zW9kszSJEX19h1/W0nr5cZnCBpHtrt30Uu3BgvKtiZmMdhZli5/cehHxP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766568711; c=relaxed/simple;
	bh=zvXaJ6+/+UwICxdI9c37a7HX7xFrLmdzWbivSVbo1wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB//3S5QxCZW95Lwss9Gfbh+x88eXrWMXIYnwlzssHqbGfq9sm4Hn0SwJght5wmyxD9ldlsfEzp+GZIC7viPMweI5kYTFRN3lZ/1KqlXSbS+fFzqEfcomPLJtS7Voga/p+ySIy32i1E+sSfCA3S+p+rPiPRO0AOQoj6mhiua4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nr7sUGrI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1+icLID; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO3mjqh4134198
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 09:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzSEzqdun1mjV0uIVhhioBCdLWTpP7aEZ+Td0LigZZ0=; b=nr7sUGrIw7GFz1Y1
	/Oud1k99b5OOkTXmmK0diZ64lBva7YXagiYSiOhr0eo4k/6gCWkz2mAYgspQRcAY
	N9XoZF1/lDsLX37FOlpDtQeCy+jo3sQ8I5l4bWs+/8Z3/Bwptt/p86YuKDJdCeV5
	Hy355MHAXAlbJgByxdAI2IfpLI6+SloiQJ6oEJydZ7dIwyetgrxMBRZbGaMsGjLe
	/XHL4Vq+raYj2+boDz+F7PcYlToI+q2DxVEA/xgdpjqbbXY5rkO9KUuz7CN2azh4
	MJ6/Wkw4raZfzBZmNGWTstIQfy9MCboN56tIdPbu7TCsB816NMTMJQcPjpvjBHBd
	inN4qQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7x46tmd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 09:31:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1dea13d34so131268651cf.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766568708; x=1767173508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EzSEzqdun1mjV0uIVhhioBCdLWTpP7aEZ+Td0LigZZ0=;
        b=V1+icLIDCcc7Pm88zLeEh8mrvZi/oBKRIL5Rjt+dtou6L9f4OUcH7+x+06JOc6or+W
         y4vB8L1R8PqkF/rBe8H3SKcTiLcfxSCKLHYvZLloyGYRw/9p9RFC1vgEGs9vTwdnNWpW
         pTsoL4BommtEEYOPa7Q/BvYfCCcmvYMvnzPjNNQAESVC1ES1X4kxKOL+tVdUGBpZp40n
         klw5VIZbphlZdK79+7e0hX/+RziYHyRhNMgTwRwY01naz3BUsoqqG+BHiqOhhBZrjOhk
         GrmE2VS9CiC76Fhx6/BtETU2fYmK0E/F+yJSUWOaKELi9QKJLWXRFglS3Mr/tkjKtDgt
         L/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766568708; x=1767173508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzSEzqdun1mjV0uIVhhioBCdLWTpP7aEZ+Td0LigZZ0=;
        b=xJFrfljlyMJ4igW5uRUN0GdETrDnM+bu+mQiyTs8IlyBWgLQIcg6une6hdP0oRMTVI
         ppfO5oXcSrfVPeqzR6UrsVD8XPbIczkgFJYFfBn0oDL2OOnC2nZmo9UTAvQOnmt70Kro
         9G/FOCWyjkeVh9exLC5mo2M3hSB5TQf1OOM22UZDICpBOdtxbBBl5uj0UCdzOrbsRze6
         zppbazEi3e5rwmEM7mXc07WpR2Ll+BGDUkQJ7LUetjl+Bk7ved8cXK6ZPZxQ5DjI+Z97
         GkOyB3b/ML76A3DQ7vvBNW4kwpGTZSh3oAPFO6fGcE3uMsWL3vYi8OmyMjTJGuJv2KXV
         Q2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVhkDOG7N0SUupetyvp8Th1tkVR73l4Ue508qPIt2PNvXBbs1JBm3CbIp/j6lYYQw76A7Z12daseQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfva/px+3UUZ+1H8XUS54WHn4j/mc/Af1rKecHtACl7hTMRF/
	QRuDUNt+vZ4MAAfMIeb2VpKLFq3WUBZW1mFqpxPD6WAHpXJpcHv9LohjKMaP+eGq3OticYjvw5W
	8mNAghm/hEIjMCCdGRwC6ZC1xxq1+bhaEYeLGf/it8EL5u1wuWlOhOlcMIVQvUQ==
X-Gm-Gg: AY/fxX6Z2BrCh5YMtoyXgdgHokJKGrzvRWSuv7MY2JyLL+jLZFbXJhJkJaRmOt5LRei
	T07gpcGHAxzDxpk2VDVRYvjgaRcJR1Wx+68HcDwaIFUQu/I9JRxZMwVst/OGozLW70It4vWCFFX
	6w9Wke3UkM/eHYKQLC8lAqGowOr5TkH/98tbkVeLZz+o2hjc7FIw3b798vAUAYWvWGI9EkIYoFq
	moSUxkjIOBhvAwIz2+QMjxGD6Vyk80Gh0O52Nc7hj93WfVwfkRtXFpSRnHicAv1gcdopTl6ku7h
	KVQaqvXiaaQaB2RjmL5AYhW0luYg7D+XutM2k6AUy0zO70OIW2zrDVYOhsyA86cIfKQsLWA1BUx
	Ekbf6dZuVHwUx3aoZ3OlzaSVCyAl1upr+gMFiUxUX/Ur8MVxCiefGQgbDqZclvTyeZy9YpXY8t7
	1nY1Xb3P5OplDY+pC/l8j+7IA=
X-Received: by 2002:a05:622a:110e:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-4f4abcf525emr298466161cf.29.1766568707979;
        Wed, 24 Dec 2025 01:31:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2qkqY+hdKlKic6DxHWu0OFloypYkzoaOPFgzqGWlzDkY1vj/gUKwiZFPPsffiMMKo84MJ8w==
X-Received: by 2002:a05:622a:110e:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-4f4abcf525emr298465841cf.29.1766568707546;
        Wed, 24 Dec 2025 01:31:47 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5f12sm4777418e87.3.2025.12.24.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:31:46 -0800 (PST)
Date: Wed, 24 Dec 2025 11:31:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        konradybcio@kernel.org, amitk@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
Message-ID: <cdmhdgwzrp2bmuqwjjn66gnvi3zu4p5fnbdkuzvrknu37asaq4@waf3az3hkk4o>
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <fu7rhvpo7t2fjx4l7nvzd2cec7loyjeqyvwgochghyyax4nqof@6bat54r3qgov>
 <7e946103-06cc-4e44-be00-fd0ab9a8f55c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e946103-06cc-4e44-be00-fd0ab9a8f55c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: gVK5-gw-BAkn0iaFV2PcLT2OR3bVsYPh
X-Proofpoint-GUID: gVK5-gw-BAkn0iaFV2PcLT2OR3bVsYPh
X-Authority-Analysis: v=2.4 cv=aOf9aL9m c=1 sm=1 tr=0 ts=694bb305 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5zzmveTRI80yMoMAEPwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4MSBTYWx0ZWRfXwU6UIeff0PMf
 9Ec03O7O3OzBVV6k1S28Esge9P740qANAWj1W/u/LwKgvXJ5K6TMVpeOBfFIHw0kw/Gvyn9gcfR
 6OX4NEwlg+Kaeic9HeiCFTMOQlcGPDGC4ZZypVtrcE9jkx2dRrsEdHpBmxqEQXNeHBEBXXgh65L
 j6FjFo/uX9IPQWjh34xtbjpnG6g8oxrjaTAt2WHqXy1K2nWwi+LKtG/6LI57wCXv7w5TEyQz4PG
 tEl/DjRhQvcwEO1mZIeziUT178AP+j8xW9o0Z1lHkKlX3dw/gle/2y6v4o66D4reFVtVASdumDm
 w5Pu+uIuNxB5fAO1vsKkZYRfEPJyZEqC5Y1Hbh9gZlb6RHtLLqzJnf3zK3gR9CDWsHb1spTb8gC
 in6go72/Vpt1vM7wW+/cDxpqwBvYiZ5+ZioWJ8UPTFQJcvvY3H4L4zu8Ku7BlptHtha3m0KgKRI
 i0CT62ecpFfQabU/n4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240081

On Wed, Dec 24, 2025 at 01:54:04PM +0530, Gaurav Kohli wrote:
> 
> On 12/24/2025 1:00 AM, Dmitry Baryshkov wrote:
> > On Tue, Dec 23, 2025 at 06:02:22PM +0530, Gaurav Kohli wrote:
> > > The cooling subnode of a remoteproc represents a client of the Thermal
> > > Mitigation Device QMI service running on it. Each subnode of the cooling
> > > node represents a single control exposed by the service.
> > > 
> > > Add maintainer name also and update this binding for cdsp substem.
> > > 
> > > Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > > ---
> > >   .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
> > >   .../bindings/thermal/qcom,qmi-cooling.yaml    | 99 +++++++++++++++++++
> > >   2 files changed, 105 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
> > > 
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qcom,qmi-cooling-modem
> > > +      - qcom,qmi-cooling-cdsp
> > > +
> > > +  vdd:
> > > +    $ref: "#/definitions/tmd"
> > > +    description:
> > > +      Modem processor temperature TMD
> > > +    properties:
> > > +      label:
> > > +        const: modem
> > Why it being called vdd?
> > 
> > Why do you define modem-specific node here, while the CDSP-specific is
> > defined under the if block?
> 
> will remove modem in next post,  earlier we were developing for all
> subsystem.
> right now wanted to post for cdsp subsystem first, will fix in next post.

Why? If there is no significant difference, merge support for all DSPs.
It would allow us to better understand the requirements for all DSP
kinds.


-- 
With best wishes
Dmitry

