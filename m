Return-Path: <linux-pm+bounces-29513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C31AE85D3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF27162E2F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5B264A8E;
	Wed, 25 Jun 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxZ5cnOE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E2442C
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860677; cv=none; b=ZSrklh5tlP4WHu3HhgZNK9qsRUAoHI34/ai/iJZBaqveNNiyMNMQONyOHkQE/hmRcLEEoU/20ps2behdPn+6L9vosxncMHLtBc1cXXZxo9cuxWd2BCkwGM5A9y1+cqnS7oVy0eWI9crpTSsXkHjjsFT/7xL0xmEI2l+F5Pyegms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860677; c=relaxed/simple;
	bh=8eT/fOLThxftYtvpcRG/6FNIormyhjzWmm0diXGJqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X67Ex6klJGLp50MGxIgPEO6c/g57euMYZQJgRCfdPEZuOaCfjBsqq1VbBZjHdRo3IEMb5P2QLxNv5BfWvmUdSPzAOSXOSiAax/3+9kr0alTpq/wwZh9a+OGUTqTJETfLjKeNWLt4kMPGENGD5eROw6DtJWmyhFRMtZm5b1sBX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxZ5cnOE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAV0rm022703
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+qRpaoWoOAGUcQvHdr+LjcPB
	Kx5JqKIrIwBc+b+23KM=; b=QxZ5cnOEpi9cUR564qPxT90NVWZdMVF0blLz00dN
	a60MbSUa6V+EM7Hh99OWQ4HjGiiA+KEjSbscHHrjQM37HpWes4PsW9Kw0uzwrNHa
	35APwRDXf2PfXrVzCuqd8ZsdD/goJMugEn2189Y2aCtY6dfYnh6RH2z1jMYCO6YW
	tvWUrkc3/gLOY4tiKmVeqqV3XaXPlzPw3HcaLz8OOXusD+/XrPBcR0NkzdITXADC
	9lkiaJhfQ3RyRU16K7Ar3kHcUbeygtIZlnfHoHF1WgRi1JA4y1v7WNulKmMrjHIa
	vgH7Q+pxZiaNV2CzH5PQBe9aLz8gixKu3L4D24lU3nQ7xA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88f9w8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 14:11:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d40f335529so146099685a.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 07:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860674; x=1751465474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qRpaoWoOAGUcQvHdr+LjcPBKx5JqKIrIwBc+b+23KM=;
        b=SdGNkHtAww30IKKlhSwSz7JVveEwQzjx7PGrSjzd2Q3OXwAPrZV872Me7fcePcQyeI
         xiRBw22b9hRjotKizlqlBzPuGa9QUzy+hvTKfRo/v5CDIFoXlrqRHsOYyLCUNemCeCHu
         KxuIsgJWA6n9aPsFv6My2VnZauZGH3J/yHwRX8BlaeIn8EkJdQOdNkd7rlfmQv7GMTw2
         eUweMQLugyj55vx8EjT/02j8C8nV+vIoQD1gJt7wWQUtT903F9TU1N/HPjCsF69Ar/SN
         gOO8BACGgGKVvUWk2wTZA1RVKtUrbJb7tLpMimmgjvX6fJ4MFoAXDtBzRMDTCWBFU3O+
         cm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/fX4Ke8iO6U7wquH6zQ4pdxbjWBVJ3WUGzRpl7cc3oTZ4mO8LaFQk1P3p5Gv/iNaupSNDdullPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcQqmjxhsAeuyEbTTCD6Pdjhz+Uq4NJVsdFahELgaE5BS+FpK
	LxZvaYjjcICfyma72ICZ5g3dVNGpFUk+p2R/d6cL5L0Hg7Zj4YCQ8phQ/4B50pPHx2wwf49RpgU
	bGy//bcncg72sQ75v8ONAeEy5w5A+LawuNNsH2Ue16dAo027EewMWRomv6KDcnA==
X-Gm-Gg: ASbGncvalK9cXQrJjdTtDiFMtxPAqg5kXIMv+dCWV4SZjyDNCeSh31aH3oyPLiyrKMH
	dzocKUJMn2xAt5aC16nxV8GSM5C9xMrojwsIzYig/SWxIN5NkLFElGq3HxkACnI7pD0gmADZwxJ
	M8DUUvVnJAKkIq5EIm0JLyLnHvVaoJW93+eBaPOjcz4+yfLDAIbP8v6QJg3s8yIBc9dP6+dUlQm
	uF8otChZgUMTho7HRV8W6Vot2afacevx/DDyRMAz0NoKoi9GCCRBPCniMFsaFN7TYyL2pzzyszu
	HWvVPDb+38m/tR5DPA4aTzIUtccpCsJRsehzsjHi2O9e+RXxoZAqI9FUoulobmXQASwA8gtQdrZ
	5dECApjwN7GrUr44f3BVufsufvfAbmQGVe3Y=
