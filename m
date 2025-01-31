Return-Path: <linux-pm+bounces-21193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746DA24597
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924647A23B2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2025 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD11B414A;
	Fri, 31 Jan 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KILOcC0G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428815575D;
	Fri, 31 Jan 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365443; cv=none; b=t47HFI3v3izt8Qv6rED0ghmZ0sVzQEuP5UL12kJp099g6iahC/+qL6gxPBCMUy0LACwGIdd9HVlKsG5iNEVUdcrFBf+zqEoxg/doR0rdzm6RxgAZnavUWmvlsJ2j84BK1X8Zn8i6Cg6872WWQo9YnLa9szdQy4l1w3dtOtHgV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365443; c=relaxed/simple;
	bh=YapN2yvZIwdswNXYbi1VrbhQHoJ9NYwGj54en8q3GcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCbO1UCEhlknchWSOt3wXnbzW/+oNCXzxVeBguzPu2w0xHbL+Khic1f6Sh5s43VN19JJwrxG8WERCNE7Mh5R7nYYudRn46SuF0B00nC5iz+wJfOG9d6ENyxbEMFZHq3BmTJyYYplRLosQdg0DOVfeZAbwcCWDYfiRnuuX6bOr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KILOcC0G; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb87127854so613631b6e.2;
        Fri, 31 Jan 2025 15:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738365441; x=1738970241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0ZMs3D/azII+yrcqeVKwM8wsWt4qgAa1Wy8fUSpJ8=;
        b=KILOcC0GuDdt2CkVmYAm2BJ9jfbhVKUgjwvJiiryuv04H6gBat3JSRt7gCjWCbe6uy
         Qb24J0ggxkj7vcKkDtzdN+ihDWU/jQv6u8qreYL/VMLD+5y+DEqZqPly8CMTgrYvX3rT
         uQDuZiF+WsMqi0kHWJvou5TpqGSFGwcRkIFh8N91QfzZ7HH/SffoAqSv1923c7zsMOOj
         mLMqKuXx5TGCsTrMqH58f6b933Ka5ukicLxybbC6l6+F8J50/kVSDfdglN81ElMyD+dJ
         DJ/WfamrsVqOiiRDfKznD8qzy1wp7d8wA8EhN0QRWpeQ6rT6zmwv0H1YWgE1QyhDVyTS
         G7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738365441; x=1738970241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yA0ZMs3D/azII+yrcqeVKwM8wsWt4qgAa1Wy8fUSpJ8=;
        b=LIvm+GZKRZhSsWILVuszmIPEGkf0tIE3aqmns6Hu8oxKm/oUXZ3n0LbVBYCSEZnI0p
         IArLoDBYs4RIZ+BlTb+m24gviImMq2A6r2OqdIXEOQWHzKkumPQ8Dw89L2jsemqccDSP
         iyqFfCR8erM/8qdLdGt2yKH1mB+LJZxA65oYL4qlN2jrQDBREnLnCn1+6jbSo1uLZZLq
         41gSUpxVHrE7vprBs2AsJKECHMtK92/g8udI/xf8pH8P2VVi8dlv8r9+OHRhj4YsEkc1
         vAyQfZquC9meckDdgHXIcbb2gZ8q5xki2XI5Ysg/1q5xjQPTVlRug5nknno5sF642s7I
         Sk6A==
X-Forwarded-Encrypted: i=1; AJvYcCU3iUPUf0wSiU/rYkSNzmj9Y7/9yEEkNbfqOg9FMLF79FzTpBGuM1TQbW2bwqeZG00a69wmuOIauQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XSLhvLhjA5Uh9W6ll6gjuYZlo3koGranQw05hNsx8zsJRQwW
	mYFk9x9SN8IDgRYFOyPWQUQtZCqsguYlABB3Nrq+YXoqig7CWJzN
X-Gm-Gg: ASbGncuPmOEHjT8i8z/+5f/o89VueH9TuHpgki3FETcx38Eex9SSIG0OLVtFo/qeVq8
	8H1iDDu9QYYhSJZH6duWjbDrYQo1/kWXeM6E/1XaH/5AlvnoYv3K/f9zAUf2jKn4AQ/yoVI9eHw
	yRyigmha2noRpQx5KUjgRX61EhiRZG8GjjCFZpEBDL7+I8HNabS/6IiRNLT3xZTmqcF+ENUC2NV
	HET8RjBj5fnX0uu0tlGgcDAS3ZjWylT1oxsMpvV+1RdXv16ODybXLUKQuPeW4sK0GPvpMa14U7Q
	KE/n7QDZxXaNPVGxHG62EigE8gBbIFSfHn4=
X-Google-Smtp-Source: AGHT+IF5zsoG/jawq548wfM27QRPX4FYVr58VStU1xLHndeakk40y9CTMujkL8ITr+DZKnbHxokUnA==
X-Received: by 2002:a05:6808:3197:b0:3e6:3867:d107 with SMTP id 5614622812f47-3f323a158e3mr10821535b6e.7.1738365440973;
        Fri, 31 Jan 2025 15:17:20 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d061:e6e5:c6da:b514])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33365bf31sm1099128b6e.34.2025.01.31.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 15:17:20 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/5] Fix RG35XX Battery Charging Issues
Date: Fri, 31 Jan 2025 17:14:50 -0600
Message-ID: <20250131231455.153447-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The Anbernic RG35XX devices sometimes fail to charge when the register
for the battery temperature sensor is set to the incorrect value either
by user error or an incorrectly programmed efuse. Allow users to
hard-code if a temperature sensor is not present (which is the case for
all Anbernic RGxx series devices) to prevent this issue from causing
problems. Additionally, a bug was identified with the handling of PMU
faults while this fix was being tested.

Chris Morgan (5):
  power: supply: axp20x_battery: Fix fault handling for AXP717
  dt-bindings: power: supply: axp20x-battery: Add x-powers,no-thermistor
  mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
  power: supply: axp20x_battery: Update temp sensor for AXP717 from
    device tree
  arm64: dts: allwinner: rg35xx: Add no-thermistor property for battery

 .../x-powers,axp20x-battery-power-supply.yaml | 22 ++++++--
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  1 +
 drivers/mfd/axp20x.c                          |  2 +-
 drivers/power/supply/axp20x_battery.c         | 50 +++++++++++++------
 include/linux/mfd/axp20x.h                    |  1 +
 5 files changed, 56 insertions(+), 20 deletions(-)

-- 
2.43.0


