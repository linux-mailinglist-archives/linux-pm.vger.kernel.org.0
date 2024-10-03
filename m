Return-Path: <linux-pm+bounces-15122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EA98F813
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F58B21F32
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 20:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8921ABEDF;
	Thu,  3 Oct 2024 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc6MI8VG"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BE1AC88B
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987194; cv=none; b=KHGKEIDXFmv0Xn2tIJ3COfkZdpNBarO61MXrb/Z/aqJP3wvyXRuUqcH1VOvD0SEcSKoRQRtGbTzRpRBU9tsHP0UzKWcIw9nWNwC0TCMtSliMZU7RAZRFeUR8rMHBsymQC+qOF5Jk7zmqPN8AUETRPCKXw5/E2MEP6m2uRE8HHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987194; c=relaxed/simple;
	bh=s3W8c6qcKyxUfG9k6Cc7K83ncqIQVch1STYPgum+C2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/iv7gWz1Z9qFfYgsqRfBj4n8M9jGM/dBEorkSxU91ARPI9VQHl0+x4WReQ06gp1UFMOzTKMn3gr2JWwogmdIiB/QzK5HFfaZre4cpgTXB9sRy/KnSOnKmROyPS21ANWYj72ariBnEcsnRmH1OERwd2nHvwrOZUVFvBEJjqQdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc6MI8VG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727987191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igBZH6mM9CKfKMsiV26eGd7LU5h+xeGLjVtbvEUEYvg=;
	b=Hc6MI8VGD+sue+WRTurHNXl5JEXNfTN5A+nosAWRl685o8MnMKzOCVU2UpY+GpB6IcQ6KF
	tNzhGS6uUv3itUWf87SM8FGi7jNniSMKf7g7y1N1mfJf2uPitsQQEgiX8RbWexaY7kPIY7
	ZtlqKpvJKPmhcWdxXjNT1sGWOSNSg5c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-UMcOCj4MPki9xWtJyi9arg-1; Thu,
 03 Oct 2024 16:26:25 -0400
X-MC-Unique: UMcOCj4MPki9xWtJyi9arg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1761A19772D8;
	Thu,  3 Oct 2024 20:26:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 759BC1956054;
	Thu,  3 Oct 2024 20:26:19 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Todd Brandt <todd.e.brandt@intel.com>,
	Marek Maslanka <mmaslanka@google.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	regressions@lists.linux.dev,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86:intel/pmc: Disable ACPI PM Timer disabling on Sky and Kabe Lake
Date: Thu,  3 Oct 2024 22:26:13 +0200
Message-ID: <20241003202614.17181-2-hdegoede@redhat.com>
In-Reply-To: <20241003202614.17181-1-hdegoede@redhat.com>
References: <20241003202614.17181-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

There have been multiple reports that the ACPI PM Timer disabling is
causing Sky and Kabe Lake systems to hang on all suspend (s2idle, s3,
hibernate) methods.

Remove the acpi_pm_tmr_ctl_offset and acpi_pm_tmr_disable_bit settings from
spt_reg_map to disable the ACPI PM Timer disabling on Sky and Kabe Lake to
fix the hang on suspend.

Fixes: e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-pm/18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de/
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219346
Cc: Marek Maslanka <mmaslanka@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/pmc/spt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index 2cd2b3c68e46..ab993a69e33e 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -130,8 +130,6 @@ const struct pmc_reg_map spt_reg_map = {
 	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
 	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
-	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
-	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
 	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
-- 
2.46.2


