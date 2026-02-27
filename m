Return-Path: <linux-pm+bounces-43288-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI5mF/9EoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43288-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:17:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1791B3BCE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2CDE315D536
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0A38B7AE;
	Fri, 27 Feb 2026 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjawdX1s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03E36BCED
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176517; cv=none; b=rnTU7LsbE48ubmhfCUr4Hrlc9TpLH6DbtqHftWYG238Jld+ZlJsQOhfO/pIskzdNkU6EwZCEApBCiBC7Uo3zvCMsGTqbTWb6SP1cJkx4w/WNFATqYYmFT8GhQmJD8NZ2rcZz2fhqSEhSHRmuWK+kztgM0STqz7EIdmeW5jq+Wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176517; c=relaxed/simple;
	bh=wVYvUIvThmeYxK9y1dkxq/j7c+TyFXalQgUYZy7JXWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdMFRtRa47egtTiPKCaap2/b9PEt/7zjQR/ATcasyssZV/r6adZ2DeI0XkjXJKNnajqc/6fHzp/qeJRUVtSumoP5V1fi8nXfPn2axty0iJvddjQfBIaZMx9Hi76Sy7iWK+lDqyLBN7cp498U+N7HqEbGzBAxYfux7EeT2W9d/xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjawdX1s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936505e7a0so174742466b.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176514; x=1772781314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxP6griohT9HSxEeETfyibe+6CSx5ahGktEAwrsPHxE=;
        b=VjawdX1s8rgx96og/2Qb/OfG4aWnjM0am6JvuNJ+nDB52EgZXQazHHVECz3+/vC5xQ
         la7OLFlp2K9o21MoltWNEb+jYPSZGv8XIQFauOxTYPlty5LiHYUpoHsAB9VFsE0xiwXu
         HEI2XHBKET7SrHf/FfEaWXj+ha4KU09By95W+1xSD0F9qgjTX2DE60klfcUyuqmQRK33
         2+z+HL7OIPbvOZ9xXqz8F/tp1WDddQdYCfSe0GvwuR9OgKt3kQ/NjQlyqi9JX3dFdi08
         h+LYa0LEcvhK398t1qru8N9oaITGjuQiv/Ry9bsrBRM6GU0m56Jk5vI4J7/TjzdiAb5H
         KyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176514; x=1772781314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kxP6griohT9HSxEeETfyibe+6CSx5ahGktEAwrsPHxE=;
        b=D8s2Sjza/bPFrz0dx+e/3k4EC5UgB9d/1nM1Ly57HoceFf9VdME9sXcF2oVMH8fIC9
         8O3AFXmfzO7Q6tnataqf+IVbXEnBrkG36hlQImUK2b57fRW8dt9YU6OgLRBGCbZMN2jk
         2GHCHfEqVpTwCzccddI8uYWdXV6IsailW0LjNsSpF9ZcpgL96AiDEDWT5ZWNj1aHR5z/
         cin6a4G46WNAliSAs9ycVBfKp0lB0/qi5/WdB8NN5im+f+qdg9GDRw3OERouQ4TrRr/O
         p2jQwYa9CCkPFg/8nQYRe7KH9dx6X9pVeWWvPqz3yDejmbeWEy0B0OaTV0Os4lKFhIaj
         Oh2g==
X-Forwarded-Encrypted: i=1; AJvYcCXwtMybzbL81uzYT4vz9DMa6zH0ZgHdsURULKEKA/7eoJ8NcM/xeZp23DRQKLe1taQYIh8f0pQqOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+Rlx/pwAjYowKcS0xgoL9kewR11Ks7TmnzbzDz/2ZGMoEBpC
	oK0i4kCicrj5IfCf9Moxd8H+u8tRTE0ZoRR7d07Qg1LDm+YLJ2Ki2/36GnNcpPvPlfk=
X-Gm-Gg: ATEYQzyhh/UOitZyzNgXfSCMMzCzwpNFE13t0WYm/cBU7A2R5s+/FnIO+D40yi1SIMO
	0wi6oDqQDwTki5MemMWaP9BI1D2HaF9IVPdPpm8SMlfdCpEMVEOiJqCEmQRJXOlQR2iKfdhYZOG
	X7HAzB+Mj6dlZL66gtWt94/uXSpdh0LKd4zVMKIIdN9HButD2T3TzuREXsSbDtDR/qIbuU29+cH
	mtA+Q5xXX3w0bwsM2UVKEj/1svrGikb2dhclH8tDnGEnu4ZaAQtgmCndcAlxVUsCE3hURDl0T7V
	JrEvHnnaP/dyvRKg9xYQn7ovR2VNz/y8d6sdOp1SafDuIaac+4kqxqnre6gDSj7aMUC827zCvl9
	E6hJ/CSRnOScMQG7tdBHIG1Xe6jYJoYUg5Gx/FU1dxacTGITkw+CVYW0r7wa5ClmtM+cUJdRtqM
	cdc60eQ5KiDGwLoO0wvZFrrmSbihX2rujRpuGcPF/WmrfAD2NAFC9cel2kzlFwK7c25iAtD5NaA
	xtLCS/ohoCDjR0HDw==
X-Received: by 2002:a17:907:d11:b0:b87:6bb4:9eaa with SMTP id a640c23a62f3a-b9356f38f98mr305079966b.8.1772176513601;
        Thu, 26 Feb 2026 23:15:13 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:13 +0000
Subject: [PATCH v2 08/11] power: supply: max17042: support standard
 shunt-resistor-micro-ohms DT property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-8-e50be5f191f0@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-43288-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: CA1791B3BCE
X-Rspamd-Action: no action

shunt-resistor-micro-ohms is a standard property used to describe the
value of a shunt resistor required when measuring currents. Standard
properties should be used instead of vendor-specific ones of similar
intention when possible.

Try to read it from DT, and fall back to the vendor-specific property
maxim,rsns-microohm if unsuccessful for compatibility with existing
DTs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index bae0670e2496..823533ea5a17 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -929,8 +929,12 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 	/*
 	 * Require current sense resistor value to be specified for
 	 * current-sense functionality to be enabled at all.
+	 * maxim,rsns-microohm is the property name used by older DTs and kept
+	 * for compatibility.
 	 */
-	if (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0) {
+	if ((of_property_read_u32(np, "shunt-resistor-micro-ohms",
+				  &prop) == 0) ||
+	    (of_property_read_u32(np, "maxim,rsns-microohm", &prop) == 0)) {
 		pdata->r_sns = prop;
 		pdata->enable_current_sense = true;
 	}

-- 
2.53.0.473.g4a7958ca14-goog