X-Received: by 2002:a05:620a:c4c:b0:7d3:ed4d:812e with SMTP id af79cd13be357-7d41ec0076bmr1016205585a.9.1750860674213;
        Wed, 25 Jun 2025 07:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsdTX5U21ci+ZoikbgW9ha3da7QH+cSVnPctS29p4Tf3xI2/dfSDOybeyC/94tf13yQvCYig==
X-Received: by 2002:a05:620a:c4c:b0:7d3:ed4d:812e with SMTP id af79cd13be357-7d41ec0076bmr1016198885a.9.1750860673537;
        Wed, 25 Jun 2025 07:11:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b97f79ab1sm19898871fa.31.2025.06.25.07.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 07:11:12 -0700 (PDT)
Date: Wed, 25 Jun 2025 17:11:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: increase ICC_DYN_ID_START
Message-ID: <p3vjrgnxm54xvzvk4evt3v4hpot7stcxx53phopabe6eqa6qhe@rxbffiisaxrf>
References: <20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-icc-dyn-id-fix-v1-1-127cb5498449@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEwMyBTYWx0ZWRfXwdrEY8DX9qjw
 FHRiIKpPuXoL/+L3++p3YvRGQ/OFN03WROawqyxvmHS18mW+Vq9yRB06emf73aRZAIoChz7HNJf
 1uSoEqvyrXkXBCYvLniMtPxkwEDiNO5+8Hv0JSx4acqQryuD09H7BD2W/0CStmi484Ik/TgOS3j
 tZatQOPucWarGu0Ev5umMNtTuu5nW4nnBLTbHyRDSeygkDr6GAIY9yxR3frMsqcsP62USgp/GJI
 rJhHmQ0sRTE8+5g97dYxKtFWUUvtKoiHmBz/ekxZ2RnMYgjlV6ON7RhBAlIvi5HO/Tq01WlsW4v
 KdlIy6xE2OMXcCkXGhlnhrXPRkGRaHMqpdk6xqPlhX8t7Hyh4bOhzDE8drNHLQ1sVSD0IBLr/rw
 StHSJkx3l/cWUNvEWNvYueAMkwfE/5do8GzqWd50OoVackJslY5eR7eTEpxaiFRAU2ypOMjM
X-Proofpoint-ORIG-GUID: WJmEN6dAB0iDC8wbmshyuWnKrCVBKiyA
X-Proofpoint-GUID: WJmEN6dAB0iDC8wbmshyuWnKrCVBKiyA
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685c0383 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=lmldiUiqA5WZr_cUjP8A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=943
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250103

On Wed, Jun 25, 2025 at 03:34:23PM +0200, Gabor Juhos wrote:
> Since commit d30f83d278a9 ("interconnect: core: Add dynamic id allocation
> support"), interconnect node ids greater than or equal to ICC_DYN_ID_START
> are reserved for dynamic id allocation. Yet the icc_node_create_nolock()
> function allows to directly use such ids for creating nodes. This can
> cause problems by executing dynamic id related codepaths even for nodes
> intended to use static ids.
> 
> For example, the 'nsscc-ipq9574' driver creates interconnect nodes with
> static ids starting from 19148. Because these ids belongs to the dynamic
> id range, the icc_node_add() function replaces the node names
> unexpectedly.
> 
> The node names looked like this before the change:
> 
>   # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
>   nss_cc_nssnoc_ppe_clk_master                          0            0
>   nss_cc_nssnoc_ppe_clk_slave                           0            0
>   nss_cc_nssnoc_ppe_cfg_clk_master                      0            0
>   ...
> 
> And those have an unexpected suffix now:
> 
>   # grep nss_cc /sys/kernel/debug/interconnect/interconnect_summary
>   nss_cc_nssnoc_ppe_clk_master@39b00000.clock-controller            0            0
>   nss_cc_nssnoc_ppe_clk_slave@39b00000.clock-controller            0            0
>   nss_cc_nssnoc_ppe_cfg_clk_master@39b00000.clock-controller            0            0
>   ...
> 
> Increase the value of ICC_DYN_ID_START to avoid this.
> 
> Also, add sanity check to the icc_node_create_nolock() function to prevent
> directly creating nodes with ids reserved for dynamic allocation in order
> to detect these kind of problems.
> 
> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/interconnect/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

