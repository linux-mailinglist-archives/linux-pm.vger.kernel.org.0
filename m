Return-Path: <linux-pm+bounces-32020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5BB1CAF7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DD71618BC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02C2BD597;
	Wed,  6 Aug 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Oxlo+nVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376F289373;
	Wed,  6 Aug 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501719; cv=none; b=O3kni13sk0CpsYRAdTf6OeC2Xwn91GlfaplospHTK1tRroQLfFYTz+ea867jGDBFX1gmhvCHJ0PG8qwUL2TnKLCZNCEFOG9+5ZjFx6MpbW98HWC7I0m8A/Y11Uy4/BHFWgXWzoU/deguiD6qcKSf4P0Hh8ViGbVYwyD1EJ1tyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501719; c=relaxed/simple;
	bh=eJGICosdXjxas1ToQdEVslbW48DwDha7KI4VsUvnZU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iijoAkD7nzumUvJF8D+2jB6iVJEF+/qQ3UW1EQ/prgAM4K7wBbyc/d98i73FxQbSDLPwfTIoipleUpa4XxKkk2Ji7+5bX0pTcqMA6L/MjrTvUxHfQQttCpGnvMC6HupwYBrFU4FXKTQ1MEgvtvDpMM31dAL2HmXNw/xZjcemW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Oxlo+nVB; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=uqGmJn8cJZgdCQ0s0hosjUCyOf8EkpHhMcNeiToi7DM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754501632; v=1; x=1754933632;
 b=Oxlo+nVBCnRdZT1wE0LNmuNE8GlrGS86Jm//yANCp0yD7Wykci7snNLbOJCYBIO6FXHwwZcD
 pzy3JGhgAeX+be8t6sQHKyzPu/FDP6i43T7RvOi8DEM3v6HQn1EjNj+Wbd/WO4FGuUI0T2lbLEs
 NKhGj/2nKS6Pi5s81j/FJKjaHp3ATW6vhY21y3Lc9xLbU3kOPYScmIVJGxbYC2IzbgGzle1/Q/S
 OK+G7dUY0lPNyK7TsUAOnrEevUnzToV8ngbeyvn+TyfqaI+GMpl6Tcs1QcBSaJKLLwZ+TIPBMLP
 ig0VMZng12VR0k9nmSpq88hw/3om4Z7cxJU3AFqbzwu8Q==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 795d6579; Wed, 06 Aug 2025 19:33:52 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 19:33:23 +0200
Subject: [PATCH RFC 4/5] MAINTAINERS: PXA1908: Add power domain controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxa1908-genpd-v1-4-16409309fc72@dujemihanovic.xyz>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
In-Reply-To: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=eJGICosdXjxas1ToQdEVslbW48DwDha7KI4VsUvnZU4=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTJ/45pGTdFuJ03XYXV7mHxocLPjnGy+d/Xfbimntcr
 VZG5V3zjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIyR6G/0F9f7a0fqxOU2J7
 w7F0Kfss1nO/6lQf9AlMrc5eYJ9WLMvI8EbgdZifmF/uyzNXhC89bbdYeKJXpTZA8e3RB/8if2Q
 GsQMA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add the new PXA1908 power domain driver under the PXA1908 entry. Also
add the clock schema (unintentionally omitted previously) and a link to
the PXA1908 mainlining chatroom.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fda151dbf229e48d791e082b1f6be2e43fdb8d1c..905f3027d00e0cd5edf59fdc7dcf6aa69ec608d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2869,9 +2869,14 @@ ARM/Marvell PXA1908 SOC support
 M:	Duje Mihanović <duje@dujemihanovic.xyz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+C:	irc://irc.oftc.net/pxa1908-mainline
+F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
+F:	Documentation/devicetree/bindings/power/marvell,pxa1908-power-controller.yaml
 F:	arch/arm64/boot/dts/marvell/mmp/
 F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	drivers/pmdomain/marvell/
 F:	include/dt-bindings/clock/marvell,pxa1908.h
+F:	include/dt-bindings/power/marvell,pxa1908-power.h
 
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>

-- 
2.50.1


