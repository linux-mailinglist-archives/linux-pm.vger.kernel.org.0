Return-Path: <linux-pm+bounces-17938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B305C9D58A9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 04:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F498283469
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 03:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466615B13C;
	Fri, 22 Nov 2024 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkqUIAZ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F72AE84
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247257; cv=none; b=BTf2oabrFscMuMMSPyYDiNI6THiFGrteD2B9XHegemeol6V7t6f8/yeqOv5VEREXW9QbuGveY6ZM1mhL/DbcmLktEGY+6O8m4UWUR2PWlJ42htvV4ptAkVpDSMhn6umt5A2+Xd/H4o2SjJXK8K2n4OrftDWpN5Dbr5SE1Y4q5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247257; c=relaxed/simple;
	bh=9PRuTzDBqQfJQDriZ1LwQnsJ3pxswr44u/jT5UYum2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JTEincno5dtjjNsy4ytZWSig2y6msSdE2Tm3Isdm+rBeaKuNuro0czRJ0pBadKRCG+ZeFqVlA3nGPl6teNrr+fClN0f3MABJctmnPXI3tDxLzUzy2bhcC0Y2LcHEaSb9GXscaAlKacRTwHEmvgA/9mlb+X7P0Lpu5NibLB3uQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JkqUIAZ7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-212884028a3so9599505ad.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 19:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732247254; x=1732852054; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUPLabeEhsTuPB6N8IV/JgXFnjKZTiSfXFCFhiuDbdQ=;
        b=JkqUIAZ7L2x6EVLpE8J8O8BqfHDNQK5VFSdNk9e5vpnKp6yrxnOtZU7ETlm6uNLxeR
         rg0WuIGllftScg2R4wCXx7jQSR9iKhiRex7SqMbDW8OIboj+BkmijbJRReau4SAGekUG
         QgIccYj9OZvpRUymJZuHQN0R5T87ssatuwf4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732247254; x=1732852054;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUPLabeEhsTuPB6N8IV/JgXFnjKZTiSfXFCFhiuDbdQ=;
        b=jQ+3eUGQKDXeacsHrkDGzd385SijtQWQMYpZBo26jkmVu2thu1Fk8VLQmZZO7HKN1M
         8qybaoO+hyPcvYzh/vXVKWJRHQ18EjcmNBdN3l2TorUoXty+Lb2zC72drRIDW9OOfRH0
         RXabzGg5ZH2F08FAIAwUvwn05VNoLPXwE+Mw9EyXYUYfecIHpT03xcRVkkyAV4OdmCUw
         gZYSmXkp9DX4gV77k8GxCwVTDYxAJnSPKb4rSTf9vNeadsknvwj60voUSoNolPbieNHW
         eZi9TNhZJixLdWU7/OLtHeFjUfT7kBeJmYhDkOwkOy4z+Gcb6M0lE993dNxlrfNS/exL
         TSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUHMluWpFB9d5pEh50Waxi3WUhzMieyVYf/pE0lVQKDH/p9uJ9IsS5iSYxbKubmeX21iTrgv8WM0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfRz4uC/q8fZGfW8io6ZLBgXJndJ8aBgCb/Ml/OuxRiGxRJiD
	MqBSPpsNmRoIgcr4EPxATv6WVp9kQ8kUxtmUXrPZlfgI3vw0gylmlBH7InRxpA==
X-Gm-Gg: ASbGnctgCjrFFcm6ApJCLvsUntH/SRc170whRBbr1JG2/x9iwnvUUDX7FDovF0yFsDJ
	8VTmZqjaKgyKuXISShSCIBs+ZT1ONzGWMCefFqENvVB1E2V4IbsE8uYWXujv3614xiR1rInn1oK
	R3UB6L3UXSPdq64X9oSDtP47FW0vrXl2rbDJSOql/NRTKsC9zx9E6zHM4hLtTA41hCCR0JoSID1
	Ga9bylWwiIoSHfkdoneuSWmLH9cY705OC1xWGrIdS558ndDpQOP69o2DO8O4GRa6saXKYE=
X-Google-Smtp-Source: AGHT+IHiALVToYKglGv8HQ4w/4rsnqINW3YG6Y1GRh2tGW268TcBGb5mBkzYGC/fBrRZJ1hQiu3nXA==
X-Received: by 2002:a17:902:e845:b0:20c:e169:eb7b with SMTP id d9443c01a7336-21283c7d68cmr91453535ad.14.1732247254165;
        Thu, 21 Nov 2024 19:47:34 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:533e:26bf:b63:973a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de554b11sm550174b3a.133.2024.11.21.19.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 19:47:33 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Subject: [PATCH 0/2] Extend the cros_usbpd-charger to make it a passive
 thermal cooling device
Date: Fri, 22 Nov 2024 11:47:20 +0800
Message-Id: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMj+P2cC/x3MQQqAIBBA0avErBNyiKKuEhGmYw2UhUoJ0d2Tl
 m/x/wOBPFOAvnjA08WBD5chywL0qtxCgk02YIW1lIiCUiRnpvO4yU8b7xxFgxpNp9RsVQs5PD1
 ZTv90GN/3A9AOCHBkAAAA
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732247251; l=964;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=9PRuTzDBqQfJQDriZ1LwQnsJ3pxswr44u/jT5UYum2w=;
 b=Zc1RWAqzt3jVrYqd5ASn9V+gjaIAcZeOGISABX0Ac99Xxsn8I3BztCE6a22BtmSCbL3aekvws
 faN/RYixLo6Dxfe7unI1ySbUZo5kTdF4qousRqILdTYvWR2gEqJJnw3
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The cros_usbpd-charger already supports limiting input current, so we
can easily extend it as a passive thermal cooling device. By limiting
the current flow into the system, we can reduce the heat generated by
related chips, which results in reserving more thermal budget for the
system.

This series will only works on making it a OF style thermal cooling
device, so related code are guarded by #ifdef macros.

---
Sung-Chi Li (2):
      power: supply: cros_usbpd-charger: extend as a thermal of cooling device
      dt-bindings: mfd: cros-ec: add properties for thermal cooling cells

 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  3 +
 drivers/power/supply/cros_usbpd-charger.c          | 98 ++++++++++++++++++++--
 2 files changed, 96 insertions(+), 5 deletions(-)
---
base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
change-id: 20241122-extend_power_limit-62c2d9aabfa7

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


