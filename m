Return-Path: <linux-pm+bounces-2372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D9832861
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E10283750
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F64CB5C;
	Fri, 19 Jan 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wLC3Vf1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D244C633
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662532; cv=none; b=D7xkctzwk0CMcXXZchluTCkPXnuf7wigUpsgAcabezcmeMpNNEbfIBHwU2l+ILb8m2Tx3q2kguzF28oaz1akT/NBxOYfCQphsLjMhGwSFhH+Qo8JdA8GWClPQC6vl5bHayF6e5SJPJ+rgee8tN4NtrusMcZ5nbV30OmWhdettK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662532; c=relaxed/simple;
	bh=1DhpLZ/QC2ikMIv8OW+4cNzhlMmWDJJXRcZs198iPlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVsFfxCwxG3KrSU+703EKvU/CYDQ/g2z4RT+o/Tik2xlQ0YxHJp/VE3/CQMm5rjDnO81TzY/trM6iHuAuC7BFBU9yI7VfwnWGKrOwUE2OG7miM95YoJKv7ZeXODgpIaKYPytGrjJCCrXlOVvGoRrVsiZOVPL2l0/Z++Qgkp4ggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wLC3Vf1u; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559edcee47eso616970a12.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705662528; x=1706267328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okEOgUTTvG10NiN/AqLj194Y6CTF03Wx1MeaENsTf1o=;
        b=wLC3Vf1uFLuxbO6Kz244e2x6oe9f5MU4ljeQMVtcBycE6W5UtjqQWtm8SWgqCtGjFa
         N9zOMkI9+y6Wrfk/JUmJChcDs2codLgNGmZByIHk2k3tBoPu5o1WDP6GWFIFM4fRDuq6
         4FCoPEURt4BX702K01E0HuQoXO9opzV/VygDkN6urCGOm9HGGPKcHQ16tKJ3ZlrnvqaK
         YO0RBlwSX9hXSaFgoIQkQ5aCDIJrEeEpV5eJzxNENEEwCVBUZ1pn427sNedmRF9BJB5k
         xuYT1RsjwzuhNuB/kr1Wt+eeu7OH9tIXKH5VhEIRRbbI6J8kWy91IosDlH0D2ugr/KTN
         lblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662528; x=1706267328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okEOgUTTvG10NiN/AqLj194Y6CTF03Wx1MeaENsTf1o=;
        b=iCCZv4jLyI6PNLPa1lnE1gClJSp4oIwTru6pERE42d5/4Om8eo9VpJfmfJSR2aAG6v
         kaWI25V579EMoEVABDLcPSn44goUAgCnVMdlt+2HERusAxE4niMoxJz12+OlXX1e8IFh
         shvZOcwnfttt3VFuL9P6NbDg0ABUyQZ04ynh1uQ9ubJnuZZb3LVUsdcyexWp8xLjxXFr
         qOcSfnKAwYD0ts7oVy1/xrQpRvNjAg3kySsVUxmFu+bTK+XbLhsete6b6pUBFbzlalnO
         DHgguSvjEkXZPyySaoeg9xyjMlnXrviIdz5xK0DitXfEo7MLOIXTkJDgcObP84qQfNXK
         O7mg==
X-Gm-Message-State: AOJu0YzV2p8VHXtd7UpqZN4O37K06H+yjP4rh18bNAeXjul21i7jDePf
	QkQy9ubq+QcCAOWVf8oUMGbG4/No7Vjye6R+b88EIqhx0KTlChtMrrwJuSb9pZI=
X-Google-Smtp-Source: AGHT+IExGlo4SMY6bavsiNwBVukS5zNpiw1btzBfUGvzwWyix6ifH0LNGzSKIkssylX/XCDVEEzw9g==
X-Received: by 2002:a17:906:5a8d:b0:a2e:92dd:80a3 with SMTP id l13-20020a1709065a8d00b00a2e92dd80a3mr1400562ejq.123.1705662527753;
        Fri, 19 Jan 2024 03:08:47 -0800 (PST)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906261400b00a28d438a1b0sm10091661ejc.83.2024.01.19.03.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:08:46 -0800 (PST)
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
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: thermal: Restore the thermal-sensors property
Date: Fri, 19 Jan 2024 12:08:40 +0100
Message-ID: <20240119110842.772606-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119110842.772606-1-abailon@baylibre.com>
References: <20240119110842.772606-1-abailon@baylibre.com>
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
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 4a8dabc48170..b2988758d6ff 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -77,10 +77,9 @@ patternProperties:
 
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
2.41.0


