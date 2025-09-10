Return-Path: <linux-pm+bounces-34359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D2B516D9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069AA7B2A9A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86531283E;
	Wed, 10 Sep 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQEP+c2v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDA23E335;
	Wed, 10 Sep 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507199; cv=none; b=R6qNl2Qe51R7uNIxYB2MQiToAXsHxKU7jUwEjvVv18T7gX5zEwyeOM5s79nbGc/G7zVdJnyeVNFbOVJKRrpEPFJYZQnZFAMTNuhuvMSzJCyoU4zramxF2n0UCTQ21sysm3ufM0cIAH9cDDhkv+uDDAls95scWUSNcK0VV3o1SW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507199; c=relaxed/simple;
	bh=5+oqeQqKcOcNexLLWSaNP8FwXROd5N6zTPNxd1c9umA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hER0+jXSJGBioGFClLxdH4e1lD1rKQAX6tP4UMEC5m8EF6nG2A0rbo7GfRuq9C4u2lMSLll+iOyphscl3NKpYslwxXxosgtJ3X+5rkC6/l2bQqgscWuSBhhTaKU5326tYYxyvnHYwDgEerCFxI60UMsc6NOqNpyUDxz/HtgTFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQEP+c2v; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772679eb358so6325092b3a.1;
        Wed, 10 Sep 2025 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757507197; x=1758111997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAi4h7GkC5BQfTMRwYsmkT5Tfbmlnk4jobHVH0SykIo=;
        b=QQEP+c2vEis8MHIARWYPUAw2eAe9Ksji+83NNeacr+y6/b9vpcm5qiLRcIJBhLXwc1
         lof0vdSxtYPg5CTe+G+K6fd7RJ7tUz7yNoFsdRai23ASVQnn5dU0pDZAtSawjKiV4htz
         xy6MRXaQ+9hAuX1Pz5odJQgc8+tL0N4OQuUCw3dhkkVu2YLGBd53vlyxVVoDhECz7GGE
         MYfn8Ryw7/Ft2dYcSPCynL7Ln0SIOP+IbzOBybNijAUQLclZEzm7TrpgoDHiHPRqAC3D
         Ltd8tyGv/wWPxasoP/V7WnXmfuhR4baGHJfCD7DBlVVkTcrH8qW8ui8C0gg0C7E03Kkq
         6pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507197; x=1758111997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAi4h7GkC5BQfTMRwYsmkT5Tfbmlnk4jobHVH0SykIo=;
        b=SlIMaMD3+YqDENK7a/JoYGqEiqHS1sF+RhphsvUDlhrvchCEVTiAjwdiN8iCcNUWAs
         HM/23ZaJFjzEsNEeJrVTdy1LVcOTwkkCgMit7ml1jbwDBM+jL+h0uxMjRTsZxrhRdbz6
         ZPnCK6rKpmOToAOsvvZJWNw/Zr3XHRV3vkeYX3Tn9+km/yevtGY8/Qsos+rn1H3XbdCh
         kCUo2Gv9aRNNrUCTnzjnHJIksB+fRdde5L1rCgFllHQ9B6/nnJHwN5YDjhAE1QGC+2qc
         L6xJj2ZjbXXWOHpPuK9MPXsowYRBzFzelReNz0OHw35/gyHeAuTYS/RW7x3TmeHzgxS5
         Zbfw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqTNFzy7wjfdi6mZZvVd6W22UqQIZxVVA/ZwG/17fz+lrFSfZVQalJYZH3mQJdktnVIaWyVTy7+Nuo2o=@vger.kernel.org, AJvYcCUy4hDOxslEbBOjr3iZElFyBCo/xmqgUWEsLue64gxWocitHf59LhGiL1lci8wMKPRJx98AxZK6In0=@vger.kernel.org, AJvYcCXw94NpWsQCb3Sf53PKYMi1HJftDTM3wehEQAWf9UABmke3MfQaTLb+4OBBSTo0IeLPeqYq6EPSM2jM@vger.kernel.org
X-Gm-Message-State: AOJu0YxHulLNU9TGtlQui/sS/PHErWJSPdOPhVbmCl04UzPwsvrclxtd
	eRI3LChbNJm67gwlyWQ2Vv/l12XuiZ5iEDFK5lTq0dQJCoIIScOXB7Ik
X-Gm-Gg: ASbGncsbBxfy1PDRd9aZMMKHZq4Dym8dL2wVM2PpOgVar7YpvZH1HKKbP7zNpswuZUR
	OstdrcAPh4m/J+PvmzVHLOl7dzeMEAIqyZWu0iS+hb+TPx6kGwxiAjNigjicCuT+TPj+LVP9pdM
	U/LtSk57MmNlJZLFsQ2chnAL9ROCB58kQc3Iu7znzlu9aqfCH+Gs5DnnZXWPN0dxoDSv+LFYkTN
	MpoZyuzqqF4Q2YrYWlqox/AocQd3ls9eVEXDliT0o37bkV2SgFTg2nnXP1EznxMwsBkP7fczqlD
	Ye5f+vOMNEnmDKUPUFTxw70KxVo+T1w8rUBuYkMcWwPzsMvEwPrevkTNjaVfgzqp/Oud1CUWex+
	zdB+p28GvGE7sErS/No9ihsY=
X-Google-Smtp-Source: AGHT+IEL+glbAe4f7mR6m2MbjJRehY217dc+1T/qJfFPi9e3ces+GtynNKFxecJgYJ+s46Lx0V236Q==
X-Received: by 2002:a05:6a00:928d:b0:771:e434:6c7d with SMTP id d2e1a72fcca58-7742dcce97dmr19901041b3a.12.1757507197186;
        Wed, 10 Sep 2025 05:26:37 -0700 (PDT)
Received: from localhost ([2a09:bac5:3981:263c::3cf:19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775fbbc320dsm1290652b3a.96.2025.09.10.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 05:26:36 -0700 (PDT)
From: Ryan Zhou <ryanzhou54@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Thinh.Nguyen@synopsys.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rafael@kernel.org,
	royluo@google.com,
	ryanzhou54@gmail.com,
	stern@rowland.harvard.edu
Subject: [PATCH v3] drvier: usb: dwc3: Fix runtime PM trying to activate child device xxx.dwc3 but parent is not active
Date: Wed, 10 Sep 2025 20:26:30 +0800
Message-Id: <20250910122630.8435-1-ryanzhou54@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025090959-italicize-silly-f628@gregkh>
References: <2025090959-italicize-silly-f628@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue description:During the wake-up sequence, if the system invokes
 dwc3->resume and detects that the parent device of dwc3 is in a
runtime suspend state, the system will generate an error: runtime PM
trying to activate child device xxx.dwc3 but parent is not active.

Solution:At the dwc3->resume entry point, if the dwc3 controller
is detected in a suspended state, the function shall return
immediately without executing any further operations.

Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
---
 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 370fc524a468..06a6f8a67129 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
 	struct device *dev = dwc->dev;
 	int		ret = 0;
 
+	if (pm_runtime_suspended(dev))
+		return ret;
+
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
-- 
2.25.1


