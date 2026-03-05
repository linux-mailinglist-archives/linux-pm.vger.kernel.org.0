Return-Path: <linux-pm+bounces-43637-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMblGZP6qGnVzwAAu9opvQ
	(envelope-from <linux-pm+bounces-43637-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:37:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8220A97D
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B28303F7FC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AB263F4A;
	Thu,  5 Mar 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdzX1E95"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC071EDA2C
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681653; cv=none; b=SX32lTCJKUpIbnfMK4EA/R8y1Vrj8JEKH+PkzdDLpd7tlDiogPqlCDZnAiN3KyxgfNJLM/aihmMCOAaMJNt32D95oo8q90w6PDj4zFbyI8A/8LAb6KBUW13mMtGCxkOTbuWUhF+Qhgael/JNxYgtsPTxuppK0xKFJuDDS/n+rFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681653; c=relaxed/simple;
	bh=NMf/UuC+6nAcyqNjQFRCqhg1UGaJWlr8nrgTlWj+vis=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SwfXzIPN2qUkADNis7cF6BgQmou2eiWBfyOgUtspYx9hDY87BCM7lDIaXSzUA248lvb8lXg8XBRbEKCuQFQTjcPr7UDq2/OoVdfFcf9PDYDehPa2xjsmVrMLUtwq1aN5FWcQ0WelRZeqaiwE/vY6QLbAtDAD8VkqQnIIWEma1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdzX1E95; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5062fc5d86aso67844281cf.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 19:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772681651; x=1773286451; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRmZpXw1Na1Jt0sZYZ3Dk4vuOehC4OWy1CGhTN9jzyk=;
        b=kdzX1E95jC5i2I8BeTXMJd/3I+S9bGzgXdoqz9QZGF6br+fpg3DsueLAAsPff7MKmd
         DoVrcJ2VgvrfQ9GHYMz6Ijxu3Q17244rW/F80t8xE5YWv9xqubok8whEcdkgmDtRjChK
         r2CLY/AOWwFkQdT1qbOor23GLuUKMLS1O/UyQWgP74GK9LFmEBj3udYF7Qh7gewsQZKo
         BiDmeyBRYEbpQY3Gbh0eYDB0hKBDIJxlEY+r/Uv5rhyxEV5FOTe51azXb560cyqbU1nA
         OQXZrmJmZttVWNdslX78MrPlMkVHEXlkVCpsfGV55M+4FRgwF15PSvGzOB3D4OnlL9WC
         35/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681651; x=1773286451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRmZpXw1Na1Jt0sZYZ3Dk4vuOehC4OWy1CGhTN9jzyk=;
        b=pE3MRXuD6ti3sTwjfulmZC925FsXud5YsTtdc6M2ZV+FCVDQxJwmmOJcS77j4GfPXR
         In99+I/osZEseC23C04I1PMx0ChkDiIPJsTC7FYlumwhMs88dlxZ/oEDi3c9+kmbXbE9
         0NRe6uHufMVkwCccF6nJe05bZOpoCcrTDlXAGyfs1Exdag0p/kelQvIzcC4lLypti6ge
         AE1fJ4/2y0yrKB5Oo2FlPYW6NMNZUx/diuzjpLc/1yhCWZwM/fRHbBtjI8wEQAic6ZiU
         7a8X0c0tNS/NCKNihT4HFc3UZe4DXzFPeeVJ+SXd3XknwxJFXuinvXcpM40tVkHI0GfA
         oaYA==
X-Forwarded-Encrypted: i=1; AJvYcCWh7KBJyvV4c6pqu2Q7rFHQKPJFRw6V3eMUaJPU+goM2jHSWWfH1k23etbvx7hoCw0BxAJiuFDSbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXe0pkYaC0/FqZFfmlhJ7D2HtU7sXtgBRooB6Qvlm8mRLRXpR/
	ZpsgolkCiMrGkv/D8z9FGhYHmt+YmR700MfBfczP9p5kKNZpA330leEE
X-Gm-Gg: ATEYQzzU3YxMU80y0hfRIt/1m09yfsVXM84Uq4PlENdFoYliq2894731LHcTyjL4Ctb
	O3fcXycSgyuPOjpOYUXKXnuzi4mVHC7SMX3YhZMWtZ2X30gWCKHu434u5FDtYDfa3m909KyRlz4
	mQMeLuNdi+lWl20ymtFFDJ8Nw0atD4V+6+ZVGRjeOZCX645NdOBjVNXL5y4SgPF/4voI+vvC25j
	Zm6pkQx7j/6AfRnoNmJeDvqUWI5gQYspJ6GLnb9HtuJ66gb+vOoiqkJKX0ptrcrQzG2yrLZWYvd
	PUe8ouil+kzy12o+6dzqaU2tzzxQVIbHjKZ7T19LMMp8wRHgSqj86zxjFhD2Ps2d1v6sd+HXvwC
	pkal0vitu5kYJ9A1PAOBtOHCbeTC2ddN4jzcQ/XmlH7ZwnTwMRsCHY+5SBmh+uYENy3NBMREaHK
	2UFQR8IWFpKiS0PNA7zoorAbr7bgGVTZI9sWT1Ew==
X-Received: by 2002:ac8:5f11:0:b0:4f1:dfc8:50b with SMTP id d75a77b69052e-508db3fe6f9mr57487911cf.76.1772681651474;
        Wed, 04 Mar 2026 19:34:11 -0800 (PST)
Received: from [172.17.0.2] ([134.128.219.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630b6sm190667601cf.7.2026.03.04.19.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:34:11 -0800 (PST)
From: Yuanshen Cao <alex.caoys@gmail.com>
Subject: [PATCH v2 0/2] allwinner: a733: Add A733 PCK600 Power Domain
 Controller Support
Date: Thu, 05 Mar 2026 03:34:06 +0000
Message-Id: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/5qGkC/3XMyw6CMBCF4Vchs3bMUCoXV76HYVHKFCYKJa0hG
 sK7W9m7/E9yvg0iB+EI12yDwKtE8XMKdcrAjmYeGKVPDYpUSQVp7DQu9lESoamKAvOqISbWda8
 bSKclsJP3Ad7b1KPElw+fw1/z3/qXWnMkVO6i2fVdba26DZOR59n6Cdp937++DMi5rAAAAA==
X-Change-ID: 20260304-b4-pck600-a733-1790e0e48d49
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: C8F8220A97D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43637-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi everyone,

This series is to introduce Allwinner A733 PCK600 Power Domain
Controller.

Allwinner A733 has this one power domain controller, PCK600, which
shares the same BSP drivers according to the package provided by
Radxa[1]. Unlike A523, A733 does not require the resets, and it also has
different delay values. Apart from these, driver wise, everything else
is the same. 

Add support for A733 power domain controller by making resets optional
on sun55i-pck600 driver, adding A733 sunxi_pck600_desc and dt-bindings 
definitions.
Tested on Radxa Cubie A7Z.

[1] https://github.com/radxa/allwinner-bsp

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
Changes in v2:
- Fit the pd_names into two lines
- Link to v1: https://lore.kernel.org/r/20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com

---
Yuanshen Cao (2):
      dt-bindings: power: Add Support for Allwinner A733 PCK600 Power Domain Controller
      pmdomain: sunxi: Add support for A733 to Allwinner PCK600 driver

 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    | 17 ++++++++++-
 drivers/pmdomain/sunxi/sun55i-pck600.c             | 35 +++++++++++++++++++---
 .../power/allwinner,sun60i-a733-pck-600.h          | 18 +++++++++++
 3 files changed, 65 insertions(+), 5 deletions(-)
---
base-commit: 0031c06807cfa8aa51a759ff8aa09e1aa48149af
change-id: 20260304-b4-pck600-a733-1790e0e48d49

Best regards,
-- 
Yuanshen Cao <alex.caoys@gmail.com>


