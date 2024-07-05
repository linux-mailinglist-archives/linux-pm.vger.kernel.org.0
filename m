Return-Path: <linux-pm+bounces-10689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E1928794
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C691F218D2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE41494DF;
	Fri,  5 Jul 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnqZ032C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CF148FF3;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178008; cv=none; b=uTe+Fr2flgMl4+zVaaosg7oGKDnJrfj0gXqwOf15cqI5rawJcsnFIZjZcQZYqzoBwCZQwd9+8boEQSEF7PmmpPZu3SghR/gAbnNh9CN+uFW6x21tJxGZNPIxuZ08SYRKzpsh5mI7dMNcAJRzY1fK6D9Ea07Q7NXCRdKjacvtQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178008; c=relaxed/simple;
	bh=RqdSmw7cEjVnEde07wAs3Ofz+DufcwRJcjjwmoIh+DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAdzJukxNAlxAdjz8qXFp2BzbgsdqQ/7MqP8qXgHg1NuGVr22JtMvndmqmm0ItpsEBZy6T9ssfFupmD32dkn5SxJQ8kSTS6wllu9c5jG0oW3rk8qlh28J0pBTdoOINWJz0R8vCWQRowaosB2iSXRMNwRhAZQBlStjW9InQRZJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnqZ032C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7395BC4AF0E;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178008;
	bh=RqdSmw7cEjVnEde07wAs3Ofz+DufcwRJcjjwmoIh+DI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lnqZ032C/+hbYaWqvDGSW5IUziCA9s93uX/uoF4YSyVasbwWkpBREKDuj2j0nCsDF
	 Cpcruy+KTOGjKQlQOIO5H5iYZS0dQwv4e71HjOyDJFYg98NhbVbUGNHdoBLYLCQo33
	 XgOi5bT77b/6wYNRPN1hBzUdZzZfXIR7kwJ3XkB550nB3ZlxdHPfcGrRqG2YEpWX+q
	 G6Pj+MwvxEUwmOITgMW/GUaVFp0pU18wrOLt3WDPo98z0J2TiQ1oXx5HHe/4vRLSHd
	 tSiNs6FbZTGHZNQhbq20ZWh6PDToLlwIpWK1DTRBQz0u7ruSibR56aHo+KOAhnQQ/L
	 z8DrDFSySYNjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F12C3814E;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:13:27 +0800
Subject: [PATCH 3/3] MAINTAINERS: Add an entry for Amlogic WCN power
 sequence
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-pwrseq-v1-3-31829b47fc72@amlogic.com>
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
In-Reply-To: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178006; l=844;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=2LQ5HRplZ2LlSPyzOYDNeeV7S6poY56OZ7f06ODqzXY=;
 b=PCOpuH5dGrWwfCdZFsAqjetcT/FPX1SeagmqXMJ1KkeEskEll8W9pctua+mg06NS6v906tdIe
 ZHNfuK9mBtKAWpdnStmTqHBzAOQcsh5Bw3Gr2cb8ti1WB8p1+NCLIvG
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add an entry for Amlogic WCN power sequence.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcb37b635f2c..0773f7040341 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1174,6 +1174,14 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
+AMLOGIC WCN POWER SEQUENCING
+M:	Yang Li <yang.li@amlogic.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+W:	http://www.amlogic.com
+F:	Documentation/devicetree/bindings/power/amlogic,w1552-pwrseq.yaml
+F:	drivers/power/sequencing/pwrseq-aml-wcn.c
+
 AMPHENOL CHIPCAP 2 HUMIDITY-TEMPERATURE IIO DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.42.0



