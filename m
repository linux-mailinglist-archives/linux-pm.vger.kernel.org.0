Return-Path: <linux-pm+bounces-18721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16A9E7B76
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F4E18865FE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE7212FA4;
	Fri,  6 Dec 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JJBf+PyR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06001E1C10
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523185; cv=none; b=rD822XwjgjsNYfXwqKSYvFCUG8g5rZXybqo4WeARvnbYcRb0d/cYLEpW5m4GizYng4V/wC3D/1qX6AHj2AXWDIilh3TC4rDnovGBnVEllLHSciZD6xKilXwpj1QvLnSSjk9WbAO+xiuiApWqKd0VJ4pp1oXh9ugAVr6yQUskGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523185; c=relaxed/simple;
	bh=Y97KH6M0ijxkZVfpkGPDKdwkUdjVhhwQOY3Z0kcTNBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPphBKtmVfp/0EiTd6Ht4LPbGDiGMEMYgCUkPKKPSyhi8S06bguiA/PzW7fVkjfmF2mcEQDvsshwAtfzJRO5a9wio7GPEad4U1talomRjcS7AvDzQNviroiN1ZIHg7z/CLCyBpCqm76IZIaxkQCrq8cryDltLQeER5D74inq9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JJBf+PyR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb94cceso6164615ad.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 14:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733523182; x=1734127982; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ijyw4ymsAkFeWgQVUc3VJve4hsyHlzdR/n9h/faXYk=;
        b=JJBf+PyRozYRFqcsfssa3IPoOhCdwphmSmnm9kglYxEnHeaCtazS9KcXeN8/015Ob8
         F01vPr7XjgV/C5zBEXy7JxyKcw1tSQo/qT2Ql6wkB/f2gbJDxdr52qS+iApQ+mvq+zZp
         MD6w3Ibzp9IbccaBqOgZbsa9189b69y09QbOm2JhRfiwNcuGsmQxUIflLf8zpjn2+LZ3
         tWV8bnL2frJJr5t9PTafw+jvP4f0uYUX74/tsW6fhTQOvUa+7ndUIONHPD2vJtqC68zd
         uVzBLLxRPP3DlfuOAO4bKU5eInI8X8um5hGfi7zkC5eXDE3uZ40+Pd/p1Jxx5lMAe3H1
         sT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523182; x=1734127982;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ijyw4ymsAkFeWgQVUc3VJve4hsyHlzdR/n9h/faXYk=;
        b=NdjN/NVgov8G2NPYh5s28A7DYuzcoUBByfVVZN7Eb9lzLmlARuisNwuuM4UIgi2Nxw
         oASsbX7nRESV+tIjT/uoklRVo8bc4wJQhj9z7o3R5jBhNyjz5rriBm4+fAq3rum7aZhy
         P1dIdgaTTHPMA9KkRUQfOEUWu3wTkmtJJmdBekGVPjAcimAe03coA+KNttyHAnmM4Mns
         pSqQhPJdbQxBfgYAuwTitP7k12JC77zbgZl4BOBsbXEQqIb4qucXVeiZ6vKl4gwmLVAO
         IlmvexMmsMvisHbqPeekeRLn09f3Ee7DoycqjdLc6eXqlLEAB3IOwmvlxfHurEgXwBuF
         33mA==
X-Forwarded-Encrypted: i=1; AJvYcCVmX6EWgyN+Nc048msK/klKYioH919vH1179hwQZctQHhhxZLZpg4pO5ZlLPItVadbV506zoZ8+dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YygJYDJYoPwDaESNVGCFp3Cx4VQ/t+CgDjmh6PSRa2GK/S7LF0G
	GrbJ97wN0nyqgfkODVB/xKEF9TRA0p2sUEkjID2kKFON3JFcdZNdjd9KCEZD8oU=
X-Gm-Gg: ASbGncuLPyxvNj1Rv9tbyZ05LTygem6Up3Dm2Ebv+Evh/UchtVBvXd1xojQFvF9IJaA
	LmpuJ+3LyiSG7SAvVVEh2dB2yR9SJ1Jf9mOz14MhBr6TssnXZrrr8UMpnm+yk3aBWVgm5bhdygn
	pD48VUw/jOM6WzfCuJR6n/dTLHbXbUC1rv2L6Yw/r5IVRp0B9Ueul5V5VkNqhO1pSI6gBD0RNwA
	dSCuOjX9TV8RSkcdJIe7lqRJ6xX7+1In7zuM2ZnBI3xze42
X-Google-Smtp-Source: AGHT+IE0aIHhhTmAidePOav40ceBPnjxnWQH78Ga0X4GWG2q6QRXiZRk6w9WNT1JZkEgO2Szry7sFA==
X-Received: by 2002:a17:902:d2c4:b0:211:18bf:e91d with SMTP id d9443c01a7336-21614d5dc31mr58848105ad.27.1733523181838;
        Fri, 06 Dec 2024 14:13:01 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cf9f681esm53275b3a.98.2024.12.06.14.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 14:13:01 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v6 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Fri, 06 Dec 2024 14:12:49 -0800
