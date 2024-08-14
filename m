Return-Path: <linux-pm+bounces-12190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E734B9513FF
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 07:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CDAB24C86
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 05:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0B47F4A;
	Wed, 14 Aug 2024 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TVQ6pF8w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69120B0F
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614283; cv=none; b=Yza/izIabkzrzYpOFn0d2tMa+25upp1D3WnjVWaLgwCUNc1imvKd/DbGDg1KL9CGLYuCcJIOytzEhlz8+JiK2fPYQ4OLFZR2KAxwMvUfCw8oFD38YuL7CrUzD/hcGHjcNLc/9BcB5u4XioHoc2x3aK25MStX0nqqI56dF4mB5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614283; c=relaxed/simple;
	bh=i2+GQ51N56bMZrhkaA13V9HEXxbHxaVwbyOXV0N5Htg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eDNqM94ojXmdrrEnZSGRJPcQbmmV8AXBAz/MVjXcQVNPi8JlQwPPrHOX3AglrSgtRsGJb4AfLa5J0bFBzCmrgGIEK+I/biLYxiXqHkTAizcqmR3xIzqwHHex1cHT6RwvI2Xl9SZ0n8hykl2l6g7nGNxsBnJqt7l/iWaNE6knzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TVQ6pF8w; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so3865758a12.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 22:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723614281; x=1724219081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOO7x8iSBvV0De6dCZQ1mV4ufVqP7fre5DuTvGToFgw=;
        b=TVQ6pF8wWcL9cN/+H9m2ivdpWWNEwWqzvnS8mmCmw4CFsTYbXn5T9x3na23GBMRrqY
         dyDZaD9ld6CVgdh1N8F4r5/gGU9ZqbBh74a7eGMnm33eifk4nA+F5HbXfBwI/GpcMBBo
         Ds0RXsiZ/N9yYF3jVDvzQFZ0qbhat6WzgTL+IwVucJEheXMxA0LAPXfes600wB4sWl5r
         4+0kut25mMjM9tDYcq4flC9tgUX11mbESLfk5KuDbwRfUGb0jMO9QKHWD9wruZ59bjYy
         5YAbSSdgWIs09CNsfuVWBXRjgzWotv1uGp8D24pWe3sFekTwHWdYV/mzSHi/bJE/Q01Z
         7Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723614281; x=1724219081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOO7x8iSBvV0De6dCZQ1mV4ufVqP7fre5DuTvGToFgw=;
        b=mvtl7giLw8SZkUytM6CPVd/tjp0h07OSF7RNS3N7FOuXOLt8QHX+wQEBCLFEbXrqv3
         cfbr11oXWg7/9TJkRV5kKSs5S5Pjl8K5MOvGUjiwgHDeWLs2x9zTCps9RH6JHinKz0/7
         2ShY7L7CJPg8WnKu4H+ErWxMXazNumvjocNX9YjcCV6VRD+NH8eeUAYzc+oS7Gg5L/HO
         kLlsWX0ZLPox5Tkar1O/gSg7VywTfmN0yfBp8qNLHyy5NQlb99dWz1J+votXF5d8PJKa
         2huvLCvBuJkV6AOcht2xQQ1omxdiJPrhhks7rSNTma783LpUGOia5nWIugFU0k5QLrRr
         wT8g==
X-Forwarded-Encrypted: i=1; AJvYcCVOmCMUp29qJShKUrCGpZ2AB80xm7MhQxJmAwIjMX2HnA4khnTn3Hh/AOiKa/JtzqmrYdx4NPMRAVbxDfZX3O6/9TQ1fVN30Qc=
X-Gm-Message-State: AOJu0Yxsy2qZkHgOmfd606kx5B1I0TQJCBYQGinrQJl2vPvBjTjOlf5q
	now/kRJ4btktoVGENFTiaA2dk5soF58ykpXlhieuF1ZiTyJVUudYMwpBzZ3Rs5ZqyM0GNd+8lFa
	kraQ=
X-Google-Smtp-Source: AGHT+IGuQTz6SVKJdGR7qOzZH2eW0RKBxe5F6pnliwORwQw6IjLS/PZfnZvv68tOCBbgMC5KQYJ5VQ==
X-Received: by 2002:a05:6a20:d49b:b0:1c6:b364:dbd1 with SMTP id adf61e73a8af0-1c8eae6f450mr2704301637.19.1723614281087;
        Tue, 13 Aug 2024 22:44:41 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ab486sm22062085ad.150.2024.08.13.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:44:40 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 0/2] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
Date: Wed, 14 Aug 2024 13:44:32 +0800
Message-Id: <20240814054434.3563453-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add this patchset so the devices that inside the cpu/cluster power domain
can use the cpuidle pd to register the genpd notifier to handle the PM
when cpu/cluster is going to enter a deeper sleep state.

Nick Hu (2):
  cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
  cpuidle: riscv-sbi: Add cpuidle_disabled() check

 drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1


