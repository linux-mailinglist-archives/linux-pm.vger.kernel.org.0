Return-Path: <linux-pm+bounces-12417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A802956884
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3DBFB22794
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC95161328;
	Mon, 19 Aug 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANrY0/Pl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308431607BD;
	Mon, 19 Aug 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063371; cv=none; b=Ho2QQ2EtloEQELhKktoqMh2vnQP0L8PSxYWPcuwoYiwzOGCXcNQCMUMqF240rV6ivIaNejrL3+3ifjrhgjabnUc4HYTL4Fr4vwImFBuylcPe0XgIEv70Lo6aoO7vfSbYO3ViRp3GlRRTs5+hh9MruZRcpX6PeOExIhC56OUaocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063371; c=relaxed/simple;
	bh=n/HNo3bXhp8Z1tZ0WrF9AGd2RHZDK+fQ2NYNF7c58gw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KSGGY8n1arzMdTW9e3/ke9saFme0es8qCnoeZnnD4Bd4/cyWlduEqwHdNdSrpsRveVZOnqROF4leLkMe+AeGcjeHN13opOzoDLa+BsStixtuL9Ejal0HqrgpX2onDec85cgwnOJyrdC/NUfjEf3ZBaEDVf81rFMc0dELJseWOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANrY0/Pl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47INk1iF002536;
	Mon, 19 Aug 2024 10:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=oalxGoOgVALa
	kA13G9+maA/k2q5KTWfrChZjLVJVA0Q=; b=ANrY0/PlUVuDXFqacBiQa4nib28X
	1SgFsQ+tcqiaGI4W+BOVNZ1jb+32N5dE/zb/v4vJ09tgOVwFNzwLXStHArC4vkNZ
	Ilq152Tu+VNK1xN0FMSj3ZC+RYSAwLaiJXcwtRvZnPs6aQJi5AsVyDs07bViJvSq
	NRlEbwF0+pP0A8ZeOKpw0nR43Zk1aMU/6Zpvn38npRnEB29T8Nb1LGWjL2NLJmD0
	411cGNuaCUjF0PU9XTe5HhOpkNntBRpuTLPdyU7TyCRVXZTzamXs7Q8SuKOK8Fxx
	QWJi6Fa7QO4f5DZNrGi1vz8hmuQZyTSCqEZ2L/KZ4FCVSK3rN0+URB7nUQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412key3u9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 10:29:16 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JATDV4015269;
	Mon, 19 Aug 2024 10:29:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 412mxkbfsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Aug 2024 10:29:13 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47JATDfS015264;
	Mon, 19 Aug 2024 10:29:13 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 47JATDUj015263;
	Mon, 19 Aug 2024 10:29:13 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 6A4DC3474; Mon, 19 Aug 2024 15:59:12 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v4 0/2] add device managed version of dev_pm_domain_attach|detach_list()
Date: Mon, 19 Aug 2024 15:59:08 +0530
Message-Id: <1724063350-11993-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _AMVEJZ0qlrfeWZGGLOV6fdC62-wW84L
X-Proofpoint-GUID: _AMVEJZ0qlrfeWZGGLOV6fdC62-wW84L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_10,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408190069
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

These patches add the devres-enabled version of
dev_pm_domain_attach|detach_list in pm domain framework and
use the same APIs in venus driver.

If any client drivers use devm_pm_domain_attach_list() to
attach the PM domains, devm_pm_domain_detach_list() will be
invoked implicitly during remove phase.

Changes since v3:
 - updated null check for num_pds to num_pds <=0.

Changes since v2:
 - made devm_pm_domain_detach_list as static and no
   longer export this API.
 - added null checks for num_pds to avoid adding a
   devres callback for the same.
 - added bryan's reviewed-by from v1.

Changes since v1:
 - fixed the warnings reported by kernel test robot.
 - added stub functions for !CONFIG_PM case.
 - removed un-necessasry type casting.
 - fixed the issue with remove sequence.

Dikshita Agarwal (2):
  PM: domains: add device managed version of
    dev_pm_domain_attach|detach_list()
  media: venus: use device managed APIs for power domains

 drivers/base/power/common.c                    | 45 ++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/pm_helpers.c |  5 +--
 include/linux/pm_domain.h                      | 11 +++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.7.4


