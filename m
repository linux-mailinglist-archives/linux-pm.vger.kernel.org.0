Return-Path: <linux-pm+bounces-12327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB6B9543EF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA21F23D28
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590491459FD;
	Fri, 16 Aug 2024 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+QUHHvp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60A1448C9;
	Fri, 16 Aug 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796371; cv=none; b=qheJOj9tluqYRAv304HJalg09a8ced2ZXxI+w+fyXZGvromq1BSDChTC/xrdazk7F3tPZMCSTYvF8nxMAZOA4OqPX8zlJefaC9DhCIieIjB3qg561tXSs6K5c/n40l64ddTltAwF/39EMk/jliI1fXKHPf8rfojO5vK2hz2SrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796371; c=relaxed/simple;
	bh=OEUMcNEwb5KpCYbBVGa/9sqAXNJSzG3pMkHYL8I03Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYd/BRIe/E8RS77oCve5PJNFY7d/eH6bATiPuXbi8AElrG/4JtyZLWDYpYwshsmPe4DFHY9PaAhhuK+EUAv3wX/09VUAPMbLXYaYHwIgSB67X7y77/iGXt+Xdfua4UMnUHBzfFogFFD4hL+aYzQ8HIyvBLdG3DSjm8zeR2lDHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+QUHHvp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso12476165e9.1;
        Fri, 16 Aug 2024 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796368; x=1724401168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXcN+4MSX/QcUPqVj1wMQhGhi1WKb399yNI1f64c3To=;
        b=Q+QUHHvp61FRoGBiiqksPTSG9V+m1rpEW16yP1XtEVHFnfi7d7g5m9FZkU/bLgx5Ei
         toAXKArJwfdxnBMKXdxcLT9pWgVWG5CEZZY3si6edzdeeVDmFPqXVSoWFFGuJ4ZmClUm
         MXHgYNX0ZrS0KVIyZlqt8HvJ9DZQDMMudWfmcHEFC1DFOMiPwvlcG1+ED7OGvFrOwvBz
         66SVBP6wHnDkOYct3wJpth/t/6FE/W5ZEkRKinnAeQj+JT/4nuyAjsb0yfl7LYzmC3wg
         ZGC9uU5GHBzEZX3rh+l/7MKXzRuOm/zXpXRHMxp1eKKxsCACBmUAUkM1nlonGJxNiCad
         Lt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796368; x=1724401168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXcN+4MSX/QcUPqVj1wMQhGhi1WKb399yNI1f64c3To=;
        b=dhhKxSN/+3ZFXMO4/TzeRjTIzY9m/4bfLjWeIcI/JsyY1q/Hj8qaDn7eYv4cEyUlHd
         akx/Jrnw8+nrpp3pGcr6/inNsY5TYUUrrRd/nw7wf0LObAGLKCdIxBtoHgAsohgXvL2Y
         mziTSH5QtBqp6iht/qPlpgpyUYKhAloYxgDu8EkfgirCJIVdBJCYAXYl0Nwm4W9xC9Oo
         uWIM3g4M47Ti2uV1zoo6ZjefZ7dE11XU0DDgiBmsRNWaygptApM9dGRM1y7rUvjHzJFv
         M0koc2hewZtVNfnnd+mOTpAWSau7yJWVZG6waTvPo1uzP/EqHcepjQxAbFiSafsZGka/
         FCSA==
X-Forwarded-Encrypted: i=1; AJvYcCV5fWJKqEubPLL4JT0ESAACjMGQozB/O/XmRg1BcNBbWmmuZdNUd35T8eamEtpS+bpJ7Ijn5sBJ+d0TEMxnKBTDAmFPYcvkC2/a+2Ugn4cjW0H7njDd86aVDLK+2XyzaKlGl7xAhfCcaVcHGhPn5qId9VGDkJ1LMfafMuEFYGTE2Je+/hTWg/8WAg7esnau7WPxp2zJ6Wy5nfPH338Bbi/NR+ybwes=
X-Gm-Message-State: AOJu0YwjTiYkERkhwMCXqvFQ/IM9UXLTvbnnKnkvcWjJUMZAiEitHPS+
	KgFxA9yrxUHwd+Za/w3sd0PIr8WUZoUkxdoED2Jf85PYgAc05F/9
X-Google-Smtp-Source: AGHT+IHcp7XnLYvNLhbNQnLEg3KjGHkjXNOAnHLq2tZHnyLDVXPWGzMQ/tM7Ng9t/D3Pn35IE9GwdQ==
X-Received: by 2002:a05:600c:3c9e:b0:427:98b4:624b with SMTP id 5b1f17b1804b1-429ed7e4314mr13528225e9.24.1723796367650;
        Fri, 16 Aug 2024 01:19:27 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:27 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:13 +0200
