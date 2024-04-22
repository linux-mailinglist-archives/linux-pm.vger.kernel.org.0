Return-Path: <linux-pm+bounces-6770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583848ACA1A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E698283983
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599C13B7A0;
	Mon, 22 Apr 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fWPDcojr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1B12837C
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780033; cv=none; b=sklIpuE/ADioofnv4irlgtsrpmOogc2KDXUioNXQaevEfIA0jJizHAa7Ire161Q1pc+R4wjdxGIuN1HFGQUA4tlvFHdYhsroqe/3e2zxsyxEqWeFByrBqptgUQDbewiCHkykpGqh9B6Jf/3fqZUUVCHKdPPyhBYPfe/UiSgsG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780033; c=relaxed/simple;
	bh=/kgM3M2CQ9kSB/j9iX5RDwS4UPbgyYPEhUl77ZbFEUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=BQcg8daqXpJuTTsJdhfRdabwuoQewxGdv+m2DPTAa8cFf1TNn8TTGwE8Ln8WN+U0Jzi0kWWd8XVbOFwV0A2lEsvH2rxA1Io9KnW3PRs8BYk0UahNLqKbIm48yGTffD1klI3qc5ultfeHQ0YTou8mVfgJUZcxyWQRTEuKip5kOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fWPDcojr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M6ahVK003084;
	Mon, 22 Apr 2024 10:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=4Hlp93KO7e8l97jOFkCv
	3cRnesaPYsnaI/Dz6r5qdE0=; b=fWPDcojrJgJEIW2DyO/4taNGVE5GgtwVWuxb
	+PQOV2mUA5n83rZFWZeTBpHIWZohB30lciRMesvaZO3l6D9okBc1GsSz6hez8o4X
	OGOpvEnRhrSv+NOvGrhgFvEVRP9HpOEFqUR1iy5PqpcOBwj6fiAnzHSaXhFGIpzW
	jrnRkCgeH5QjNw77H/5RQBEYSNticg4chdF4bEZUdmNFT/+H8N/aq3yRRnyXtmhX
	UCNedrORFOLGSSSgpTrgZ56A1mDlHWhIxGjOrX5ESPh1uVMf/Snz6bNoeRSnAjPu
	TBLg/dSlNC63jvwORsL9+zK3LrX1fubDhQMBfQ7CKJsvMhRgaA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xmxq4t2v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 10:00:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MA0NtZ026200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 10:00:23 GMT
Received: from [10.216.48.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 03:00:21 -0700
Message-ID: <c0c9fd70-69d4-a7dc-8c4a-773dc742f6c8@quicinc.com>
Date: Mon, 22 Apr 2024 15:30:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Behavior of the PM framework w.r.t the parent-child relationship
To: <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dnw4MaP1en_ke79CN0K9gK8yjVV6zEt-
X-Proofpoint-ORIG-GUID: Dnw4MaP1en_ke79CN0K9gK8yjVV6zEt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxlogscore=821 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220038

Hi Rafael,

We are planning to add runtime PM support to the PCIe controller driver
and facing some issues with runtime PM. These are the details.

PCIe controller is a parent of the PCIe bridge dev node and PCIe
endpoint driver as shown below

PCIe controller(Top level parent & parent of host bridge)
                         |
                         v
         PCIe Host bridge(Parent of PCI-PCI bridge driver)
                         |
                         v
         PCI-PCI bridge(Parent of endpoint driver)
                         |
                         v
                PCIe endpoint driver

There is no driver associated with the PCIe Host bridge device node.
And the runtime pm for the bridge node is not enabled explicitly.

we are seeing PCIe controller driver is getting runtime suspended even
when the PCI-PCI bridge and PCIe endpoint driver are active.
Our expectation is controller driver runtime suspend will be called only
when the child drivers went to the runtime suspend as the controller
is parent device.

For the things to work properly we are calling pm_runtime_set_active() &
pm_runtime_enable() in [1]

As bridge device node doesn't have driver associated and it is kind of
integrated with the controller, So we are expecting when the controller
driver enables its runtime pm it should enable the bridge runtime pm
also and vice versa.

Can you please check this behavior and see if it is something which
needs to be fixed at the PM framework.

You can find more discussions on thread[1]

[1] 
https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com/T/

Thanks & Regards,
Krishna Chaitanya.

