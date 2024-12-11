Return-Path: <linux-pm+bounces-19000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F9F9ECAFA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8728692D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA050211A0F;
	Wed, 11 Dec 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRKT7R42"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A21A8413;
	Wed, 11 Dec 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916185; cv=none; b=fJ+H540U0Gui0ubhBUMfsB2g4a+Up8a+37Nf8xTLgRF6pbuNNtTQalSNr7ms+rKLY4yKQ2ob2rLH9VXWXYu8gMu8RmbPLgzPKPV8G23Ai+R4fg89iocaos3UW+xhRjwFzu8zqF9EdWeRgw1Psf64rIP3CN2PmK0N16hzGPTDpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916185; c=relaxed/simple;
	bh=bfYMhLAAkkZc88mag8TEfhSuTWGW9xyLT/3qKbgJ2ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5p9Idi/k0gru2m+9tkJGwvcwipW2DbyuevNWjTAub812ppz/5f6vuiR2GskjUmKyVT16QBlUs6hDxrrypwLvDar1smJsf7n7SFi+gRMaLsT9FcYZLgcqc1HRRL3BSVP9k0yFvq8IEb8zwKgcWhI190MyYLA1xL/sQsK/vjaGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRKT7R42; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215770613dbso44171895ad.2;
        Wed, 11 Dec 2024 03:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916183; x=1734520983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2fBpF4DPgk8VjYpxJsEGAE8QpoFNbBTEEgsMSm8FzQ=;
        b=ZRKT7R4255kNlmZm3HL+WMr5Pa127eY0sektvC3ej1sBeatG6dLhL2NGE3UGgF3CB0
         6mjdCsZb3ApM3rOoOmKCwmKJnbOU+7cgwFYpDsf4ZCU+CLTlhag4UsKk2FjeAoOiLv/1
         lx2Ah2uExfR4zakl5JYzoOtxtOYWJCjMQoamv5oEVmwO+I+kGbd/oeNAbx1U3S5SaLP1
         UN/+2TX1K9cDxJRgm4KIR2qbOg10ZceGbz8KMhbA2JUjuBE0mhsQ5jTJ6ZvVzsDq/hqZ
         XVYQLjD3QoYf1ubL/scsoNBOYtvpuHsIxmCU0XeKKeT+QCC5H0n9prOGiSHCyOa/6ip4
         vVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916183; x=1734520983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2fBpF4DPgk8VjYpxJsEGAE8QpoFNbBTEEgsMSm8FzQ=;
        b=jrVoYhfOYh5o1dYNSLwo5ItZAXL46IVUcd5tY2lT8KWI35bnv4eHolnfbc/5z8djlX
         YBNk4IbBucp0wlf1VRnNFg+RthaddsYsUgOxisOeKVwJSCJVeiJfWZnKm0pMX+104qYR
         W6nKEzaS936YkQZ9MdyeVT6jj3aYtHp76b0qhrn8gcrESheWruLqk6K5g786OMzBMxch
         mePop/glj0NkZzVg7vSKbU7Qml3jyoWkgzbAZJm3b9f9tQYEbgBMSxyA/5a3slzGQi/F
         60EJCdu+Z3NqlH8XCg4yk6py1OLHwzFkRjTGHyB43Rifxge/lUrQqYug/8R/NJeTz+uc
         IQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtj5OKkRW+71MDT3WC9472ethG23oSTT5BXfgqhzz47ekqVr4RNf9x4Z//ArkoIZXnbQG3r/Iu7X7ypcqt@vger.kernel.org, AJvYcCX0ZMJvl5iy1zjN2rqRk2A910Pcn/oj98ta6Tj9LkPWttHXwDlHK5hsacIIjYP+thWOti4Yhk8lNqKE@vger.kernel.org, AJvYcCX6Kk9VFY2EwhslRH7QG/uIAATG1phPq+AUgzOVujygZefENrzbTGDZ0XRU53DLKI+MVtgv9byUaKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhrF2tIxgCDYklfqwyie84mdkxZB5b3Cnp95eaK5eDwLdNkiN1
	HpAqsHMTTrEtY2WdbVFGLfxStu+Ibd/+7dw6p8s34u+ZFtQKArbI5QtFf15C
X-Gm-Gg: ASbGncvNhh3P/mQj06HUNXOYFLukGDkRd36gxKw4WY4wQfZW8+/ffFxUD57Herwlg6L
	8aaT7rMH9G8Fc5GOPtQpb/+Pe8wyKHjf4HXTtG/2xRX98C2mqgyCFHkfoVS5piB4uvUY2ipJ0V+
	yrau9Ud+O7h7iEjzCPKSEDJTF1oiL34gOHhIfMwwawJ713HjY/TY9Dzan3GBd8kfDTtUmJ942qA
	BkUDfoA0N4pZMdFWMuHssRhpf4sbpTs8+AvKOTAjvOuaIBgUGvVjWJ0Caew676KQ6NEmQ==
X-Google-Smtp-Source: AGHT+IFQ2IW9tilUc4WqlMVThxJsWeAViNnNodENYGpepZHa2B/aZBLf4geEEAiOuYgDZKDGadI7tA==
X-Received: by 2002:a17:902:cecc:b0:216:2b14:b625 with SMTP id d9443c01a7336-2177853690emr44032965ad.31.1733916183466;
        Wed, 11 Dec 2024 03:23:03 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:03 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/7] Apple A7-A11, T2 SoC cpufreq support
Date: Wed, 11 Dec 2024 19:19:27 +0800
Message-ID: <20241211112244.18393-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add driver support for cpufreq Apple A7-A11, T2 SoCs.
Device Tree nodes will be included in another series.

Nick Chan

---

Hector Martin (1):
  cpufreq: apple-soc: Drop setting the PS2 field on M2+

Nick Chan (6):
  dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2
    compatibles
  cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
  cpufreq: apple-soc: Use 32-bit read for status register
  cpufreq: apple-soc: Increase cluster switch timeout to 400us
  cpufreq: apple-soc: Set fallback transition latency to
    APPLE_DVFS_TRANSITION_TIMEOUT
  cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support

 .../cpufreq/apple,cluster-cpufreq.yaml        | 10 +++-
 drivers/cpufreq/apple-soc-cpufreq.c           | 56 +++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.1


