Return-Path: <linux-pm+bounces-11926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F543948638
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F9B284374
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419616E870;
	Mon,  5 Aug 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qUtbvVKb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFE14F9E6
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901157; cv=none; b=W08ETa26qvAhdTRrmAOaGn67e7f1jdcixOWj7GNV9Evija5DWKmzld3k67+dNNJzU2pTI5lCDwqz1x86U4ly7ch3EDjEdEvX1RsR57xT0m37fcRlwO3e4u7U9JsQvzEwh2+i/jh0Er+e0EKhhX2SexUgc/z32+6mS+nwWl8wfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901157; c=relaxed/simple;
	bh=oDWvqZLlTRsTm3mtLU+N+8ckvjki4RAgkVzc7cx3B5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CJbfRKR6iVFQBDWi/xkiYzRXOWkp6GdgzNQjjIHdfApDFXF0/oYpjVu8x23bOJcq2VIQFvXH3yZ1MPfimzC6i3yoEUNFwVb/n/VR6W6w2YkxbyMTSZfA+phfQb1VfxBxbZVgSG8n+KIAadFA9k1/x13gwtMgGoTtQRhwfCzfd/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qUtbvVKb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d316f0060so4046453b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722901154; x=1723505954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlfLagP5nVyPXkAB8M//TTqvQzW08KpKDm8mw3Y40H8=;
        b=qUtbvVKbapmgLJ6EmVhY2es7Ye5yBB2GMZRjd65rHiVaYgFYqie08lO5G1lYyn1o/z
         pShl8r/xAEcox5hrWeXex3meqUsfEDsFDZkYtORV945gfH8FCVkvPmssaIfbc4mZDt5O
         VXE+IsPxzLcrVRiCgUMu/U7BxnICk1dXYDQ58zuCxqr8aBqTkVDDCjTNcYY+svn70sej
         pzRAHa+LHuDIec9Zy6th5BsI4Tvi+l2cncnk7qcnWPJgpRR6Z3B9B/tdLmOcbGgTPSjx
         3430gGa7FQn/u9AnzdHpIGHkko/TonB+uZf7RDcJK4cac/fDK4C8dks72MUWGZ20srJu
         6I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901154; x=1723505954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlfLagP5nVyPXkAB8M//TTqvQzW08KpKDm8mw3Y40H8=;
        b=rl2Ovj0cyfRnuAvULokqTD8iEkL0W9PomDa9HCX8j1xHbO6yi57vWv2PJywPRh8rr3
         2SEKTgiYlZM5hHSrskCvTdRRhN6riecMQZOfWK1X6yXZ7vXztP3LLard03MlIdIu/cO4
         yXwM7kctwkbbqJKQVMLkUBOfJqAO3O7ih5NXhhQJLVMhNvF1oQP5EhRj/6Nkd4aFfd8K
         oGTpgHd82U+WK+ZjGk56BdGIyTFJ4PgQ69VV3nlq/3e/APMP/9TXLx9m6tBnM9UMMBBO
         0HQtmJ6V4kEFx84GtKgVjvNxC3lOu0Z1sESlj40ThdX0E+xHaEf1CjN8+ubsViR5uB1i
         x7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xsaEQMTWrcNz7jCNY35i3KcIXQUR96iUZijDy/4mCNpVklKNLBKw4TE58DW/9XHusMWkeZRpXJ/UeyOn4dcxlJI+OqpLM8g=
X-Gm-Message-State: AOJu0YwYQ4pLvZZhmt90ed2XkeB1Rg6KWnZYR/kU8yxb6rjYWPvY6ZPR
	Qus0TcGMNHOSopMwBK55MvopIbP+UoPl4mm3x1DZxT6iwQ1MXcSi/vqeAP6iEtE=
