Return-Path: <linux-pm+bounces-9418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C125090C811
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BA41F21493
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34621D18FD;
	Tue, 18 Jun 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jCVm8vli"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230E157E87;
	Tue, 18 Jun 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703249; cv=none; b=W878G6Xq3VaxX2R7AeyhRtB/YFQsUnywg8H0Tlp61DaUBb4wEHEsvBx0P288VGjdcUE4arV/sBosjiOon/5/LUOvPeIv2JOsb1Z93/pzVSWZjvzwN2VwnEFyy0b/VkMSJg2H812Voja45ArAOp9fQ5Nug3qU3PJw6MVQQh5l1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703249; c=relaxed/simple;
	bh=SuuMdxTB1TUBGVcPE3uMbDVIZIHn+4mmBaHPMxoGQL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SBUgZAJEiy49IfepK+WPVrkTlUjXsbgB4UBo4OzfVatrP0AgMXK67sl3m5yLl09i/xyd8bdZkuCUU5bwCCcuU+UjfDsjx2wATu9VMet+22BIL9UPypnEPNbt763zOhV0pb6YUwbnsvU2LBPXV+/QR6w8L1TgQ4FHfYn+JPp0TEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jCVm8vli; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I4HAS1029833;
	Tue, 18 Jun 2024 09:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WtVfBckLiI5FLen15wtMjcawDbR9unoUCWkw3vJ4c6c=; b=jCVm8vlidaIoUFvm
	tOXuZOfyMpi89j21Ve9Mola4mq+cReuT8kiDPfWcIa6NhSMFbirIpdOMlORBHtS8
	s2bb6TSkr8Ip4h5OyKwp0VCBYjnzgDvfuhOhpiyxZ1CMFH5E3Vpv9FDERclZhuD8
	3mek5ooxf88cehYMCxang9Cc8hxnm/hd7bITY8v46Kpfe9bIJpYIFFLXotCnQfaX
	TKSFYEOy3KNtcA3kpXuwWMGhWolp2wRLnKWbal4IVeN2clHMwb1giReSwEHg01Vc
	4qhB4GUTSuVApSofC3BP9bozZx2P6jLQLbprV2KYp6EhnZOM3uQEkuKMKvqEHLmv
	qfrsZg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytfut3brq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I9Xmre011769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:33:48 GMT
Received: from [10.217.216.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 02:33:40 -0700
Message-ID: <9984b744-ddd2-4ef9-a766-8e8ad40a6bfb@quicinc.com>
Date: Tue, 18 Jun 2024 15:03:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 1/5] PM: domains: Allow devices attached to
 genpd to be managed by HW
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy
 Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit
 Pandey" <quic_ajipan@quicinc.com>, Dhruva Gole <d-gole@ti.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-2-quic_jkona@quicinc.com>
Content-Language: en-US
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20240413152013.22307-2-quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tdta4hSDgOD0LTzLi2KBW5duGrYlq5x-
X-Proofpoint-GUID: Tdta4hSDgOD0LTzLi2KBW5duGrYlq5x-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=938
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180070



On 4/13/2024 8:50 PM, Jagadeesh Kona wrote:
> Some power-domains may be capable of relying on the HW to control the power
> for a device that's hooked up to it. Typically, for these kinds of
> configurations the consumer driver should be able to change the behavior of
> power domain at runtime, control the power domain in SW mode for certain
> configurations and handover the control to HW mode for other usecases.
> 
> To allow a consumer driver to change the behaviour of the PM domain for its
> device, let's provide a new function, dev_pm_genpd_set_hwmode(). Moreover,
> let's add a corresponding optional genpd callback, ->set_hwmode_dev(),
> which the genpd provider should implement if it can support switching
> between HW controlled mode and SW controlled mode. Similarly, add the
> dev_pm_genpd_get_hwmode() to allow consumers to read the current mode and
> its corresponding optional genpd callback, ->get_hwmode_dev(), which the
> genpd provider can also implement to synchronize the initial HW mode
> state in genpd_add_device() by reading back the mode from the hardware.
> 
> Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
> Signed-off-by: Abel Vesa<abel.vesa@linaro.org>
> Signed-off-by: Jagadeesh Kona<quic_jkona@quicinc.com>
> Reviewed-by: Dmitry Baryshkov<dmitry.baryshkov@linaro.org>
> Reviewed-by: Dhruva Gole<d-gole@ti.com>
> ---
>   drivers/pmdomain/core.c   | 64 +++++++++++++++++++++++++++++++++++++++
>   include/linux/pm_domain.h | 17 +++++++++++
>   2 files changed, 81 insertions(+)

Reviewed-by: Taniya Das <quic_tdas@quicinc.com>

-- 
Thanks & Regards,
Taniya Das.

