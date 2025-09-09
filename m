Return-Path: <linux-pm+bounces-34291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E7B50536
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 20:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468E61BC86A4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279CB352FDC;
	Tue,  9 Sep 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OitNkwcf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20D747F;
	Tue,  9 Sep 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442576; cv=none; b=KfjCqTnn03YLGoNfOhJZVBqJM4b/eZc211fBnCWOZp7oGH/NgJKWudkznBgSkTzO6T0J8Yu145FpFcnODOBNfW9pSXjfc25MEgkPPDAEWOd5ukDQZbQZiZ0+qj0h620P2LUZ9ZddHUvMDaWWb6gAizhVUNhTsj5yobwDktQ5S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442576; c=relaxed/simple;
	bh=8/VhQMsCYdwokncl/VGkbezDDLNFgwE4Ik+VJqNIH+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RTQbxIJ7Txvp0upOQdz6PcifmNeO7oL57wxdvrzbhThc5oEF3xnMXB3uXoxVzdP/ECHWAFYvjQpwUSY+VQ5CcG+YX9DUQbPgiELJdgmTtZ8LoIiCkL/TZgC5jXbhvLmjHOHDu/eW9620VF6jNGsr0DuPkyrir8bL1P32evGvjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OitNkwcf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b045d56e181so890952566b.2;
        Tue, 09 Sep 2025 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757442573; x=1758047373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YvSQYwo7bHxPE4EP4TGCXv9yZH+Ts8UI/kjqLSZAlA=;
        b=OitNkwcfrjeqJEHdHKdK1pSk1RLLOzKMGI4cgTs2V7S//e37qOkZvfZfO9WduZ7G8E
         uKMVhLrQoMSmrrt+MSjcrJSO7tpsnz/zq6WMseLUghlA+tmL3gMCgEDk+Yl3XyVi95wG
         So4Shnqg6sMk9IzS71cO8uwbMP2dykEmtOnrzvXDVi9IqdVHWhv88O9K59UvX5KbGJWZ
         nYMJtIN4Ff+W9RtA32XJYV5KgnBcJ5F3dXKOfSw8CCmpRByPIgFu8D0gQUVB5j3/AH60
         kg2IQn7MPitZJK+y0RVen+gdnQ7qgZPxu2izbWSHBzw4fuX48ODDxkHrWdGFbRMUzwoX
         Kn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442573; x=1758047373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YvSQYwo7bHxPE4EP4TGCXv9yZH+Ts8UI/kjqLSZAlA=;
        b=vh36pYWfgc6NzcouilFDPYc/WIJg/6WuBtgxaNaYBG+qJfhH/1Yt7inleIWwjZkS/H
         6GY6Jp99/uZzt8hCNlerHYPjW2BkTuEOmCVE5MKxINt1N0y9B2gPh1EnxZAJz+aCNoCX
         m+dghV+usLXaCKuvjKVEyM+pT2ge0f3W7jOnBRpOcQBFxo7Km319tzUnHEel+W14sG/Z
         rrPJOzQ545SpVvYYQh/qanlZVgrpEFIQAmhXbmpXG9oMVXTlRqhvIldWSh9fYlPT8mTF
         bqV2+erOLIhk1WB7GwAOkedig7dcekcYmjwprZlTnLpp7oE6OVbrPdghWyeo74RU9zSx
         yb7g==
X-Forwarded-Encrypted: i=1; AJvYcCUy3TkgooLsj5y7Np2zr5+cb0M3NfApQQK/bpOHJNfGQ6NRAW1PmMe8Mg+AjslqpIyV2HjEF2psm60=@vger.kernel.org, AJvYcCVRJ6cOVN1JK9n3fwOh4YjzaaFsO4/AIyO9RqCW3ylQmtio31CxzraTf8yWpCFsKEoUREnSvbhup4S4Ce0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYvTGBs3Vo5kRcRs/1YrwVyFO5XGZBX1eGn7R3J+4dHgS0ODR
	oMu7IXOAZiEtThKS6g0uhBbevek4HnhHqLG2zx+H9ddZr0q/7ykD7aMm
