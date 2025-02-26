Return-Path: <linux-pm+bounces-23011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2414DA46717
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC77916688A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB522258E;
	Wed, 26 Feb 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA33+QYv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E82206A4
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588281; cv=none; b=lLgTEzRpknBH/tAVp8ZAVRoi0zcwWxZPf8p3VL8gIXrVrtdFnm4bwZwcG8WdgLG8/wSOLbShIQj/6M61v7s9h4L6APfAfVtLrndz7hV71Pz2fn60ef1P9m2c/xMKDyB827h3XiSOkltyLdJFsBIQjHbFeQRY/DI3Y9qiGFhyO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588281; c=relaxed/simple;
	bh=EAZCxfsdAbOo+Fr4fqypNUN33rmB2Bh/8eVrz3m4U6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JDjY07Gr+FVJ9Y1TOZQLiZp3HxaxUPA507x40fm2YxcWAGPUbXNZ5O9593oy+ahUzqp+N37tm6STuhQRkJjiEoOPZKAMOiMk+yx38Kb+wAWr6CNUwRSxLNvqWu5FVb5gCaHCXD93r848Koh37wuF19FkoOCfYvakSBPIiDU9fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA33+QYv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso1233332566b.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740588277; x=1741193077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKCRcTLMZnIrHbEKuD43z5qHVVfLC3XXEk/6jO6k5Hw=;
        b=rA33+QYvoAoUG5FyuBT+AyU3gCaSEIrIQ8s56jqZnyp8OZbqm2xaIovbvJp60B1fgW
         tXfpnKgMDis7d8Jo3gxiUqtKQRsEVL5+zCyz4su3F+8WjSFnxhjEiupk2toADwt4IaF/
         rh1T78RP3RWNQUlP5UPVXiFPFqHvZ1BgEfx9K4/7rCqJugl9mzXKJRzAK54GUQZiVR6m
         Fnzf1Z1WpTJfwi1gad7gEIkpYMQ9rfiL3u5K3E989XlaTfqZEcZq6sTvLqzjeYpgrmRa
         Rskz7jkp14MDujwuVYO5HgFcYyTrzFSqPHyxl3PYqoV6H8EWnFXfTlBm3KtucV4Gnmy2
         LdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588277; x=1741193077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKCRcTLMZnIrHbEKuD43z5qHVVfLC3XXEk/6jO6k5Hw=;
        b=oMYBwgGM+cfrSYgU7yGRdJb+OxBWh1WVy7o1HEpJyDSsOHmyS84AN2JKHy4DI8KmRd
         tTcxo9nrc/+2DUXmsm05plPTYipFLAGwN7PyxzXHS+Yi4j93qj9AVRQn+Zs19guJW8lA
         4inlTsLoz9yiEVFZjbFNTRy2rz7lTHnMyUSxjlO9djXWRrdULjXqzhD9P+vA2iwvJNWx
         5wDtHqZ7caks7/NW424ySCwDbvVZ0y8aiXxzLhnxjXcuk7j2VUDq/G1PCjITXWHW6pdn
         1DYyiAvZ7VuNqTWZfQ40COIiDwHFX3myqf7irRGE/KVtWz7p51kPShV6/FtgaEPBUbpk
         rWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMmPP9q3KvwQIaiPkSFLqjIwW1E/ONB4IxL81CsgRNukRg6elDGtdKli9AYV9U25p2Plf89ib31Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoUkN5tGoT1LTqpR58sTgdXWA/X5AWmFdVQlK0lM8tTS6IYEC
	5UzGNMy7AxlYCirh1qzrUowyCqqgaikLxmj+9YkFVBlLqh27XSMomTCm1nMAjyQ8kqs/0yFlq4G
	TxUw=
X-Gm-Gg: ASbGnctCOh0+lrYZ0FAkpHYrocLzQSWxg8IfKgT6B4UhwQM8CQYNttk3RCHcWT7IOqT
	jwpFz784is5pEP1cAiIWCw5XQndLMyqcME0+LNmryatv5vjwLT6XkT7ZToP9KqcIyZYqxGdcc6o
	tAnymhVf3g1xxpYKcdpX/aaAikPrOLizK/cDKr3xGRik5XxZV2eBKGBsZmssLrlvwMFShvSd62N
	//my6xenjAVkgpx8ehhhOqiobx4azBoZ3ahQJBRrEMJkaz6+sMW9nKDGBNSceB23S4vg+VswjXx
	QCAFDYIvn3MldJMSE36B4tSCxaRJFs1S5fUngF5VDR0Y9bIeFiLeJlqHQoUbdMOm+mSEIR/Uihl
	HMxzF4tSDUg==
X-Google-Smtp-Source: AGHT+IFNAtJHyDKSHEKDSUw9B2zaIiFn3sdbmyXKXU0qKvllh5gJYoJgG6lFeV+RuUdWCGeQdROOSQ==
X-Received: by 2002:a17:906:32cb:b0:abf:2bb:13e5 with SMTP id a640c23a62f3a-abf02bb14cdmr109491666b.50.1740588277524;
        Wed, 26 Feb 2025 08:44:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm3058459a12.68.2025.02.26.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:44:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/2] support Linux reboot modes in syscon-reboot
Date: Wed, 26 Feb 2025 16:44:25 +0000
Message-Id: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOlEv2cC/42NQQ6CQAxFr0K6toaZyIiuvIdhMUCFJjo1LSESw
 t0dOYGrn/eT//4KRspkcC1WUJrZWFIGfyigG2MaCLnPDL70Vel9QFusk4RKrciUw2jCl/SEVQh
 VXbf16UwO8vyt9ODPrr43mUe2SXTZn2b3a/+Qzg5LvLjOtcG7ECLdnpyiylF0gGbbti+/QFR2w
 QAAAA==
X-Change-ID: 20250226-syscon-reboot-reset-mode-566588b847e1
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series teaches syscon-reboot some of Linux' different reboot
modes.

Linux supports a couple different reboot modes, but syscon-reboot
doesn't distinguish between them and issues the same syscon register
write irrespective of the reboot mode requested by the kernel.

This is a problem when platforms want to do a cold reboot most of the
time, which could e.g. wipe RAM etc, but also want to support rebooting
while keeping RAM contents in certain cases.

One example of such a platform is Google Pixel.

DTs can now specify the existing properties prefixed with one of the
Linux reboot modes. All the changes to support this are optional and
opt-in, platforms that don't, or don't specify a register/value/mask
pair for a specific mode will behave just as before.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- fix whitespace issues in binding
- Link to v1: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org

---
André Draszik (2):
      dt-bindings: reset: syscon-reboot: support reset modes
      power: reset: syscon-reboot: support different reset modes

 .../bindings/power/reset/syscon-reboot.yaml        | 74 ++++++++++++++++++
 drivers/power/reset/syscon-reboot.c                | 88 +++++++++++++++++++---
 2 files changed, 151 insertions(+), 11 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250226-syscon-reboot-reset-mode-566588b847e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


