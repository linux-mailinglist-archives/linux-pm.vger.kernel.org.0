Return-Path: <linux-pm+bounces-26867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E362FAAF2A0
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 07:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E2C1BA6704
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 05:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F02135A4;
	Thu,  8 May 2025 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uusqgq85"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DD20D4E7
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 05:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681103; cv=none; b=TB9b7yzhahlXHSabIHSol47IzaxWEivKV5yRolDLZMhcEC/0jGwn+2eyAgaiKQOqCux8ot1Ol7gTTymaJ0J1vBn7RiAkVHWn+pJp6orMP6kcq1IHFFkMF4pgikC9iGUXsMwZ50sPX5Y21Swz6ziIKg6UBX8OmsBFz69olhl8gvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681103; c=relaxed/simple;
	bh=AQuEWPjekhThkflJFV9dZKxAkJmiFPkZ+D9N7nJgnOY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=STnoEk8BSXCT7Uxng0bfMoKW8YelL8n3FLQPaTsEBGmaahfRQit9e538PjFveMh2fcgZr7kG7Dbe4JRgvkUxFVg9e/V+AhWxAGY4qaAaB+suHUu6CevywY0kK4uImbXsZQDKeN0rgKbZJKbtP8uV2N5/EMB62kTjX3BX5WX4oYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uusqgq85; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ab450d918so995197a91.2
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 22:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746681100; x=1747285900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+objnduDEdA6XgtoHIMnhtVVZlrAlpTMhfHb5uGFsAo=;
        b=uusqgq85fZK7YMtOQd/EhhX5EO6PRytOwuUo4QpRjxRrFI/ItckZ3M0RYZmwwwR7xj
         DbQfrKNX6oZXxbMjBdBbtp1FtK57uZzvY74KiLMW1dfrHyU1yPjBOETGxLqVAg/dqZtE
         duurueQyr9IAHkypH3UrjD+i4LeHVMUbREFnfgnSQtqJXxkvksWCKD5SY4YXNwHcueE/
         rHsQw3LeAy4f3kiJA7ec+CfbAONW9PK+7l8dDDyoc59sgA04mtXjGfabuktn58VsVfpI
         BZt3Xj3kShFjLwcsxhbhI94DiEzpYfvyPGapJ3JVnc1/O/4+3j0TDdnr51NJauvwyg1H
         3LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746681100; x=1747285900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+objnduDEdA6XgtoHIMnhtVVZlrAlpTMhfHb5uGFsAo=;
        b=Y5XGGf3cWvqyrxN98ekYXQTQaEbnTqT+TJXDImFvd37XQnK1W+wXrT5WC711njWsrf
         HJyDMVCi5IRA9/Bw4i0quFf1wSlWcoasbIcOxVg/K83kaIpYIxWjClBM/YEGb+l3lNFu
         JBBf4J4fGFRbujwzi46hRW7px5UL0TYH6pWRc/Xl1sFgJ2VeXVCC3QAsbOg8UP/Tt0Zk
         0zEl39aUBI1Jd46Y5VkZU908N1xyIs9porpwtE/1qusTrA6gfRyPJbIbs4eko8FFZoCW
         cZCAyqcf013Si3nHMmjgMvuCpLMObtaCIWyHy9u2vrMB+PtF/DOrxzfaHkgsxTmlIdQ8
         A5YA==
X-Forwarded-Encrypted: i=1; AJvYcCVcg5OXD/RA/J4+g640Q7jZZIRMnfBJtCS9B1OJajIDwTDx1FaclQIufmX9V9H5sPZBps0L9mqezQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnDZFm7cLk9QuvCUfVVI+nDIKvXqe8Gc4WGIw7DKQ6ih+XkxR
	sR1qr98U1rawEEtZh/O7lWFGqyCK3IRkhEp/IVsg1X4VIr4sNr6zaZQ9/pPMkBaUPr4v+VoJMa9
	FSw==
X-Google-Smtp-Source: AGHT+IGGonQAPWDxdBzLe2Ueqgy+uFD50vWf7E5zkm1R2s+R8YnCic3HHOe1DuE+B2Hm8cJPIF79XW+rfBQ=
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:2ef:95f4:4619])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a89:b0:309:fd87:820e
 with SMTP id 98e67ed59e1d1-30b3a6d7b70mr2372936a91.26.1746681100133; Wed, 07
 May 2025 22:11:40 -0700 (PDT)
Date: Wed,  7 May 2025 22:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508050856.674782-1-amitsd@google.com>
Subject: [PATCH v1 0/2] Add graph connections between tcpc & fg for Pixel 6
From: Amit Sunil Dhamne <amitsd@google.com>
To: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	peter.griffin@linaro.org
Cc: andre.draszik@linaro.org, badhri@google.com, tudor.ambarus@linaro.org, 
	alim.akhtar@samsung.com, dima.fedrau@gmail.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

max77759 Type-C controller supplies VBUS into & out of (depending on the
charging mode) the battery in Pixel 6. In order to represent this
relationship, we use graph to connect tcpc & fuel gauge.

Link to USB connector binding that this patchset uses:
 - https://lore.kernel.org/all/20250507-batt_ops-v2-1-8d06130bffe6@google.com/

This patchset depends on the following:
 - https://lore.kernel.org/all/20250421-b4-gs101_max77759_fg-v3-0-50cd8caf9017@uclouvain.be/

Amit Sunil Dhamne (2):
  dt-bindings: power: supply: max17201: add port property
  arm64: dts: exynos: gs101-pixel-common: add graph property to connect
    tcpc & fg

 .../bindings/power/supply/maxim,max17201.yaml      |  5 +++++
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 14 ++++++++++++++
 2 files changed, 19 insertions(+)


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
prerequisite-patch-id: 74aa0a6fc4a5c56d870bb15375fad1fe41ffc1e9
prerequisite-patch-id: 46f968300dcf5442e12d882ca23168494249d378
prerequisite-patch-id: 3ad83a2782819bca215bb267d36a1ff04fe557b2
prerequisite-patch-id: 86b5207d8f44255c36b1e600ecdf4f948c5da685
prerequisite-patch-id: a15532888ff2572696d9fa6a14775e8ebf590391
-- 
2.49.0.987.g0cc8ee98dc-goog