Message-Id: <20241206-lpm-v6-10-constraints-pmdomain-v6-0-833980158c68@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOF2U2cC/43PS27DIBAG4KtYrEs0w6t2Vr1HlQUYaJDiR8BBj
 SLfvcSp2qiy5LJiRqNv/rmR5GJwieyrG4kuhxSGvhTqpSLtUfcfjgZbasKACaiB0dPY0awoAm2
 HPk1Rh35KdOzs0JUv9ZxbL7XzQjSkIGN0PnwuC94Pjzq686XsmR5NYnRyxeq6MO2rrHbIaWyR3
 IePIU1DvC7hMi7T3znkVo6MFKjFWhlVW2dF+2b09RRMdLuya9EzexKx2RRZEYVCzqRWALVfEfm
 v2PwjIy+i47JpjeGNkmJFFM+i2hTFPSPI8l699mbtavkjIgJuirKIHBC1BqEY+3v1PM9fiEs8c
 UQCAAA=
X-Change-ID: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3769; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=Y97KH6M0ijxkZVfpkGPDKdwkUdjVhhwQOY3Z0kcTNBk=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnU3bsF4JQ7/8UbfGMucR/j7XBVV4vqdySArbbd
 iwouJliJfqJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZ1N27AAKCRBZNxia0/vG
 ZVOMD/4kyxmRYQGPNwla3vR81G0xRC3SAdlkKmw4KvOlaQMP7jnvqxnKawgQUpX0gu57mPeIbJM
 Wcbkjj4CpWI2a4MoGunrrGOy0uJIh0ZVVhScv5nXIDxg91LxNGUrkN4FpKvl5A9JYwhsYEkrmzL
 nYEjGVhUflEOBHycFix8UFQlw2O/3We00L/hnDijh5FP9Y2JfJkBwfOa3EnxVxNNP6ONmBAHswb
 BmPOl/Qio/vDFBmI4HnL+upZuUdWnNgKrFRt1pHEH2IOtOF0v1Yq6Of0vNwvu2hEIFpGoBdwvAv
 RadRHYNWtwD2JIddC6CS5tWxs9FE49XaBlKNFyfyuKDShMVpRvi9kUGQp9s3ke2SaFBBH6VSosE
 Ofq7GFTZYORm2NywmKCOsp0oeMX22GvqQNa0mXM/Jxh6Oo6bVydphSLMoqRqpFn6pBV2IhoKM2H
 zDtQpU8kqC2JKQ/622LzvbxrJYw0nVfLTt0ajlodWz6LRnN/CemalE/BSjImUy4umhEfR37WOe/
 jI4atzk4Gohs0SnfBIsMS2QJGwJoDpdnI3FXV336iOxLRsLML7KHZK5KPnV8b1JxOBtkjCo7DTm
 m+QOqmRRJEyDFDmJeNZpPQGPAsm7hZuJ/LruhjeWtHyND7xeVpNNNR2J5I3EVisf5aTBzfmi6Ka
 1rLgeoltRzF0vZw==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

The latest (10.x) version of the firmware for the PM co-processor (aka
device manager, or DM) adds support for a "managed" mode, where the DM
firmware will select the specific low power state which is entered
when Linux requests a system-wide suspend.

In this mode, the DM will always attempt the deepest low-power state
available for the SoC.

However, Linux (or OSes running on other cores) may want to constrain
the DM for certain use cases.  For example, the deepest state may have
a wakeup/resume latency that is too long for certain use cases.  Or,
some wakeup-capable devices may potentially be powered off in deep
low-power states, but if one of those devices is enabled as a wakeup
source, it should not be powered off.

These kinds of constraints are are already known in Linux by the use
of existing APIs such as per-device PM QoS and device wakeup APIs, but
now we need to communicate these constraints to the DM.

For TI SoCs with TI SCI support, all DM-managed devices will be
connected to a TI SCI PM domain.  So the goal of this series is to use
the PM domain driver for TI SCI devices to collect constraints, and
communicate them to the DM via the new TI SCI APIs.

This is all managed by TI SCI PM domain code.  No new APIs are needed
by Linux drivers.  Any device that is managed by TI SCI will be
checked for QoS constraints or wakeup capability and the constraints
will be collected and sent to the DM.

This series depends on the support for the new TI SCI APIs (v10) and
was also tested with this series to update 8250_omap serial support
for AM62x[2].

[1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
[2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Changes in v6:
- fix build warning on arm32 when building with W=1 and CONFIG_PM_SLEEP=n
- rebase onto v6.13-rc1
- fix latency units: convert usecs (PM QoS) to msecs (TI SCI)
- all dependencies are now merged in v6.13-rc1
- Link to v5: https://lore.kernel.org/r/20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com

Changes in v5:
- fix build error when CONFIG_PM_SLEEP not defined
- Link to v4: https://lore.kernel.org/r/20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com

Changes in v4:
- fixed missing return in wakeirq error path
- updated trailers with reviewed & tested tags
- Link to v3: https://lore.kernel.org/r/20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com

Changes in v3:
- change latency set functions to static void
- Link to v2: https://lore.kernel.org/r/20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com

Changes in v2:
- To simplify this version a bit, drop the pmdomain ->power_off()
  changes.  Constraints only sent during ->suspend() path.  The pmdomain
  path was an optimization that may be added back later.
- With the above simplification, drop the extra state variables that
  had been added to keep track of constraint status.
- Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com

---
Kevin Hilman (3):
      pmdomain: ti_sci: add per-device latency constraint management
      pmdomain: ti_sci: add wakeup constraint management
      pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
---
base-commit: cbc4912199deab59fdbd830b115d81941d0add46
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


