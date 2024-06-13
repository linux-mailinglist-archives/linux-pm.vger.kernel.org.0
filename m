Return-Path: <linux-pm+bounces-9086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767B907399
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C289228591F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA63145A1A;
	Thu, 13 Jun 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dVtQKdED"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAB145343
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285059; cv=none; b=VPC62Sjr0zQJpgwgqWRWzNkhTXVHS9WHtCmXn7cC/28gVKiJQp0g0QqH46inrtxZGCWuzwEzkP7OF34pxXfUBM4b6tw2n9VbbCODdzfunTkQ7kFOsLn0cxCSMInD7ARyAErzvBQY3X4+I0FkUzEpkigFAMbttKb+/Y+xhbprEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285059; c=relaxed/simple;
	bh=rnldv7833XODCkkhE2IoJHX1ijFNhpuCcMgGUEpMC7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTXKi4fTnyK0Rhd3q+RkCsEgvnrhlD4toDylGPXqq4hB7Sl4OYK2gY3JxZnCrdMlXGAXprsTdIVKO7tSuEVEttmCEUYWIlSC9NLqbSBlzF2UjWc7PLzVPEWDb2TNGZfyt0G4D+Hbi0Mj0EK8JFwKdWFMz5QUt/bu2dE464I619E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dVtQKdED; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso4321805e9.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285056; x=1718889856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ3mx1HRwERqoH8XmiCBcC2qPne8ED2LI938/bq1eLA=;
        b=dVtQKdEDmWJhRc5J5qjUfL8DaZXdrdqZeBSpMsQcgTx7OhEmPo/A/H3GERSIrzUhf/
         NvmUs54kkXt7kLERWqk0cpe1owPb92fIwOzjwe9UmIvo26vaqB5Zb4lzPA7ymOLsW8MF
         Fku+erMegf/wSDFxSV1YfbHgtvGOlwxVIziNuwNrkyvtfdeh/pPBL3OQLGBpo0ITpOdT
         0JBJqfrWrUixz8Yhuj7X22XXxL4PXu2e7PC+pFl/J5Mpk4yLdGdTddFAmDFshUq2iwQm
         tDvREFDxXWywgDSYN3g716Ty8pdbe3ms24foPqM+bXE17693EmOsBJTShs2T07q1S7Au
         z2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285056; x=1718889856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ3mx1HRwERqoH8XmiCBcC2qPne8ED2LI938/bq1eLA=;
        b=GKBFDqSvlBoUTyX76bEh7GAFlLrIpkV/n+Nz2QTrOckkljQOVH3/MzQf5pIMynpOpn
         UGjj+EgdjebBbO9Cdj03QyXzAqVrIif9lcQXN5l0CX4EmKQmVExakDBRA5fgg5JrRwwl
         Lu7Yg3sEja0d1HUmEMijERLgouveWgi8l5h3dkLNSrxvNXtOINH7j7juAVdOe1WQxql+
         1+J8liEdD+KwZ3QIqhi8HTC7HJ+DuP5ybPFu5QBeA8WMDToXhqg/89Z5PpjjHbaiYAba
         0fpZ6r9/r4wNonnDm64tGz7xCjEv4Cs41eNCMnX9bAuHZyvoYfODJwdfsvi3sLAzndrJ
         8bfg==
X-Forwarded-Encrypted: i=1; AJvYcCW82XeGNrHQa/LK3fr+VEpDY4UgPinGXd9UP+AP60rRbmQhFIBgc5oNZO9rapuvzYhCPQTP7PsK8sr1HdVorUXXkvr3p9QTAWc=
X-Gm-Message-State: AOJu0YwjSyxNO0yROnO6RDHjcBfzOY9RuS095CDYrzLqrJQiZHwUqkDA
	w1Xdef9Wx9KjklD9dZLcNdux2OW78DvZhBijDyPUK6Swu+EIREUW3i6DslbUI8s=
X-Google-Smtp-Source: AGHT+IEJg/QKxM4h1Il+pvifbmJ54eJISJ780cLTsOHK41otmROyNxfcRHscGOFu/oRAa2gn49Gm7g==
X-Received: by 2002:a05:600c:3d99:b0:421:dd8c:35a3 with SMTP id 5b1f17b1804b1-422866c2561mr59775105e9.26.1718285056346;
        Thu, 13 Jun 2024 06:24:16 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:15 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: thermal: Restore the thermal-sensors property
Date: Thu, 13 Jun 2024 15:24:07 +0200
Message-ID: <20240613132410.161663-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
References: <20240613132410.161663-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thermal-sensors was defined in thermal.txt but when the yaml binding
has been defined, its definition has changed, dropping support of multi
sensors.
Since we are adding support of multi sensors, use the original definition
for thermal-sensors property.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..fa7a72e2ba44 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -93,10 +93,9 @@ patternProperties:
 
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
-        maxItems: 1
         description:
-          The thermal sensor phandle and sensor specifier used to monitor this
-          thermal zone.
+          A list of thermal sensor phandles and sensor specifier
+          used while monitoring the thermal zone.
 
       coefficients:
         $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.44.1


