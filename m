Return-Path: <linux-pm+bounces-37257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BEC2963B
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 21:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925543ADF6C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4D1DD543;
	Sun,  2 Nov 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z10ILadT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsrvGfY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1FAD4B
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114990; cv=none; b=rY2ieAoceZJisZyU0oKTOS2WskAmsu0LxU0y2n7iDIxsOsydUpNs5lM0vKKcePCzdW8LGXDnHrcPMBgEORSfN9MDdlXPFTqa98hOLqpBnpycl8JAttFt2nQz4CV/ZN1oXRRAWmOxEbd+bsyiLQvxnrkoA0eaTYZdxHRcYNJUq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114990; c=relaxed/simple;
	bh=h/u8vHBKIGlljh8+g/brM9h3GvfDhZF9cPx7V89qOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHFePdb4nNtfetP70YDcq4RlYMm6O58RrTt14WsWFG5Y/fXUkdjowSaLe2uhc8YTl10smLVKyyNJoGvwMvXxND7OqRrEZO3roHzs7/4PyMPD9stsfgTx1KQyQmAa/OK/TxJri+C656u0LXk6tby1NQq5X0CR8nww5jjL82+/jXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z10ILadT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fsrvGfY8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2JX8RN1038063
	for <linux-pm@vger.kernel.org>; Sun, 2 Nov 2025 20:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iF9Sk1yicLSyJ7MZczRbuGla
	53qxli3xBrfBnCGZOUY=; b=Z10ILadTX8AxWugGw6Cbx1DalAgqK4+Aqg7ydHUR
	XjNH3wL9jHwrwf/mth3kHp+CpDCfnlohzqndByE+jaSc4DS4R5SJDKIWzFK4tG/P
	GUQ1SJm3uGYpOdq/q2NgutiiCK18k0ra5wtLgMxsWkT8inWBrIvOGwc/aSe3d3l+
	Zzq2GEIgQBH6sR2++4x/G9uzL+1FhA6QtymlqeRbKHdJjb9V2R0XeyNOb1TJ3KIc
	RWPFCif52yW+cqBY9fsd0jBElG2VjhSH+PbA0OQ0woEgWZmtgvznk0ufKnZjCh8I
	M14DpdVkeGziCiLEq6SBHk+tZEnUs/OldkYM7SX8T11PWA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5pj3hmka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 02 Nov 2025 20:23:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87fb496e4d1so175638876d6.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Nov 2025 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762114986; x=1762719786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iF9Sk1yicLSyJ7MZczRbuGla53qxli3xBrfBnCGZOUY=;
        b=fsrvGfY8jHxTVZRMnGvYGFJ+3ioZvXeZnL+uX26+rDX+cBX+xYWq6sJdLeSzTffsVp
         cjYEgFKQ40iK3dYNbdlGap8S8x/S74MfswQLfI150Fy6jV0jyh4Ec87q5QQvjhsc7kB7
         kpRAKLGViLzdff3PXhtQLUbMIBnw4YUuCs3qvipaAE3i4osECYu1MC7J4ohravVb+4rh
         A9h6w8FG1RM73RQQBmecm0prQR0McUwSp6RGQd2G6QJu2qTmGqSXn92rBzLO18aXY0M4
         NwovAZRDw5NOuAfdRbyjCQrBElLH6qLfxREHe9tA50ilczgIM+pL2dVWT9/CRXu1/OSH
         mCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762114986; x=1762719786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF9Sk1yicLSyJ7MZczRbuGla53qxli3xBrfBnCGZOUY=;
        b=ZOfBOQqqoLGe2SVvnFlGuPpI1KvLV4lfwVdLBcBtbcjN6rwamWvy3wUQmASk6cBVDw
         5AJ2KchKZYNZnlf0XaHfXuGnqEJhB3hXeERYMQuIPWdOAp3/YXCv8PlbOJzRvyYv+/AR
         DaPATbk9xvXFhC+A7JpAkgVWjS/55vvMz4c/8uO/z0E30fF8cuv3uNL9bvBwQL5EFsEW
         Z7XhPW8wausHPFnVXvolUyUgh+c+ez4GZu9rmKsu62XNCDer839UpXvzlteHbg2olKlN
         Wp3dv66KJuLzRuFKnBNo4rGYf/yY0Z+B6YktiXYiJcr+NPftFUe7DP+2ljze/iKqI+XF
         rUlA==
X-Forwarded-Encrypted: i=1; AJvYcCVK5c6PHJtlReBOemlhSx3a5xzQn3QMy+v5CmfAJAo1SJC3Xk2IHzDQnaZDt60PPcJZxQFRfjHmmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsMqC/xuLniTNUtwC0HVnB92GHYO/BsTt+88uRtBW0WotHi5L
	vpRLi5621T3aDcYTiUvu7v/ivajNShZJpF5ftud2Ba8wvGVexfsNiIVIZpi5fw7CPauOJEluVjG
	HohfWJ0jeOpe/WOKU08R+Vw1fkdQAzqfTYTRv9Ht1pxGzBOt4RQPxxmQdM6kvew==
