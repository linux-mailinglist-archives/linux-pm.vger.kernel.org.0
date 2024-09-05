Return-Path: <linux-pm+bounces-13738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93C96E58D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 00:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1131C209CF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36381990D9;
	Thu,  5 Sep 2024 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tei17ggl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECC1863F
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573804; cv=none; b=kHyTy6jTVspUk5NfVrkMbGhP/xTPTJkTuOQpg3O/Vky29Ixd57qe3URFRvBe041DVLqorp/nXcyJhG5dxKu2VieToRcGsMNVe+BAawhxMEZkqWop+l4xOZRVFgPldgdsQolMw+FqWJPHeR+LFOvRm3296Fi5YzbuZjb48h+2+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573804; c=relaxed/simple;
	bh=saMma2ymybzJWYTTQFbUhKrtLeP15luhuGW/Ddk6lvk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MR20RD3lLQ9oaJ4PxBsLFJknEG5362bbLICWKPiT3hGyHt8lfRg5tvqbUUSXwoZU4fkgGeQAi6lT/vfvMVaWd1i+A036xlWi7eJgP937opDrMNyhKLOeO8LsdU25BrU1Eq/lj2fcMFDI5GiFzfUg/bFP1WhV0qZntVHCTlDXCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tei17ggl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d704704aso85288b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725573802; x=1726178602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41WL+feSyoP7RX6WUBTtYFgCqTaroj/Azw0jftS6Ft0=;
        b=Tei17gglZXb9ZxVVj5EXiU3dsKB+ejhoWDI5jJDzdAbU2Zj0zTMOq0z6+IEdtQGWY4
         0b7TQb5tUX/HM7/poj/2Abzlu+WuTCWmnr4Vg1RIiNgO/vgBjP/U+ZNKGx/ggkZ3sz6I
         F2XtcWTZhChzgRkiY5VNig8ENuxHmb3yCefOn2eRbbxa4/HcmFF8p+202XUonB393Iau
         9cwSZLKLaGPHpk4VvV8bBVOmS4/4iP+k1x4F9rpqBbySrAZ+QtwETZMRk1TnpFfUGeMS
         zYjc/Oy0M2+i8Pk7/7Cd5fhI9yPZz4LpMLZABfSLcBlXoYCLFgUFkjp2JTu37Gh2uUfI
         HL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573802; x=1726178602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41WL+feSyoP7RX6WUBTtYFgCqTaroj/Azw0jftS6Ft0=;
        b=E1xDFLzFmGr1uRw3o4NTPPQOgjtSCoZybJt9IQj4CNzAXBMGDRyq63d3zrcjYMov5m
         zWqMae1h7eRQPUrYDrIZY0bfRHUUhGelQQlc7JzJFn77S3yEKDWMc7SnB9DVU6iLQ16p
         VIGXrA2CoyZFGanlZhTya9rZid/nw+UVI6oq0v71eND/uSGCTy2QCbBbJwUGPy8kQ9do
         dJ6VWvT4XcxCH/YKaKFXJIcYn5FkcvZpMo2J8QSwJL57ww006J4ftsPWzvACjc0vhWZ5
         oe/A0HBSSra3xMA1gOUZBUDpUTaByom3kC5sKHRoY0R60krltpXy9VvPzfkvb/VtWqxA
         TGbw==
X-Forwarded-Encrypted: i=1; AJvYcCUl69rAQZx3qYXGrPEpwBee+66+auhx2pB+ubm3HxsrAXBH/0OkX8+2WzWQtIeYklfEE+K5O/1Jtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoCbJGrSxsTRCeqcAlnX1Mvh4e+K181x5lSRVnsabB12UxYWT
	PgElTNT5wZZ0bYoBnGFIUW348T+10nzp2nwTpS4GYiFfVNNDLBOC5b/bdL9bHWo=
