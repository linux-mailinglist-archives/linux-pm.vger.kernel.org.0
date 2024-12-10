Return-Path: <linux-pm+bounces-18896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E459EABE2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCF8164D48
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553B233D8A;
	Tue, 10 Dec 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6LHjU0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94D233D7A;
	Tue, 10 Dec 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822724; cv=none; b=qFatOC+uCEznLi3BhE1wQDvnNvYwVrvyJD61EYx0gCaEht5ZMryHxXkBF8BblyJ94D5j87vS5zedyfV7onbHb4hxsKhrzVHh0K2PH+sDLcEIKYl1wtDYAETPf7LSh6pd/4OphkMnIr2XV94AEZd0X2LXGu6ZfheiCgcbC1a1Qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822724; c=relaxed/simple;
	bh=U4EIJduUVU+AZu1bT10Rl02jbPPXAi6Xe1i11IgFCoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BDpT2gvUrYaiI4Ji5IZNKpOsMMeKS7uC628jqpkYUj4anwdKWhII8Xv5DOuJNhDaRqdPyjwiga1cJ3G6E8WnPcU9lLbyZhSZkNnRmXjGsDBDFoGB0dYccEt7q12L7a8jbBolz8o3ajSCrbnFVK1OPyTjwamZY+qVqRAYk4tYCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6LHjU0F; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6413fc7c5so524164466b.0;
        Tue, 10 Dec 2024 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822721; x=1734427521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eM2aY2jhSfrimDAy8nlYTfo5e6PgwQ/aXGIc2H8RXPo=;
        b=L6LHjU0FUWoSqIWW463MvKLTW44bAgqwupecpZ9kUQYHgZYlzGZ2G1ApIPd9WcZHNF
         dW1tvD1JiWlfLmqoZ4OovsIHSs4i6Iridxfh6j1VnwgG3JUfioJtyYxGlef6qB8VBhPp
         Cx+CfVTRZZ6JWATQ8q1bmAH36yZBgZSUuIkTjJrzZ+G031/jvCTJuHjVAGsA02Ffd3b+
         PKLgzLiXJV0XyLiUP9dA2fcFU0rliw60RVXzl3MVL45E2EaAXLZIGp6N8Wsz9/JfgaoY
         XyY/Uz7OszmPqWVNVyePwK8fqjSH0h52s/wbGDS1ocjHiE+9WIAOoKaGjYsTJHYPCGlO
         bgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822721; x=1734427521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eM2aY2jhSfrimDAy8nlYTfo5e6PgwQ/aXGIc2H8RXPo=;
        b=kBZHl2Unv91VVIRF+iwy3IXulyBScJbxBuA3WYbtemDDJgXGyI5krPSWctQUHUgMTN
         fZTKxAkWlln7vzv5TwYnOZGCqSXLulg+VGC6Mxyv+k7rzJHdcwiXEm7e/x64S5XWG/Q5
         sN9VoSF7R6THgZI3PftxseKF6J1bmyh8ZlqjKn16yjF/IXHV+A16Zyyb2iE8PsiaS5HM
         3Q19aCKY9/NCBW6iuztHdySbnayNtQKud2C0GYqfd5PYgF2KN0bofxkhbBbEy/JTm5O8
         ht/aHDc/C/iDKkb5bVZeR7POb8/lVTAQoZYFdkDRXc4ZE0NXhCGMHGV6/u20O1tglJiH
         DxLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0/pkp+lIS78R9fJfoqJGsD6qJjUBNkY1wXcmaKf+zuYc6+ArwNXqWTzPCxlqOyqFsfAyWWbQJvTA=@vger.kernel.org, AJvYcCUGRJbOlf68Eux4p7cvrwT1v7KPUOBleKnlx/ywy1RwMWXY4AxumwIM67kQF57SxA5Etl/hVb2/TEHI@vger.kernel.org, AJvYcCWBfhv4+D5LZUqIpH/Q2+dm4jpJTYa+kKxxA2YS2nw8w60vPQCO0EGxO0vfGvrIC9klT1mNL/W0Vz4LgDzR@vger.kernel.org
X-Gm-Message-State: AOJu0YyEx0Avj3nukb/2XYysGKA+6hk3gWF0EmmqBdOwkAyVlb0jqLty
	QORqcfWJnBQYpbgeSgwxTxFsfettMxj6vxynCDkpF/v+751YopSu
X-Gm-Gg: ASbGncsRvGbuEqgzbnp+bfBB4bQ1fZNL+hg1jhwsEABJmShlezur84fdVq1VGESQljF
	HTxu7r7wlj0awjkQdH/V1MFpYSZSKmOgAZfuAFSlD+wgIFiReF6YUrfLCKcYrndkFM+KvEyyI00
	kM7xdYr82majbXVQtoIQwdn8YvqR5NWxil/AjyHXFi1sRgQftkG7PPrFtcn5wE7rpICqZXHy6K1
	GSus0qABBaMC6ZAsjMWyzAJ58YPWjcsAzesIEGBdISpnwxC16SdL5k2ATGUkjNPzliCx+hCzCZX
	b9HoezQ=
X-Google-Smtp-Source: AGHT+IHEQM19BfQF/lOFgKzNDopfEPFPaCxM8uKvUeAbQ00HxI70ZFCiAZYyARi3xHbuM3EzCkVukw==
X-Received: by 2002:a05:6402:35d3:b0:5d0:d3eb:a78f with SMTP id 4fb4d7f45d1cf-5d4183c5564mr9697753a12.0.1733822721407;
        Tue, 10 Dec 2024 01:25:21 -0800 (PST)
Received: from stefan.beckhoff.com ([195.226.174.194])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa6260e2c31sm817095166b.180.2024.12.10.01.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:25:21 -0800 (PST)
From: Stefan Raufhake <raufhakestefan@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: s.raufhake@beckhoff.com,
	s.dirkwinkel@beckhoff.com,
	Stefan Raufhake <s.raufhake@beckhoff.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 0/1] power: supply: gpio-charger: Support to disable charger
Date: Tue, 10 Dec 2024 09:23:42 +0000
Message-Id: <20241210092343.3537-1-raufhakestefan@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Raufhake <s.raufhake@beckhoff.de>

Hello,
We have a device with a simple built-in UPS, which
is controlled by GPIOs. For the control of the UPS,
we used the “gpio-charger” driver module from the
power-supply. For our usecase we want to support 
enabing and disabling the ups. When the UPS is 
disabled, the device turns off immediately if the
supply power is switched off. When the UPS is
enabled, the device has power as long as the UPS
has enough energy for the device. Now, we are
looking for the best way to implement this
function. This patch contains our first proposal.

Changes since v1:
=================

- Rework of the commit message
- Changed the property name from "charge-disable-gpios" to "enable-gpios".
- Inverted the logic of charge_type to 0 = disable and 1 = enable for the 
charger.


Stefan Raufhake (1):
  power: supply: gpio-charger: Support to disable charger

 .../bindings/power/supply/gpio-charger.yaml   |  6 +++
 drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
 2 files changed, 49 insertions(+)

-- 
2.25.1