X-Gm-Gg: ASbGnct1bp8T9kRUrj5LQUSDNfa386a2vt36RX6apsdH/tI7tg8ko5CCPwm685KtFUE
	4qOW8YGCwH64zyvlIgV5kQzYEu5UStFmUadKB8oH2lYAOdbPxfSsb9tS0RYiqwwJTpY8WpjhHfI
	8eoIle3H6sSVw3dtt0G0qSlDQky3r06BtZOsE3Du7Bfba3tIqA9RPrbnwyf+vqpaS6p5q3/veFQ
	pDUyRCPdiByz2PHg/mQCkMB+VfUnVH5iBoqk+QQjSRsXRvxtNuvuqhW+3e19KXp8uRbaE4i+J8D
	iyxjRgugqS4W39FmKOdusNiZ39RVSv5Gbdk312BKK6r7+lJml9cb6DO2mCGdPyWQzQ23AdLZ5jB
	bvGHgPtiWpoFC3MbKD3KkQBvuokKP+Epyjwk1bDsF5Q0HpIsgcLNuxMIu4WIK4VD4BwZaefa/hK
	vhodJJyb4u9pl7
X-Received: by 2002:a05:622a:1aa4:b0:4eb:9cab:2fe3 with SMTP id d75a77b69052e-4ed30f86babmr134606651cf.41.1762114986278;
        Sun, 02 Nov 2025 12:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdXjzmIdT5HviWiYPFMzknnTnf5Xba5QMdeZ7TW5vTE/MopL+1YBFU9igPofrEauzBqmUbzg==
X-Received: by 2002:a05:622a:1aa4:b0:4eb:9cab:2fe3 with SMTP id d75a77b69052e-4ed30f86babmr134605941cf.41.1762114985710;
        Sun, 02 Nov 2025 12:23:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1c0baabcsm18171791fa.43.2025.11.02.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:23:04 -0800 (PST)
Date: Sun, 2 Nov 2025 22:23:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Raag Jadav <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <adqu7gyhxe55cocimsgcbifilmyos2h3dc4tqbw4uxv4pmbdkj@ps4akoyq6v76>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
 <6904c563.050a0220.a13ee.0212@mx.google.com>
 <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>
 <6905f3f5.5d0a0220.27a792.7a13@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6905f3f5.5d0a0220.27a792.7a13@mx.google.com>
X-Authority-Analysis: v=2.4 cv=ItsTsb/g c=1 sm=1 tr=0 ts=6907bdab cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=E1j94P29M-RTyqinJ7kA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: lSHVq5FpuzOyogReb9nJVNPSRCu15XHm
X-Proofpoint-ORIG-GUID: lSHVq5FpuzOyogReb9nJVNPSRCu15XHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE4OCBTYWx0ZWRfX50oeCuNZkXVT
 ZtZDUHUMOFocznwMGtvm80D/RhI4wvRVM1gnpgPiYroLlPVgYyw3Ik2OAtlm0XIxV2mK+HeCdPh
 umTIVtpO732Bu3SIRnAeq6aO7/yRi3zUBE+a9c19O8r3F2oO2TF9acFx5pOqilZ32sdpBCq6aQk
 nRwKbSPUwNekAQHmOgal4J/tYSiXegzEudb5ux6AQ7HgXiVdDKiQeq3bkfLKIfXPQNUfLtwnhWe
 1z2lIS1ITuxf/zclQhfHlD5TguQAPaKCZkWMEq1EVWhMUQ97FGngqdbvmI9Rc8S6QUrloWuFi2e
 6TRV0eDGdT5iRuJZDy2C4yAOxNVaJSWBuwCx9t72d3vtLECuwDGh5NN3jg2F5117v1RoXaaz5lz
 DhRdrguiYnOkGJOBAIcq1TWOpS9yXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020188

On Sat, Nov 01, 2025 at 12:50:09PM +0100, Christian Marangi wrote:
> On Fri, Oct 31, 2025 at 04:34:22PM +0200, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 03:19:12PM +0100, Christian Marangi wrote:
> > > On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> > 
> > ...
> > 
> > > > > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > > > > +			msm_id = QCOM_ID_IPQ8062;
> > > > > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > > > +			 of_machine_is_compatible("qcom,ipq8069"))
> > > > > +			msm_id = QCOM_ID_IPQ8065;
> > > > > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > > > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > > > > +			 of_machine_is_compatible("qcom,ipq8068"))
> > > > > +			msm_id = QCOM_ID_IPQ8064;
> > > > 
> > > > A nit-pick (in case you need a new version of the series): I would expect
> > > > the conditionals be sorted by assigned value.
> > > > 
> > > > 		if (of_machine_is_compatible("qcom,ipq8062"))
> > > > 			msm_id = QCOM_ID_IPQ8062;
> > > > 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > > 			 of_machine_is_compatible("qcom,ipq8066") ||
> > > > 			 of_machine_is_compatible("qcom,ipq8068"))
> > > > 			msm_id = QCOM_ID_IPQ8064;
> > > > 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > > 			 of_machine_is_compatible("qcom,ipq8069"))
> > > > 			msm_id = QCOM_ID_IPQ8065;
> > > >
> > > 
> > > Hi as said in the commit, parsing 65/69 before 64 is needed as we might
> > > have compatible like
> > > 
> > > "qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
> > > ipq8064.
> > 
> > Oh, this is unfortunate. Wouldn't it be possible to use some API that returns
> > an index (or an error if not found) of the compatible? I believe we have a such
> > for the regular 'compatible' properties.
> > 
> 
> Well also using something like checking for the virst compatible might
> be problematic as real device have something like "netgear,r7800",
> "qcom,ipq8065","qcom,ipq8064".
> 
> I will check if I can implement some alternative logic to have
> consistent order.

See drivers/soc/qcom/qcom_pd_mapper.c. You can use of_match_node() on
the root device.

-- 
With best wishes
Dmitry

