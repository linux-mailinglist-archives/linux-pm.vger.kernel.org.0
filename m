Return-Path: <linux-pm+bounces-27188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B3AB7E33
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9494C4999
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD95296FB8;
	Thu, 15 May 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HLnpRHs3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CCD29673D;
	Thu, 15 May 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291345; cv=none; b=WRM75N+HO0060RAzpCHgR6czOfk4julcM3PKGDKbWC+FxMJ3kQMd4N6v6RqUEiP1x894Hl1jSBny1xyuiFiEadWk6i0OBlM8pbiMllQS4q9MfdvNmgd4ADKxrbk06ntEMZeFihybQZk/kCDyEFAcyhLDaa5u2DmpGZ8QvDY7QUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291345; c=relaxed/simple;
	bh=69uQGetP4cHphm++LEFmfNFCPk+Rz2LhIoWgX09q16A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxNrnm6dr0CEv6k2+Ofe9IvrkehNOEqDBtwkdNPYjL+Wa9KZrn1o4uX5jzbkdrtRVzydmI107fvBbrRg5GQKCS4xIP5Dp7XR/cbqAbdpi9W8aQgyu0cf8gtATqGFcs1UIXzEOZVqbjCvNtLcatnLUBfjc6tryFh2lpbDqTcH3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HLnpRHs3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EIeSxL002748;
	Thu, 15 May 2025 06:42:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9r5OcaVRJunHiRxyKY7Nrf
	v+T7msSpQEsmsSgben/yk=; b=HLnpRHs3nbku2sv/Ij1oh9E3xp9ih3SeUG6t57
	2QP5w97VpQ+FF7Ib1dpGhPQK8cAkXcsga4SO5s2MIluDd1n+C8oqSGpGRyZsCMW2
	ybmjcogSFnzjrdLdqDA2Sohh82a5Xqhp6MNVqO4XL4OflV3zlEsjSEpPyR00rp57
	IegPgZaXPMYtKu+w9E6F6AlBqVzTlc7Rmfj9+zU/iXf3bPbv3FqgJIGH6raI7cQu
	HGegE+pMPQ929tGRnYbCkjqJvmR7kCVe+KbX09ggC2Lr+O2htGnJUFPXp1iKruBw
	+NKa5AicEu4fjpWvcFs6YQnBwHRoAztOQmALzwcj33b/yE/w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpd6vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 06:42:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F6gI42028639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 06:42:18 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 23:42:15 -0700
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: <rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
        <gregkh@linuxfoundation.org>, <dakr@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Charan Teja
 Kalla" <quic_charante@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>
Subject: [PATCH] PM-runtime: fix denying of auto suspend in pm_suspend_timer_fn
Date: Thu, 15 May 2025 12:11:25 +0530
Message-ID: <20250515064125.1211561-1-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fhHlrlFSvDfN-PrL4bamuMWqKoVO2whb
X-Proofpoint-ORIG-GUID: fhHlrlFSvDfN-PrL4bamuMWqKoVO2whb
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68258ccb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=H9JB4yF801-ZaJQK_joA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA2NCBTYWx0ZWRfX8L/1cc0T8Wyp
 KxZuPHxfR4l0sSwwQR5232zXjQ0ByFU2Ha+jNmk2Jo5g3RaK4hgA5EmO6UGWyNvhhTwGYBewCur
 81iqPN0UFSgO+fU9ojGGggI73WrVbykIlH714Eyo9v6laRIxVsnc18ZefvnA2lyPj0QnSb1ZrVW
 JDDe5rrtvpsmp2D6RFj5ArwSFeSWGG8zrA/E8GOMunwdm/zWvInxVz0+M2qlS6WojRdfeiHIkuo
 lv0AIRTN1d3FopVMrLmDEAGy3FkNfiChntDTKMD+Mjlo0mFz5AuMVgD7Xcbh28HPWxHzkl47pcR
 VGRCMs7tDyEb3mdYqqHE9oGXpMvNqvYvfWTx5Dc0SSMXRTA06o3iU2KRYKLEbkDdGSkwxakYxI2
 TmQVHgGd0/aCrYPdP9Y2uXBz68LOPNIP+KFlYvt+6IXUsFNdr30euZKPiogeCVPTSFJ5MOAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150064

pm_runtime_put_autosuspend() schedules a hrtimer to expire at
"dev->power.timer_expires". If the hrtimer's callback -
pm_suspend_timer_fn - observes that the current time equals
"dev->power.timer_expires", it unexpectedly bails out instead of
proceeding with runtime suspend.

pm_suspend_timer_fn():
if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
	dev->power.timer_expires = 0;
	rpm_suspend(..)
}

Additionally, as ->timer_expires is not cleared, all the future auto
suspend requests will not schedule hrtimer to perform auto suspend.

rpm_suspend():
if ((rpmflags & RPM_AUTO) &&...) {
     if (!(dev->power.timer_expires && ...) { <-- this will fail.
	hrtimer_start_range_ns(&dev->power.suspend_timer,...);
  }
}

Fix this by aswell checking if current time reaches the set expiration.

Co-developed-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 205a4f8828b0..c55a7c70bc1a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1011,7 +1011,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
-- 
2.34.1


