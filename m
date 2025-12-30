Return-Path: <linux-pm+bounces-40053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC89CEA6E3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 19:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 440203005038
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CB320A0A;
	Tue, 30 Dec 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRzCiLdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BE2580DE
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118252; cv=none; b=D6w/d2rA95ZTuaRm+aW8/wZEa+UHJZAjbim7WAPHunblsFv7TXcBiJdMZeDrzdZ5xELzcuIgDTcVBMgJatgZ7aPHQRBbudsM6VoFAWNxJl9Cjo5PX5uO5YMbmrrVpyhjbll4Z6Rjbcd2Xp9VQJiWNBAyEqiwYwHVLPqhL96rM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118252; c=relaxed/simple;
	bh=FgJuNpgaVD0m6yaXMmc2AfRGD+fA194iC5P4RORcRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i77JpSCoCC7jHbLcGUnf0hAYfja4tF0xFuBvLreLYZ1zIMN/V8Zt8Komf30WnMQ+WVWP0fMagulFERbsWoRwgib9+Yn63BAKYy4m3X7m5zLdmAdMayXZtdWUUWGJCi5ZH24g8FtBXGJy7eKEjJDpY+vSMXjn04JPAdkuKjfIpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRzCiLdG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f121c00dedso13642253b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767118248; x=1767723048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4o2F4BeHSek0PRiyhvtGksMp+wv7OaL4BHi8U8EOKo=;
        b=jRzCiLdGMBSfGpEhCtHyr/JU/LptiDCZJEfmCo3lyH4ZesMzZhDixX+HxuZEFyPObA
         ZDvpl/Gxs1yfacsLRce18+COii2z9dVuDBajN4FRNV78pFxUkv235fbCPaJq4XQg9O6n
         j1CPpchgDgEKuoLO6HeY1VlDvlyTMlGtBrkuuMf02sobB+f7Fex4MrA/cgfJxIAvRD0Q
         cPlPgIPQviFjZavRoU2bCBZ8o6bk67sLSC4lDj2emB4fzAV4YxoZQj8R3buNGfYso0s7
         8OYHmLp5igt5IcVWyeK1rJLulTvO9gGkS60xrtl5lNH0d556kwNYk4hz0L93gmf+YsQe
         R9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118248; x=1767723048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4o2F4BeHSek0PRiyhvtGksMp+wv7OaL4BHi8U8EOKo=;
        b=SIVNTcogrHqBKj6cY8w6EBVnMszH0PeRNJwVI+uPBGWoedrTZYbzOOo+F78UHfQ0Jm
         UQXOdFIZnCChTGMil7Y5YlhDLfuCLLIFdkztfKHt747DYXSCDKqVzG4CvWF5ixVhT5cH
         ACgKpqU1epag/z/OCIG7TgcCiDxTm+posr4R2j4mbe+ftGSuaYSANbCjO7NCTqzPLyVC
         ang+vedZjARW7KoXPVZS74Ubdx0slXGvj8Z3FBLOxQksiPX8X3BE2fKzgp++M1qnYGJu
         g26+Urn6HfUivT5chNYztt5urP9Z7PBMC7wXILLmDC/rM+ve9P9zq3diWftwmHmgO5rH
         tIXg==
X-Forwarded-Encrypted: i=1; AJvYcCWkSamYL26B7/z+7eSVmZEre61X0s5Cntx1biHmVrjvG5thJD6QwFNRaVGsz74Xzb7M7Y1oBPjCog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVcvu4+AyUGdVEVioutzcTcZbX55w6c/PdQdVs3zO2LpL/x54/
	WTnDeUzs9kc1Wi0sLPLxHX72cw5UvEVa5B2bMDcVQvacqOxWiYnyIjZp
X-Gm-Gg: AY/fxX7BM6uA7c+Q5GmL+tBEAWuoA/86930xel8ruHiiFnt5aMDOoJ1NKZvuYUYfnuM
	L1l9Rdpvb5B6mEqHHo905PBsCUtoSrCdTt9SdFLhD0wXbxBLvMjWsgLY8UZ9S5E7l+Lb01LYDjR
	inWkNL82uA2D7R+xuL2Gz0mzqWLLsslTuokJXfbJKsJZTL+9BFtdnRgzyWx0VL7Nd+Yg8K5dKBF
	LCFAZRpI4qllnvfIIIG2xsuCr8x3cmhG/m6C1pSF0kRSCP+LKl5SEu3PrMAc9k0ZN0jiB+JX2J0
	Slq5zt4+GemDUj5w97OH6ZW/S6yXnlKzhL63mXfYLG0yYzcE8R2EWnkmXRpxi3fiN0DJz+RVoxs
	jl8JyTOLSjDZOvNx4vgQ7jelvIUcQZtQ4xxhWyoSolAekSDAUKRIlTCWDXDpOdrjUaS2xUbKvqG
	DtZgSaaq5zOig7xXNoV/UtXHd9Rb6XNMVizMK6BfP+8NY5Hv7Uq3bNay00bUE92arWC4r+21kle
	CzXZh5UkroJMmn9O6uRud3eAymZOx76
X-Google-Smtp-Source: AGHT+IF7WV9lO2SRprnaSS6rXcXG+rahUOdxgA9XI3QZjssiw/UqNuh+1y3CwU7o6es14BggMVW//A==
X-Received: by 2002:a05:6a00:420e:b0:7e8:450c:61ae with SMTP id d2e1a72fcca58-7ff67063910mr30261999b3a.69.1767118248003;
        Tue, 30 Dec 2025 10:10:48 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:10:47 -0800 (PST)
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
Subject: [PATCH 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:25 +0000
Message-ID: <20251230181031.3191565-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
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

Kuan-Wei Chiu (6):
  dt-bindings: serial: google,goldfish-tty: Convert to DT schema
  dt-bindings: misc: google,android-pipe: Convert to DT schema
  dt-bindings: input: google,goldfish-events-keypad: Convert to DT
    schema
  dt-bindings: power: supply: google,goldfish-battery: Convert to DT
    schema
  dt-bindings: sound: google,goldfish-audio: Convert to DT schema
  dt-bindings: display: google,goldfish-fb: Convert to DT schema

 .../bindings/display/google,goldfish-fb.txt   | 17 ---------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
 .../devicetree/bindings/goldfish/audio.txt    | 17 ---------
 .../devicetree/bindings/goldfish/battery.txt  | 17 ---------
 .../devicetree/bindings/goldfish/events.txt   | 17 ---------
 .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
 .../devicetree/bindings/goldfish/tty.txt      | 17 ---------
 .../input/google,goldfish-events-keypad.yaml  | 38 +++++++++++++++++++
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
 .../power/supply/google,goldfish-battery.yaml | 38 +++++++++++++++++++
 .../bindings/serial/google,goldfish-tty.yaml  | 38 +++++++++++++++++++
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++++
 12 files changed, 228 insertions(+), 102 deletions(-)
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
2.52.0.358.g0dd7633a29-goog


