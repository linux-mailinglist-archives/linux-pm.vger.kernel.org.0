Return-Path: <linux-pm+bounces-28189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E5ACFED9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E88C16B17F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849E286419;
	Fri,  6 Jun 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEESVUea"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB927A127
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200893; cv=none; b=RLvEsrbTMl+y00JpnZfaVcRD/gZ08XXYN6ITqr2nXxLC5ctjZRpe0Hi/hxBAuCSz8jb3QtPFkqVk7WbOtwJM8AuHjZzvu99utjA+XCEjKS4isLKivZMLAFNViMw9LvWuFYvYFAVawPKBIDVMk9aranwCbDrKfCA+3sHKOdeEP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200893; c=relaxed/simple;
	bh=ZFnM3PDhFbSJjWsyk0zkU5H5rASBj60HHgmc53ZHy8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmF/7yCn9iJbEC4sScBFSLH3qINhX8qeTMrg9jxzyWK/JGUV9iMGDCJD9lQ3bMbD1CWez9KN2UjcnZoa/bkV3waG5zuN5ShocK+Y53MJTRgbCK9GNjCXWtLG4FRC7qFFVFJggFI1f5EW1imwpN4fOnBSF4t7dQ7gJCUWw8vrhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEESVUea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749200890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zY1UJXwwdXuV/sjsPfipNC1p4dsxIugLMJFfrvt+Ih0=;
	b=hEESVUeaznH0JxUOK+TKxspAkTxbnqyAS0j5WVhE+1A2OpMhECei2lwVSGSDfJwuYsYjIg
	d9lFNwiYGzYu2dD8itVrqTu0GgSFgcIqu+MdP3BQez8dl9uAT4XS1URimP3IjUw1pW8bCY
	r5H/e60QwPUpJtBRKuSdMlJUso3JoZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-vCQzFBpBO-W-A_SM2iQlfA-1; Fri, 06 Jun 2025 05:08:09 -0400
X-MC-Unique: vCQzFBpBO-W-A_SM2iQlfA-1
X-Mimecast-MFC-AGG-ID: vCQzFBpBO-W-A_SM2iQlfA_1749200888
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450eaae2934so15764335e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 02:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749200888; x=1749805688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zY1UJXwwdXuV/sjsPfipNC1p4dsxIugLMJFfrvt+Ih0=;
        b=ScbFZXqcSaC9L8UO5mQEWLEPZjYuX8u+dChG6DWaQDPWstRPbwnYSGsejWp7PXvHbW
         WSLDwminatUcGz+7ov7BwSVIdka3ZLGM/SQMEV07N2fs6mE3OIlSehoBRHAGozvjUzlg
         B5Dc5wHhd8kYlCMtEM9cnFHu/hQpi+kdEEh4gxEhib63FKcXaV0DeRlp/sgFfrzUgR3c
         417NU4OZUYZ6JQq54lr/BztqzxVPPHdOkBZXvSeaDFWJ5GeTGB48bOGjkrWQrx8O5rnj
         eRC32Qf0JKqvkJ8md/f3ETachlkr5PtZ/twb0yKYEwgn5+5X3VTgi+4Br90QEfEPY8R7
         l3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRoQ2zCzOMohrWvh/pDpHSOhXWeDWvYzbokKQhSdN3hEviFyQzzDnIvDnyfR2cytzMXWYdSikA/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPXp/0DvkyroTnP8hCMn2ZZbeuMlRmEL102p0PM2VBSsjdjVw
	dcDJIdxBKnJ5pk0wcTzbkdF4nnUgRsk/+jBLCPulEuIAu+hdWyByWtezMBlogRKL8nqk4XYXnaq
	yXxI0tiRTrxLcsDWdjE8Sk5TkBCFDp1NXRa0xtCR2EEcsoF2ZlKdGlFr5hlQ6
X-Gm-Gg: ASbGncs8GdSBF4yptvpILcmKrfzxVXmaxrQqL4jl7uc84fmPaUi8P6GPVqNxlEBYX+J
	DoPXxlRPMXJR8xi+u9BDeSv1q2Olb1yfiGcG6vfdKA0hvImYLBK6TWxUuBt495b0GtRoBTnm9Td
	n2CJZ9OLjIChwS7tBKVJMGqB2QPIygsHsPFthLiEMyJI4opCytf/Vncj+3FgxTsusAfsD8t6u7g
	yvqjaSALNXAp9WquzjFbV+6uq1Qy9dLV672bfXBdRiqAl8sZs+mtO2JBD4eLQMKYQIcKJW12YQv
	s2HXut24mb2msNsIGfCslhEzEzcSICgZJVP9cv/hNXFwMmSexIT2gM93O1NT8Vnc4uF3
X-Received: by 2002:a05:600c:b86:b0:450:cd25:e68f with SMTP id 5b1f17b1804b1-452014e9325mr24877495e9.27.1749200887748;
        Fri, 06 Jun 2025 02:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFgCfJhv5D4WKiJLVPtf7WFxx5mFScPGVIDDWdSB4TB7uCI+iacBtSoT4d2UV7tlwIeLe0gg==
X-Received: by 2002:a05:600c:b86:b0:450:cd25:e68f with SMTP id 5b1f17b1804b1-452014e9325mr24877175e9.27.1749200887316;
        Fri, 06 Jun 2025 02:08:07 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137290b9sm17000835e9.34.2025.06.06.02.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 02:08:06 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: remove code clutter
Date: Fri,  6 Jun 2025 11:08:02 +0200
Message-ID: <20250606090802.597504-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

There is no need to introduce the boolean power_on to select the constant
value for state. Simply pass the value for state as argument. Just remove
this code clutter.

No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 2a213c218126..8fe1c0a501c9 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -22,27 +22,21 @@ struct scmi_pm_domain {
 
 #define to_scmi_pd(gpd) container_of(gpd, struct scmi_pm_domain, genpd)
 
-static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
+static int scmi_pd_power(struct generic_pm_domain *domain, u32 state)
 {
-	u32 state;
 	struct scmi_pm_domain *pd = to_scmi_pd(domain);
 
-	if (power_on)
-		state = SCMI_POWER_STATE_GENERIC_ON;
-	else
-		state = SCMI_POWER_STATE_GENERIC_OFF;
-
 	return power_ops->state_set(pd->ph, pd->domain, state);
 }
 
 static int scmi_pd_power_on(struct generic_pm_domain *domain)
 {
-	return scmi_pd_power(domain, true);
+	return scmi_pd_power(domain, SCMI_POWER_STATE_GENERIC_ON);
 }
 
 static int scmi_pd_power_off(struct generic_pm_domain *domain)
 {
-	return scmi_pd_power(domain, false);
+	return scmi_pd_power(domain, SCMI_POWER_STATE_GENERIC_OFF);
 }
 
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
-- 
2.49.0


