Return-Path: <linux-pm+bounces-43828-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDirBIbmqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43828-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:36:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BE222C89
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357AF3139AD3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D534029E;
	Fri,  6 Mar 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="JvuDaMDY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D134CFAC
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807594; cv=none; b=Y+hFt5bH6Ap9yo5EvlzA0ZMQbm6M1rksk2NF5CwliTnqPZBR/TTiSxfx9UQS4DqihEn+wTSJNLnPNq2F+uZf5YE4Fje0C01xYRtWmF6GB2ke4SKMer1E/nVbqIipzRln4vK+w3xJQchoNrX377qd7lJ3pKbJpQ/a4O+k2az+FTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807594; c=relaxed/simple;
	bh=V5+a72ZC6NLwNlJPuRbxmZ4cdjnC0AK1Zw75NzX2EUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ttrV4wRa+MWhB5dc+r/kPK3f2+4pfTq7RgLszLAqGYCeVXJxia6tOBm+96MjBJpUjBm/u46U0pBlh61mW64fCQNvWA6sG6/QtVpUzWUoF/0zij0L3XZ8vLenRAoSQnLLSIC11GiMNhzWK2uW2L/Q/1LM1H5N6gHxWTqAHKeXIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=JvuDaMDY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso101663525e9.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807591; x=1773412391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMFiA7z3ai1QGEzG7JWM4eDTrrfS1PgbZ2wKh/4AWAw=;
        b=JvuDaMDY4+QQYN8MpK7ZnPuHjigbI0jyrWMDZ+prCp4CrQ2FkuEIOsDwCMqUQT1QTI
         BQxMODtWcwnsefOmT6hhFvIw8vid1vHZ1F2v/go21iucry+YhK0yvCVDqLWSgcUeDDfO
         BvCqKM6O1Tv0jn8yNA1ZEmuSBfRXbekvsrtp+kurE+KFQepBeIqVEwUi1ee5Kq84Oqt2
         iad7Jmmetefa2ZeVkyP7x27F6Bsudxk9ZMJ8wWogI49oZniX4LX/2NQ74B4JgjQkHo1z
         Q2SKxgN22qFQ7A7N4cCCdF5vtRaFWmllSBLsIVcb+EAEOfOuNJG5OAH+6omP04uqdLcw
         942Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807591; x=1773412391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFiA7z3ai1QGEzG7JWM4eDTrrfS1PgbZ2wKh/4AWAw=;
        b=XRClmMJX0RAtZtxnYihKmZDqHx6FHMyn9wDZGV0Jau4p+igf/2nva8I9BVnby+rppO
         Z9cgfYW4LoTo0mFAC6im7eNRHXDmUH613qzgoPWGKJnyY9rERfndkyLMftrh13iL6XAR
         7cgMRLVENTuh2E1ySpjKiV4sxpEBQClzsf2hGkCdFJgSv0qz6RmJmxtARe4df8k3sSaf
         WJKxct7IoT0VY16ncwRvmnSS9NvTKZC2oMX2aY6HZSgrniJBbr7X3QOdF+rkz5JRQADj
         fpNjbHg6L7uqW4sjfSboHHpPyU30yq8BpWpTbxjXGLpXVSLlPOFUTyhn99K+hXwu3r+R
         mquA==
X-Forwarded-Encrypted: i=1; AJvYcCU76pWbPn7eXB0r7B+qDtgg3VgfhR958bYOwxziO2Nr4LURnvbCkD/Y5zvEvSdlUu/rfEsdasYlpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUjWaL6Bjt4J5mAEJmHg6id9EsEBre06G5hHGZ9IM9nEbSCwc
	zAgEdqiNgBRMGiZFav/WC9T3hRxL4fiOWyxJV1RuKhwh67WLmheceV17WT3bQT1ICz8=
