Return-Path: <linux-pm+bounces-27771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5DAC74D8
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858E3A20044
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF34C8EB;
	Thu, 29 May 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DXoPD5hg"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD4BA3D;
	Thu, 29 May 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477631; cv=none; b=XJ9kYwcHNHs4vVFF9cfRL+k32fNdjZW4TMRl0Lq9ME4JQrBUs0QKbCy+2ZN73Q0jgYL74/Ec0H6vVeqfUmnXXPn04ms0S1QVRnkGKvghtHGQpAQgywE0e4o3hh5EjND3eZuuzf7uYm7aNa8Sg/1PUuSpJnEX1dRmEz7gQ2gPJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477631; c=relaxed/simple;
	bh=VlFnpcsdHQxDHPb4oV6QFvxYxzGrchCWD4dTCtFa3zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRT/7axXf8HdQE7Ua8x1MY246zWw0vJ79JzIBEXQ7hWuGaDUmwsd+1+W7HUp5chtWg7G4cbEntECc8eInK1PFpCOFePbc3xgneeXgGeuu7Y3rHEpABe+gM1imbT7cH4rzGtEvqWJkFJBhkQqpebDB089B7ZggJw41PrSkHWUZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DXoPD5hg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zIN0s/km0iueisreKfHC8QMZpfiOoTcx08RjbxWkD0Y=; b=DXoPD5hgLwelEIuQ4fIw97hygH
	ZoKX+7N5qN1YGICpApEFIx7QxFeOJUZXsuCRHR7f9q4nf74YCl64VUqEJA4YrA3wWCSZgj+A/3R+0
	LOCmeBVl6p/vlprbmKNrGNHF2dXBqwkGG1RP6tZXvr45iMeDI1fL2lzmuEZvnXBC96INoFfrEriAP
	Y/6XHaNLB1fVOHjQIj6SKAUuSXVcqNoLp6i5hFwckhAx4ZTKv5dsyF1UanaZm4mCfV1r4CudaOa88
	JWwl9vG84Q0H+1HMsCYZ5ryQBOQvPRCFzaCr2F0TjQZVfAiYm953zbxfiWKoVrMczsjRJEFLJFXa4
	rJxRcPmQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQto-00EZvd-Uv; Thu, 29 May 2025 02:13:34 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 01/11] PM: EM: Add ENERGY_MODEL_NETLINK Kconfig.
Date: Thu, 29 May 2025 09:13:05 +0900
Message-ID: <20250529001315.233492-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a Kconfig, ENERGY_MODEL_NETLINK. That enables the netlink interface,
which allows a userspace program to read the energy model and receive
multicast events upon changes to the energy model.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 54a623680019..b45933370b4e 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -390,3 +390,13 @@ config ENERGY_MODEL
 	  The exact usage of the energy model is subsystem-dependent.
 
 	  If in doubt, say N.
+
+if ENERGY_MODEL
+
+config ENERGY_MODEL_NETLINK
+	bool "Energy Model netlink management"
+	depends on NET
+	help
+	  The energy model framework has a netlink interface to notify the
+	  changes in the energy model. It is recommended to enable the feature.
+endif
-- 
2.49.0


