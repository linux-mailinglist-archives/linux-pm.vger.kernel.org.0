Return-Path: <linux-pm+bounces-34949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61109B83623
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B243D1C26FB0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E252EE61D;
	Thu, 18 Sep 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="NRIxXyCQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC692ED845;
	Thu, 18 Sep 2025 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181532; cv=none; b=HOtsiIQSsBtLw3NMqj3KgClvAFBAH8hn5EI9xeojs+rkQHKbS7E5mHj5zvZB2FODrTVlQZfduIbMmwz4LRvQbF09bCyj5RKa3OwTN8S20rJOqldJqSw9jU6YYUblyXVgdw6yQH4NbcM3X8PSZGJyhwRE7rZpBRlfGTOd7TDF7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181532; c=relaxed/simple;
	bh=/tS5VN8wqJ0W6f79Uht7zyfEMcAvhg6Jn1SC8qgkuXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2GDXLg/OkmTeTAN307SHMG1RhqyKBRpMVd3svfF3RkJGz8m2+3qf7RCswV4sAiXkBiaiC6iRCzkLd/j/U7Sbmn942ioHsgddt1egmuqLyU1ppF3hcoL7FNElj/pReCKRjF3HWRe10sfxtYb/dECMU0/gSGl+7XbzFCMdefUfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=NRIxXyCQ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3q5kiib1kd62l3L+MK1D9QnKWb3L2UjvT/k4OiP6KHs=; b=NRIxXyCQ/HBB+lrJkjGwh/Qi9J
	Sl0pV0V5oZq0UHi+HfnP13h/14EDB8P3j/FyyCVW4nVCOrJ68XUG6WFPHD9InvseSbT+883rRFWVH
	1q6iJuMziXBJsUFdb27E0QnqY3kmeyJGlEaWKH/rmRxidgs31XscnjS6swajgzWGfHpfJJbbpQR21
	+iHlTbO/fT4dURmjPaXpu8Xa0Uec0Zpvz2Cw645XeDTlodQxE/xnML/FiRmHvd8b54q9B7lMhVkYT
	gdYcW+k6bviIvRL+Hnez3MJKb7NxJcPHzzTj+w985P6l2V4WC4yPxMyUpx3eJ5tGYa2F7j6G8SScF
	663V4NSQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 18 Sep 2025 09:45:11 +0200
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for BD71828 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-bd71828-charger-v5-3-851164839c28@kemnade.info>
References: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
In-Reply-To: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=/tS5VN8wqJ0W6f79Uht7zyfEMcAvhg6Jn1SC8qgkuXk=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmnd0xunaLH6fnQrt/t8MLU2RF563fNfiXExaJjmfhIy
 LBr25HIjlIWBjEuBlkxRZZf1gpun1Se5QZPjbCHmcPKBDKEgYtTACaifo6R4fXuupATM//ZVtTs
 +ujvIOGrk3oiZJvU3MJgvUa7ef1fOxn+J8SYHAzZtKH+BV/8JX/ddfubF0h1eAcaSm6QCLl1x4u
 NCwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add an entry for BD71828 charger driver.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45..044eb41ba4797 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21848,6 +21848,12 @@ L:	linux-serial@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/tty/serial/rp2.*
 
+ROHM BD71828 CHARGER
+M:	Andreas Kemnade <andreas@kemnade.info>
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
+F:	drivers/power/supply/bd71828-charger.c
+
 ROHM BD79703 DAC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Supported

-- 
2.47.3