X-Gm-Gg: ASbGncvs+LLdCTEgsbQODlZa2lh56h0ylk//sktvGtlAT18k5KTz0B2x2fZAyeArQB3
	hkXjYQJzIkmtIFmgqnnKeyDUk6hRA0gOMjHk42JDF3SIezccKnQ/trKZJyXv0WpZVBumc62seN0
	OalDgFF5wix7R1ssd/PJuBsdQ1+K5cYsaQIH2ftN6A/dSuHvBlst/vg/LlimddoOdYttknYpwPT
	PJ+1/ElielemQzOr8uMoUCvtbr3QEKFQtwfIQ1CcV3TtLk8NlEdBpNa72j5y6Ih39oJMZhHLQVs
	6Virl5eZNbePiDWfrKhi5VS47Y/YjlF8hWonYP7ZKfldgpcV8HESlOS26Rbzk8qoHL0bHqjdGur
	QL8FZX7jwaM/9gl30xIvkOc4RA2AdnnO9/vtNGKl3GA==
X-Google-Smtp-Source: AGHT+IFcw30pZdVbvqIn23OQkYsVvw7+ElUc8E1dm0PvAq4GMpXt/lHdNRTNqck7AEfAxyfK5cBvMg==
X-Received: by 2002:a17:907:6eaa:b0:b04:8701:7304 with SMTP id a640c23a62f3a-b04b13bf6e0mr1320121866b.10.1757442572628;
        Tue, 09 Sep 2025 11:29:32 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07833ebe61sm30520666b.89.2025.09.09.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:29:32 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2 0/9] power: supply: fixes and improvements for
 max77(705,976) chargers
Date: Tue, 09 Sep 2025 21:29:10 +0300
Message-Id: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZxwGgC/5WOyw7CIBBFf8WwFqUvUVf+h2kaoNN2kgJ1qKgx/
 XepC/cu79w7J+fNAhBCYOfNmxFEDOhdCvl2w8ygXA8c25RZLvJKHAvBrXpKKUXVSHmShyaNqAd
 q0E7kI1hwM4eiKzOpO6WqA0sgrQJwTcqZYUXpch9mRbdxBjO4/Q94D9o0k38kWgsjRqDX+j0Rd
 Pj8Kl7rlAcMs0/Vahyz9fqXXMy44JDaVhddWxb5pbcKx53xltXLsnwA7pdl2RIBAAA=
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757442571; l=1710;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=8/VhQMsCYdwokncl/VGkbezDDLNFgwE4Ik+VJqNIH+8=;
 b=EOQHuaCWUoFI2GU1R+FHQrOxNrNj3ymMFptThRX1N+zlMd7CD3N2QTXn5WdX0mnwmZudnplAB
 zEKBwaWAlDjByeiQ/iunIEVjBcOmHvMDCKyddMYNKxQrRVWvnLnhwHf
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This series consists of:
- max77705: interrupt handling fix
- max77705: make input current limit and charge current limit properties
  writable
- max77705: add adaptive input current limit feature
- max77705: switch to regfields
- max77705: refactoring
- max77976: change property for current charge limit value

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v2:
- fix charger register protection unlock
- Link to v1: https://lore.kernel.org/r/20250830-max77705_77976_charger_improvement-v1-0-e976db3fd432@gmail.com

---
Dzmitry Sankouski (9):
      power: supply: max77705_charger: move active discharge setting to mfd parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: return error when config fails
      power: supply: max77705_charger: add writable properties
      power: supply: max77705_charger: rework interrupts
      power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro
      power: supply: max77705_charger: implement aicl feature
      power: supply: max77976_charger: fix constant current reporting

 drivers/mfd/max77705.c                  |   3 +
 drivers/power/supply/max77705_charger.c | 386 +++++++++++++++++++++-----------
 drivers/power/supply/max77976_charger.c |  12 +-
 include/linux/power/max77705_charger.h  | 149 ++++++------
 4 files changed, 345 insertions(+), 205 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250830-max77705_77976_charger_improvement-e3f417bfaa56

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


