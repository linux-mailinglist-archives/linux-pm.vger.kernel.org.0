Return-Path: <linux-pm+bounces-24430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55993A6CE31
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 08:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0C9170BFF
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8005200BA1;
	Sun, 23 Mar 2025 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVKqnD4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A827AD24;
	Sun, 23 Mar 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742714093; cv=none; b=Rp6jFlQGiC439udYh5ADfZYsG1SjeC73Rxt7o7xhvBvkVH2MKv0BWALCRUMSRz9/7ja1/6Z2o5FcKrR+Aldy+F0IsPLkoNSodT9hFpunPnKwLIjzKg/H6IuGw8IQug4TlkbOYbJjbzEaWEAg2HR8IXm4IGv7qmWwVVaaQ6eslQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742714093; c=relaxed/simple;
	bh=GJHelorMo/7+pcp0cFYxOAb4+HlzolzvwhZk6Y9/JeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s27GiMtFKri/kk8W97/s1zm99SewsD3PmpTpizaryGnmYjyA+A85hqr504PwtInl05TJ5zgv0BMojFf5gWTPVqpeDf+QPTUOLaYHDFTtoZiggAAlmUOuHqA5QYp10s6eMwFgX84HNBv1qTUqXPQakxZF6VVTvT1NXtRFu7sXvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVKqnD4t; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so6471075a12.1;
        Sun, 23 Mar 2025 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742714090; x=1743318890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtNt80DAB335/uRKq5f5fTTE5QKZJIZOvKQIq5dr29k=;
        b=DVKqnD4trgy56lWh77pMDYPY2wPCRqHeeyLtfcsHoWhhqRU0SJo/lPpry9z4zL0deX
         k95hPsBtwjf/N/9bP6Z4X/vot9bL1KxBV+inkz5oGIA4Ji5pqTefzEFk4ZbHc8WGTcA6
         9BU5NDfV011wesTDZ7h8VHP4ssl1wk0Hu/7CbBhGqmCXecYgZXnFIBE8w4f4QSPnTLy8
         sb7Ci/ZmG6F+f4IkKjOUCHycuPS0CzIiseDE2SKc82wquo9yPUm6bkyQ7qkQ/5jKL1eP
         ZhQlgfuslXQbw6k8Vi7+YX9XIHiCcVWSNhXgwoRtMGwummoQgwmcKf+kCv7X2E5DMZG8
         uEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742714090; x=1743318890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtNt80DAB335/uRKq5f5fTTE5QKZJIZOvKQIq5dr29k=;
        b=AhsB3vLzP2jTuk/mXN5kIX4QLfogQOtqT8p3ezhW/W5DAmCLwQ7OdIzb4T9ZI43wJF
         iIFtrrOI6uP7qYSltDxaT2DkyfhpDwFyOa8hCBlUEblBbuddqWiqxP2+bHgZGxO0d+Tj
         VkfOHcSEBySpXSPGPnZo6eZ6NNGb0iJER8HxtPY86YtnxVi55bD6fGZwXUCKaKX9Z7h6
         vB+3lL8MmIb9iWvwt0e1CBhwrfXFL7A2zXOqOSF48nyHxGg3PRIywED7fEeBHri5Ocxw
         HE1RL0B995OEvl/q77nrhQj7WnG0q2/3HRxSmt5QbEi3ed5Sf3a2cESk0F6WPGZ9hpmq
         EBuA==
X-Forwarded-Encrypted: i=1; AJvYcCURIYxy5C1UaEFSGyB+JQnr3SNHbmMg+N5IhusF9DjiF2gYelrqPJGt0hdASLu2LqyHZcu3e+cH95RvBLw=@vger.kernel.org, AJvYcCV+19Nnx007XT1TrNSNdQDBipAsp25aj4k+CevpGWW/pKT+NkY+Gghw5d6AC+ESB2HlRtaigUhw9FwLtLE=@vger.kernel.org, AJvYcCWL46Z8lB2n24uzYPsH9Giimenm4xiZ7eYukV57Nw3OfBPTDPnwM2KtN3rTbzD7n1MQfbIna7kleC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9ZUaH2nFpHU8aRMVJ4fBHcCzfAjGSTVgfuxX8g74G6kVxU4q
	mxbtravAFtgdw9Xl4uwspSQmJHFbB1bEnMGRSbA0HicRUzIvmQiH
X-Gm-Gg: ASbGncv5IEZ931tacW3NSS9K0tCYqhIegH5weAC+XKGLxcgWAhFJgmfeSo/heQ/MTY5
	F7aHyI5oFexut6x/S6Gc48fkyem7M1if5QX21++DgcIf+5FnqE+3XdAWtcZdG6Ut6oAc25hlriN
	vCSfmN6i9oI8DTLWDQnpS21RYxH9EIo55KywObrBFoIZ+gv2bjbMoR7ZCmZPa+fyKnUaubwXQ6I
	9DeiTyaUxxSTpV3yauZHpR70foeoRHbH1XldfsRIl/GXE0JGlDTGMI5Gp9fEYmEY6OFKWbL0PVM
	NApIbMwvMv8/l+DbU1kzudLOGXW1dDfSmMNs
X-Google-Smtp-Source: AGHT+IEfM2FhgguV6hU5oZP0B6rU5mJe4cX3B7K6QzAse5rXY7gvhfVbQuMkX6QRZ3r/6inKt6vEwQ==
X-Received: by 2002:a05:6402:42c5:b0:5eb:ca95:4a91 with SMTP id 4fb4d7f45d1cf-5ebcd51e684mr7106227a12.31.1742714089885;
        Sun, 23 Mar 2025 00:14:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfaecfbsm4218283a12.41.2025.03.23.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:14:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/4] power: supply: add support for Pegatron Chagall battery
Date: Sun, 23 Mar 2025 09:14:20 +0200
Message-ID: <20250323071424.48779-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pegatron Chagall is an Android tablet utilizing a customized Cypress
CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
single-cell battery and features a dual-color charging LED.

Svyatoslav Ryhel (4):
  dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
  dt-bindings: mfd: Document Infineon/Cypress CG7153AM MCU
  power/supply: Add driver for Pegatron Chagall battery
  ARM: tegra: chagall: Add embedded controller node

 .../bindings/mfd/cypress,cg7153am.yaml        |  55 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../dts/nvidia/tegra30-pegatron-chagall.dts   |  16 +
 drivers/power/supply/Kconfig                  |  12 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/chagall-battery.c        | 308 ++++++++++++++++++
 6 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/cypress,cg7153am.yaml
 create mode 100644 drivers/power/supply/chagall-battery.c

-- 
2.43.0


