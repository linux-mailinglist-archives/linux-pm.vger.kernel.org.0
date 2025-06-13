Return-Path: <linux-pm+bounces-28684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE18AD9087
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57A33BA0C2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C27D3F4;
	Fri, 13 Jun 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zrbmd/yq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCA1C84A6
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826817; cv=none; b=vF6QydDLn5de9q32KD48ICijgZiNd3UcxJazTuT18lJT4YZWy51Na5PSUSS+3PLIBCYVExsA30UpfutVbDTLUVZq91yFN2pjN+yZ9S9WJztM+4dyq4AKiGACR7dn+6zHd1lzEGfFg00+iifnzU1hXVqlHxNTZlw4R9b0MffthEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826817; c=relaxed/simple;
	bh=E4CkMZvZn5O/HFg1JTR/nxza/gN3m2V4wLT3hJV+ghk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7vUpjjxVLXV8VCFTTNl57KdsRw2s5NZptpwe7E8FMgj7qf88/9roip0+t1xtJkw7JC0sX3hvamGG7DHmNOj0/jl//Rj8AI5Ne+427n74zpBF5oaLTNrw0lkRtjUoO+v5Mhxq6EdTFbGKDqV6foN7F0gD2Qo2KRabnSq9Zu0jsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zrbmd/yq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D9Jhco015372
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RIoq7TQNFr31va//bRfEh+6W
	CaxxSdbEdo/2Vwgk598=; b=Zrbmd/yqIIBgBE7q1alslX9otWJmxqnOvxqIlsoI
	+MzWPJ526slnGZ1+KfyTpSrfEJjMgzwcCBJpbQjTUv1/TsD/hMDvPwiaTurNHMrp
	V7aVbLpTdXeAmJ+KHcyDFczMWxw2qXojueJV36jp6Bii3rY7NVEzY3w4zMl8WGJ8
	bNfzxou/bCp+R9DxYv8FQHOMWqd0GeZPLqNtKuqATKtcVzCTsTu3xypCdyzjT8Fb
	RDxElTisnPd+b4DCBgX/1H7JrFH0Cl4iEO9OwoGvWPAHPP5+yU0N0XmeyQPFswMd
	MSNgOdwodI09tgBijgTWTJdr3HkWOnQJExAW/1Pjfe96ew==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 478h8krpc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:00:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad1f7f175so37377196d6.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 08:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826813; x=1750431613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIoq7TQNFr31va//bRfEh+6WCaxxSdbEdo/2Vwgk598=;
        b=lWYqt650nA+TKgXjgoxWsIuiYCI+FqOM0UZaaxCXicVaUKGuaFQGOV3jcoLGNj0PZ+
         rb6HSK8qvB4kr9u9ElVgbikcfBn3mvcEqriRAeDz2VjngTWCzha1gpPgJ80F7wYRv4X0
         fzQh6Ggt8Db3/V40nuBQRB/qfVLqK1z6iI8yU6a6YhQVcz/haD95vx6CszlrEsz8tWwO
         1sfn+PSiXYUDnp8WJDfeA0KD0pr3zSfCw+lXPW2UaDiClxsjnyoa9g2U77K0YKrVzsoC
         hobNGNtrx1nHUNWz+on/929WA99lp4j2obPrmS1bPgnm5MEXrRJqIQ0w27hKSiRrLkiG
         z3rw==
X-Forwarded-Encrypted: i=1; AJvYcCVqsL9+zlGk5SJ7Uab6FSTDdB3r/xpGfyJkJqoB7eSGQwzF6qJj5tlfIiIbv0f6X/opS+TW/ZHq2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBf7UA4buOBvY1PRkM0IHXci2Co5Qln6SGv/sF9m8xvnOUG+KF
	221ImR7SG+7Gva86odbqlbffP0BM80r+eVk1JuSZt6EZOXMZ7J2WvwdPYveTYWUAieOPB7qBrO/
	v6gmLJxKrWEY0BMqAS6BlB4wyUqOiqRjQNPx1NsJoMtKW6hGPptPdh4PWxicqreauXTApei86
