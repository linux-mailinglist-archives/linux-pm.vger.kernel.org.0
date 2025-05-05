Return-Path: <linux-pm+bounces-26638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB4BAA90C0
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8055F1897681
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDE17C21E;
	Mon,  5 May 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pkX+gdLm"
X-Original-To: linux-pm@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster1-host9-snip4-9.eps.apple.com [57.103.64.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046941FF7B0
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440244; cv=none; b=RwmPIVcQqvTPrrBh3698HEZj0wvzPXXwOyT0tgsB0+KYNcIFg/My2NleH9hgN7F9xu+Qc96sawXwqyJ8zB9x/OhJRhs0KWYcbCuMK6oIxez6SnitDy9pI9RlJfZ55+Fa0eIorAIGqqVvTIKDAsF/4AdzOEJaN65ym6uWkSsviwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440244; c=relaxed/simple;
	bh=GUGFiV9TE85rK6IJCno2tLTGn6CA49p2TSUwh7TGSUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r/UhHPkX0CYcILjpraVOcEQwnhxSVZDnP5E+uoofdBT4qcb6EuFrvYlklxwl5omkqyRX4/QKOqT90ZYlHZCVYt7iZB0ChGLt2yMkT6LlVkyYZ9euVAopk/mf3g8jqoLnm9EF4gCsMMWrZrTALuu+rF4XcVjXebL+0dyKa0i9hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pkX+gdLm; arc=none smtp.client-ip=57.103.64.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=TpUqnDjaGq9gtGHHOd6VeHOE8qsCo3MZ6iZzx1E1rwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=pkX+gdLmYCa9UXAzCbE4wSZrAWRiKwFVotAeE4fYEFmgdf5LaWnxAVRAgJEc+yaUL
	 xEJaghCX2u19oIymLyIQXYbc0/Os0z7y7qoFyURYNKeKVAygDsGKKQ74qvEC52jcyo
	 BY8dSrObbmQLMphzXeEjAOJlhFQzYtwrSfC4JrV6VT1NP7yyJWL0RPu4Nse2BxxhHQ
	 G3k2HAtc0h1c/zj4j1XDw0UAoobVR5u+y0lu0ZQ3BrXAmV/acK1tjmft+BQNWQxcOG
	 Y5PBs3sh/vJMw8T/ZfKckCX/fepP1C6vmb/BTeyUeN1NXRwZoaVCiEIRWxYZ7PBWAi
	 7/y/p8blwU0dQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 79888180022B;
	Mon,  5 May 2025 10:17:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 05 May 2025 18:17:04 +0800
Subject: [PATCH] PM: wakeup: Add missing wakeup source attribute
 relax_count
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-add_power_attrs-v1-1-10bc3c73c320@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAB+QGGgC/x2MywqAIBAAfyX2nGDSA/qVCDFday8aq1QQ/nsSc
 5rDzAsJmTDB3LzAeFGiGKp0bQP2MGFHQa46KKkGWRHGOX3GG1mbnDkJv03Wj5vrLSqo1cno6fm
 Py1rKB5l+RRthAAAA
X-Change-ID: 20250505-add_power_attrs-fb7cf6bd4ce2
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: CNjtgK9LB8I1L7anSHyGRHuoN9xVDyl6
X-Proofpoint-GUID: CNjtgK9LB8I1L7anSHyGRHuoN9xVDyl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2505050098

From: Zijun Hu <quic_zijuhu@quicinc.com>

There is wakeup source attribute 'active_count', but its counterpart
attribute 'relax_count' is missing.

Add missing 'relax_count' for integrality.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/power/wakeup_stats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 6732ed2869f9f38a272faab0044b6eb3edc051f2..3ffd427248e8eebae3c05b5165bd4200a0668339 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -34,6 +34,7 @@ wakeup_attr(active_count);
 wakeup_attr(event_count);
 wakeup_attr(wakeup_count);
 wakeup_attr(expire_count);
+wakeup_attr(relax_count);
 
 static ssize_t active_time_ms_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -119,6 +120,7 @@ static struct attribute *wakeup_source_attrs[] = {
 	&dev_attr_event_count.attr,
 	&dev_attr_wakeup_count.attr,
 	&dev_attr_expire_count.attr,
+	&dev_attr_relax_count.attr,
 	&dev_attr_active_time_ms.attr,
 	&dev_attr_total_time_ms.attr,
 	&dev_attr_max_time_ms.attr,

---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250505-add_power_attrs-fb7cf6bd4ce2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


