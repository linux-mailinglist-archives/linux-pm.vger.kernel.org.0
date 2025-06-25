Return-Path: <linux-pm+bounces-29529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1D7AE8C29
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508826808B6
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38192BEFEF;
	Wed, 25 Jun 2025 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WnSBn8xs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cciF9kMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83832D8DBA;
	Wed, 25 Jun 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875486; cv=none; b=cmnE1Futm3Xrui1shSKGOoEyMymCrrPfbp8luTA9b/yySvFEWqv8nN9NuJFHXbKFW/LyGG/heWmTzAFO5dX2/XDXJKlE10IWqw+pjUbRJaVMgMvyZPb2U6laFqmwjXhezH1PHpqRlQk81mYjkpLlptbPkuTlXbT4VUeFBaQgL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875486; c=relaxed/simple;
	bh=cZLL4NiFsrsSSBnb4+NpGnJuePtwb+1C2iKbj7qe5b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7Y8gXfHpiAiH+Q1vYN5KnyGFZzOOR4QQNtcpRgko2zfAEweKgAbecqX6ghN1CXklrhztPLG2hVKxWzZp8aPX6bdEaWVujq7xpw6VdTuj52kJVhqRaGb0dOK07cK6nccRLpjEyQtITeGrmDXjJqNLJvsBtFHJaWLJJ6V54sDMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WnSBn8xs; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cciF9kMc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bS96K4PS5z9tDb;
	Wed, 25 Jun 2025 20:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750875481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8FvA74DbAnH2SDacVZmUn+0xQLGYnmdcTF9cZgBY2I=;
	b=WnSBn8xs9FdZduqxmuQL5OYHcrNr5aVPrPRzQsZjotSTOrUwcQs6fGYR+b27Vf5vjOVtak
	sSztGye5C+f9N7ABVX2b9L7PyeGr7vHjEwtTJUryduXdV9sivTsznqAfVEGxfTWpYu2bkA
	Nhm4+ZOrWOKqbunkpt3tj/sErA7WXpc8U4AWQVS9CftzXvnX+OgVKjjIlV4VzhntbiZg41
	lJ28ff5vMfk79bbaGrUz8yy0CLj8xBUCcyH70z2Qgc2B1ig3b9yGhzuglHIKLoalmGZHxg
	EBzFFRsBFbBrwMRnIFJxfqBn55jhR55tHf3oQR6CRxsgCI0vgQANdMgcbGeYrA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750875479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i8FvA74DbAnH2SDacVZmUn+0xQLGYnmdcTF9cZgBY2I=;
	b=cciF9kMc14aJXEDqH5n1o8++KdVySVaEJazzrovjRrTCFyyRCa2Oke0+3skz1Id3dBMUIB
	mQ/lmPutQ/qB+xAmvWQBeVigeEIb3gVmDSLJhjvnW5KfwAkS0iqDWvoI9TqAm6j5QMO2uz
	0KdnV6XEKcR4N5x7BNyIMlv/FXdfK2kDMSVUmJb6yFYO1TTpghC/IetYgStagDhMUVOX6N
	9Y91MlIjvH5vByn/M6Ti1IkLrD10o78ahVQd1LFBpDlUfFsq0IRPynqmaQYR1HHeSoHoId
	MbWfhe1eru1HmIPxSVTrRULthPY/QMK/dDyoHNG3muxIaPKJgysB9Yrg8R+fBg==
To: linux-pm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: rcar_gen3: Add support for R-Car V4H default trim values
Date: Wed, 25 Jun 2025 20:16:58 +0200
Message-ID: <20250625181739.28391-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
References: <20250625181739.28391-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4n1foh97qgozcgqyyh3uuhghqq4ounaa
X-MBO-RS-ID: b9bb5bb80efd9419a50

Add default trimming values for the four temperature sensors located
in Renesas R-Car V4H Working Sample SoC. The trimming values are
identical for all four THS temperature sensors.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - :%s@\<rcar_gen3_thermal_fuse_default_info\>@rcar_gen3_thermal_fuse_default@g
    - Put rcar_gen3_thermal_fuse_default_info_v4h on single line
    - Add RB from Niklas
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 413b373523e4..01858e72f4e0 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -371,6 +371,16 @@ static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_defaul
 	},
 };
 
+static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_v4h = {
+	.ptat = { 3274, 2164, 985 },
+	.thcodes = { /* All four THS units share the same trimming */
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+		{ 3218, 2617, 1980 },
+	}
+};
+
 static const struct rcar_thermal_info rcar_m3w_thermal_info = {
 	.scale = 157,
 	.adj_below = -41,
@@ -395,6 +405,14 @@ static const struct rcar_thermal_info rcar_gen4_thermal_info = {
 	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_gen3,
 };
 
+static const struct rcar_thermal_info rcar_v4h_thermal_info = {
+	.scale = 167,
+	.adj_below = -41,
+	.adj_above = 126,
+	.fuses = &rcar_gen3_thermal_fuse_info_gen4,
+	.fuse_defaults = &rcar_gen3_thermal_fuse_default_info_v4h,
+};
+
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	{
 		.compatible = "renesas,r8a774a1-thermal",
@@ -438,7 +456,7 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	},
 	{
 		.compatible = "renesas,r8a779g0-thermal",
-		.data = &rcar_gen4_thermal_info,
+		.data = &rcar_v4h_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779h0-thermal",
-- 
2.47.2


