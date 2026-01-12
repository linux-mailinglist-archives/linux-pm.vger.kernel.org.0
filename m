Return-Path: <linux-pm+bounces-40697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC800D15573
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DB63032AE8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB033C192;
	Mon, 12 Jan 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNL+471h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AF33F8CF
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251298; cv=none; b=VhiZ4iAn1WzbN4vig6kuFzJ8qnd6ZE7AXU4Mnp9k/aamDruUqJIoTovvLVsr03WO41chg+g4Gwoxa0mSntFe07KrMr+GTkXbUDXK+XKNsg2FYq8Tnc2LGWra1IwsmfxrqnftoItihvHQlL4G7DaVJxtE3hKLKZTT5930cOThGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251298; c=relaxed/simple;
	bh=qpCaq6TACL6eqM1utYs6sRZYduBCrJkOLynbCIHDvqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/tvrIwoSlmML1tQG+x3JtqWUlwCEkJYVD6Q9iPdb0zPiAqs+7W+pa8uiK+eE/zL6WauA+h7Xp6WRCaWrdI3IONcpOiaXiLeVcdRyc88IbbtSWsOm41Op6+sSJBjXnhYHcuw8wMPCpDOL2LkqJkvrWb5+fNobhPVP48VjHjwM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNL+471h; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a367a1dbbso115852326d6.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768251295; x=1768856095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUq04sqpfNThT7kS3bI999/FPk05t6O1xEOGrVfWKpU=;
        b=DNL+471hTAqlBLbUSLe1glJBeBdYLZwUUEpWLobc3jNtIMwrqKR40mmia+lLs8q7/W
         oVzB7PYdnSowrdkiMgFRUwYJJlLn+AoH64QBKEBCByBQPEiYNhwtdqy7DnPBvT6xq8/y
         5RTZQVz+9/vm9NoVmGss43yGMLj7NdYLUVHg30AoskYEYGCcndhVxQicjeiPDTCVGHDh
         Hm+cQw4VJhCHORkjAoMvgeAwYzztDJ0fx6pktAME2yjp4hCaJ+X1OgLU3katvyYw9yhR
         acR8BBtu9+Jf3mJ3T9uVY6nIgH4xG+6KYmgWTE7lbVynQLmQFdP4Zn1jHanFLQDa/Dsd
         E7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768251295; x=1768856095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUq04sqpfNThT7kS3bI999/FPk05t6O1xEOGrVfWKpU=;
        b=TgNJ2lD0VXUVhNWWEuVyTnqtXdmq0JeXZOxRYzmOOLLKpS29Lf7/2IATYs5qwJoUai
         3YX9prcJEJsCQuPKKAILbFoHUA3TSBX9lQ3L8MRTezPUwx+nFFN7ykbjq1lmAlk4Kq8s
         770mA9LPYONF0+XGSpZCZBjEoyycWCsxvzKp/jJQZgqi+QxwFxlcHFmNLrGL9g6zGCCQ
         SrIhq8XgO/cKu7oBgoHAfTFyvVBbfuD2Yh/1zWCNltBPfZIi8XkSshbkbHY9M9Mbvf35
         pKV82KiiKZBr7UGL0iGb+McxAUXB9MwkzobftUCcJ/GvCCGnrfslIw688SxtRFPAMlsm
         UMyg==
X-Forwarded-Encrypted: i=1; AJvYcCU2SzT97+DbJ7rQnMQhfZKBNKErHtEohEpMKnlmtDaNMg/zjzPH4YCtpDn5ZNDkcQUSJ8MAWICcPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKbDwtrl6PH1Bb158uo+lbCbJlIqAryO1cvI4aU+ZKvyDag62
	ksFprN0lTfls0PqpDEOxwY9XEa4PgEutfNv5M4hiBOcwKJoUnxuAJNf1zQ1lcw==