Subject: [PATCH v4 07/10] power: supply: max77693: Set up charge/input
 current according to cable type
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-7-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=OEUMcNEwb5KpCYbBVGa/9sqAXNJSzG3pMkHYL8I03Hs=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt+pTyoecftSlWocNm7S26aezVV4rEMO+uPW
 6mo/bs4DKKJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfgAKCRCzu/ihE6BR
 aPA9EACUf+9CzArgSMlfX70XD47zElr1ycVHjU3iVpni38eeLaboCWaOWLue0lUp8vJc+z72T2A
 l73u4b4NAsTtECVS7yt5TGx351I4glu00VE0m6+3Ia10dPOos/IEcl7fgYYcZbwusGlqBdOUs8P
 0Vpox3q33iJTI51mwM1TULoUkJ0cC8j1P/Ca7WCL8/+G0j9cUBI7PY2+nz1aYKqhLuJ2LsTGFz/
 eDRZVBkC9uAeG93rfr9m4+HCmtFs7EjNrCa64aIjJb92JNeuDGXs+N8De/pA7BQ7V9/BdnJ1FAk
 eMp5Oeddtnipbd/1xRH6Gk+yBWHaY6wZTITPnqxhvkT+SjK2D9ItoVZ6jvNbWn7ml+BT9HmXFPV
 Os4WUQ7otla0t2IiYWVlMMp1UQ6XaYDCNMEQX9IYf124mMhJIXAc1iJnFt//SwG3Cdx7e5KOhiZ
 vMNRJhz779zLSo+/LpCXFL4Pr8URHMfDDnZHgX+EW9e3Ay0YkBl76+pV6iar8s6DZ/ka6C4SRpf
 4LMmudret0Nn/sogjbBkLJl1s6aiGOTT5xi9P5QrzjuhbfOB1dKd90HtlEEZQGVsz5zGAxP3WIm
 /dTutI6AoeolshZSPXSwh6W25o9Yy2a9FzVeO6uMv96T+JfDOQMRMFssG2SizCy5AAvwFZZbwGA
 W80OZ31JEeXliRQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This behavior was observed on a downstream kernel - for chargers, the
current would be set to a fast charge current value, and it would be
bumped down for all other cable types.

If we leave only the fast charge current value applied, peripheral mode
stops working. If we stick to 500mA, charging becomes too slow. So, set
the charge input current limit accordingly to the cable type.

Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Re-introduced this commit from v1. It seems to have been accidentally
  rolled into the previous commit in v2.
---
 drivers/power/supply/max77693_charger.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index bf156544fe1b..908fd2a178ee 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -716,6 +716,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 						  cable.work);
 	struct extcon_dev *edev = chg->cable.edev;
 	bool set_charging, set_otg;
+	unsigned int input_current;
 	int connector, state;
 	int ret;
 
@@ -728,19 +729,28 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 
 	switch (connector) {
 	case EXTCON_CHG_USB_SDP:
-	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_CDP:
+	case EXTCON_CHG_USB_SLOW:
+		input_current = 500000; /* 500 mA */
+		set_charging = true;
+		set_otg = false;
+
+		dev_info(chg->dev, "slow charging. connector type: %d\n",
+			 connector);
+		break;
+	case EXTCON_CHG_USB_DCP:
 	case EXTCON_CHG_USB_ACA:
 	case EXTCON_CHG_USB_FAST:
-	case EXTCON_CHG_USB_SLOW:
 	case EXTCON_CHG_USB_PD:
+		input_current = chg->fast_charge_current;
 		set_charging = true;
 		set_otg = false;
 
-		dev_info(chg->dev, "charging. connector type: %d\n",
+		dev_info(chg->dev, "fast charging. connector type: %d\n",
 			 connector);
 		break;
 	case EXTCON_USB_HOST:
+		input_current = 500000; /* 500 mA */
 		set_charging = false;
 		set_otg = true;
 
@@ -748,6 +758,7 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 			 connector);
 		break;
 	default:
+		input_current = 500000; /* 500 mA */
 		set_charging = false;
 		set_otg = false;
 
@@ -756,6 +767,12 @@ static void max77693_charger_extcon_work(struct work_struct *work)
 		break;
 	}
 
+	ret = max77693_set_input_current_limit(chg, input_current);
+	if (ret) {
+		dev_err(chg->dev, "failed to set input current (%d)\n", ret);
+		goto out;
+	}
+
 	ret = max77693_set_charging(chg, set_charging);
 	if (ret) {
 		dev_err(chg->dev, "failed to set charging (%d)\n", ret);

-- 
2.46.0


