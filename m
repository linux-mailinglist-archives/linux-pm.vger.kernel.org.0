Return-Path: <linux-pm+bounces-43539-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /xfTA46qp2lejAAAu9opvQ
	(envelope-from <linux-pm+bounces-43539-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 04:44:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B91FA7AA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 04:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31CAE3018C09
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B637647F;
	Wed,  4 Mar 2026 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUAhM9YL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EAE21578D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595851; cv=none; b=bGnKbsBMyMQGWiaJIVaIueu7piXK/wtg4dDIi0EjpQm9IxGsBIHCveyQAPKpdO+sZW2JPLrYnL6OR8TVP0kwWjIx56cQnwYBjaXpN4QvKx5UqjC4dyBc7xzDRq1OoI6jq1PZXgzvhof1HnQKcc7v3NsJ4yM0lqEKRC0v5VKBwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595851; c=relaxed/simple;
	bh=97IdsNQD0Rvl8zYfDuEsgyoRn/f/Y8Pl2UCDFUdnpBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Si84b3lQyb43LdLH08SzLFo27rD0Plk9NIWWqPuFMrN3QAkdtIS3D54+MSgBNh8CwnGk2ev0AD9zkv2FGL984ez9duNg79M5E1hKTDEI5U5MI/VXJUwxTMJ0a3kmFL/5FX71em2XEKVU18Ko8quqM4a/ZEIIkNYNXnmiu/ZKDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUAhM9YL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a133cdd4aso11374356d6.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 19:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595849; x=1773200649; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UX3cCFsEn7IKh2oIgy8th+LH6QgE2NnzyAhbtsRwgI=;
        b=cUAhM9YLkqPglhBp0FU2zbHz4hXHg/2OzOu/GA+wvGpGZ8/aOHajvxGC7twGJy5Lhv
         rFuiictfBOQ9zcOTWCMwkkKR6+SYxB1LxkysRRfiXbtriaBmOUQQxcE2TWk8RFu1aic7
         2+ysUOI4WPP/9JwmbqGyEC4GcgmKEW4oMoC9HJEFKhpO2YbHCI7m1aivzzrobk77NlQQ
         s2voId35sh5ckMfyC27VRGbYSkJ0P83CnVblrtKcpd+eroDPhLRkKv7HJNGvQfu6Q/q2
         9tqlw1coyByJF7TPbi5josZmzP4Cbk3IGgkZztiky+RmbANm9oNSCcfMnfL+PuqAIpUV
         6BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595849; x=1773200649;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UX3cCFsEn7IKh2oIgy8th+LH6QgE2NnzyAhbtsRwgI=;
        b=NN18b5U0ZR0s+GcwFieBMI7Ry6B0RNDZpQulX4yyaYpqtGfhWqJX3mbNn72VC9DGTa
         r5M+QyhayoRwKYxOAwzisnhFQgJLUG2h6L2OEpXMK/MDY6Gx0OfjEalFIlUGEqsnPBMX
         nsLhV569dtumVymT3dJdhhmzGi1I29k4mEJpuX8gWD82pW/LwFCMTeE8RgI+rsophwDR
         hRysEz5EeppRF5po759CDuQ/Aw7/QJWQEEPuycuT6xc4CypR+ZlgzlqyKQ+Kc8AhpPsL
         D50wqxTxaevJPysXnkcpIW3srjZGlxyiWaNSlB9yJ4oapd04QlmU5dnyTvFGhswrE6Rv
         xXDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcE4QltJ0nSHo3S098ylAZJuntSmC9soT6sSEPutLnbXhqve29FXAJlVSXIBUaoC1fPIUzAtyccQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hdAA60NQjlW2fAqfbmjAUh5REnkdIiaVlTEikMsuFX2UZIss
	Fo5385YEC1MLrhiBSS3MTftsMWIrzPyCiSJZsbk9d5Crs1BcbGKreaQr
X-Gm-Gg: ATEYQzwQhgfm5RHJObTlGY+hOS0eUubV7yvOOY2tr8GmgF6q2JPHylBnST1d4X+U3mM
	xCYUgSfmN4OWorcjJx8qU0BIfHS7B+CkFuwCAZru+o6wVnUF+b5L+KJbRzytyNqWsGZE/+wB6/0
	DldhYWGvTyOJJ6xsdeGXG6i8c5XP9wMZaUATxfZavMAQy3qEhMRgYT9qCfYyS7KUq7nSZjFcwPU
	mzkMswrCu0pSHUKS5puJIr6Si00/3wZBOmFetxM3yZIxkP6U0mVBLXvyjwk52UQ08ItBm4c5/+o
	CXqr3ku+J3w99IXa+0hnlCi4CiQzFO0UudOv249jrpN5pbArzkpW/ELe6g3eyg/KduYOOwXC6ao
	+Zf9YhLpl+uyyGtL+10Taaors/rOZRtWlmWIBljFYIdI7xVWMeL9BEI/f6MNnkWpwwbyJyp2eLH
	PNujFTyC0BYo3bX5joBXaFhIfsO/3TP+mQ3CUJxA==
X-Received: by 2002:a05:6214:1d06:b0:89a:ec6:101f with SMTP id 6a1803df08f44-89a1998c1e7mr7800326d6.1.1772595848813;
        Tue, 03 Mar 2026 19:44:08 -0800 (PST)
Received: from [172.17.0.2] ([134.128.219.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e608cfc6sm88603286d6.14.2026.03.03.19.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:44:08 -0800 (PST)
From: Yuanshen Cao <alex.caoys@gmail.com>
Subject: [PATCH 0/2] allwinner: a733: Add A733 PCK600 Power Domain
 Controller Support
Date: Wed, 04 Mar 2026 03:43:43 +0000
Message-Id: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+qp2kC/x3MQQqAIBBA0avIrBuYUrS6SrSonGoIShQikO6et
 HyL/zMkjsIJepUh8i1JrrOgrhQs+3RujOKLoaHGkiaDs8GwHJYIJ6c11q4jJjatNx2UKERe5fm
 Hw/i+Hwha8cxgAAAA
X-Change-ID: 20260304-b4-pck600-a733-1790e0e48d49
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 775B91FA7AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43539-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi everyone,

This series is to introduce Allwinner A733 PCK600 Power Domain
Controller.

Allwinner A733 has this one power domain controller, PCK600, which
shares the same BSP drivers according to the package provided by 
Radxa[1]. Unlike A523, A733 does not require the resets. Apart 
from that, driver wise, everything else is the same. 

Add support for A733 power domain controller by making resets optional
on sun55i-pck600 driver, adding A733 sunxi_pck600_desc and dt-bindings 
definitions.
Tested on Radxa Cubie A7Z.

[1] https://github.com/radxa/allwinner-bsp

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
Yuanshen Cao (2):
      dt-bindings: power: Add Support for Allwinner A733 PCK600 Power Domain Controller
      pmdomain: sunxi: Add support for A733 to Allwinner PCK600 driver

 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    | 17 ++++++-
 drivers/pmdomain/sunxi/sun55i-pck600.c             | 53 ++++++++++++++++++++--
 .../power/allwinner,sun60i-a733-pck-600.h          | 18 ++++++++
 3 files changed, 82 insertions(+), 6 deletions(-)
---
base-commit: 0031c06807cfa8aa51a759ff8aa09e1aa48149af
change-id: 20260304-b4-pck600-a733-1790e0e48d49

Best regards,
-- 
Yuanshen Cao <alex.caoys@gmail.com>


