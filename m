Return-Path: <linux-pm+bounces-14400-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D597BA3A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F12281CF0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA517837D;
	Wed, 18 Sep 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ozSINlCU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F915C150;
	Wed, 18 Sep 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652477; cv=none; b=khwFdpcBgiORV1SJxkWdsDaJDSOjbCSi0+KYTvNpofr5gxOAwGCqaknidERWHK/VBznyjxVE6vXCrLydBb6H8zBOgSYmetj37R1ZTWyVHfIVRomBlW0TXSbfmgKw2YaCS7hLia9FCblHHbtXF25bbIGe2OQjCnpC2H+VbFLeJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652477; c=relaxed/simple;
	bh=U8/Lv2YwwgyhpxOf09roeTE5M92/MEKBkzahSiAmuNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WBkEXUnVmGK46FPSstHtNTUhY3ocKebuqwV6RXi0QUMvIMGciF7/ezwl0CL+L2DRoO8kMybSnM3Z2EnA9S6xm5yCgAIQ/WmobGgOHn9m7/dIo54IZl7zRLK/2/U5g7dsOxsrCHtDna6wOXlHGuWwBf0UbQU3e+PkxaqS0ELVdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ozSINlCU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HIoZFe013717;
	Wed, 18 Sep 2024 09:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGKeKnE4cbpXs2ly6M1HqZTGvlB5uPeWFZTcOSxFjhc=; b=ozSINlCUx1oBkvd9
	DmSrn0CVyAFE9Fxqz7JFUhV++6V2F34uAOHgv7YC9FcCbd4Urx9OBSDvkhGyH48Y
	ZY5ErvZYVBXWzdKAbPRQAgpRrMaq8wOkbNQemS+YEp++HlvxMvm/L8DTuvIqlxhY
	xM5BVyoXfTHaohSr4fCIxSFP5a/Ob3fAY2G0+ST7ooRT84uie0XjO2hy77f4q8u0
	D9ZGZhh3YLLIJ6J1tPm5WB774HCNduYoeXCuANOpJlAlHezVPl72EOkmIbR+Qnqv
	SgFJsbgbY1EdlfJap2vExMS3yxhNLnvkX22ryA5rXxLFM5ciXLeIugoAE/DCSvFo
	7cBCnA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hh9fwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:40:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48I9eghY017304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:40:42 GMT
Received: from [10.218.15.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 02:40:37 -0700
Message-ID: <40dd23e7-9ea5-4eb3-bb6b-e1952d746958@quicinc.com>
Date: Wed, 18 Sep 2024 15:10:34 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] interconnect: qcom: add QCS8300 interconnect
 provider driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Stephan Gerhold
	<stephan.gerhold@kernkonzept.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        "Adam Skladowski" <a39.skl@gmail.com>,
        Vladimir Lypak
	<vladimir.lypak@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Odelu
 Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240910101013.3020-1-quic_rlaggysh@quicinc.com>
 <20240910101013.3020-3-quic_rlaggysh@quicinc.com>
 <3xjvx2kwrlruhhxw4aald26qjf5fzikay2ypzr3mwv75mlmf5q@lmn2o64npfg2>
Content-Language: en-US
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
In-Reply-To: <3xjvx2kwrlruhhxw4aald26qjf5fzikay2ypzr3mwv75mlmf5q@lmn2o64npfg2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kfAHwdp5rv5mTjZA4y68O1eyqBSLz097
X-Proofpoint-ORIG-GUID: kfAHwdp5rv5mTjZA4y68O1eyqBSLz097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409180061



On 9/11/2024 4:18 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 10, 2024 at 10:10:13AM GMT, Raviteja Laggyshetty wrote:
>> Add driver for the Qualcomm interconnect buses found in QCS8300
>> based platforms. The topology consists of several NoCs that are
>> controlled by a remote processor that collects the aggregated
>> bandwidth for each master-slave pairs.
>>
>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/Kconfig   |   11 +
>>  drivers/interconnect/qcom/Makefile  |    2 +
>>  drivers/interconnect/qcom/qcs8300.c | 2088 +++++++++++++++++++++++++++
>>  drivers/interconnect/qcom/qcs8300.h |  177 +++
>>  4 files changed, 2278 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/qcs8300.c
>>  create mode 100644 drivers/interconnect/qcom/qcs8300.h
> 
> The driver looks pretty close to sa8775p one. Would it make sense to
> have a single driver instead? Or would it complicate things
> significantly?
> 

Yes, the target is close to sa8775p. but there are differences in the topology and same driver cannot be used for both targets.

Thanks,
Raviteja



