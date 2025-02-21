Return-Path: <linux-pm+bounces-22612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD1A3F143
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0024E18992F0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590F204F90;
	Fri, 21 Feb 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqiL4e0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624092046A6;
	Fri, 21 Feb 2025 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132008; cv=none; b=WAZiHZdGjbYIEOtiDFuJmP5u5TCH4vMU+UbiAP4FrXyIJODafkIGhhSXAs3/pyNwO2B1J7WuOcAwww/VbCAip6bOpfOnk/VxuTYioBCGxzWSy3bchPT+lMIugkxvm43xH/l020YS38C/gDKl1c2ch1RNnlSh/JiC3X2Qt5Ldl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132008; c=relaxed/simple;
	bh=Se+ktXeGp1G/eESkOhJ3QXv058/3RbGnqgzXQHPUT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBaPI3ytjYDGo/RPsj0F2Ms8MPZ7Be0Q3Wme2XkfsP63Ya8Z7InfZhWoHQoRlP4Aq66VprBiUqMrjVg09xrbLgVt1UZ9StRSX5mMu0/bPDjp7gkcENt4aUqmTOD0EddvYlCwyp/zooRl+lZEWzYL6Dr0DRP9ziWI77kbo1ZRHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqiL4e0x; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-543e47e93a3so2189704e87.2;
        Fri, 21 Feb 2025 02:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132003; x=1740736803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLVwB+GU8xfxQzzItDC5z6HQk73kuURkW63I+L7hNAs=;
        b=EqiL4e0xNPSarXirmwAXg5TU3LXLNn4E7M4LfmZwd8uwKY3sXR++47o9/Qz/4HOpr6
         9Rt7ZwNgvUR4tv38pSTBS3IECgm2kHmS52OUWpHkqQtHlPFa4QjnfIqGztfjqM6PoWV5
         AKaZRthqbg9MZXN5il4UGf55290wq2/uQvivgcjbebCUX/WlQ5unzmiEV1yIGkBvclou
         aLzlRgwJ7+ZRCCjXKovYWDLpnXMKIab9GuSDNnvE0QshDL0oaZLWC7lcplILY/yIHWqL
         DRdNa/FnRKc3EFp4QImIaAwWTEURrRDu7BvS1nuF7aLISjUPwHPhd04WVmZkPuZm4Ed5
         /jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132003; x=1740736803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLVwB+GU8xfxQzzItDC5z6HQk73kuURkW63I+L7hNAs=;
        b=OaL2ofhnT2Z3RWndZd+xMH7udS012AJOdBLHb1Zt/X7D6uVYjVbmKnxqPdpiX+16Pl
         56mgMH6kyIipFt0Ke2K9tYuBvffcQvC7tTQoubOxNwFOeAMYBZTvr7qsW6zK2Wi32xc3
         C7PAq07ENxg6GMV+OgoCGmgTOT34xoK8IysvcwpPs/Oaa5zx+HCb0GoM6lUsEwXfV+So
         020x+buhNnrFtQEX+3eGYKjB797XCui7Fe7iSg4/eLqux+VjkDmLiFoaEcDoCb0uR//x
         RUQE0a1Vb2y9VU6dYZ02En6NZjqs2b8vw9LU0oYBS84eCCdNFu6nkc0BgFVCpuJA4oFe
         fu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWZwQTEYjItkQTJLVsxiuPMkTG40kJTNi5dhEvQkaZw0K6knrTlcaTC1lockNAm89+kX6z1sAoQ+nt8ZOsh@vger.kernel.org, AJvYcCXTdrbEsATtnYcJVwCWuFf89Kr1mnAi8PcUH/SJwosutqHWfYZEzm+8RaxnWEiDElrTiEu0YhclQyOp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6WeYUTZYDx4Lt1egs6+TxneykfTzJt+qZkr92BPTJZe+s8Le
	j5O5c7YxggrX9pJ6SHJB8oBzG0fUChWGU4SpAkbi/tLiBm52HCAs
X-Gm-Gg: ASbGncuokLW4RehPmztatQ/6Lh95RjLqve8y9j9M8LelRYYONUAXdpHX8IbhqI8qFGF
	sQ8Yo3LF/99SqZ+4XMNnozJ25YOXHSLUAGgxhU8B7CfXl52SHiagFPX181SrKLLWkcfy/LJh6qO
	J1Alp97hN3Z7FUCFHVDzor1vcl5biaQh3+/KyM6r11SiPTL+bOCk3rr3pX9qcMXFIA/I/p4vIhe
	cg5F/ib6yXrIYWKQDtN19SnePkmQ5dmUO6Uf3ubzRnzJi7i9wBbf42Uo4++uDvte4wf+qQEIbiW
	Y1iY8CEX6YbEWj6b8Q==
X-Google-Smtp-Source: AGHT+IErZdCZmqT/hVmV9VGsyyRFvsLHJ5ZEyrPE/KSJnPfmO0ICWRGIiXwTWZAc0VGXA+jxodYyMQ==
X-Received: by 2002:a05:6512:3c99:b0:545:944:aaf4 with SMTP id 2adb3069b0e04-54839129a67mr913108e87.11.1740132003083;
        Fri, 21 Feb 2025 02:00:03 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461eb04602sm1604805e87.68.2025.02.21.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:00:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Fri, 21 Feb 2025 11:59:41 +0200
Message-ID: <20250221095943.57297-1-clamor95@gmail.com>
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

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: Document Maxim MAX8971 charger
  power: supply: Add support for Maxim MAX8971 charger

 .../bindings/power/supply/maxim,max8971.yaml  | 133 ++++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 685 ++++++++++++++++++
 4 files changed, 833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.43.0


