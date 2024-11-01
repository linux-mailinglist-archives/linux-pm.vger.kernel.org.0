Return-Path: <linux-pm+bounces-16880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037CD9B9481
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CEF1C21BF7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A441C75F3;
	Fri,  1 Nov 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cpcs48Cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932711B5EBC
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475409; cv=none; b=hHJV9hv4a+6+tscwLMds9BddI/nTAJjOgIZMANY0JGOhvX9xw/QFXgsAt8wVMy/WCZ3a7hrEzySkIIqpcMDusdN4GTSli7GvfAMIkA5EgTz5EL31nIcdvf3RxyFiZ5C6e7tXmcDXkF28NzZL2lthQouGK55Av7uS4lHycS1o9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475409; c=relaxed/simple;
	bh=sJhIZM8nF2F0ipz5K+7ZrDZObZ0A9WQI1rMNPGAN4Ho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dyGWswkh6jijX9Usk1Qu2v8ioMr55T/VGQ774tS3h1gu3M6potE7ZZBoTsKcDv5Pk2+7IuGqfN3zVVB3oeHrhXf2XaGM3CkhSu+1TuKTCiycWvOiwT+VXCBmiSnA3E5GSHQ81lcLIxgVmt3yJua15Ksd188mCWRNS38yj/2hrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cpcs48Cr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so1613588a91.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730475406; x=1731080206; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6D4NtcREXB5Bup547qNdCAW5XslwNEJ4Q+db+7Xpe90=;
        b=Cpcs48CrucVVcXwrlqkv2+8TotkB6ceyj9xejltj8mpuPd5GRylOJOgpyMjibjCNKi
         oHENbnt40ZlMKUUtgsFnpiT5FQeZ8MirMfzAk+JgSAsMHfKq5aaN5gYEmk+ddgDkhb7k
         42nXfpfE5idb9DNTS6xFmv0j4theuUe/Wwo2RLxcBqkOjVRaKib3BTBzHWnnDo7APgA/
         NmJzzNkUuPZYlFek0GDvAosKvZB2LOQipOCtHW8zZcbEcT7nuwmMB32GM+tEn/hRUMUF
         RxWNA/9zFYCIRAB6wao8AA/oAOHnomj2VZAbiwgeqPOjqjaQsm8NMv2hiH4ur3ulzQJf
         ouMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730475406; x=1731080206;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D4NtcREXB5Bup547qNdCAW5XslwNEJ4Q+db+7Xpe90=;
        b=Xh8C1A05oseRiFUSjxXPWaGe3YMBauVOkq/OqI0tttMUJhIkhFWOn0PojIbnYTJstQ
         2Ngqb4UWlMV/bnFAP3WsmvLhKHDUR1viMkXgZpKlX2i3X87hKfQAHipetcFxvf2IckxT
         sQitsBNMp+iPJy9/vRdQosme3lyx/UGP3nawdOItR5EyfkATt1itavHaqa0spEwe3Mmy
         +Vw6Oz7FnPDQqze3diTJbFRtq4HJ0gfAt8l5fXZJCZd/850ZEGp2/pQ9AvNKpC7++dxP
         K4TYW1kgvHZkgyh1E3OTLZHJsJOkjOa4lXFvG5MB3OREfPXcrOyzKRZj4Oimg2SlJqsm
         FQuA==
X-Forwarded-Encrypted: i=1; AJvYcCXIYsQymBA5H4RcFZdwgv79TC4KfMjATNdk/A/xP/obLfdNYzJ/FF7tz0iLwRqobL0q5l9k0Z3XbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyvzXLUcT5Vh9hPXRudP9/yqQPDXVeyGdCim/yxFYU5clMeFJ
	SA5yGCD3JUGHo7YI7e5n1NWsO3pioKCM8d9uDnLNVU0c0yMjAELtcP1Z9yboCeRHYsdsU2pGyMR
	PCxooeQ==
