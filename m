Return-Path: <linux-pm+bounces-18033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551DF9D7CE3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E438D1632E0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9B185B77;
	Mon, 25 Nov 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0nYKnJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B12A1BA
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523489; cv=none; b=lfKKzqQ6sIy3m535tHgu/CWLsmdEqhB7W3bImHLs63coOJ+Zg90mxh0719sabwVlhMVkiM1Lcw+QrG6YDUHQ0PZ/GChS63ZZ8hBvyve9DYbn4OrVTW5fluHg0ehnouMeYoxQBsu+ivE4+IJTMq+R7ReZXPEeoolFxUV6JrQO/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523489; c=relaxed/simple;
	bh=He1DTAeJIyTPOcYmAq6cC2VSNdhtBdgya1P84hM+ZK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SxWkehO7/WIzrzslKfzXvhBSQBDFZ4uG5Riq8Rvoe+pCEuWm5sCb7+wJrTHz0/riIZ/sBzYAPCC8TYVjnNZKoXX1jL72a9E5C9Fy5KIC8M2n1mz+2e7Nm06DVt+yEEQ7zxPeCQ8grdcUAAxLSC3rLDkwPnx4J0HvKhFopIKm4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R0nYKnJH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7251731d2b9so73799b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 00:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732523487; x=1733128287; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Vcboz9yqJnuOCvwaptZL2oHcohzZsxdO1sPf8vDF8=;
        b=R0nYKnJHez2N5o8ZhBS2IVS7ji7thAdrMTQpcEW3r5Jl/FekL1t9cVYeMc3b/Nka+n
         jURe07RKHdzPVYaI7/8WicCC4pkttwbNrvHo6CMa6FAbJRmLqbKPWuRdznOlNAVPewe9
         H1CRsIal1tweaxkb3GrwBZafxzDTcaV83+vEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523487; x=1733128287;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/Vcboz9yqJnuOCvwaptZL2oHcohzZsxdO1sPf8vDF8=;
        b=OE4WtXOLSUCem5zdU32exOFODbeNbU+n2eWiR3ZB34gGTc8SuIHL+1WmBZ9k5IANHu
         W9teJ2Z17Q3kc5uTqAnIuu7XUWXngvWuUPimp7xz25pqA6OjTFtgkA0KNOjGnXXKAppW
         YkVjCXOA3Tdr77dbQOO4sbZLvp+hVcN3H5ghtN9yE/tnYNKmvabmOpBlGm3pLPx11cOh
         aE7loq9UQTw9tAXgBrDbKuTX410//e/e/LlryqZw0s7iiMp6Q+efnTqCr3JbERw45Ajv
         WdGv89CrvhkrzVKfejExKhnaUeH663s4iSh2B5XlBW09WhXjJx/QxfDIl+giUMTsVdP1
         i9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlYQ0h1+IbDgNWh+jWilL/20m6Djc2fXlVHa9OkuFT4oFEZXnryotsh9TQ40KrXUtOhrl9xQcCiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFEkLJ1+AJ2soQJS2a9D6eKTsgMHgDIEqhOzM6ShBFzrOxKrr
	0zK6Jgqsgk9ENJb1+h2NwaHr1nvxU+vGAC7Xwi+ziSxL+zaPakUD81SwzoZZRA==
X-Gm-Gg: ASbGncvmfK9llP10OLJSm95+ZiAjTOw3iquxfi5z5nzCNMNN4qFX0tg6sI40ifwTE7C
	EZ8sizh+nweHzhBi6cYnlSBmaX1sqXC2mR7Hrs1h098F0l4BJCXcl6rFEgxw/yzpkKklSuOaA9y
	XZumgyF/Fni9TbmYTJTbcWyfufvvfjBnel5CGxSmdmQ79n6gHozOTnvPjWzB7A0bGZsi3I5geKE
	QAp0vjCbs07SdUda/CRABstVBdUponBjRhDh6ltBYZNFstSi6z+XozoT4EdIcGZSn/YYmch
X-Google-Smtp-Source: AGHT+IHErz94EiqWWoHbBTw76REJa1NEGWWXxWddsah0jH/Nk15nl1D8qZYS9TdahVOTmzplFY3DdQ==
X-Received: by 2002:a17:902:dac4:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-2129fe38e54mr183070215ad.15.1732523487360;
        Mon, 25 Nov 2024 00:31:27 -0800 (PST)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfece2sm59090025ad.157.2024.11.25.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 00:31:27 -0800 (PST)
From: Sung-Chi Li <lschyi@chromium.org>
Subject: [PATCH v2 0/2] Extend the cros_usbpd-charger to make it a passive
 thermal cooling device
Date: Mon, 25 Nov 2024 16:31:15 +0800
Message-Id: <20241125-extend_power_limit-v2-0-c3266a86e9b1@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANM1RGcC/32NQQ6CMBBFr0JmbQ0dDagr7mEIqe0Akwgl04oYw
 t2tHMDle8l/f4VAwhTglq0gNHNgPybAQwa2N2NHil1iwBzPWiMqWiKNrpn8m6R58sBRFWjRXY1
 5tKaENJyEWl726L1O3HOIXj77x6x/9m9u1ipX5kTWXUqTkkVle/EDv4ajlw7qbdu+zny85rcAA
 AA=
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732523485; l=1270;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=He1DTAeJIyTPOcYmAq6cC2VSNdhtBdgya1P84hM+ZK8=;
 b=OLCwUcBUsou2+ABwP0UXSKV7vUZPaomRddZGrl+h86RNJ+x71QSs7oiW+L7DP3Q1wvzytKfKH
 4ENfVmX64huAdUGwGKP6ecaGmBEYsfU1426QNSxPlqFMMjHCDNGYxz5
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

The cros_usbpd-charger already supports limiting input current, so we
can easily extend it as a passive thermal cooling device. By limiting
the current flow into the system, we can reduce the heat generated by
related chips, which results in reserving more thermal budget for the
system.

This series will only works on making it a OF style thermal cooling
device, so related code are guarded by #ifdef macros.

---
Changes in v2:
- Revise commit message for including the reason of change for this
  series.
- Remove uses of `ifdef CONFIG_THERMAL_OF`, and use
  `IS_ENABLED(CONFIG_THERMAL_OF)` when needed.
- Does not failing the driver probing if failed to register the usbpd
  device as a cooling device.

---
Sung-Chi Li (2):
      power: supply: cros_usbpd-charger: extend as a thermal of cooling device
      dt-bindings: mfd: cros-ec: add properties for thermal cooling cells

 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  3 +
 drivers/power/supply/cros_usbpd-charger.c          | 84 +++++++++++++++++++++-
 2 files changed, 85 insertions(+), 2 deletions(-)
---
base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
change-id: 20241122-extend_power_limit-62c2d9aabfa7

Best regards,
-- 
Sung-Chi Li <lschyi@chromium.org>


