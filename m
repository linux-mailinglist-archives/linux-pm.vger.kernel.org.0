Return-Path: <linux-pm+bounces-32465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB4B28DE3
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16E05E3FB8
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A692E337E;
	Sat, 16 Aug 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWTsFUKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EB27F18F
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348223; cv=none; b=qUZS3L0nBk9sUKk3YGd8jCY3veDixrQxh9j0DuBNIbq7ET75uwtE/F67EPm9Q/yf5Sw+N7qbckB8v/VPwixX5lm9jJmR3jbNXVw86U7ck25n3z+L8impn6OCKzlKFYIFEWWKKVJpb57Mp9LharPzdjYoEyd7U/gGejku0xKuFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348223; c=relaxed/simple;
	bh=6TgFYNP1lEjsHaeBStSQCEGmt5hICkmmUy4Bb7K6JPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTNFkAkllPFkSLavTwHuAYWqv73JOxWMgFLXMI8krvbhxQD8Cwe0aGkTlt7F2/fP0x3n1/TKzONLvmC8ntcMdzlvcgD1wbu+eDt267yQ+Hb62yQzCuw6M9mBbOxDwxt0+oPQ1Sk2CWpTR6t8ZPBpIejEC6aNvJEN1Ts5h23Pdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MWTsFUKl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3Aonn020866
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wnbZRQQ9mMuQHPLOu5zBC74Y
	XEciAewoZhL2vFlk+pI=; b=MWTsFUKlqALOj7OfW8kciknPt6Q2q7IBhyKAx6lR
	8R8UQt+XD2B6i/wqbq9AJAdtA7mk83xLw1EshRKsQLHVorllDv+sna1QGdACfRQZ
	d5ixMq0HD3D6AS04dI3jAXAftt449vEnEA5N/4f0Ws67eZpVoXkUOaGdeuXNLuq2
	99MwRNkWF3mzd/4pi3Colxt/raiuscoKnS1S2FSspkqIv6QnZABBOdvhn2gSemv+
	Wy1NrVf3MKfW0yMRUO61eIb8c8t2+/LqKiHZv3KzQ2eNq0+CX/lNoBlg6yqqvB+9
	vUkrHWiqEcJckb0sa0mTZKb110vnpF7i4PvqItXKwL+stA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjy8p5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 12:43:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f57ef93so56675156d6.3
        for <linux-pm@vger.kernel.org>; Sat, 16 Aug 2025 05:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348220; x=1755953020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnbZRQQ9mMuQHPLOu5zBC74YXEciAewoZhL2vFlk+pI=;
        b=do6gFDMiLvteJeupl7DFTot0O8Y2CdX69pQ+1kK+Rv4Alo6egSZ7yt2TeLG39/K4Ss
         OF8WuuvVXBsxje4YRDmO9ZlLnSuFNAuoTMLESgiC0NIX0MuvJ8rt+uGkIaduqCVJlENK
         QomSzDSRxAuvhxWJ7Mt3JDrFwZjbaWflqKHkur5o94Xf6Tq/O44e62FeCUUb1omX9b4v
         ZmAceoeyK46SQzEZoEqv2IdIHPe602ZkgfPzZUa8L5lqpIbPpAOF3t9Zv3FOhYc/aerK
         xSwrRfjY+Kw6RoFnKHj4J3d1NmIYjEkCDl82RgF4X3VLcn+4vCCAjCK6BPMHAZgaNleG
         lGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHvQpp4ytQcmmghzu7w+nRbp4MBIbgb4EPZYQVbZkMHwVAsym8519ibpQ3+sitmThEGG0Qrh/tPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGi4XpKFs2J5c9sxriOkjqMXfsCfJORiVESpLKzex2f+UPqVw/
	D8cIxXkifafyK0WRa7FkpyKSfJFxSoZFgMOeGVoggwwPW5aplhp7fUbZ+8NdFFPyBZrA5/NqyPo
	hMawKdB2/7EHcBEblsCGHoGQPIbbYZsfjW2h9RyWMYacS+e6zWmSiyQXNoSZXZA==
X-Gm-Gg: ASbGncu1ez58pQ8sl0U6z3mMTx98TehTpIKyOIvQPBOMIUiiwPRqZNQN4AKPG4i0TNp
	RgaIicYe2u5cpXV5FU+Qzy/11iCC8vSwuy1u+1xzWmS0nbSE+7es7e5o1LZ9KVZBCbzgWICOLIy
	fcYZlcL/mITfkI1QExeHf2/cDA+3aOQ9cZcN3cT6YfaCm1uSnRAt1tcQEYR01g+KRfrrlY5VFvF
	zypOIMIptWXiiNL1moJYqm0zWxleyG0FFpN7BV8jX7mYEZXfcGJoPYbWOafJXbDuHvg5fjyTEcs
	OAREH8uJRIXC9qYu4tK1y2vgipPN572CzMVDffC/rqMUUwiqsuoCfX75b9+RobI/BIb+VUNGd0f
	LhMHEuusgJjJYN/cGhEQnYX2keSSlKFrFjvp08ugKXAS75QQfLSpQ
X-Received: by 2002:a05:6214:5299:b0:709:b6d0:946e with SMTP id 6a1803df08f44-70ba7be61fdmr64078886d6.27.1755348220230;
        Sat, 16 Aug 2025 05:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mxaGHMBAq3flMOYhfAbZP1Br65//td+kAgSqcW5C7HRLHSAZm5covXfrQFeeIoI2toC0TA==
X-Received: by 2002:a05:6214:5299:b0:709:b6d0:946e with SMTP id 6a1803df08f44-70ba7be61fdmr64078656d6.27.1755348219799;
        Sat, 16 Aug 2025 05:43:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a625b59sm9446991fa.59.2025.08.16.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:43:39 -0700 (PDT)
Date: Sat, 16 Aug 2025 15:43:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] interconnect: qcom: add glymur interconnect
 provider driver
Message-ID: <ncay3hc6jqabm2r3wflzxza2g4buc6tbyc77tl4nfjctjmbxal@22e66ed7aswm>
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com>
 <20250814-glymur-icc-v2-3-596cca6b6015@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-glymur-icc-v2-3-596cca6b6015@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SCzBivi_V3_AJA8zaYKwI-qkOHsiL4ue
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a07cfd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=88ugLqT0w4BtEkFF6HEA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: SCzBivi_V3_AJA8zaYKwI-qkOHsiL4ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX1RWCO2GIjIbA
 RcmvVdYioymphWrV1oru+zQmq2RAKflQsyGsdNe2Fm2UnLzvLxH4omldt0dhoOG5UgdHoo5ZWnL
 ylcC2On3uAKu9rZ4lMYw1mx3XDgMXa2jHRFjAlYftjzY2WhG5nGF+7aoMlVuJTTKsPcgh9uBMr+
 5iAYsD7xiFRepuWmQ+3VhZfw6sQCLUgfJ8nphSKILIun4HK+IiTVsUOgowpQzSitNcEQfTgAKWq
 0FpYXOlMahPAK+V0x/JEKPW6a7LGp21IppEPYIHTMLKdy+tV7Tc8OglVAZlKqfBWM1SiqbQtqUm
 2YCnVEkQC48odZ0i8iCgOLQnQvnpOfnZpxZWFP7B9d2S32lUDBVQWsARSvdz1ggrVsgpyFB7c1I
 PreRp2+0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

On Thu, Aug 14, 2025 at 02:54:21PM +0000, Raviteja Laggyshetty wrote:
> Add driver for the Qualcomm interconnect buses found in glymur
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pairs.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/glymur.c | 2543 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2554 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

