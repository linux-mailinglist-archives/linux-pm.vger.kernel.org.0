Return-Path: <linux-pm+bounces-40441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCAD02335
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC37230A8669
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4A3D7253;
	Thu,  8 Jan 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRkdeZiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDA3D3302
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866425; cv=none; b=mgIIVQhYHoGOoBN9Z9eycOrEf8Cfk2q1qarRhSF1D0sBOO0YdV/m1YFTlaH38fwpA4+mhIRUsfDeu2Pj98BJcyyYJLHE8/YFz/fUDgbFDNmQ8zg3DAcJ1mD1QjvTRyzpIcRatSEAFSskXx+dVSdQtFUAAuDclG0xM8hFj82Y2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866425; c=relaxed/simple;
	bh=F+HI9weCrGvZqZdvGzT41fozcChUp0aiMuJIzq7Twlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X46IxH2kXIi9OXRyfri7yooOQyUxEINzr8TCGDKdz4+hiQ1znIJmPUyp15FiyUoakFy3CX06C2IM9F1glLeXKsn/2pvWwoxtRxvKCna8p+kk+O/B+UfpePDCtz23ck7h800eyQ1Y9h8eRsASpbHKY6joAnnM/iLjsaQabsFPIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRkdeZiO; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso1085200241.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 02:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866420; x=1768471220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNWaW5uyJY39Ee5wA6GOpA1sGvgkAjuELUOx96wJt9s=;
        b=WRkdeZiOdf7gBNdfDu8FOnDfbf5fn69bSJmJY53sxbyuwKBuBncrDONb9kpBUaUxCc
         jX/trX0xQFLuAB943/LXnVKBNw80noY20ntWRkfq9Lysr9AeEEMkx/P3alU03fpx/UjM
         vA+H9www+1UnCbqAMSvyIH45OvGi4X/yoOVoKqI51JxfP3rLz0TuyVslMrFAQD2Rgkvw
         2o0FQpZ8ZMJGJ47mRR5bxr288GwyHhq6myQXRpEUXsqlSPty2KpPYjCbbhC9K6uWgw/D
         TDpL2VQtV/tKP1N4dlGTOEcda7buvDElsTFJu7E87hyl8b/QNEYBTBjy+k0KEWKuY0g6
         BLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866420; x=1768471220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNWaW5uyJY39Ee5wA6GOpA1sGvgkAjuELUOx96wJt9s=;
        b=WlVorKRHdZghqsdecBVg+K6Nd7BQEeov0z5G0RqDPZwLnHOzBf5gNFm8WifXlPvQDa
         5AjJlMcf1ZLS0AtX15LVIz1hXN8Sx30pl5ZYx7hKznA3ovpMkB7ee1otsZqTKnin0uSC
         9qJmhPen1OtmzQIlrg2UynMFCc6l9gYpWIIYD6AwRBDb+y5J0D2JZjO4qJihWrTLHx37
         TklyctCpWqWhFqjtfAcxTDluMV+jOK1hB615R9E6aF2V250QAuRUsAn6AMPKRG68aJbh
         KD4b5AvYgONekakfudA3e6ClIlY015y7gidYrAhFZhetIRVmZe8hDoPBYsMeOGmKY5fx
         JW1w==
X-Forwarded-Encrypted: i=1; AJvYcCWjK12pAJGvR/ly3147x1DcLVlGRnRH7wgH6aF4T2bFNmkehLxfzh7Uz8WwJsQykQj8pQpu1ScKjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVjmGrica3WO8QI9v9dL3oYxse1QV3fjF9kkWxDAtpN3GCO6+
	J9NcxyZPwWSfmEtl/dvbEW2sKl6YOYiK6e8F67iYjoemeItWwOKu6wEBFeu1AA==
X-Gm-Gg: AY/fxX46T084U+KdgbYlR4I7cseqV38gTRf6dSvBmazajLrE7SQ1REz25QTfXCZux9j
	s5C3jPpwDMuZ+/zgXK9U0WXFuoFYp9fQmgV4DSS5mgaHweKtRt1I3VJaNyo0xTgOVNZR5AjBqfP
	p0vHUxAydLl7sZh2/Tbf2g9f+oBLHiDK0a+2nf4+dG/HG7NIT+I7AgT1PdRS+8gk4wnZjCgcOfk
	mlFEBRJ7pWAQNbLniYc6mfK2CZkoUtrlRwZO1KFRuhJW4hAvBbmgGRKW3DBbSUIW29YguGFkznD
	CSBnBkQjnwTQN76XC210/jXcC6CVbloP4UXC/6qmHmJTKVyjwRu74F2zc5aHLpTOXy9Hil3o9kO
	YHSDoijA1bW91w5GM6dPS71jgy1ZsWYozB10YPwQ61UeLOh3rti9S8rde3DYPpjmltEorj7BV2Z
	ZQ8jw17iFDYtZNTyzo/8TYNpr9KpQ3rzsL7wEyim9FzUwWJ0GBMna6vFKfkk3CujQWxRl9pKFND
	e4PrSydyLv2GxDlB2HGlQ==
X-Google-Smtp-Source: AGHT+IHWNlnOIQoHRnNghuP/KuzB06upezljxGJd8aibyns6gUrJ5zRj9QVDAk4WOeIpJQ1oogEYew==
X-Received: by 2002:a17:90b:314a:b0:343:3898:e7c9 with SMTP id 98e67ed59e1d1-34f5f831c74mr8109800a91.2.1767859745886;
        Thu, 08 Jan 2026 00:09:05 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:05 -0800 (PST)
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
	krzysztof.kozlowski@oss.qualcomm.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/6] dt-bindings: goldfish: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:30 +0000
Message-ID: <20260108080836.3777829-1-visitorckw@gmail.com>
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
Changes in v2:
- Add references to generic subsystem schemas (serial, input,
  power-supply) where applicable.
- Update property validation to use 'unevaluatedProperties: false' for
  schemas referencing generic bindings.

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