X-Gm-Gg: ASbGncv9IJ+24hNl65w1Pgt+88FBpj0HdEZMOTMZg9040mKe6vqnx3AUQD7WrzDw4Oj
	T1rVotrSA0gJKmeboZwT8Cqn8+Kq5zac3K3AG1KqXOs59GHTEOmddA/CnrzZmGU67dt95732Ic7
	7WsntzQG/w8Zy6X4UIZi743Z/ZtwiiqWXewpUFA0bHc0uure/W9yzQ1o5WspGrEXuCWmHYGhROL
	xFXXp83XFpHaQe1pTliV7rMY+Q7KGLd73L6bhhWvXCXZfzXNV/J8z/QcOnfmopKdTkHYh8/ZKl6
	QBqw+OjXWImFL8RzYXKWg9i8TLzIr/iSC/tpcpDbFbHSSMNy+j6Q+HtDJXJCcEGbezbQShN2jpv
	loLz7a2e+IPsJzguXPPuckMgiInVxDOY4ENk=
X-Received: by 2002:a05:6214:b61:b0:6fa:acd8:4c00 with SMTP id 6a1803df08f44-6fb45b1e941mr14748236d6.9.1749826811557;
        Fri, 13 Jun 2025 08:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGoXvnc3lC2lrsZXsOUtgUvC1XW6+DbQdmBou7XX0ZccxSl3D3oAsA6zhfFgbdanwdCRWggA==
X-Received: by 2002:a05:6214:b61:b0:6fa:acd8:4c00 with SMTP id 6a1803df08f44-6fb45b1e941mr14746296d6.9.1749826810361;
        Fri, 13 Jun 2025 08:00:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1f76fesm472238e87.226.2025.06.13.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:00:09 -0700 (PDT)
Date: Fri, 13 Jun 2025 18:00:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sc7280: Add missing num_links to
 xm_pcie3_1 node
Message-ID: <welmka636qegzxkubalsaskuptfjq7zudmeu7zsfayqpqqg2fv@xtvjqlm62fcn>
References: <20250613-sc7280-icc-pcie1-fix-v1-1-0b09813e3b09@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-sc7280-icc-pcie1-fix-v1-1-0b09813e3b09@radxa.com>
X-Proofpoint-ORIG-GUID: ahCRNdjL130TNjHbRmPVNZny7MnjCKPm
X-Proofpoint-GUID: ahCRNdjL130TNjHbRmPVNZny7MnjCKPm
X-Authority-Analysis: v=2.4 cv=Pp2TbxM3 c=1 sm=1 tr=0 ts=684c3cfe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8 a=egLgVL_HDBsgJ0s0AK8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEwOSBTYWx0ZWRfXxnQub3GC4/3l
 wQifKcJ7Uc1F9nr/SbX+8sSgxZ9pF3iBQ2f2LaOkngCNOXqQRHrG+WdoWehih1LglKG9O7gQg9Y
 6PRxQu/hHufs5xR7/jibDa7Yfw6pZWdov4o/4RmrAfEf8XdJS17cqlLD+Ho/9dooRG6NzA32OQW
 OWkFjWwEVJsxw8A3OYOo4oY3rOPd+tzo+ejelvs6fbDrTWkWTgBaPgvgDCz+5CcIhSP9E2hLCVu
 5kVESyBSy0TZ5SDbFnypBvfrcjz+ldTKfmy/x1MmzCx4wuBHsymNyxtzGj/D7sqHX9/5r7g1ER+
 VB5trAmVP6zTOaPQi5n54TS9pxvH30D/zMhMZqhiG/e9+1yfA3U/tAJM5neURVrPeWmlW55eLDI
 6DQgQphTcVOAxRdkS8X74/D1eBO+GMRYPM8VxdRMXhmSqUX+n+XCgOFdk0fwmkIvi4RPIAao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=877 mlxscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506130109

On Fri, Jun 13, 2025 at 10:53:38PM +0800, Xilin Wu wrote:
> This allows adding interconnect paths for PCIe 1 in device tree later.
> 
> Fixes: 46bdcac533cc ("interconnect: qcom: Add SC7280 interconnect provider driver")
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/interconnect/qcom/sc7280.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

