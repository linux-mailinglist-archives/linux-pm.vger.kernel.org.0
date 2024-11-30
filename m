Return-Path: <linux-pm+bounces-18298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B69DF201
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 17:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0372815B9
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217F51A0BC3;
	Sat, 30 Nov 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUKbfdKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A681E884;
	Sat, 30 Nov 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984786; cv=none; b=KQm5xR2OvEi6AmcBxf1XgEAGVUiP3A4Ra72qsvMao9aCAdvZDPOnKDROR8A3Eborv/xEdHGZppBtRQH7b4cxVzKlS/HWvOrNxF6INkKrLcjMzZr29yyhmM7Vcz3qd4T+HIgg7HQfN57KT2lfI2VQEUwO1xjTmKIxEW8QrIBsJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984786; c=relaxed/simple;
	bh=z9VgMMlrXrwpeyfCx0LOGtyGUR0KGzavwtDxSs8pzsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NIKwSQLiob9jVaY6zrKcoSjTtn19ilZ/u02hU3qDgHA6xO6hD8DGJxuP5353rksUXPMZkyStCYDC2SBaT9mHc9tNkybp+7OZqp9ROtOaYCUqr1l1JBgIWNfPXQIXLcZkzY0Dv375bXW2Z0Y1i3TYvdr4DhwIihQvr6zqD6XbkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUKbfdKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C04C4CECC;
	Sat, 30 Nov 2024 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732984785;
	bh=z9VgMMlrXrwpeyfCx0LOGtyGUR0KGzavwtDxSs8pzsw=;
	h=From:Subject:Date:To:Cc:From;
	b=sUKbfdKD6OIXi2gRoLBVqMb5VBkbePkNJujGyPQTgjxfSW+KOvy2OZnsbYBq7uvBd
	 wINHsbSnAI7S4VwFPZofWeXqtULQTDEBAh+POSXKNnM99mQ5wYv6HR5R/Q3/q+Bzmg
	 kVJJJKqLS9amm8mu0te2iU52lGX4HmrhJ99qEvFIJm6gVaWOL1mTlJ3rJYVZlM7wlc
	 WHok9k9fEfqI2pTpAUciEx+51lG1PQIrR5whrf73M7E0ElOO/Yic5hflteAtouxjqx
	 aQuzxG6zJVb3v4iFN0UjfYdCeZZVrNIus1EjHA736lTiuEsvsvNzZk6XAy01pUuPP2
	 bn5/QUrpkLwZQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/2] Allow naming pmdomain idle states
Date: Sat, 30 Nov 2024 17:39:35 +0100
Message-Id: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMg/S2cC/x2MUQqDMBAFryL73UA2SsFepZSwpM+6oFGSIILk7
 oZ+zsDMRRlJkenVXZRwaNYtNuBHR2GW+IPRb2Ny1g3MvTVl2zU0ucDnIgU+ygoD5jGIWPscQa3
 dEyY9/9/3p9YbuwnBfmcAAAA=
X-Change-ID: 20241130-topic-idle_state_name-e119caa0069e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732984781; l=852;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=z9VgMMlrXrwpeyfCx0LOGtyGUR0KGzavwtDxSs8pzsw=;
 b=oR2DJctsqm2BsXAhtzO60VneBOCl2yKAd7P2E/1xjuuDK94yOOSrZlVu55bUeVtGHey09UBM/
 yN59RDnzC3cB/aaq/NHyAGIa5s/i09Z23Xcxmh8QrKu9Ys6YrQ4lB2v
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Inspired by [1], add support for naming pmdomain idle states.
This only affects debugfs output.

[1] https://lore.kernel.org/linux-arm-msm/20241014161631.1527918-2-robh@kernel.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (2):
      dt-bindings: power: domain-idle-state: Allow idle-state-name
      pmdomain: core: Support naming idle states

 .../devicetree/bindings/power/domain-idle-state.yaml      |  5 +++++
 drivers/pmdomain/core.c                                   | 15 ++++++++++++---
 include/linux/pm_domain.h                                 |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241130-topic-idle_state_name-e119caa0069e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


