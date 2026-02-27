Return-Path: <linux-pm+bounces-43284-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDSAM69EoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43284-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A011B3B64
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519B53081BC6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427E36BCC2;
	Fri, 27 Feb 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNiBz3Zs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430612BCF45
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176514; cv=none; b=tdLknF+54kZQw4S2eY3T/UV2p7eMs9vfNvJcvAJa1dLlAJSMyXd7IQkfgJAgAoR4ns8zfDFijZpS1k79QgomsyH81nfiFwjv9dk05h/mEbQNYj4SKuXG0dSWKUSFXoqS99aSU4CupPF19+hVSOrst756v44rKRJjD+eH/EAoMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176514; c=relaxed/simple;
	bh=kKTFsrTeIjXnchyGp8SnByWTExbxMZ64ELwHVKAY21w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0PCQDSRJCoN5HlCkNyx8FDBZ73JaFUP4TD1Z91jQkbcGJsGTOjeh2B+JNHYyVTL25+DEuXTWOdGotfCD8kQpPFLVZM6vs4e8QcKu7ow8wV5U6TxSR//aw+KT7/XUz+B8zc+3bv/o20svDLOvhA3l6qxEuYZbabHDiV5LzlbEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNiBz3Zs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso151937966b.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176512; x=1772781312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgWrxE7EqiAv9jTaPHb4K7l0finKeYTH/5fyrp1MuBs=;
        b=MNiBz3ZsEz5m0XB6z+gNEwBaouhEYxxPTMXoRms2jrx4ii2ut+FA1wxTKTXHqM/yr7
         V6+Ti8T64ROmvhxNSEGnNoZyaYtXwfM0jVRJMAyyAHqE2P6bkWE9kJuXD/phzx/V37Ew
         fe8tpYsppZmxkjGqmfzdUhoDmnRjvNZ5+zLWl2M3JhPdac+XJA02YLCDT6TL2rzPinbY
         8q9toIDcV1d/JUmySxmerMrqdvp9KishpVtjiv0HoS+j3B6CxtyUkL7UkjuEVene08kd
         Vbgf78SYs5SLTP0zplHz8qDKkTkHi9YVT8UOtQAi//qMm1CVSDp7GmM1Wt+VfWDuRdrU
         6ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176512; x=1772781312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgWrxE7EqiAv9jTaPHb4K7l0finKeYTH/5fyrp1MuBs=;
        b=plzJWVJTzCnOHUS+BU1vVMa+yaw9l+XWebww/4HziEpAEWbxtLqH1uJPYBEqX8Qsqj
         2aE9RWgaYINnb3pwlY0Gh4uzbtPpacJvVpeG7zFfNB8jXe93xWeX/OEVETcw8T13Tgdi
         6NjNTf/5yWm76xBfyyvxJOnwLReGwJIueinLMsn3PNVPlKX5MpWuaCcOysCyhXVteJqc
         0zKTdvPUetvTXajQ+6jSOIVx7G3AwR6Reg2M+/qKQUvyXiY7ZscJ7bQbC3ElK0Zw3E9M
         d1qou+7uKh3owDHillNvR4/WKahhlMgjZC9hcUQe88GcOlXNoI6xHT80j01SyBI5QhTt
         TQ4g==
X-Forwarded-Encrypted: i=1; AJvYcCW5BcjK3mUbvV6D9BCb3kfecIkr5PJ72RC+xu7gnO4Rti0XNhxjFRSkK6Yi2Lylk0Bn+GOp9D4vMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUEF1W1f7bJEJas30a6N27E0ELTp1kP7nCnOISnAsPEb1Xwki
	XPIGbhKCTHSSBIz6V8LxB6g6oMqU5fZkojT0/eekQLfPmZgSA6ctNftcNXhSrPYttzM=
X-Gm-Gg: ATEYQzwF8j7MRsWxtJRiK408LKjr9aBQmCKWCYWARR783QFwySr8XTlhqD5PuAUroU9
	IKrDdyQbEckbRtjyNYAcvje3CE8t6ga/59aZqMz2HAeTszIw3tyVmLiPhnI1Wf2SRXTJVhhEG8i
	NFxrjJlvol7S19mYohHUUpwBbtmlXaHBk0woI1WaSIV8os4mATeT3qYbgRVEQkGuNx31ot7dNsy
	DrXCc61X6PfMsZ/Xull+ALbyZhcrIlVfWP2CWdf6oplcfj1cA4CsHhcgbx0ZuBWuR0e220hBKXk
	mydA3h6WTvcayL0vEJEkIlYdvJkyQ0+XvXvQl4pxIbHclqBvH7eeaX3ZUsQ03Hd16lTxGkPg9cg
	TR89cjzmqBhJKJE9cLUeGn8+OZbAr0sUKi+KzBFcjvoLmNiF8+xwPu8aZQmIDjhRroePmY/nmVW
	chPzDJ8lhXSqsbGSrAXjawgyVrNSRKjJ0763yZNDhAyhDYXSr00cEYoExUencBRbxmKftHSBg9G
	nOp/zjWESvzGfZQig==
X-Received: by 2002:a17:906:fd84:b0:b87:3168:2ccc with SMTP id a640c23a62f3a-b93764ba217mr89539266b.39.1772176511547;
        Thu, 26 Feb 2026 23:15:11 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:11 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:09 +0000
Subject: [PATCH v2 04/11] power: supply: max17042: fix a comment typo (then
 -> than)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-4-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43284-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59A011B3B64
X-Rspamd-Action: no action

Fix this trivial typo where than should be used instead of then.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..07759d4fdc37 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -131,7 +131,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	 * FullCAP to match RepCap when it detects end of charging.
 	 *
 	 * When this cycle the battery gets charged to a higher (calculated)
-	 * capacity then the previous cycle then FullCAP will get updated
+	 * capacity than the previous cycle then FullCAP will get updated
 	 * continuously once end-of-charge detection kicks in, so allow the
 	 * 2 to differ a bit.
 	 */

-- 
2.53.0.473.g4a7958ca14-goog


