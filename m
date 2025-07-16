Return-Path: <linux-pm+bounces-30925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB2B079B6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1C116C398
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4B2F5098;
	Wed, 16 Jul 2025 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSSaVcie"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D722F4300
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679377; cv=none; b=qXQaUCiICM0YYorEiXGiirISQG9Upnj5kw0NxaPgIhEKvrxAzuJHrmAuslzJxrfuS3TbMgWDgM6NKKzxmZp1iMGs1aQnBFvJtDI8/Oixp+xR30zdztPo36xxgqpyFxh2ZFd1yj3iNW4adpi+8hmhgmg+4Rvi/B3YByoUNKN/mkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679377; c=relaxed/simple;
	bh=VhG9AzSZ94L0m4yTcIbjiip59GubrfIHNlb2iIofRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXFQDq12nxLf9NWfThC+KOfUZT7dXuod5sKcJZd07gHIAZPY1nWlsCOBx0by91jJZtwoWvkg1Ik7tZ+kquUH1NbpZHugaT99Q6i2WFacm4yRoU2scXd+BuhkwXDCR7q8XzjmTcvT+CNandL4L5JMlZCknzBBoam2yvDVHWO0hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSSaVcie; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE9KOM029579
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7RAbCb/hRdSzkV6VU4Ax2LJC
	ptbH3p1ObvUqjOpfe8Y=; b=dSSaVcieCjTUNUNkpJkqtkVSk94E/cFHICoovQwx
	gE/VzGj7JdERa2teTygJdcYjeCshwZOaR+43jwaTE3Lxl7CNsQ9KLYCF0zt/gtbm
	kpHsVVHEPRX7u1cV8UGxq2A/00PrSr7utW6CPekzYydJGjX7youv1Smy3nlEEPoC
	S8i7kEVF4IZmjeiUChnP4desk4Rairw59m2EJsZgvOnaDhZ/t3M9e0FW2AS9MxTb
	RuxGTjBMhgd1qwLAdkhuRp6FC2p8yLJKaxaB67w+UDZEIkTUq10lSFO1fFax7bV9
	Dds7L6oKZMrOcwir0B04LOtxcMyG+dVZVM/O2bwL+ELtSw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb4h2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:22:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dabc82916cso1197522985a.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679372; x=1753284172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RAbCb/hRdSzkV6VU4Ax2LJCptbH3p1ObvUqjOpfe8Y=;
        b=JnNw2vhStEsYiWM5yZTKY5MlWc599jcqUzOwgTA4svNfu/iKhU3upoD8xH9YFHUnUy
         rPvKfnrNM8jSimhaOTN4f15i1N8+X8+w27fwGrPe3XZXtNLnZFMex+eNBJ8g3osZIVq1
         yM62tVagw3VhEKM2s+By4BwIsJjxiLwaevPobEyMlClTpMnG2AOcren6atxbBhLnKJLR
         UOPMdfQEWiJ+hCo/Y1wFSCfMZDUN8fgiStXC1ksybLLJ4bwOD0oZPb4Um+Ry+LK7QO7f
         YiDVOODQ0Oj9fUJ5djlYeCm6IGKpCOfl6pJx0C9slZCas8Xlc/cvmFROUiuhztV3/aXy
         OeLw==
X-Forwarded-Encrypted: i=1; AJvYcCW9LKuiMs1nFubEXGqpdCrinYZcRv+/KOYeU7+bKgRIFjcIxTfiAFvF7y/nWOaA8VOPM0nLXl57Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhfwbTQ2silkgC/A6hh9KvWXYGU0SOX/FaBVi1Q8ON+zRd0Fd
	qXje/caanSrc8m3jUhmXA8+jQcTZ5q9ocJ96vPPpQxpHuCnb5C6sQuZ9H6mJxNqeUjQoprV5P0B
	8LWt91jwggng+N7otdgRHFg2Dcyunn+RiAQDrj6D8HgmAJcAPYNCEzpYfBPcYnw==
