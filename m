Return-Path: <linux-pm+bounces-40729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF7D186ED
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B59730012F7
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05338A9B4;
	Tue, 13 Jan 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSyIFME/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799238B7A9
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303273; cv=none; b=jtBN2mExHKTBj01kk7SEap0/ep/j21Ih9xFA/o9r3ze9uFpfXr++qilcB6ddsCEWPHQhdLRjdN1wHjW1O3a3F4hVR9UXFXvVYB/4VmNOh7WjuaCa29CYOhY/j5h4xAT3NPhoWl5YzAZv5Fd1ZSQMO62gWRAmUwUiIgbhcqZ3V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303273; c=relaxed/simple;
	bh=BxQThXKC8yeHVSgVuMqaQwxA6jCxwJIGPEfZiSybX3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJrQiej383YLrKgn5Y/CAtmwnqjNTzzl8nvAG/x79XFlpAJn+sfHfyQEZZgoOv1tiHzUXLP3QTDItPDJeQT2duip+Kqnmz+99ESy9C7iJnVTrUDsU3eLDeY9b7K0njIB9ZUHNFFdoE3J2QyMWXgjaimPAYo3nyDrG0XhNCFEGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSyIFME/; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121a0bcd376so4474932c88.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768303271; x=1768908071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Sop77tdlghLGqlW2lD54uYlYaNgTrSImbZcSm1W050=;
        b=DSyIFME/7X4v3Z818162m9pnoT1jhIrqg7nl+SBTS1E8d+PR72IEXErgtLdXvccrCp
         9CTAeeMfUpiEycUBWZBuXEHqSxZ5zmJVwNUu4CocsVJMijp3QF0A+Oc+9CJgtkWZf5O/
         BNqfJH1WrGbOD80iu4Sga6AMC1Kum6dHw/lxdJMmVXb/KVKupneBVJx1cdrKn9bWFDR1
         uk/eYwJOlW8JoT9RN39JPnnutKul/oqUwmbQb+/Ff5P/Fb4qGypnWcCXxByj2dVXHy7P
         ZoBbdRYydFS6z348QrFiyPATq/QYBuaBcTWaqESzqWfN/eNJPsVVP1LsBdL5RHaXnQ9h
         8Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303271; x=1768908071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Sop77tdlghLGqlW2lD54uYlYaNgTrSImbZcSm1W050=;
        b=EFhbFTsn3ZevfbfIobghVRxkjcD4y8PCJqOOVst0RxAl4Dds/HF0YXl59ez4hEiDBe
         Uv5mm61uMBw6MgvLFyqbAXf7DrwJhEQcLhrbobpYUtqnesMV0v0H09jQQ8DeYpnj1EQF
         HXFJBjdQbETPzGQAekXEdXpdo+7nDdbGHTImYj0LY8wvNy/7ZwajOv4X88UDoyCfF13H
         IjtZw89DZOv2KKThvcAFw4Wnej7ehxYaxgHnlvkadUfkT1IO+yxiSnFHoE2RHQAkNLvM
         w1HF4kHtO8kcMH/Du4Hf3DyFipDeHNg+9TLQJ7NpO5ka35AlUmhTK04D8owFB1aA4dvf
         SbFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQvZz3CkCyGWq8apzsgzlu+G7D0pYYqnC3+NoI8UnvzAaMPPvF2iNChFfbcxUNdBYrkH+Azkemjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oFuFSkLfV41rBEkU3jwyI7mapxpLC0hkt823k9TqWNKToPNO
	KMmtUz/uqNC/yMlueu1dANxWQOPB95TCYIYdN1++HCBH0xdHBZtn4FyVCPKlYA==
X-Gm-Gg: AY/fxX6rWs47kuj4ZK164guOlkLnToo+yoIyKJ3mXG0giEEkAe2enkQvNy73Irpbt1r
	81ihqzpagUXn1COsNwzp7HlF2C9EAsYCjs/rC7b+RJsawXfBG1U+TSA2RUSCEDYqA+sleqi3HRn
	no558IKduhEbM0ZqQfRhT5YkWjmZ0YtGqDiU2al+fHcdStsyRj0AEcR+nB9EnWCURjO/sC4BkS2
	LN3cEjYbBJ7WcXvNJhjIjJi7Qf5O9VnuVsqB8+pVZowLy7U2sItDTPP9X32Gs6oa579yeMLJEZc
	i419wQ3ZNiJQXFYRCgqpHvkf8c1Qf6KES/FYfrr06gtXRqP4bGUzEpbuP0Hpc9hyQ+NN+UCg/Wi
	XazHLEsfrIsAGvpFe3nijde4QjZbqnw7GZiL4t/cOV0F9hX48aofnA+GvAE5bj1CnmQo/+BBGVJ
	fixZvkH3YZG/L3vyAVnlDQ8l5crnoeTDoBzp1Up+5fX4LR8+H6QrVAPZRTkihxxfQ/VRRu80yGz
	SlPImkvyuugVNr5mhy+rQ6kMUZoJB9I
X-Google-Smtp-Source: AGHT+IFDZv7qvFhhROPl5N9K7peOOsuOQ4CyM9RhLyedWdWjF2fUf/8J4j0bRoJff45OX+N60FkOeg==
X-Received: by 2002:a05:6a20:9193:b0:35d:3523:c90d with SMTP id adf61e73a8af0-3898f757a29mr19808618637.0.1768296379649;
        Tue, 13 Jan 2026 01:26:19 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:19 -0800 (PST)
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
Subject: [PATCH v4 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:56 +0000
Message-ID: <20260113092602.3197681-1-visitorckw@gmail.com>
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
Changes in v4:
- Update 'interrupts' property in examples to use decimal values where
  appropriate, replacing hex values.

Changes in v3:
- Update 'interrupts' property in examples to use decimal values where
  appropriate, replacing hex values.

Changes in v2:
- Add references to generic subsystem schemas (serial, input,
  power-supply) where applicable.
- Update property validation to use 'unevaluatedProperties: false' for
  schemas referencing generic bindings.

v3: https://lore.kernel.org/lkml/20260112185044.1865605-1-visitorckw@gmail.com/
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