X-Gm-Gg: ATEYQzy27xcj7NgcqYKrt/97zPs2H6bAy+C6+A6jRXXMl4IoaGnNBuzMYZg7fHHUGck
	scg5OTYh+8iZ9v7OIDWXQGlOFdohXKOknkNkuT0AKtDXT4IrozQFELnK4p6YMhS5FT1ERO7gDFZ
	uvq11az4f28z3mhf1bAwmkF8jIie47nC0oEcv95osckA/UUCccmS1aY2vVoiPaOpzeMKfaOr6yg
	jVGD5CkWGveCGogYxShc/ifbXTWye86eiGtVtxY7adnNFCYRC6zr3hh8auhbnWi4FzA5oEmlDWb
	7JbBy79wEyfQSPa6LMO6Bxg0NUS6GYYreuDRXn1+LPQoaep5G/HUT6XJyMzofz9XQhhDJRKEzF3
	nnaeM7h+vS7mTJTXvbT9EmKHXfX/FMHiwzbofKPS0e6/KOJcJEBRZYk015NxJe4AY2RF1P6bpCE
	8AH+pj1dH9qhVfeS6uq7CLkwjmEirQY5ZOcmpC6pb+nr59447+KC6Wb+hQAIIiqHb/icgRDPCUl
	dHrpA==
X-Received: by 2002:a05:6000:144e:b0:439:d8cc:3628 with SMTP id ffacd0b85a97d-439da89d71bmr3657783f8f.49.1772807591084;
        Fri, 06 Mar 2026 06:33:11 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:10 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 00/11] Add support for the TI BQ25792 battery charger
Date: Fri, 06 Mar 2026 18:33:00 +0400
Message-Id: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJzlqmkC/2XMQQ7CIBCF4as0sxYzQEF05T1MF7Wd2kkMRWiIp
 uHuYrcu/5eXb4NEkSnBpdkgUubEi6+hDg0Mc+8fJHisDQqVRY1a3F/KnM5KoNSqH5x1rR2hvkO
 kid+7dOtqz5zWJX52OMvf+m9kKVCQJUOIWrfGXacnh0Dx6GmFrpTyBbO2JJegAAAA
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808; i=alchark@flipper.net;
 h=from:subject:message-id; bh=V5+a72ZC6NLwNlJPuRbxmZ4cdjnC0AK1Zw75NzX2EUE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerr4XrRZXd4t/c4DBdMKF78/KlCg+ElWsUU1u6Aq7
 8AukY57HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz1ui8M/+M2HKnQ/5y6kGfH8i3qEkckg/97Pd1rMe+N7AmHWiuWLWKMDIeM1Et
 3vs6+cGyC0MtQwycazkq2a3uZp9bsKTm1zojHgBsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 6E4BE222C89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43828-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

The series is organized as follows:
- Patch 1 adds the new variant to the existing DT binding, including the
  changes in electrical characteristics
- Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
  driver, slimming down the code and making it more reusable for the new
  BQ25792 variant
- Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
  (this is a standalone fix which can be applied independently and may be
  backported to stable)
- Patches 6-8 are slight refactoring of the existing BQ25703A charger
  driver to make it more reusable for the new BQ25792 variant
- Patch 9 adds platform data to distinguish between the two variants in
  the parent MFD driver, and binds it to the new compatible string
- Patches 10-11 add variant-specific code to support the new BQ25792
  variant in the regulator part and the charger part respectively,
  selected by the platform data added in patch 9

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

---
Alexey Charkov (11):
      dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
      regulator: bq257xx: Remove reference to the parent MFD's dev
      regulator: bq257xx: Drop the regulator_dev from the driver data
      regulator: bq257xx: Make OTG enable GPIO really optional
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip attribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
      mfd: bq257xx: Add BQ25792 support
      regulator: bq257xx: Add support for BQ25792
      power: supply: bq257xx: Add support for BQ25792

 .../devicetree/bindings/mfd/ti,bq25703a.yaml       |  73 ++-
 drivers/mfd/bq257xx.c                              |  60 ++-
 drivers/power/supply/bq257xx_charger.c             | 534 ++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c              | 123 ++++-
 include/linux/mfd/bq257xx.h                        | 415 ++++++++++++++++
 5 files changed, 1164 insertions(+), 41 deletions(-)
---
base-commit: d517cb8cea012f43b069617fc8179b45404f8018
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>