X-Gm-Gg: ASbGncuiZCupmZcKo3mQzi2rArSwgCWCEhphYvwQpZgh67QgExlzaI++Prcvdj1Wxpp
	gzQeHP1Pvdjtpm+0CbAO21J7+Xjkn2PvVqPQaAmjlrMC0HIYD9DB9hLqWUbzLBfhBbCvZWpEGyZ
	BMiRIgJ4mFfDmSy0Ni3ampItgecSYVNF/xoo+CCko7TcD2ZiGdvtKOFCklH9Smu3kklF/f0kXjc
	488sZx/uBQvHsXoGYQ6Dd8sCFAuVwVeuRk40R2A3DHArflJhKheDOBszfRXmHqxJQIzx1dSjNmp
	N3mjj4xvMZdTQCM1Ssge8u05jeyiO6mVQ7vifzM8h9AnwMlPaYYCXBJZTLhkRnDBRyPf9XGpvkI
	PvnVAERm9GCBKDgrt+4kLPZvhSgv2E9G/BqeywKh5HjGmi75tDs2W
X-Received: by 2002:a05:620a:178d:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7e343643fc7mr486070585a.54.1752679371690;
        Wed, 16 Jul 2025 08:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGENloaWvoY9ZjMi7UqKHYublujFbYKx4L5NxmeqRfowsOVGfz002Oq2YrzRud/wdh7lvrpMw==
X-Received: by 2002:a05:620a:178d:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7e343643fc7mr486061885a.54.1752679370921;
        Wed, 16 Jul 2025 08:22:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d086bsm2710587e87.139.2025.07.16.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:49 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:22:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 00/28] interconnect: qcom: icc-rpmh: use
 NULL-terminated arrays and drop static IDs
Message-ID: <k4zbxmhgcphpsmyjtvobmjcogblanvvujyxqdalx4melhiqahb@rup7xg2mb736>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
X-Proofpoint-GUID: aJA4uFCF5Wv41ff5jtHH6WzYcPk16ago
X-Proofpoint-ORIG-GUID: aJA4uFCF5Wv41ff5jtHH6WzYcPk16ago
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfXzBJUqrsUKS1x
 mGs+qJG85L/zlDXgmntDohpuxZ+Ch86ugPVjR/DC4KF/+OBrbLvjmZox0P74OPCXsbWGX+eTAJB
 HsgdTyWQJXUa+wnUfW9LcZcibDQgnMyxKN9Evm9Hq4bJPoqUZZNYbQETPl6pO9WPzQukV5ETPFZ
 AczSR0yt/162OOMG/QdNqxpMDivOEOInQj7PyiE2tNll6UDcOHsf4p29fAsyCCi/Z45r3614vAn
 U5k21Hh/0tRdGNX66yOhQWtmJV2bXQPRU4/2Sh880/W2nZ/nPblFmFo//4CNgJJHfHARRONjNHE
 /CcnFil4Hx+0ll5VAmhhpuMKRrCbQE/lfLI328gIOW9w7rOXiKRJA+kXie/L8CqBuQaGQcILkut
 h+2tKZSR4u1mof70uYIQl/P7LgMQlg/Mabb52xBCYMWfCoCAU7PEEtvi/tvIaxPbMhWg/HI0
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6877c3cc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Zi2BZlG-iNg0ZsKB5K0A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=699
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160138

On Fri, Jul 04, 2025 at 07:35:12PM +0300, Dmitry Baryshkov wrote:
> Qualcomm interconnect code has been using .num_foo fields together with
> the arrays embedded in the structure, which results in hard-to-notice
> mistakes if .num_foo gets omitted or incorrect.
> 
> Rework RPMh interconnect code to use NULL-terminated arrays for the
> dynamic IDs case (as now all the arrays contain only pointers) and,
> while we are at it, rework all the drivers to use dynamic IDs and drop
> static IDs code.
> 
> This series touches only RPMh interconnect drivers. Corresponding series
> for RPM drivers will follow up shortly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on linux-next, dropping applied dependency
> - Link to v1: https://lore.kernel.org/r/20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com
> 

Georgi, gracious ping.

-- 
With best wishes
Dmitry