X-Gm-Gg: AY/fxX4ttGuL1wnNJwQsP8TSaGyf9QImhVHGH7SJ8fUJsF50knWtIjCR5WH2Cd0KHhA
	Z7ivjO67adgfWd6fusELA+HQXquvm74jrFJLgdgBSElt9nXGvH8HBLD/3kNHWb8TPTILe87KoZE
	G1YCiss75OY+ZZR763QM5hkp45CmFXeltcIGDEjFZg8JY8Hi5ktD2WXfYZvHEfnmkqFOEY96SB/
	rdKIacmZ6w5/gU6C/H19cK6s4CIZ/yLdj2ZVPPS7M9GvDimgmVxfukBE8KK/p5YqAjk1leqqNpP
	IW/wugPtc3J0tcOl3IZ7vOHuSxlZP8URW4z0N8mZSYdumYNqSeowypf+q/79bENmOSEH3bXIQmC
	sHa/ctVoSCEvYosqFyIaGkd8o/9l1vBu7gGGGzLyNhw7dEtXjs/jaFGJxe+HrUmoo8EvEnEkIVD
	qv5n2dzDjAFYMahhO5YRtaPah4md5kLZI73aKom+7dHAYO24/JbndQekVxYxJ1nWOqCM3b/CHI+
	OuHXvgHmoDIBPojRjFGGQ==
X-Google-Smtp-Source: AGHT+IEj1k7cb2fd0Uhwg3rDL/Jbgy35/7F5lChJPW1hzU6BQQa/0pFpWI+28ikvSEYQSgMkRmokRA==
X-Received: by 2002:a05:6a20:7287:b0:35d:d477:a7f1 with SMTP id adf61e73a8af0-3898f99146bmr17183198637.43.1768243906956;
        Mon, 12 Jan 2026 10:51:46 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:46 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:38 +0000
Message-ID: <20260112185044.1865605-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish emulator platform bindings from text
format to DT schema.

Most of these bindings are currently located in
Documentation/devicetree/bindings/goldfish/. Move them to the
appropriate subsystem directories (serial, input, power, sound, misc)
to align with the kernel directory structure.

Update the examples to use generic node names (e.g., 'serial' instead
of 'goldfish_tty') and fix minor inconsistencies in the original
documentation to comply with current DT specifications.
---
Changes in v3:
- Update 'interrupts' property in examples to use decimal values where
  appropriate, replacing hex values.

Changes in v2:
- Add references to generic subsystem schemas (serial, input,
  power-supply) where applicable.
- Update property validation to use 'unevaluatedProperties: false' for
  schemas referencing generic bindings.

v2: https://lore.kernel.org/lkml/20260108080836.3777829-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/lkml/20251230181031.3191565-1-visitorckw@gmail.com/

Kuan-Wei Chiu (6):
  dt-bindings: serial: google,goldfish-tty: Convert to DT schema
  dt-bindings: misc: google,android-pipe: Convert to DT schema
  dt-bindings: input: google,goldfish-events-keypad: Convert to DT
    schema
  dt-bindings: power: supply: google,goldfish-battery: Convert to DT
    schema
  dt-bindings: sound: google,goldfish-audio: Convert to DT schema
  dt-bindings: display: google,goldfish-fb: Convert to DT schema

 .../bindings/display/google,goldfish-fb.txt   | 17 --------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++
 .../devicetree/bindings/goldfish/audio.txt    | 17 --------
 .../devicetree/bindings/goldfish/battery.txt  | 17 --------
 .../devicetree/bindings/goldfish/events.txt   | 17 --------
 .../devicetree/bindings/goldfish/pipe.txt     | 17 --------
 .../devicetree/bindings/goldfish/tty.txt      | 17 --------
 .../input/google,goldfish-events-keypad.yaml  | 41 +++++++++++++++++++
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++
 .../power/supply/google,goldfish-battery.yaml | 41 +++++++++++++++++++
 .../bindings/serial/google,goldfish-tty.yaml  | 41 +++++++++++++++++++
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++
 12 files changed, 237 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
 delete mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml

-- 
2.52.0.457.g6b5491de43-goog


