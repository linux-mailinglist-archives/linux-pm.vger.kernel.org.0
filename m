Return-Path: <linux-pm+bounces-38187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3EC6A743
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CA13D2BFCE
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A936997C;
	Tue, 18 Nov 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpWnU95n"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47736996F
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481527; cv=none; b=dLjnhOmeoJf6+cCr5jSccdt49gPMBkXtUq7AmhLw1HcW6aM2fuC0/haXRcjbTEN+Gakdf0d0LefdQnoH7y8a6rjFT1cTjwV3i1D/RqcAFl4BJWGoWLi411SBy7VWJ5lYcsiJAO5E4C2xZPn+6zzKs64frC8bHhprtt7FWxjHkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481527; c=relaxed/simple;
	bh=w/IZMKw3JZlQsVeZkGgKBw6RsNQiyGUgrwYveTjVUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fF4wvA1ikjJt11VEkT4taUqe2EFTqX5BgrP10mZYFxTWpaGKu4ym4H1pOfZzIrKG3lzVmcf2Aw1tVlq2Z88ugao9V0wIOmTK4pbQY/qY1EJaN4MbzQ44GaMOgRzB7+bMaO+NNz78Hr39zEqiz/JsuGf+v0j50MU8HbtY6U01mNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpWnU95n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763481524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR6q9nN6tLl0OjvkimuaeaYQsj1H42Iqp2Su1pl+Lbk=;
	b=JpWnU95nSu0VHyPVC0qccdkSJVT14R4QozB2t4djZib8RlKktc/juYg/phbmWkxJReEGYV
	Sc5d8DuOIo77sTpZ39Ck5+mFGkRhgOGasE94uvYUlMps9qZVbq4TjnbQBl5V8K0KE8ZNQJ
	p6KDsGm7+t5b5dW7JlpbrWOFYhkjWLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-dplfiAZ1MWy2ktaNS09uKQ-1; Tue,
 18 Nov 2025 10:58:39 -0500
X-MC-Unique: dplfiAZ1MWy2ktaNS09uKQ-1
X-Mimecast-MFC-AGG-ID: dplfiAZ1MWy2ktaNS09uKQ_1763481518
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18A581955F68;
	Tue, 18 Nov 2025 15:58:38 +0000 (UTC)
Received: from darcari-thinkpadt14sgen1.bos.com (unknown [10.22.64.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA7C819560B0;
	Tue, 18 Nov 2025 15:58:36 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 3/3] tools/power turbostat: allow turbostat to work when aperf is not available
Date: Tue, 18 Nov 2025 10:58:13 -0500
Message-ID: <20251118155813.533424-4-darcari@redhat.com>
In-Reply-To: <20251118155813.533424-1-darcari@redhat.com>
References: <20251118155813.533424-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently when aperf is not available the function has_amperf() still
returns true.  The end result is that the program gets an error in
delta_thread() which causes turbostat to restart.  We can avoid this
by not setting msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present
when aperf is not available allowing turbostat to execute normally.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5567b9ecd516..b3f1e4ae5813 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8592,6 +8592,10 @@ void msr_perf_init_(void)
 				continue;
 
 			if (cai->needed) {
+				/* check to see if APERF is available */
+				if (cidx == MSR_ARCH_INFO_APERF_INDEX && !has_aperf)
+					continue;
+
 				/* Use perf API for this counter */
 				if (add_msr_perf_counter(cpu, cci, cai) != -1) {
 					cci->source[cai->rci_index] = COUNTER_SOURCE_PERF;
-- 
2.51.0


