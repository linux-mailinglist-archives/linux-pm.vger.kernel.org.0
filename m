Return-Path: <linux-pm+bounces-43415-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGjsFnmSpWmoDgYAu9opvQ
	(envelope-from <linux-pm+bounces-43415-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:36:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BEE1D9E8C
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F167430C29F7
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A23FFADF;
	Mon,  2 Mar 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWQJCrEh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981A3FB051
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458344; cv=none; b=TONNZ7HsGGteH5L6B3gOycRyujHjDAfi4x2EgtzgOEfMMc6EZuWCb4HQuX48MSqLCZQIW8WiT2qZk+WB+Iyyv9jAbR4XWXNo5MlrC1B+W5jUPiVDR4v+XG+8uCkk+YqmksevQkvH2RAR2jOUC9Baj2lFB43MrEQ/5RtkR9DEr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458344; c=relaxed/simple;
	bh=SAIAGny0Y2XTVzwN6+mJDxSyPdsCJbrl1w/OoDWAPaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/47iirt3Xxin1BkPbAVXliCxosfEBfWRneqw0TubUhIA9XENOB4GwsO9VXzugN0oDtvGDPi6pAgZfT+YnyHta6kGQxhcT6nKYf8yXHIcfWTs8HNda3dvaQna/Hh0Da/ZMq9/FOMxuBDhgIB1f0tbWC1v1YoM/NCl4UxRl7moKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWQJCrEh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65bf2f59d64so5577982a12.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458341; x=1773063141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5RhTsIbGK1u+E+dW2KJHV0kE8sCoa4tpAdX25mDZ6U=;
        b=MWQJCrEhPxrr9Co93Opokk1TNy8UDAgyGBvLZjMjqu2gE1x1upDWjOkYnBUMyy6y6D
         dLy2I41UScDHOA24Swonf6o3r1SREHNt6Oj2ywaBl9CIuQ4l7U1DaacRQRTWXhvEsU/L
         h/y6+hgn0K1AmYgcMnsH5RmSxF/zRWU2qqeSxAzZruNqmMzROGfJZVHDbV/C117jKGXb
         VoeAImfajte5YU8AdPjUAEhCONYIBTzST2jGt7EmRs6+SVYREUCDQCtAsD3Zxd8XDp6a
         T9qIqY3CnjoSOQ6TusmWlr1E7WcZr41JpobsZ9wTnblDq0SfSKVT3XlGbnITsgVPphol
         ChPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458341; x=1773063141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5RhTsIbGK1u+E+dW2KJHV0kE8sCoa4tpAdX25mDZ6U=;
        b=dFl7npErIJfCu+x4sWSudUGsW3xEL+gIO/8WoCgq2g59W+o0599WmQIg51yqBpmZdt
         FRw/6Vg321ukHRtlSdQSfQtKvi5dbBjiEztoAoBCLrETurpkMcMGeHr15m/9bVL9auC7
         AdUAsuSMDqBuCyMWRcd3y9K5UQ/KYEGdGJ1gvIvpAa204xHBq/KBkYjVaOHOZjolmsb6
         DEqPhRky38aMT6AT2qvSoNpFF2N7exUEbIMDe/nsXoPyFPtzl/oAcZlUieKB1Dtgo7P7
         0TNyq8icSTraeXwbZKVcVZjY1owlZXAisM4jwjiNP2LhpixnzHhY/E5CFSuUQQk7InwJ
         eA0w==
X-Forwarded-Encrypted: i=1; AJvYcCXUCWQFejYL41GX+6D4WkGF0m3bi/SeIif7I7T1VpvloACieYOnLrlMxV+pbDQtr/SFG1i9qBHnAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVTloSEJYrOkB5herofecc3CWuNn7Z5Ht3dZ3HVA/fJ3f/Xn9
	ZtLH9oNj66kbogjsQUI7Y0tfl3bTy/qs6qC7E4c6ymgfRHbYDrAiV4kUU6l3uFTcyUA=
X-Gm-Gg: ATEYQzzKT+7D96c5GgP5vziuZUkL3bPr4bDAqu7HnJprOY8wCOpkNt+d2yfUJiXCKDR
	WgI79ilJAta+nSy4lYvJaHOiQtYbx+iGsqslxVecKo0/wL6aoKNThtLjI0MWJYAT94YCzVuilpG
	CoRC2NH1VVPznJS1VmSTllvVRcbnCxz0C981zcJGlaw7yDCHNMWApVw5qAnUtJupzjJ9zqvrMs5
	iWKBphmzAwCl/9hp2Nsn9odLL2KMNBSSf7lbO0itwH54CSufl8W1yRIzoAXR7LxDnX+KQ/Ua6xQ
	9J8PXKNYdFHJ2qZLzfy6ySb76fh6PHs2JMWZVfH1jI8vYU0GrmFSc20grooF+iUDA35iefWxjKM
	SmefaZfgh4YKBMCskLqPcsI0Kv9tm33DhACmoPCwBSwQPCcRWH3BzZBl8+QPmHQHQckehqH1YHH
	n6lKf3ZQbSkstvCxeiSf9KzCYRoiBtR7BKTps5beOhGauh4axVK33J8j0x2sastGXgixFYfvX8E
	wrawVfckePUhWY=
X-Received: by 2002:a05:6402:3506:b0:65b:f3d5:ae89 with SMTP id 4fb4d7f45d1cf-65fdd6c42fbmr6502785a12.9.1772458340391;
        Mon, 02 Mar 2026 05:32:20 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:20 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:06 +0000
Subject: [PATCH v3 07/11] power: supply: max17042: time to empty is
 meaningless when charging
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-7-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43415-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4BEE1D9E8C
X-Rspamd-Action: no action

When charging, the fuel gauge reports U16_MAX as time to empty.
Ignoring this special case (as this driver currently does), causes the
remaining time to be reported as ~102hours, which is incorrect.

Update the code to not return anything in this case.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 39091fb31711..0a6960bbf3a2 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -430,6 +430,10 @@ static int max17042_get_property(struct power_supply *psy,
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
2.53.0.473.g4a7958ca14-goog


