Return-Path: <linux-pm+bounces-6810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D38ACFF3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC21F21C03
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE577152189;
	Mon, 22 Apr 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mhH3i7hA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A015217C;
	Mon, 22 Apr 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797599; cv=none; b=Nab3VPo7VRz02mEqUW1DoJ8DMJQjIvgA4pkkTWympKIz7pIOhfB8y6p5tqNHJzjbiGXdcbYFkFgwmrMHFgucjdfuVHYK9fkWID7wWiK2TS5mTb7ybp9BWIYbOIeTM9IG0ewkBjUZmHUMTCPHXQf9lINo5RURjlAQyWmNDXCXT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797599; c=relaxed/simple;
	bh=56NB0Ly2re1535VJwQmZXfS/bgmhZPE6CKm6lQ5p474=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP6ei9LfSf85RmzzJaout933cmjLig3iJIOtiK9JSAUx91jQSW2JtBO71YBX/yAfDvrve5D05YL9P9b+FN/wMKuDV19ahN4Uaam16o+bRXAPHBQCMM4bA/W6HmTIXXi6ujSmhDM6fW3CQ7vq8wX7xAj6uO/O5J0Cu6nnEgr0RQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mhH3i7hA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M1XklU031424;
	Mon, 22 Apr 2024 14:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=25ZDNfNXWeshgPMNyeg7y
	ZS9izMi2/1VUZw2mQpw9+A=; b=mhH3i7hAHt4Z9hXN4NXWUFprRwTsEpKI2Lhm0
	AWjUSiY6LNn6dq347KQQoyipU/bPgnDiV8PEdnbpePbLDMn7lS5aCMmg1dSfyeG6
	f3WK9Art2cKrKr262u+OikWIxz6FeIEdpkrQAk+17rgBDF0+BqJdBvlSXseMA2E4
	CapFecJC9qJr6ZWgVThNJSkBf6W4VoZMsetRQ5b0lserKBaF+oaNkb9+MOq1nnre
	8elJP6MAcT2bl1hfQjud3+QG/5zVUz8VpBxvnO7z9ldU2Wljc5ymkuTWxYyqv16R
	eMVCv/WZfTHXtd70AWqKjl07CSZaILHq38jNwOuvP51mjIpnA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xmxq4tsvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:53:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MErA0L018874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:53:10 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 07:53:09 -0700
Date: Mon, 22 Apr 2024 07:53:08 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sekhar Nori <nsekhar@google.com>
CC: Georgi Djakov <djakov@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] docs: driver-api: interconnect: fix typo
Message-ID: <20240422145308.GA25316@hu-mdtipton-lv.qualcomm.com>
References: <20240422042910.2248234-1-nsekhar@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422042910.2248234-1-nsekhar@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wqCiAlHnGTAccd8LIpsIYzklWg3Gfiei
X-Proofpoint-ORIG-GUID: wqCiAlHnGTAccd8LIpsIYzklWg3Gfiei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

On Mon, Apr 22, 2024 at 04:29:10AM +0000, Sekhar Nori wrote:
> Fix typo in debugfs path name that prevents copy-paste of
> commands given.
> 
> Signed-off-by: Sekhar Nori <nsekhar@google.com>
> ---
>  Documentation/driver-api/interconnect.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
> index a92d0f277a1f..6d0a205b42b7 100644
> --- a/Documentation/driver-api/interconnect.rst
> +++ b/Documentation/driver-api/interconnect.rst
> @@ -119,7 +119,7 @@ any arbitrary path. Note that for safety reasons, this feature is disabled by
>  default without a Kconfig to enable it. Enabling it requires code changes to
>  ``#define INTERCONNECT_ALLOW_WRITE_DEBUGFS``. Example usage::
>  
> -        cd /sys/kernel/debug/interconnect/test-client/
> +        cd /sys/kernel/debug/interconnect/test_client/
>  
>          # Configure node endpoints for the path from CPU to DDR on
>          # qcom/sm8550.
> -- 
> 2.44.0.769.g3c40516874-goog
> 

Thanks Sekhar. Could you also fix the similar typo a few lines above at
the same time?

    The ``test-client`` directory...
              ^

