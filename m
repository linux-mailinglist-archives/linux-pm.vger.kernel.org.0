Return-Path: <linux-pm+bounces-24693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA0A77882
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 12:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B1B3AAC4C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A581F0996;
	Tue,  1 Apr 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zShq3P4y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C251F03C8
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502273; cv=none; b=A9BkzlajR2UGJ7Y/0EMbOqjkr/GM+nLSdltSe5dI43KovxhOEg4O2wjCZ5X8dRRfOyiwCan64388wPpQOhpBn2xDPpwwfQDOfVbMxLyTOA908MFjh7YfU0WuPSmHriomQTEk2mQZGqXZc+mkDiU+SGhP1/dqztgVoNGjmtJNYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502273; c=relaxed/simple;
	bh=najhAWRGQ57Y7UB5J/ILd72qZWp6BmS+tkxT/OOIcAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=riS72C1O0KtlqNX2oIl+h6y9ctbtTo4NnAP0d2rZRJpPg1OFevk552o/Drl9Ngu4GLfusJYJXv5nYCA2IfQQQYsCyh1wE8FW+8ArNjJnvLi3OkzChhSAoR+FQWC0cyPiGzFyu6DfpiixtoiyqQ1AmKvwuJMVcBMufblnUZmd4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zShq3P4y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso806265266b.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743502269; x=1744107069; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rHGgSQdD2hCEm7pwASM4ZVE3/ZfNMjeU9kHI9pQmKw0=;
        b=zShq3P4y+AjPfdx82voQvT5m5+uOABbc5bpz8pxOvFlT6rIHzEBm/TB+1oz0bBgFlM
         evRYymS4kStzUnifA38M1LZsRqA1pjiPUhLg8oOoJF6Qn6xpcPa/dO7w/AMGStmghwCe
         3H1ddwQ5tVbeh67nroaYLg5+FmJsURJK6kB7TOEzwQOgMoL+SFzN1qVUP7GeTNP/GMpq
         HrgYbQwtEjYSq/YklheHCgAAyyHx/FUo8mq3R6zCpbuEpiIhvq+w6eDd4PlSXyOIfm5U
         HLRvT7drTDHk+ESXNOWsryb+WhBszaZPl6iyQKgc8OTits/ZDyTasQXD1MtJ3+ZwJto8
         GpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502269; x=1744107069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHGgSQdD2hCEm7pwASM4ZVE3/ZfNMjeU9kHI9pQmKw0=;
        b=K+QrrskXp8Vsg3yqgT+QKJgYm4APqSWFlNF6p7OEMWysH8XemJ+c5S9viZBqvgQiDm
         cMULZGNp37ymBrRmijj0sNXTskkTwUBJ5urHOs8gljwd/4D2qJ2rlcNvyN1N4GC+w2KM
         +2RomwOKC3HeEfdUNP+sKmZVQEXWhYYEC9cbwP/7BEFD7+JLIJM8oi1K3rDNwstZgJZH
         UVzekLEANIZT0uICj80NHA6QVnN/9XvEQWKrpXX2hNPaJe0Vs0lPCiWjJCpKuOo3yNbs
         Lh+VnGrgS+Zh6jJduNx0cCUkUceK1nRuXhdeIziAiTbHnXCt4Ea9sE4ekDYsFJIvxCjQ
         eWwg==
X-Forwarded-Encrypted: i=1; AJvYcCU4cymAny0J5usWeOBNUos1hKbGyYl/TOyLo4ZZKjbfIgOiWp0eNTya6TtaFlNz6DfaX2F8ThyWHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza28w1e+7oeoAaaRu8KQeElgyi3PiX7zbizAEWCY2Lh0gXLgcW
	833dXbCNrfao2Z4rIbK7Y1lpDyFlaeYP4+QG+x5ipwbpb1hL2nPQXcBSM90o6K8=
X-Gm-Gg: ASbGncsIMKzO1h0neRcUgsOekEN8PT3wtbi9tb2sZTd9QrYytEmKTOLYIyeDAxWdhPp
	fcEu+MiLichmqykrefkjHAhIrfq8PQ7eagi6oznWqreHK1dIwmh2vtxbjCjyTQ2tmrAZtjF/RSi
	q6zIhXis+9Xr/ZSzL7MF2dHUpUHKuZO8jCCmiKd8KtWm/TmTrNGcZOaFLOq4HIhuPmTHAELccAO
	igjt2DAQwvD/Y+arS+ocVqV1rrEMiiAKCrKYeYp38RX2eXNQhkPPu1p5CYE4/3vHZCZxIvh0327
	aRMISXtTQXyyvkwXUMHHxZlEy0WL0tDOXsGs1EjLAlC5bO6j2sxXv/03cGUR7mWHg09VmqRsxNK
	w60zOgGysFbM5qiN24EujF4Z/bi6P