X-Google-Smtp-Source: AGHT+IFgAUMIvSHgLESeGQfg1z9nn91qdHyz9Ic0DH/cx4rUi6lSF6kZn33ca2MEKbqpkbORknGKjA==
X-Received: by 2002:a05:6a00:4b04:b0:717:87f3:92e8 with SMTP id d2e1a72fcca58-71787f3943amr5777885b3a.29.1725573801896;
        Thu, 05 Sep 2024 15:03:21 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177853326csm3674034b3a.64.2024.09.05.15.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:03:21 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Thu, 05 Sep 2024 15:02:48 -0700
Message-Id: <20240905-lpm-v6-10-constraints-pmdomain-v3-0-e359cbb39654@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAq2mYC/4WPQW7DIBBFr2Kx7lgMxgiiqOo9qi6wGTdIwXbBR
 Y0i372EdNF2kx0fad77/8oSRU+JHZori5R98stcQvfUsPFk53cC70pmggvJNRdwXgNkBchhXOa
 0RevnLcEa3BLKE6auc1NvaZLSsAJZI03+qwpe3+450sdn8Wz3TzbYRIUVgt8OTVYtIsQRb7eBU
 rK1waE51gKGSzRSCNMiN1qXGhDS+jLYy9kPkdqCeWY3zcmnbYmXOitj9fws6B8tyAgcHGo1KO3
 IyfEPvtKz+EVE85AoClEq7ERvFed6+kfc9/0bd5GPXIgBAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=saMma2ymybzJWYTTQFbUhKrtLeP15luhuGW/Ddk6lvk=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBm2iqoDl3qzuImDgvwy/56oUMlM8+yJq6igJ7Fl
 rZgheaAL/yJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZtoqqAAKCRBZNxia0/vG
 Ze+UD/9uq+XFgxGVyjsf141ywlVwWX13BifJhHv9TaLtyRv/mPy9n8DeyYOdKh7Qa9HE7oynp+q
 PkaRGCpTCdQYKWn+J3ONAu+YIWd0kSUBcNtRBOW4JhUDj+2nfj1lM/J4Qo6xl5AEP7pi2ZKeAM+
 6FJ92MQx21wVKK9EuLaDhMmw+RgGkBBKgOo7qgULHex+KH+OjkfKlhRHdGxLDBJqGgFyL/BQa0Y
 TMtAJyY4/B09khl3xYJdNcOzSmsq9Da7Z5i2nqKP7SLG9yfDc6ZbHHajIp+n7KMbyo77YHmvmP9
 Z4WIZIJDR8+b+OE6t9K4tG8EILxqwe5WBruldHXQSgTHnA3Qug6dcQicN4dyxBeltbb3cnv9e5T
 8p5MTulteVJK5aoNUxjfN4GdCW2PySJ1rxdNqNuJVGRQQjn24Xl9UeoHGqUjNO7Z0/AfTnDf8xd
 1XqH0WoIJbhK44Ow2QjXbx/VLIW5lBW45kWennL7Luwjvr8UKnHiYZZzY7npEooWz/fHYH1WIET
 h7UqLGZ4XQNp6W3Gev1Zi5KxoHAzW7GTJ5mYGwVrKiaGsqn+KNYjnozLc7hMsmGrcfixuh4Swb+
 87EgNoVS605opqr0/RCk+vS6h0WrhqsnR4V6fhIIhNQUmW6HWceObv8LNcHtYzqmoGoCj+qw13j
 fWGGCVds62bmNUA==
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

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
---
base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
prerequisite-message-id: <20240904194229.109886-1-msp@baylibre.com>
prerequisite-patch-id: a0efbf22e69d23dba8bb96db4032ca644935709b
prerequisite-patch-id: a9b6a17956ff6a09a6ed19c35df9018e28b5059b
prerequisite-patch-id: 2999da190c1ba63aabecc55fae501d442e4e0d7b
prerequisite-patch-id: 69a741b9c81d7990937483fc481aafa70e67669d
prerequisite-patch-id: 945b15416a011cb40007c5d95561786c1776bb98

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