X-Google-Smtp-Source: AGHT+IEP1xZK03sfTEAqQ2BUVMV56gxYOQHRak/cqDgve2B4q6pMILP9E+OfwxIYMys2eRW9iow3uQ==
X-Received: by 2002:a05:6a00:85a3:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7106da29926mr19788781b3a.7.1722901153596;
        Mon, 05 Aug 2024 16:39:13 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec40f5asm5950089b3a.51.2024.08.05.16.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:39:12 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/3] pmdomain: ti_sci: collect and send low-power mode
 constraints
Date: Mon, 05 Aug 2024 16:38:38 -0700
Message-Id: <20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAINisWYC/y2OQQ6CMBBFr0K6dggtBYUY4z0MiwKDNqGldirRE
 O5uBXfzJvnv/4UReo3E6mRhHmdNerIR+CFh3UPZO4LuIzORCZmdMgGjMzCXwDPoJkvBK20DgTP
 9ZOIJQ573Q6FwkLJiUeI8Dvq9FdyanT0+X7En7E/WKsLoMkaHOpnLlHPwHf9lDRKpbUGdnP8DO
 K8KKUQqRFXm8ggcDLlrqz6jbj2m0XNhzbp+AYGENjvYAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 20240801195422.2296347-1-msp@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=oDWvqZLlTRsTm3mtLU+N+8ckvjki4RAgkVzc7cx3B5E=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmsWKfWekKui7NB6vltDXLdz/o4GHPuLverfABI
 5myx6HZISuJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrFinwAKCRBZNxia0/vG
 ZYbmEACY/u4s2BZHwhegEN64lzxLQuWazliVpqqKWOw53rJM1FrYZYvYmFtUx35wOXVFg896rzb
 8h6QYSKuyqoMt5XONQ+mbitOPpa8KRgaYlcKVH+PAVnk7QHuMIhu0THt0U2aWlHrKYai3dtPQnV
 66/R7dGnnvSylfsGu+E7dsLMpiYJDKm4ElkrZdnhGsQKkScGlIHMgQoMKK5N4jYLbGLNYgLUK9X
 IAWtNF/o9CPhQ6Ivp8rPlHMQWV43U7cU+b6wi9tAvqwFnG2zB0Pljr4sTMmF6RpS6U3DKA++9eV
 GjGM9Ib5Q01x759VyBq8XedPcQIocQ+HgA2SvLGy5hBDPn0U1aB6/+9eKn/RCK1V+y+gVnU6RmM
 s3AC1GP27GiA8pLlIQrOmGBLoZkLdndlujR/TRRsYKf3Sk4wnJNlzpxZ1Uxkvd8hzsVZyNn6nfk
 RKOeH/IeCdckU+wkRe3ba8HQ75BFv7F6+bPXP8Wdf4NmzDzXSFnQ4CACaW35fCdgwn3Sm2hJQ8K
 TpfzmrkDAEl/iG0lEW6L6GQlrlfJZ/xU0FyrpLucJgomm7czYymq/kxIHoISDPe4cUIwitUf/AZ
 ohHp4+qxWGaUgSIBG24J0vrTHnzOCwAJxS0r6Y1bLZSqAMbLjzw8qaaSCSPrrvWBftWSpbiZzPJ
 NgQ6/y9FDfiDnPw==
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

This series depends on the support for the new TI SCI APIs here:
https://lore.kernel.org/r/20240801195422.2296347-1-msp@baylibre.com

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Kevin Hilman (3):
      pmdomain: ti_sci: add per-device latency constraint management
      pmdomain: ti_sci: add wakeup constraint management
      pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups

 drivers/pmdomain/ti/ti_sci_pm_domains.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)
---
base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
prerequisite-message-id: <20240801195422.2296347-1-msp@baylibre.com>
prerequisite-patch-id: 57f574b3f686c62cc0e255f52b2b8b96cd8b1661
prerequisite-patch-id: 0dc60150f10bbd6e0d7ae19001075b859d7af2f1
prerequisite-patch-id: f4b971122cc54df199c0d95a6c4ed47db1dae027

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


