Return-Path: <linux-pm+bounces-26438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD7AA42CC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 08:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2850D7AEEB2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A61DE3BE;
	Wed, 30 Apr 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+IUAFIL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFB1C5D4B;
	Wed, 30 Apr 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992977; cv=none; b=G5naraIaGS6ukZNVkukxieYV7nblv2AakSfOjuGea3GGIEKqOVuSktXfTp8RgxFyI63odkUX+4NloIPaIrDVr3dhOMp+OqKpjCxcfHBAIrkOl0ywxT3bmy9tPPVx43BkXVuClCn1A8QqQ8TR8Hw7NXq+TfO++5baGYs8ePMfpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992977; c=relaxed/simple;
	bh=m1fxntep61CEh8RG92/yJYgEWk+01WXfwNsP3Ap5OYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmB95t+gAtfFK7tuBrlC4nrcmopRaO6GnRWWsdxaDwhGe2axgFiqU1s16b/HNxEH2dckMxZKUAR5wsjd6PZsmW1qCENMVLlw9XzRTvYUpGWtTdAzdNvdDZE4S4Wp72MkgjG7UqLLBId+budnQnHsnZCq3yC3cuCHG4bsxVipbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+IUAFIL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1226765066b.1;
        Tue, 29 Apr 2025 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992974; x=1746597774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRM/SvKRDm8ts4sKPX62x6oFAs2yVuLzw1ucr3dXGnY=;
        b=T+IUAFILX/U0Ff9yEw9GgfAZGfBteHU1EP9f1A3HDzu+ru52GxiGPpizH6PSh7pPNn
         dGh1X9ZoRQDmEXfOkPhSOwj/yXUMxBOSYF3/tiuSXUDqdP2ZRG0/rht/pTqbN3W5ejuW
         zNpzXpIbFhYmRQRiHx1yvG+KBWRBOb3/Okd8t/x9ZqHRvZX/+LGE0u58GAOJbxPDr2Rn
         qh1kYP/PqSt7d95qFA4eEyjbyfHYqT5zXpdGFvI090Cl+e2Erq70gbaH4S5U/tMft0R+
         N1lo0fhzXcUg/aNBS9gDRIVsuorzzu5MnaszMoLO6zVERo9ES2QEoFGTenklIcKdlVR0
         HtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992974; x=1746597774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRM/SvKRDm8ts4sKPX62x6oFAs2yVuLzw1ucr3dXGnY=;
        b=iH21FjVNoyZOrku+eZVwq5h7A7hXVgpEw8KbDH5bktAFz8VZLMmNbI9oY0+f6c3Hd3
         sjwbVF77esceCtCvzESNQiq5RoQlvKo9Jp+5DexuTKP5R/4WNHa5L8DtjGlGGlAjp6DI
         kwljcVMtTms0azbEvL221K9epa7YMDaF2wjYPAtP3xkUhRI0tmojk+lPQMq2zIigEtSE
         SspeVRL4t5iG/p9LLw/AN3clH8N69c2bNKlY/87YiCwyndtyti+7aozDlLzps9eVQIE4
         MptTSmEDMIRdWANluMHIbb9cu3HOfwq67r0tujUnXudkUJTTczwF+3VB5OMt+TYjRIku
         Fnlw==
X-Forwarded-Encrypted: i=1; AJvYcCWR0tGhVEB8wzHqCtcGJgz7n7l9vXuNyFcExPqURpYNhbWwoJU7fWakT9r3d7Vnhc/SFHdPVjTSnERBtaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdszjJrajC3+a4GdNRKYZxb/yHREQkBNGH+7be/zxj6vwEHiN
	eDS2nmXzVFGj7150pwG91OBxvYg1vVfHKruLNuBfN/TJs9d4xtHA
X-Gm-Gg: ASbGncuKerARfEMju7nNrH/C34bZ9U6ZSXAPvCthKEe7ps71QBwCUyFudtAgiBI8dQz
	TyBzdpfObJTe0qfW2UiDuA6J3+3OBRp6jHXUSLV0Pj+6lIijIqcxOdOy9zkW0emCSgwG7jW/bWd
	IjHC/l8BxDW5o45WKDlRPbWsrIkXKXx6HuloeUY/jwkBmeja87fj0SEN6CRJFF7+buyN3nxhvlO
	NK6Nv9ceek886qrhYvlC8W3gx75EShxp+fHBScqIm7Cj0bXMzcQFb8wqlP7/umZiyYBpZWF/IxF
	ntI9cKzCBVYd4WFsPfOESONXhzl0mjYm
X-Google-Smtp-Source: AGHT+IHz72j1iXmIqitj3i1NwjvzM+WsyTxE/ik5CDTXqfGyPFTh1LKW5P2awUfXGcJZEG3az/FRGw==
X-Received: by 2002:a17:907:3e12:b0:ace:4df8:b0c6 with SMTP id a640c23a62f3a-acedc6f099bmr231241766b.38.1745992974392;
        Tue, 29 Apr 2025 23:02:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354632bsm8206760a12.57.2025.04.29.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:02:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] power: supply: max17040: adjust thermal channel scaling
Date: Wed, 30 Apr 2025 09:02:38 +0300
Message-ID: <20250430060239.12085-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO thermal channel is in millidegree while power supply framework expects
decidegree values. Adjust scaling to get correct readings.

Svyatoslav Ryhel (1):
  power: supply: max17040: adjust thermal channel scaling

 drivers/power/supply/max17040_battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.48.1


