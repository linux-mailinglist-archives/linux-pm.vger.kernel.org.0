Return-Path: <linux-pm+bounces-19098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B729EDFD0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75072829A3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0A204C27;
	Thu, 12 Dec 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK4wPw2D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFF1632D9;
	Thu, 12 Dec 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987081; cv=none; b=cfOQuPisugi+GOZEVR0AB5CtQ1zVzj6hQ8BES8+nLRpoE9Tle9fhdKKU08tqfapdkSONF9d9Th7zeYDz3nkuTg3Zw8SehSsvj73V0nBp184LqbQelcR5CWFRj8zk6UPiTfj5lNG3V3v31md3260j2Vk0HUNBP4zBUsbMlPRQbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987081; c=relaxed/simple;
	bh=2clUMBF+zfM0MT3b4JiMSxRP50eR+oc99K9vxRX3gc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKWRQ+jYNKWqumI1YfGglBw4xZgUtFC02WqwFLCsUGpgIs6C97Qiwt/sc78+JieVRuxEhzqrhIY14K7NrCD8feeA4FqBT0wT7tQeG7llAZCUt+0GPME+OeHcOs8ar18tpcnW7FUZaTdB+c17XnRXbgbe5ajswdbF+mvHxYfaw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK4wPw2D; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e81257bfso220132b3a.2;
        Wed, 11 Dec 2024 23:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987079; x=1734591879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIv08M5NuYFMrbLnuplDgqYvTP/RY0BpL7xzh6gruXQ=;
        b=gK4wPw2DFDiJQy4ZyQryEGZ/8tuvEf5a+/kCyTjjH5XmVYXOZXEThq2reW7JMdHRbs
         dSGlgnwaXOIPjJs8x/Mfjsn0iKVrpHpMnayuDBfjr/uBtMvFy2BnD/0wTEVWGguUhiTL
         GKBtFYnHKOPPxjsHPfXNd4sq9v4bzNh5TY4SSCyU9/rGtbUHZ6TdVzpSSfUBuRDOXmqn
         Nn1jQE4aONWTlfde5CX8yePooTNiIIDGsTA8TnvaEably+yK6JM8jp8qUu1kYNSwQavZ
         4TqQpgs27nRl4xZS92me1WNRkgh5pUEQMBN5CBZUEgcLvuOSYW4p8mF/6e92bzoBNdwT
         C+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987079; x=1734591879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIv08M5NuYFMrbLnuplDgqYvTP/RY0BpL7xzh6gruXQ=;
        b=ZFnyL+v4TCPFp+74HWRZbVMMiZbodR94BrJRhoxV5JzWMELUA/CA0QLW8DcQpiOJbi
         xxS+WuQDVRiGkM/cAO4iVIH/mhuBQBzzvXq9insft///ursW4/hNwrE6qMxcCg134Xzh
         0wEid6Vn2ItzjDHfdn3cVe6R47fWujhqlBSKGtUyBopYfKZZ+zrEA/3PahAxFkYMFeL2
         Ao2ywud3NtVtem4zlu3/ZSfhJSk44IARqVnIyPlCTnv549agLMyQwmw3qCTH0Wc1WWfn
         whQKqb2r9KxhJl3DXcvzEO0YfGwGOCC7tWXFGfMpOW+W6V527uTmQ+9T4G/5vrnaCq5u
         lzww==
X-Forwarded-Encrypted: i=1; AJvYcCVlpCyHSyncuSKpqe41GgXihiSfPvgzR5Eec7mChW66nMpiAJJxG0C4FxtBzegNPxiwaMVMuA07i7Q=@vger.kernel.org, AJvYcCX0h3n7R8+0sJDm5yiN0Vts9IqU2tp21cJ2kBAaNPWtCSi0l9NBqBI0HjAQ/GRm0fu6ow9Lw5zJGPv2QbPB@vger.kernel.org, AJvYcCXDXSpByIB+y+kZ7xWaggdB5HLfmOqEaJ/2XBrSzAU/88GhyvWO4kz/MaC4F3HNpmMOWRVz9pP9l3AL@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVT4TNwdYn5YbZW0aYWwjvyhLe0mLQ33jxmZtkIgcm5PWDWD6
	UfJxhqRRd74Ln+cj9y/D15l7hsDiHvIiCXyjx0UxWexKTHvoH1r8Xke4UUM7
X-Gm-Gg: ASbGnctyLPElWGwAp2N/XkhaTbdxvggeibXIGU+P9ppPR2Z+hmIuPb11J8JAsyHQVTl
	yLNadJMqYS9G9Ia6aTs2RWp5TUKkkGSCk4c9sBrjTo9IXNMty5SiUbuA2VVwkjZslegy01lead0
	NaKCCy78lv+iaPCxIDDLqkEJ5127wXrSH9K87Ntt/Ld9+6Ld8j+G6rs6+WmawbM6dRdeyOvJ5sf
	CK80xfbDMVPMNov51w+QPy+ss8vQDQqIphVb4CS1itNS30TGeiblRAlpclGYL1yRWtUt7bs
X-Google-Smtp-Source: AGHT+IE2taDr2+F/QNnwkBgUaYbLlW++dErTzZng9ixbTcmDK5lHBmPiyyr/YT2Yg8/ifsjbQynqqA==
X-Received: by 2002:a05:6a20:7347:b0:1e0:d32f:24e2 with SMTP id adf61e73a8af0-1e1cebdfe8bmr3622509637.38.1733987079385;
        Wed, 11 Dec 2024 23:04:39 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:38 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/7] Apple A7-A11, T2 SoC cpufreq support
Date: Thu, 12 Dec 2024 15:02:59 +0800
Message-ID: <20241212070344.3858-1-towinchenmi@gmail.com>
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

Changes since v1:
- transition_latency is in ns, APPLE_DVFS_TRANSITION_TIMEOUT in us.
Multiply APPLE_DVFS_TRANSITION_TIMEOUT by 1000 before setting it as
transition_latency.

v1: https://lore.kernel.org/asahi/20241211112244.18393-1-towinchenmi@gmail.com/T

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


