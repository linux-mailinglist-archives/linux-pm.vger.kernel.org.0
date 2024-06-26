Return-Path: <linux-pm+bounces-10074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF668919921
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 22:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947251F2292D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A985193060;
	Wed, 26 Jun 2024 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="FIJoORs0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.mainlining.org (static.95.144.75.5.clients.your-server.de [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BD819;
	Wed, 26 Jun 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434118; cv=none; b=QGaMdOJMSOIxf4hPuYsa0j/cGq6GTuDdEMhcYCXn+FVy8qq+HChz66cUZ49TcwsNtuGHyhmBrq7CIiU5zrVA/U7C4xiEinIlA5iNLS6TWKft4u0Ff9TteGQHKvt5ThCjAFRRlTgUxcihVQ+rc2P6aqqUwaBJLjK8dc8HCIUDynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434118; c=relaxed/simple;
	bh=lu0PtAyJ0VKwwc0NkFcFrhNvN8zzdvukCUljP7WfRwk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uwc/IUwNmZnLkJUSw+hbqfCIF5WQlKFXkMZ3q0qFTyPXfcswy0Yrm7xg+p1wNsNUdg4FB49av2LQJaySVoCzqQMDQUd0iodVggfsuWNw4914Sm3Vv0sb5KfWi4H7MoatQCzblQY6WwudUoLwPkpMptUulOHn49gepO1of6UkeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=FIJoORs0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2492F3.dsl.pool.telekom.hu [188.36.146.243])
	by mail.mainlining.org (Postfix) with ESMTPSA id B2EE2DAC33;
	Wed, 26 Jun 2024 20:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1719434113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqtKWVhdNxshkAA7AeaQA+nX3zhqTHZeoFWrw6q+lyU=;
	b=FIJoORs0Z6NSh1adS/M16P3Y7tlhgYOhOaXfFQPBKY2g2fbYsPQ0jVtHpX0D1bT+Hp4OPq
	c+agRW5hawSxwnaOpWKHszJOCqrO0txJADCScBBZH4riKNmO0BAhPmqAYR+WrzopjisMJI
	yslomVPPuim6VY3/NBPFWOTuEm7Jh4HHzCafmqaM/+g46/+6y3QMYoBqYtpQRj2C7zbptP
	v2aiOc9hadGFtkqv1kliP8kwdlqBdDPXjd8ZIxQKdO+OYPTFs+1Ad0jha0iVVs1sGZikoI
	K4hvjdI6Lde2H1C86E00Vs/jet0wzngVM8BAVkkciF2r1GqsfN5XInQQ5+ixvA==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH 0/2] Add interconnect driver for MSM8953/SDM450/SDM632
Date: Wed, 26 Jun 2024 22:35:00 +0200
Message-Id: <20240626-msm8953-interconnect-v1-0-eeb31a2231b0@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHR7fGYC/x3MQQ5AMBBG4avIrDWpUsFVxIL6MQtD2kYk4u4ay
 2/x3kMBnhGoyx7yuDjwIQlFnpHbRlmheE4mo02la2PVHvamtaViifDuEIGLCrp0FSbTzNpSSk+
 Phe9/2w/v+wGUEdYfZgAAAA==
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.14.0

This patch series add interconnect driver for MSM8953/SDM450/SDM632
based devices.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Vladimir Lypak (2):
      dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC
      interconnect: qcom: Add MSM8953 driver

 .../bindings/interconnect/qcom,msm8953.yaml        |  100 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/msm8953.c                | 1331 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8953.h    |   93 ++
 5 files changed, 1535 insertions(+)
---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240625-msm8953-interconnect-e03c4eb28d05

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


