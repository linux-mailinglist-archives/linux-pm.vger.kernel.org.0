Return-Path: <linux-pm+bounces-29940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46ECAF05F9
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 23:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F317ADD7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D74E26D4E5;
	Tue,  1 Jul 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX9Lzm/7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E6261591;
	Tue,  1 Jul 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406832; cv=none; b=YR41aLnEQZDp0YWXncCz958+6Gq3U1CJEwDLIRYU3T0TaFtf/5RzlMNLXKUbO/TsDgfm1B5zwxnIgBDs86AD9dtfMutB1hqwmFBi68VsWjLH3WIyX3UuGU6E1yJMMYmw0nxzdmZXyqX2+JV18/3eY2v5NnC8YLpIOTiX/gVNuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406832; c=relaxed/simple;
	bh=C8lLoCZLb9NOz2fXqycY7xy1dT01ZnrX/ae5CzPdLs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iair5DVCGyVoFMG1LTjchXZ4+mQDVgkWfr0cC1Qnb6rHglxiZBs25uA/xNRvKvchUe3AizzIqSk92Z0XxPDn7cMt3aEKd5HwYSoItWRP2cxQw7yESnb+Q4aEUV4RYzIL1G6B/8O2xNTO6v9Ar2JVtyAYf2r3a0289j3dxyrDTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX9Lzm/7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3578055f8f.2;
        Tue, 01 Jul 2025 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751406829; x=1752011629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IP9jbTrnB+dBCbXbGUHJtoAAOQr6sB5g1NEP/C6nMg=;
        b=mX9Lzm/7iaiCest6/wlkJNDGXQRGav13OncBolGzGKPrxc8LyH1Pm7iu+wv50s+k6j
         SihreoalQrwALKVjHYndeW3yXmGiUvVKfNHa94hvhjirqalp+PPWH07NgT59FgSWRji0
         BktrFF03tzsO8rCL6AyErgZaYeaPbO0xEcB0KAkTsUA3QmGk6xqvKDDJbr9PhEPBvWox
         UKc0lVP35OZu2D4TOscjuuF/AJERit+QjgGUIixzoN5+hWdvnFp7/r5C7AaYfJUcHUae
         aKbB5U5epexZrrY/9/yarDOYx9tKS2N0VzEL6hr05g4NibpYa+nmrmgeTzscnw6ndaFL
         T6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751406829; x=1752011629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IP9jbTrnB+dBCbXbGUHJtoAAOQr6sB5g1NEP/C6nMg=;
        b=IVTYw9RiKcGZi9FCN/jFCjYSXesWkLIQuY6YlstoY2oE/ElpXai3SElajh0hJaqnr8
         g9SMvMjVjt3uU3MKu/c6RDKOovu+HyqKAc5OKoPxzedchSdCSfXoUX1vTwIeBeu5C4dC
         2D8SG30UYd8JwlkDDpU/MnjZdsz330ZAhQXT3GDl892WGF/VQy65J7vunyhuR9OmPPLT
         bfV7Ddt9zFpbDTC85S2G43MMIvPHzMei+t86F5Z5wTezkMSmTvjtrCMSZzl4Ireepfai
         6PyDpnGrYBMItZUX4BxlDN0Toz+OmsHqwPR4L+q5sWmcO13lMdnlXubEbT/LO0BGxHT1
         BodQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI0dbdE2ZdiczFqoKil7yCblrrAD/TNy70YPz2ZNJmHE2carIjbSgJo518qUGhvLBbDbx00/zLFMp2cXI=@vger.kernel.org, AJvYcCXrHKRax0sHRgOWSYhXSngdRdpfxsu8nKiJMpaIXsnrwy55o8HIt+BtsL7tStNkDYpGU6kfPemwGvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SoMRy4SoOyPMAYtmitRHoC9diKH3PT27+v87kEAkwj1C54So
	FxqqsurcMZ8CIBw5KM3yGB9jXNB3cSvKUKYEB9xr8LCf6REaMkVXV161
X-Gm-Gg: ASbGnctdxuBCRLJShcnTM3WGptEei+BpgbAe+BhuYL0tD+FP6AST0+9VCBG0kSakG0H
	2bV9HO/O5hMbEhMOjUCvubowCBvEvAvQofkydsve9Me2bvAd8IpQNT9weA8zwGxAGuDKgdKj3er
	pDHC9RdS/lgvFvXcBA78COByAUGJ7bHVveJUmKnQYstJ/ikScnSTfZGrQRJB1C5dX31UeCgpVg+
	ayKrKib5vrhoVaf2x08A0jcNKFVSyjG+dsMzZUBlt6H1oliVQ6vVhZ229lYd1xTNg7qtbmnGogm
	npG2MSkLG+hpVxxwfvdiWS7aXCG0Z868Y+KqUTzhHRYEdeXw9RnrGLZG7SGtTLSIlOHWkSDSlcw
	Nc/wmxjbB4o0DtvECQpXsyBa07BQ=
X-Google-Smtp-Source: AGHT+IGaa4CCKl/1XiN17JtmgKYB26aWAIW3tZKoFmOwgdyrkKstnBo1P/invAcoAtLY+kSE1i0f9A==
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3b2005840cdmr37175f8f.47.1751406828762;
        Tue, 01 Jul 2025 14:53:48 -0700 (PDT)
Received: from localhost.localdomain (89-139-4-59.bb.netvision.net.il. [89.139.4.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7814sm14076927f8f.8.2025.07.01.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:53:48 -0700 (PDT)
From: Sivan Zohar-Kotzer <sivany32@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: elazarl@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] Linux 6.16-rc2
Date: Wed,  2 Jul 2025 00:52:45 +0300
Message-ID: <20250701215245.95698-1-sivany32@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 69c534982415..ba0827a1fccd 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 16
 SUBLEVEL = 0
-EXTRAVERSION = -rc1
+EXTRAVERSION = -rc2
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.45.2


