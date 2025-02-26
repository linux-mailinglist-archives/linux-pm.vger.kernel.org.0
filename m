Return-Path: <linux-pm+bounces-22981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02731A45A33
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20DF1894D99
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91A226CF5;
	Wed, 26 Feb 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVEfyBnp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4E4642D;
	Wed, 26 Feb 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562654; cv=none; b=Mm4SOnnnSL7iDNUF+29XEYlhkJPIm8kh47ynihqjk1w6ON2au9Y9l2ag3iAjyy2sqPtSMhdRH3/yCJgE2znTiKOKr3f/6373OgigUeXieLy3mEMg1KrKzKqIGLrYfWuhjDa4Xc6XsJQeHj0LpZWjOVzGmUUETvKaw1C24dhv33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562654; c=relaxed/simple;
	bh=gAtIOwcxbGm3kjGYeFyHNFrjba8SmOe9u8zObgcy2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNVrUh+nfNsxfT7lZMXaVdoHmGIi+Jwv9LGaGEn7bT6U9qK/fboDn/3zIuGkhZl7GUVGQ9VFcGlrj63OZSld3QiIdsm2M87DhQ2oAzTmyEssKCfylAxlVVWfZoK7wTgq37tF9dSlX9SEtK11P2b/4iS1bLXXRonWbm6AKbmRAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVEfyBnp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so466814266b.3;
        Wed, 26 Feb 2025 01:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740562651; x=1741167451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBhVYZu9itc60CBj6OWrVAsjS7UbgDHQocf93VScn7Y=;
        b=PVEfyBnpPJUfX/kmBwoiOi3k9CdIPoSmRrcftoPb9UPbqztVeygRt79rdttW1L+jmz
         6h0KLFKyvz21y3kYnpTLFsmLXWrjOePwOf3s3noW9R8w1clZrWq52R3Ij9kMLEwB0HSw
         d6EW8mAKMah4QiXW5MGs3ytrSdZjJMFVkoAmmkz8j9SaOsaQHmFl7VHvRtoPLlAaLgbI
         mwoUjlTEg6F/fvaU7+/RNVjQEOnWCLdHJBE7VSTypAcD/06lBwuIwVueUGD9ncjxqp7U
         n2zbKB01kw9SJQlALUkUYXnmjGvDNuDnMuBFqqMWXkxx3hkCtaaCUAlpjAu4sDP1ZCwr
         coaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562651; x=1741167451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBhVYZu9itc60CBj6OWrVAsjS7UbgDHQocf93VScn7Y=;
        b=A3HNF4ZeptoMl5R3WaiSdqhU0fnIdgXvvgV/txUEBekBhZRuUy/5KFvpSYrYeET6ag
         5/L7Cqzo5tjf3it1Uv9H1kn2q20nw2wYHVDr198iSCRNo1W2ubWjaX1rBWOxuT3syxGn
         tbmRWXpiLpcJ/hDnImMAi6SCH9gO75IJqDXMtwyKnvTrXafk2fyF4lAO9znQelAZTesg
         PDlD+IR1BeLdE2jLtA83yirtnZNTt7yoh1qzDxfVxCsgQA8owHcKov5YJ2IeUq3csn8f
         Orj80JHuRbS1KEw96HKzzB6LG3KWqVsZPXF1ceGlWgYxSQwKGKh9eylqGlsm9Ra7/G+1
         eWrg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3CsgSQ8j0J54Z3Vwh0w27kpBv/l/NTeq6QJhzfKcTb9+GiXJxyFPPKn7B1nEmsOuKXmeoxi+L6VnXktG@vger.kernel.org, AJvYcCXvI7TILCR0ioWJGddQWkuw+TVYT6NQsmn6XPpuoLV6be+JWd9He0iubGNAEUPDiUV3jxOLYRYaNl9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tsg0AEDNbmThAV5h/l8KdmpznH72aXpAiEIDQa/JSZ6Q3wp4
	oLvqOCaj+7e/zkbQPfISKMDEnR7MhNv6B17A5tguKxEaBsHpj95K
X-Gm-Gg: ASbGncvE1kxKeVST/puWeIHKLMhpjilZ8RIG5EAINZVCCDLuAusH1roZsjuzH7Q7G/4
	AIc1MP3Gc1yv60onyOJmQk8IakG9pyzund5QLId/bZRRUO4ZVLca3jjmpqJXdPjd/ojq3w3KHv6
	aSP22i9I5SKFtNl9Ef9/55BQDJQlFmTvQMf0zA0CsLs808D8GGkfLvJKu/qUn0u/SadF42e7MNF
	wi93HvRQkOBha0BbnIgjU3p2Sr0ZhbOzSq38kIY4lCZ+3XAzawj6q1BBWc/BSqoAYHkPlEzj5J+
	E9rmkRhOmNVQ0Ynayg==
X-Google-Smtp-Source: AGHT+IEbpFoj1Ub/U9ys9TR1pBhWItL2cAqOoNMzwN+zXpiuVGuMbif4xM52TG25DnnvQcfFYTqCmA==
X-Received: by 2002:a17:907:1c17:b0:ab6:dbd2:df78 with SMTP id a640c23a62f3a-abeeef44c16mr266047466b.35.1740562650566;
        Wed, 26 Feb 2025 01:37:30 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdc669sm294366266b.26.2025.02.26.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:37:30 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Wed, 26 Feb 2025 11:36:58 +0200
Message-ID: <20250226093700.44726-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX8971 is a compact, high-frequency, high-efficiency
switch-mode charger for a one-cell lithium-ion (Li+) battery.

---
Changes on switching from v1 to v2:
- swap phandle with graph for extcon
- added power-supply ref
---

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: Document Maxim MAX8971 charger
  power: supply: Add support for Maxim MAX8971 charger

 .../bindings/power/supply/maxim,max8971.yaml  | 140 ++++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 690 ++++++++++++++++++
 4 files changed, 845 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.43.0