X-Google-Smtp-Source: AGHT+IFFj+60WKfoiIjXxsK2iwYQcncuiXaKb0lwVqrEg1MHxBwe4MkWUHlT+nIYgMUoUozG0R3kZw==
X-Received: by 2002:a17:90a:a384:b0:2e2:c406:ec89 with SMTP id 98e67ed59e1d1-2e92ce75107mr12293458a91.20.1730475405684;
        Fri, 01 Nov 2024 08:36:45 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93da983e2sm2820735a91.11.2024.11.01.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 08:36:45 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Fri, 01 Nov 2024 08:36:19 -0700
Message-Id: <20241101-lpm-v6-10-constraints-pmdomain-v5-0-3011aa04622f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHP1JGcC/43Py2rDMBAF0F8xWldh9IztVf+jdCFZo0YQPyrZo
 ib436s4hYYSSL3yaHHuvReSMAZMpK0uJGIOKYxDOdRLRbqTGT6QBlduwoFLqIHT89TTrCkD2o1
 DmqMJw5zo1LuxL7/UC+G8MuilbEhBpog+fO0Bb++3O+LnUnLm2yOxJmGx+j7MbZX1gTEaO0buC
 7TVNZ4BaDqH1AWa1pSWNOHgIqalR4paKThyMAp8m5kg16xTSPMY131bZnvYzwz1bEZmFKhjtba
 6duhk92rNeg424qFU3fXM70TWPBV5EaVmgiujAWr/QBS/YvOPjqKIKFTTWSsareQDUd6L+qkor
 x1Ble/ojbd/V2/b9g2TVvjvMQIAAA==
X-Change-ID: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-cb14d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3822; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=sJhIZM8nF2F0ipz5K+7ZrDZObZ0A9WQI1rMNPGAN4Ho=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBnJPWMtji6vAtmxBrj1xLbPcea8Y3RbMW+PcQQE
 rkdXnZ/ugmJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZyT1jAAKCRBZNxia0/vG
 ZWrED/4lPApacXPdaJRxftG+06DmkKGm4y5AG+vRC+F5xBwLHJWfIjF53SWlmfhVBd2zhp8+DBt
 oA9b+a1KAYGzxFfZBGS3VXnT9ymQBMYzPPk1ACbkmUcL7g6gd6pRapH/nHskCFmKBienvbwCOaK
 d+zAwogd2ej09zPBv/lTtocuprUNnzGjHaRqrNcNKtk104w+wUJcCu47Rg3xbVl41VqDcXMAHmv
 YJSFVhvxLB+Ed9i1KXvJpg/Z5fhf42C/0b+Pk79+of+w54CjWtu4bayq6wwTepm4rDRbsWGP3Rg
 c7ac0/WhCUEWhQG0Ee59aWPO+UIr74kZhIY2RhrTFAqa4BleCYlfAPcWhkJc8LyC4XNBaYOwMpI
 VWY3tTo57E+/jF8N/+3P/oey2aXLa0MnVygD1vGOf2zB7cm593gKQR7rPbGvEOi4rHz+cBVqm3i
 U60ka2LeTlr5N0wPAf33YTU6Px8Q1RaLRxO2w5Pn+DAGEp8/gxr7ggeVmRy9OtzLOOePgNWGvye
 5ahlPFQusfH1q0H+U6ZTPO9S5OWkqcirR0dKTremz2v+lCILpzRZQaNcoP1pGdjrsFkglQ/x2B2
 2roUs7ZnjA+o7IGaidHRTFfJrw+ftWvtaprGxMZ39147dbH35BHeCzuJK7VbyJl/kDtI9EzJpk5
 4Aeq1/atbDe1s4g==
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
Changes in v5:
- fix build-error when CONFIG_PM_SLEEP not defined
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

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
---
base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
prerequisite-change-id: 20241006-tisci-syssuspendresume-e6550720a50f:v13
prerequisite-patch-id: 945b15416a011cb40007c5d95561786c1776bb98
prerequisite-patch-id: 69a741b9c81d7990937483fc481aafa70e67669d
prerequisite-patch-id: 15e97947da8cb7055745151990c756d81fded804
prerequisite-patch-id: a0efbf22e69d23dba8bb96db4032ca644935709b
prerequisite-patch-id: 2999da190c1ba63aabecc55fae501d442e4e0d7b

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


