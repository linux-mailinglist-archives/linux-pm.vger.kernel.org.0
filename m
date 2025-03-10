Return-Path: <linux-pm+bounces-23738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BBA58D89
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EBE188CE56
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EF22258B;
	Mon, 10 Mar 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBB+oqcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E01D54FA;
	Mon, 10 Mar 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593773; cv=none; b=Oyoe+5WOtTFggtokZRaqlyUxpWkvWhK9wbKHQTE9dLIpYxTJdtzcz7BrZelPfvOGzp2YeAQVT87MqKeDpJdBM90DwyWP0cAl84qChQAboGg1igPc6XIwrocFUGt6YJgbrWVqq3nDN5oLfT6IA/aIs36fVMSiLaM0xl9oL7Jg4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593773; c=relaxed/simple;
	bh=V/E/I+ZCa7+dAhhQaM5p0TDv/dIXj3U5GOSv/6EdOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lc1FpqOqOXySiBPRnpY4wrTBk0SuN/wi0Z/5B5q9JXUwxSC1kdfE5mQt2frqV9h4gpopXrXAA34JlV1VhUbFR3HkPePqmCp0D8vtlVoTQ4aOtqz3c7ABRRjtU1Lx1gwgcMBlc4TQeamnp8jv0Dpj/mTge+B7o/ES98Pb3I7cT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBB+oqcn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso3199712a12.2;
        Mon, 10 Mar 2025 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593770; x=1742198570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgVFyqXM4nOWMwuiHWgU0KRdJuxDIajetWrx1QfjiI0=;
        b=KBB+oqcnsgqi4GBvB+eIu7j144TIGATyqaqIBqFfugem4zpt3FfGj0Yic6KZKUsNBs
         e9WqhK87TL0DZtvQDhrdysaHUurkusw2KYI6tdhlOOkXeTPAtxARr3UReIKpOVluclkv
         qQFhVzEYUloO3xOsW4//kA2QAPvWjh6FtuT//6OebrdLpgjBzCjD3x+1evvv9SWbjeVi
         WPGHjEzCzILkzHpLIks3lMldTldkXopewz3AVtKB8kImIQ9ZKJ5Ihtreji8vdnEihCwj
         ZMxz+01Bi15JNIPhWqlfgJJTMSHTI8zwSd7ZdiBmzXltsU885vRmC9pQ/yCP9sHjOrO2
         iTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593770; x=1742198570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgVFyqXM4nOWMwuiHWgU0KRdJuxDIajetWrx1QfjiI0=;
        b=rTaJt9XZloDG2cvSvlXbKc6MQAFAqyLHIohR6rHyU65jnLqDogeyhV8PibKrADQzHc
         2TCoQnLMDTVR9e/iLtMwHG/arT5eESJDERqcY/5z5FQYkYEzwaV2ccvZCxvagoS7lsCZ
         kr3DgaW8HAXX/Uy5TiDr7eo6wfVxOpKnsrmkoURLTSW6CL0OQbFNjZ+6tzBQQcZqJSj/
         GjBLN218JBvE3kIfiy/3WOcR8OJs4QsfvHBwBqwV02NpTw1/FkbWr/obfxZ9X+RGHt1M
         XiNPkL5Wy1ZMI5iCSjDujNdsIFpVfBySTxBpPlz89domrJ21CqnvZ20ZVCXyxRTjwq6R
         3W8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGpbAvG3IC/HeVSMvv9GTosrUUJBSpsyT4apU+pwfe93YmA3S9dBKZMgxDJxuJ4tlHeNkJsA9sj/cA@vger.kernel.org, AJvYcCW4Wb5AWw+6zdjgrrTzphUNe8qIQ3galnuGhrVNOClgweO8YynQJAWX8cxKc4m95mEEBSxFcH9lZ/YC7xt1@vger.kernel.org
X-Gm-Message-State: AOJu0YyceTi1mQyAYlF9mZowG1ExX3svbpifr6YcsnnY0n5qkMb9y1Hv
	OkwIV6dgMdKs00k1rfwHGAGA/T67mC/tqYUmNyiGYfMZnPkAcLsK
X-Gm-Gg: ASbGncuzJkuaDBiOshb81LDYGteCAcDCrL1tJby11vfzOwiquvIm0KugSOUz25Trf5s
	u2Acb/Nbg4bGPbD3kZypNVLfHR9cm49ecWtyLT46XeCZPJSxEuMSW6hDEd7uAW/6Wbrx+90OAAX
	i1dMHtKfIBpZEKdJkUSeVgJE4Xqb0zVyOxaKS/PzgoPjqyeAP0LGkrsNu8rmD68gLkAUG+XfoRw
	Wd0ytJZbq/De9ypGPiVejvc7N5eJruprj5PaMoykwBvoWF2mjEEteC4Dsr0XdietOlcmoQzubWQ
	DpAzdM3Ov5PCYbA/eVrWqwTkvjBcrS06uBBp
X-Google-Smtp-Source: AGHT+IFgWFwRxU0RJY9U9nj/0/pZSW8uQ6G5UdSR38nyNKlYISxmaAmvwrB9mjJlbuK+kOlUPbo1fA==
X-Received: by 2002:a17:907:97d5:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac252ba28efmr1704357966b.37.1741593770037;
        Mon, 10 Mar 2025 01:02:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac28aec7ba1sm263917766b.37.2025.03.10.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:02:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Mon, 10 Mar 2025 10:02:35 +0200
Message-ID: <20250310080237.7400-1-clamor95@gmail.com>
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
Changes on switching from v3 to v4:
- swap graph with connector phandle

Changes on switching from v2 to v3:
- fast_charge_timer, top_off_threshold_current and top_off_timer converted to
  device attributes. Other vendor properties removed.
- removed max8971_config
- removed unneded functions and definitions along vendor props removal
- added __maybe_unused for resume function

Changes on switching from v1 to v2:
- swap phandle with graph for extcon
- added power-supply ref
---

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: Document Maxim MAX8971 charger
  power: supply: Add support for Maxim MAX8971 charger

 .../bindings/power/supply/maxim,max8971.yaml  |  64 ++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 759 ++++++++++++++++++
 4 files changed, 838 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.43.0


