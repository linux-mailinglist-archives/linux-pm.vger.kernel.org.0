Return-Path: <linux-pm+bounces-24327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4DA6A06E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 08:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1044618903AF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 07:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDE1F0998;
	Thu, 20 Mar 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyEww0H3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717421EDA3C;
	Thu, 20 Mar 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455824; cv=none; b=mu1GW6UR2kLd8rxqGlxWZXVyWDlLDM/uLE+MLojKSR7g68h0pbTyMzUPdVxTo+1vHuBGT6d4C0mYQeWSP4/In1lNbaUPmxg7ROZx7Mvv95duwJc+rMlqCW7qsc6/pBWqOg8Z5a/1Fpm41oZ+qQBbI/nMoIm2y9gaBZ7K/YgTmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455824; c=relaxed/simple;
	bh=/+fImEp4W04HXan71vn8rI4+3p5PDYAMaSKv5xbvHLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCqXc/CEeucGKja0wf+It7ep+XcuW9qksgVGmEPjLleiTvxkyy33E7eyFxvQw5nAC/ZttkoYbgDBCm29TPRzEuEgMxgFvPV+JQM3GDJH1tiPcaEROmlYeFJCtQ4rtn89jUsG1lmQHJoXYRlQj5H2Q4AqfL6gJOMK132888hNmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyEww0H3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2ed007aacso114413366b.0;
        Thu, 20 Mar 2025 00:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742455821; x=1743060621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mpjffga6qbUYAqH/bNMoK3D9M2lbn6dBfVWt3T7sRg=;
        b=kyEww0H34FsAksvRyHI4rwLu/hqJga9C8EUuSEOwyNKm4iaRnEMNyV46alkfsMJgPl
         PaSEwy/rJtQW+JaR53ED2zeHWQjjM6lyF0x3fxPSnwjuFbhsBVUSoXH3aLq20Sib3fQC
         BFa5TIjh0Jz5YB7Olh5K847LddOrLFEeGoo5xbT1GUOvUI1pCTLndzE85fS/X/a722aZ
         5poST2jRBO8ymBmN4mh/EdRDGFXY+AjVHkhHpmGPm00SyytB8wRU4Rq1aQNrhZi/jBs/
         6jNdzDsg86ilK82qW1ExexxQufnZECFGY+RV4IRCeRP4dVOzRXMwxBdgl5HDp7ksKA8d
         URiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455821; x=1743060621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mpjffga6qbUYAqH/bNMoK3D9M2lbn6dBfVWt3T7sRg=;
        b=LtaWV7HGNZ8mobdDcZjqXSYeD0LUB+YjrYFa/s6ZrCqgFZskezwsEeMUd6hXP2eOJU
         1iir0ib42XSoQte+ubjPuCwAC0Li0Dr+IAFpjEdgs/701c37U7XkzegQ0U4rkdFXmmWx
         tz7goJxVZhnhY58RPyzFJSePCDJUwXwpS2QTZCtY1ImBUS0rcM0xzK5NPyA1JU+7Lbii
         2lHWreDV1MXqPZ9jFfOrg6vfUz7alRR5zi8tB+Lg7eHZY3CJhBlFd3yrQq2Upd0z/M6m
         YbpNSvKQzGunvGx/chMZARUba4+veuOT1BcDWlHTa8iEFyZzDfaQyvYaMOQuUXTa9y1j
         4cTA==
X-Forwarded-Encrypted: i=1; AJvYcCVpCpiHE4fABtPH6mzRCHkMiYQ0xjlbDJq077VFVsZMB8/8M4w5/OnRmS59lH6BFcbfjmW2shGy10rL@vger.kernel.org, AJvYcCWi3E5EjZI6YeWJOR1ZvafEDIJbHNKiHc4nsHufVAreIzOkp8FIPHjgm+Bb3y3eBX5v6rhj7W8PJPVBcq5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxuXYyAoHMpRDrTKW52eeICaM5u54Q1tAAQ0uazxfW8SyeswW
	/hN2dpXuC201urT1TwiXYZE/z59HLdmvcu0bEobSekWHGqaWkwQlA8Y1sA==
X-Gm-Gg: ASbGncsx8xE2olE9XAajGxT7q2yyOWH4rJz/XLj1tNacwyAKXHs+2H0kH0X8m/5fdb7
	QeXNZws0h4OMccDKU3CSvmveF5JHNAKA/C8HlPjHDGV65Ihz+0kmqX3gtPO+63/nlWtQIl1TT/i
	dBdZ2NpVzf6A4VRvoO//NAc9P/Q6WprC9eXA1v2ZWO4wl5YpXZ4AK9OIqsSfEBLIgXqfU4LL7F/
	QB+XW+EC5YE1kwRhbRi9V7n38ngag/HRIDGy77Z0dhAK2YziL+p5y93kF362sSHUpcXU+6ER8jZ
	eukz+I8f/bvBV/8W0dHH5mZKLTDfv3QVX0kr
X-Google-Smtp-Source: AGHT+IGc+dwu9EUcNrsBwPKQKnvaWdpbi5M7BeDPB1b/hfzq87dN1iZBojDWoe4F4XskixC0I1fVmw==
X-Received: by 2002:a17:907:97c8:b0:ac2:cdcb:1b39 with SMTP id a640c23a62f3a-ac3b7d946a6mr517067866b.19.1742455820315;
        Thu, 20 Mar 2025 00:30:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aef69sm1115638466b.4.2025.03.20.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:30:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Thu, 20 Mar 2025 09:29:45 +0200
Message-ID: <20250320072947.8174-1-clamor95@gmail.com>
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
Changes on switching from v4 to v5:
- revert schema to v3
- removed i2c_client from driver data
- removed max8971_supplied_to
- swapped power_supply_config filling .of_node with .fwnode
- attr group liked to power_supply_config
- added ABI properties description

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

 Documentation/ABI/testing/sysfs-class-power   |  43 +
 .../bindings/power/supply/maxim,max8971.yaml  |  68 ++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 750 ++++++++++++++++++
 5 files changed, 876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.43.0


