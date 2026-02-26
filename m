Return-Path: <linux-pm+bounces-43251-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBIaMP1IoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43251-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:22:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CD1A65A2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091E23198A2A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C93164DF;
	Thu, 26 Feb 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaPeWzeu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554D3254B9
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111506; cv=none; b=ZxQbDjY/pZTmLrnJsYPFpeE3cA+9lwu5GZSqpdC7o4SAx6iE+BuGc9+1smpE3oME3+vqNzBifXpW43p7FgEXsl8tW9nyvGD7U+hLpBfq3hfXQHK4TKz3Rf7pDRmOUZAtXYKSEzjH6EkXyZcTmBGFm7ns7r7SGQfIFxUZMiJvp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111506; c=relaxed/simple;
	bh=CTmFEqd4z7gM9BpiQXC8TftzHTevIiLfsiyczPYt5VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4y4WpmtEvM5jpilHRFULBe/XWY+ijb7KgFz0f35BNSsfApYebRCWOCMjv+ld88Zpk5tEnXgl36pAgpYPGvM4MhZs/5bOBliBtZrUyIrBQnwwnqijbW2lfqO7FFeJSbeTT4pvByRZlnKYp6koC7uDt6t4eCQuXsBgzqBSS1yGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vaPeWzeu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9047e72201so120550266b.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111502; x=1772716302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doSnaoOeWo4jS3UXOttanh09pOHZ+ZihIcXNRAknjGs=;
        b=vaPeWzeuDnQKkkgrqhCFab/T2fyx4GQ535y/mawvR9tZ8dG90inrcE8UEr2qlw7TQq
         Fc3bakWZUwRAJgPu7acLMEnEvUtpChlLMPP09QhMA8kq0EIyRm6BujFyG7RNd/0+GIKl
         hZLuIVysBS0k/72boDLN7xNDKVtgTOi1cgSyPydhq5YFX52oIcCuipvnwl8kxhZO0xWW
         RWiiqSEM2rUqeHhWWGrUNQFWMHtYc1UKh0jHC0rvjvW1DxQBWfBizSiE1ckgIO+3VEK3
         26qCn13QdLnzycxpJalSwc9iXzb8xNgvSSarWDWmJWjZa+64peQmmbl6itALWHAQ08D6
         wDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111502; x=1772716302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=doSnaoOeWo4jS3UXOttanh09pOHZ+ZihIcXNRAknjGs=;
        b=bkuBhfP+OG96Tvp06DJaSDBGiWpVRU6IZg/7MbGzeoS2wpRfTofFAAm+SEvMdyy7+I
         x4RW8P3eGxeY+NzBs4a283DdUP99AtYlSZxRXma9p3fMR/r1lkhqBv0hf+6XVuabMahx
         G7LmHWgUJIb5sQJsi225W86RXI7Qa+xnLZMg2K9CsjUE2mJj9YbyTK9HTvBRd+55xulZ
         mPRw3zthfKHkoAPE+vizVlJlCm8zzopZAwdqo8bK6n8ybSxy196hQ6dYyCuO1FB5IB1T
         xBnfmKTo6BBZEv30npCWrHOWs1KSW1hQshHGbfrhpUDyzbTsKY9YL8gfC6EHtMzbo3pv
         7kHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgqQr9PmLh1Ewj/TPnOBR8LQX+hveNpnIV0/9GC1L/4NJeg6mq0LfHg11nXi9LUIyD3bKSKSUQ1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cTcHOFkc3inEEm/BjWmg2ujEAito5fB2JjGwF5Jkq3msvaFc
	JCIy+ZN499dpcgX5JfujpA1cFFgg5wH/0pkW2xcSY2wfvPFOqlnD+3d3ypxFK5FNmn4=
X-Gm-Gg: ATEYQzzRFe9abGKxCOsK3cFEXahzF6Wy7ZIr/wJ5yEQVBJMmtqzKbSjxwtwU3sbatiK
	uEuI0bynpSXk5CQqX8uk+If9FmnzfRTXMcrnxEn9gNxaA2QrDcGPHx5NzQc794PsR31I5DAOPKp
	GUwYC94RFwJMsBqFMLhYhRU3nMpnCVhsHe5j3IW2rY/3c5HBsvWjrGS2ROSl7zZbKokVDcjjG4e
	ED1x95lo/Lp7dvoChoKi+Ss3BwSGDhYw8JJ+ogzuGrXQ4Cx9deV9BOx+QS9UMBVvgl6k+m/2rRY
	MSxF0szV0lceLbE2c1h0kBHOqGGi5BsZ11U8sUSnmMMpUNvhSoOgDQ8gH283IyXhfiHx8CpZpPe
	2LUBjHPGxfOiHg/66DfAl6F6CAzQhO2G2wvKZfyYcMnQ9/f9L5mTJx2Ikl+YyZ5XBaAFRpWEMFg
	LeyZuYlVWShRv5o4Z5Pbj8gMtE+2bcsxxRmUespQE7gIwcmcMEatD9dlwzCBFWuMyW4+/bS+8b7
	4oDsUEjTXbCngsVyA==
X-Received: by 2002:a17:906:9fc5:b0:b8f:7aa8:d9a4 with SMTP id a640c23a62f3a-b93514dcbe7mr261352866b.20.1772111502212;
        Thu, 26 Feb 2026 05:11:42 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:41 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:41 +0000
Subject: [PATCH 07/11] power: supply: max17042: time to empty is
 meaningless when charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-7-ff0a08a70a9f@linaro.org>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43251-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 615CD1A65A2
X-Rspamd-Action: no action

When charging, the fuel gauge reports U16_MAX as time to empty.
Ignoring this special case (as this driver currently does), causes the
remaining time to be reported as ~102hours, which is incorrect.

Update the code to not return anything in this case.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 8808c0d2ad10..bae0670e2496 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -434,6 +434,10 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
+		/* when charging, the value is not meaningful */
+		if (data == U16_MAX)
+			return -ENODATA;
+
 		val->intval = data * 5625 / 1000;
 		break;
 	default:

-- 
2.53.0.414.gf7e9f6c205-goog