X-Google-Smtp-Source: AGHT+IHT9jkz+UCs3Db5OyfIYrlRo4mz+SAmgujhurHxk3CEiZo8YgaUE+HWHRECisppy8g9djLtgA==
X-Received: by 2002:a17:906:f85b:b0:ac7:3912:5ea5 with SMTP id a640c23a62f3a-ac739125f39mr976557566b.58.1743502269438;
        Tue, 01 Apr 2025 03:11:09 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967ffcdsm757406966b.140.2025.04.01.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:11:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v5 0/2] support Linux reboot modes in syscon-reboot on
 gs101 (Google Pixel)
Date: Tue, 01 Apr 2025 11:11:01 +0100
Message-Id: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALW762cC/43PSwqDMBAG4KtI1k3JwzzsqvcoXSRx1EBrSiLSU
 rx7o5u2COJq+Afmm5k3ShA9JHQq3ijC6JMPfQ7iUCDXmb4F7OucESNMEMYkTq/kQo8j2BCGXBI
 M+B5qwEJKobXVpQKK8vgjQuOfC3255tz5NIT4WjaNdO7uQEeKCa6oo1YyKqWB8833JoZjiC2a1
 ZHtlViWGk20llwRa9VK4r+S2pD4fJOojBPcca7NSiq/Emd6QyqzpJQ1QinCjfv/bpqmDxxViaS
 fAQAA
X-Change-ID: 20250226-syscon-reboot-reset-mode-566588b847e1
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This series updates syscon-reboot to support warm/soft and cold/hard
reboot on gs101-based boards (Google Pixel 6 and Pixel 6 Pro).

Linux supports a couple different reboot modes, but syscon-reboot
doesn't distinguish between them and issues the same syscon register
write irrespective of the reboot mode requested by the kernel.

This is a problem when platforms want to do a cold reboot most of the
time, which could e.g. wipe RAM etc, but also want to support rebooting
while keeping RAM contents in certain cases.

On gs101, this can be implemented using different syscon register
writes.

As Rob pointed out in [1], register access shouldn't be encoded into
DT, though. At the same time, at least on gs101, the difference is just
different register values in different registers. Therefore these
patches:

    * add a new compatible for gs101 reset. In [2], Krzysztof suggested
      to simply add that to the existing generic binding
    * update the generic syscon reset driver to support this new
      compatible 'google,gs101-reboot'. In this case, and as suggested
      in [1], the syscon writes are then deducted from the compatible,
      rather than parsing them from DT.

The existing generic syscon-reboot driver seems like a suitable place
to add support for that, given all of this is straight forward and
simple and similar to the existing code. If the preference is to have a
separate driver copying much of the existing generic syscon-reboot
driver code instead, please let me know.

Link: https://lore.kernel.org/all/20250227132644.GA1924628-robh@kernel.org/ [1]

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v5:
- Krzysztof:
  - drop gs101-specific schema and add the new compatible to the
    generic syscon-reboot schema, with all appropriate follow-up
    changes to it
  - reuse existing syscon-reboot node for gs101 in exynos-pmu schema,
    don't introduce a new one
- Link to v4: https://lore.kernel.org/r/20250328-syscon-reboot-reset-mode-v4-0-77ba57703ace@linaro.org

Changes in v4:
- Rob:
  - don't add more properties to existing 'syscon-reboot' compatible /
    binding
  - add specific binding for 'google,gs101-reboot' compatible and
    related driver changes
- Link to v3: https://lore.kernel.org/r/20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org

Changes in v3:
- support <reset-mode>-reg in driver, not just in binding, doh...
- correctly parse <reset-mode>-offset
- add a comment for all the BUILD_BUG_ON() checks
- Link to v2: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org

Changes in v2:
- fix whitespace issues in binding
- Link to v1: https://lore.kernel.org/r/20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org

---
André Draszik (2):
      dt-bindings: reset: syscon-reboot: add google,gs101-reboot
      power: reset: syscon-reboot: add gs101-specific reset

 .../bindings/power/reset/syscon-reboot.yaml        | 42 +++++++---
 drivers/power/reset/syscon-reboot.c                | 98 +++++++++++++++++-----
 2 files changed, 107 insertions(+), 33 deletions(-)
---
base-commit: db8da9da41bced445077925f8a886c776a47440c
change-id: 20250226-syscon-reboot-reset-mode-566588b847e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


