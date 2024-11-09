Return-Path: <linux-pm+bounces-17265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49219C2D3E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E20B21740
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8361953B9;
	Sat,  9 Nov 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE7NFZv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42968194125;
	Sat,  9 Nov 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156286; cv=none; b=p9SXxHx8uIbdS8QmHq6vXyUU4ksj4juNI2GxFIGCWES94sgABF7JpduUnp95YNy8oQc5xLyNfanliMCZjPnzk67m/27Dz/UNFfg1B5p9oHHFLxQ2TjjExoHuFv7zGZ9BkY51/1vvDgWKvVXdc/P73D8Eggd2rw+zYNCWoVNaR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156286; c=relaxed/simple;
	bh=XDi/izkEsxpjIBfFcCl4FataBQfKvJR8pQmYDtefj8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX3ZMB657C73xoWMnxKDgSR+tCZCR+qvAaQ6SY4madGxnN3sdJjtAF7c/ZT9q+opYBmZiO1kgJSbG6rKSiNDYoFrhJeTTmqrno5X68YGkO8cApqY6FEj+uRuJ9U2ljbMOFcXfvG1nMnDDUboSgZ8i6wPS69SGifWyH/OJCBw2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE7NFZv6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso4080285a12.2;
        Sat, 09 Nov 2024 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731156283; x=1731761083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMBRjHQI74d5Z99eEqTTVCC+GvOlvQ6t8L8FeqMEQRI=;
        b=mE7NFZv6bZWgNBpVidSiJZN4lPK4DPHbEHHjFmZUF20LptVARrZGmbT8yr34/ro5+Q
         pGIEiqe8H4aXNOYAAM8OBYyQZe66Vkc+76Wp+AJzx9nlz6d/xWqYtypvVa8NYrWv8A/u
         hQ3CMO/7eXINQyZWsSoO53B4nA7xGHWUPsRjo/98g3CNV5nCRFcYJPK1m7YVpDv8k2Zo
         wvskD7xOyAkRBZXEyEvCsgras5ViReRcKuijIsvzS9YdK6l73lwdX3RRR8pZxB6owTY9
         TMfy/OAztZ0Nq7oe1mRB8cSIMIoFiVBf2vBtGX5ZCoBAuZn0kHqbBFD8hh7cWCgyljJz
         ly3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156283; x=1731761083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMBRjHQI74d5Z99eEqTTVCC+GvOlvQ6t8L8FeqMEQRI=;
        b=wU1hhR7098tYo2azudaCoP+o4FeoB33osMyjRjEqyDLuf/x/70cmAU7jUYy/flk3hW
         Pn01a0j0813lf6v4CYwWSSTcxXe8d0jeHJjtbkuVCeRntky52T5SbOgoseSf4ZRvnEzu
         6HjwOZt5JqnF6I94uEJx8hVyOs39APm8avCJtacnRMbDW/TgbDeWOnFmuPVP01pbVsy5
         DseAW4QR+/1uMq7hOpY0FYywfvlly8Suz8DZBgFWan37eBId1yQSltquvBa7lZtGdBE6
         vGdMfFMDRAxTpE6GkhxeIBnQWaok1sHC+dB9P+4lsmKCRsxgX16HRluKKIpqcfFlF7HK
         Tgqw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5BeYabCH8eANls7y7v5ICVR3Lv9RZoKaQHYvTn8D4ltyWJ3O5jxExpcvbt471N/b6xUYa7erznJ2Oyse8E0kkLU=@vger.kernel.org, AJvYcCW+1jpcW00089KmBDznb5b53E9Z+6NAV2gAG/Pcl18oHOYpJLovFKqMZWuu2y9jin2jo9UUiJaRnshIUmjK@vger.kernel.org, AJvYcCXB7vwEnvGef9D6VV608ViPBl7QTQFR1aoNHgTlnkRdWPCTpNCSbWBNxu8ck3uYwl/VGg6scU2ZsCSy@vger.kernel.org, AJvYcCXkmzSSVbQzjrY3flTnl9BlEUoKF4zYIg4Dp1LWu3w/G7PNUcJd/HSUWBKL6OSKaDjD5wOZdTC3aICW6/Td3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrDRmnvveGLDayHFiiDtNkwS2pHHTAVu8Jw1MkioSOzrI2JgY
	GxY5K9aHoJHQB5GChmWideXILDGWn+x1Pb002F93NTCQEZP1R15DkhVCV+bf
X-Google-Smtp-Source: AGHT+IGHmXkaxvNLQkweBLdDmIhicVaPliDsIzJWNuOAzUgBi/pEgCPcvtCC2kM/nBeKCrbNxy/bFw==
X-Received: by 2002:a05:6402:4405:b0:5ca:da2:b2ca with SMTP id 4fb4d7f45d1cf-5cf0a32477cmr4494536a12.19.1731156283115;
        Sat, 09 Nov 2024 04:44:43 -0800 (PST)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d793sm2940166a12.17.2024.11.09.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:44:42 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sat, 09 Nov 2024 15:44:33 +0300
Subject: [PATCH 1/4] dt-bindings: power: supply: max17042: add share-irq
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-b4-max17042-v1-1-9e2b07e54e76@gmail.com>
References: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
In-Reply-To: <20241109-b4-max17042-v1-0-9e2b07e54e76@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731156277; l=1112;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=XDi/izkEsxpjIBfFcCl4FataBQfKvJR8pQmYDtefj8s=;
 b=S2oWIinV5ResTYdNod6KQGakhY3n2n115RbBezpr5fVJmGmnKyaCmXd8jZrZ+MQSaky4qbucC
 JOnSGVPtY/GD5N10XFrNG4mOf2wnORx+aMouPtcZM9TebziThuOZ1ge
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

If specified, driver should request irq as shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..e98ffdad1ec3 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -59,6 +59,11 @@ properties:
       Voltage threshold to report battery as over voltage (in mV).
       Default is not to report over-voltage events.
 
+  shared-irq:
+    description: |
+      Request interrupt as shared.
+      Set in case of other devices using same interrupt pin.
+
   power-supplies: true
 
 required:
@@ -79,5 +84,6 @@ examples:
         maxim,rsns-microohm = <10000>;
         maxim,over-heat-temp = <600>;
         maxim,over-volt = <4300>;
+        shared-irq;
       };
     };

-- 
2.39.2


