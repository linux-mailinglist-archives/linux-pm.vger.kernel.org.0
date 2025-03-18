Return-Path: <linux-pm+bounces-24265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C92A6803F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 00:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131DB3B7B81
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854D2116F5;
	Tue, 18 Mar 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tXJB/EAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEA21146B
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338850; cv=none; b=QYiaAOgp5nieNHM7FbO9i6QNOECTFFS5R8yz+rQ42HkHUxqxW7ijpdcPNkw6+8y2FCuABfDBnV8cAa6yLYEVPoPqwFQXkSFnAy9qwkVZW7pNUTupRVf2vkKMYofCzX6TD508jMbvUl3zOmV8itqFfmd3xcEVqoEL9X6WXH421Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338850; c=relaxed/simple;
	bh=Ya379Ijr2ofj10+RRG61gqv1ZJJPtyVebxeOMcaN51U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CW+kwVluNLGxRSZwHubko4a+hQbJf2nowiC9OCgPrLG9MEfqcyHA6URe3O+M3hr/oDCs7WE+SKz5pOZkhskb0e7NnA2rt51f/6WxmtPPDtEU+WRtPE7x62lc8QEpqxrVuqDxPt5Dbvk7rNCPHWUFdORgFDux9R9BF7stbEq8GhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tXJB/EAw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22438c356c8so108262475ad.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338848; x=1742943648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYFuZAXLZfyhQ6Ofp04NHjTY3u72Upe1i27dNGQ4bgY=;
        b=tXJB/EAwlLWnvEMZ0+wcOO3OQ0yjxiGe1FiILgTu0OlX3ceTueTlTVfOifrYI7wASA
         K6tLlsOjZRn/Hx7/r13U7a1Ibm5gQbJQ0mvL54sG5X8U62CYpYS0eAX+/AwTPqBywKpr
         bKS6YixmG9xxObsnhQzNEU2zwesBpNbPnOm0GLge0uRleYGl5dRTBFJkvim7UvE5CVLC
         6EG63NvRnZ6eKBVtDgdf6Sa+uiHtN9ix4lZqOWxl3iP3jYjheNoQ3WvQDNLaTpp9gJq+
         WTik6WkiFvnvRRGTc+ikLeCK3Pbduv25FJ/81NgghjZlvD1NalrcY/OgFAkDNEE7/EcZ
         frJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338848; x=1742943648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYFuZAXLZfyhQ6Ofp04NHjTY3u72Upe1i27dNGQ4bgY=;
        b=fWjeAy8V0QhI7kNrhmmGOJ54Axaw0QbNUJIC1l14IoAi3vxuNDr18z45LwiB5sHqJC
         FN8ydXjCZCDROzka3zUd50fOGrOYvtXJe+T/OhNgsvnya/9rDd1OpHo/PZQuRPnBLQxD
         hzVc0iwFVNnRyGNmi1G7xvt4yqugZYPVoxU9YNxEXrt4lppeezz9jc2I8+WV7+DP6HKg
         AUfXKo6TKQAhq28dMwzyanthNMI1uH41KZ5DBicWBSpd8UUUP+zjlN3Eo6Su9XLrMicb
         J71w6JQZVx7nVitjzxsQY6z7ha7HdQ5fcyQzC6yb5o89rTTUL2pGiPIVbOdCDEuI6RYo
         9rPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJDzslGBh9mqEAFizwAzetQuwMjORFaLY/crS1Lu/ymrxPRSXyJJ0VI4qCv75AvsxtidmhjtJIQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrb8HGp7WTDqawtEWW5DBKCjeMMaavdbbCO+WufdOy5zu4yYwu
	LxJS1r4U8PuZRyLe7nYK01KcmdFQQuPEhmlZ+OXaD8s0btLASEaikBrZv9m9qj8=
X-Gm-Gg: ASbGncvaXitRg/tcjwj5o8TmS7me2mApi07P3QekdOJ2/PZOuBrEr7d5QlcDwgfCg3S
	oUjW2M4zqRQgXW2UHLtKwyPPkevxaCe9E/FRhEjhgaYbiY/gQMa9CS1Bz6aTX340QqTXNNlRZrY
	sVxMM9g5MNeTsZwu9yQjUfQfy6ti140BEpkLz66yWOsb2qn94EHLnZzKDtSuCq9ASAIisGiqtol
	N3D/XL6T8Q6bjhKD7KPdafvD8vS7MG2tG7Ml9spZ1znIN0UWYEOUPpNSzWIE7PQLM3F50WxPrwn
	K6rqoGS0vTykpCi/JejFu5Nwvv6R8jgmONWzptDJog4kkBw3kVyrtGshkp2x/7R6xD5a6mG9JVo
	o7VuFYJg=
X-Google-Smtp-Source: AGHT+IFTfJJcr07mnjzLqCop80WxhC5Pssj38zY+A8XR2rKWIc2cYcEXx8f4iEqqmQsjWdqm+Dpo5Q==
X-Received: by 2002:a17:902:d2c6:b0:215:acb3:3786 with SMTP id d9443c01a7336-2264993661fmr6691435ad.19.1742338847956;
        Tue, 18 Mar 2025 16:00:47 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f14sm100739465ad.111.2025.03.18.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:00:47 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>,
	Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Roger Quadros <rogerq@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Bajjuri Praneeth <praneeth@ti.com>,
	Raghavendra Vignesh <vigneshr@ti.com>,
	Bin Liu <b-liu@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] PM: TI: AM335x: PM STANDBY fixes
Date: Tue, 18 Mar 2025 16:00:38 -0700
Message-Id: <20250318230042.3138542-1-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes the Power management issues on TI's am335x soc.

on AM335x, the wakeup doesn't work in the case of STANDBY.

1. Since CM3 PM FW [1](ti-v4.1.y) doesn't enable l4ls clockdomain upon
wakeup, it fails to wakeup the MPU.
To fix this, don't turn off the l4ls clk domain in the STANDBY transition
in MPU.

2. Also Per AM335x TRM [2](section 8.1.4.3 Power mode), in case of STANDBY,
PER domain should be ON. So fix PER power domain handling for 
standby. l4ls is a part of the PER domain.

Since we are not turning off the l4ls clockdomain on STANDBY in MPU,
PER power domain would remain ON. But still, explicitly handle this
to be in sync with the STANDBY requirement.

3. On am335x evm[1], UART0 - (UART1-HW) has a wakeup capability.
Set the wakeup-source property in DT for AM335x.

4. Enable PM configs for AM335x.

[1] https://git.ti.com/cgit/processor-firmware/ti-amx3-cm3-pm-firmware/
[2] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
[3] https://www.ti.com/tool/TMDXEVM3358

Test log:
https://gist.github.com/sukrutb/bdbfd1220fe8578a9decf87d0bac6796

Sukrut Bellary (4):
  ARM: OMAP2+: Fix l4ls clk domain handling in STANDBY
  pmdomain: ti: Fix STANDBY handling of PER power domain
  ARM: dts: am335x: Set wakeup-source for UART0
  ARM: multi_v7_defconfig: Enable am335x PM configs

 arch/arm/boot/dts/ti/omap/am335x-evm.dts    |  2 +-
 arch/arm/configs/multi_v7_defconfig         |  5 +++++
 arch/arm/mach-omap2/clockdomain.h           |  1 +
 arch/arm/mach-omap2/clockdomains33xx_data.c |  2 +-
 arch/arm/mach-omap2/cm33xx.c                | 14 +++++++++++++-
 drivers/pmdomain/ti/omap_prm.c              |  8 ++++++--
 6 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.34.1


