Return-Path: <linux-pm+bounces-30729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B845B02CC9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 21:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491BB1896E9E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8328A1D1;
	Sat, 12 Jul 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RPfVbN7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC742566
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752350351; cv=none; b=E68Vl7x0f6T0qNlfHkhJhomajJGLmtrBptRCLeVWW6Q0ioY2lFuGInQ3zLFHuyaTnT8LKbwTlJHvqK6LV3HQAwY5MxOxW/3AeETb//YfHCywFmOAI7b5EI85imWtNX4uwGUI8tIf+REwAx/g66Fs/XG8ySL6niAIapP9nJwtvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752350351; c=relaxed/simple;
	bh=DsrgFG69ftpCKlAOEh3HyCNhsuL08FwUBbUj9xuA1W4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VsEvTmLv8fok5DJRZMQ7zynnva+xIjCVjFv2jNGpgs5L99a79LulIO/ThmKWb+CawVFwdAzSFe2pH0SgH7XMCl2kFYWW/vJlbgFiNAfTM2KxXrrQrQcUOcQUsaMIyi1WTidNDXPdbJel6yQiG5bL+Hww9OBJ/oQj67SO2Tunm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RPfVbN7E; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 39414 invoked from network); 12 Jul 2025 21:59:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752350346; bh=Wlbqk2XieQcaf+xQ3cw9oEoHT0dKFrkXApK+hvN4gj4=;
          h=From:To:Cc:Subject;
          b=RPfVbN7Et+lbrTTRTl25H1goZDw4pZypc04PDwOkIkic7PokAqHqPHLb8Qz19QgD3
           IZ7lFBBiLCfRfEqz7PP/mB++Jn18pbtL6q8igWATS6JDZUovetGtEy1rw6APX8ILdT
           uF2Gzskb17UZiJNE1jbJqJiGzsdWeNcM8yV3nN9J9J0vy6UcqkkCLOm1i1Y1WZeyeQ
           OJ6jxS6yoIKJA2vMM50StN/zHq20Rn/aPi0JjIu2YH6mkEC7OcXU1vbaa3A9xlFCPI
           xXX05fGF/pd7I35ZY/eBvzpkEyB+IU/tQF38oM5Hu/cCCIGbetmyVziXlz5wEXyjbM
           nScAIKkwTIf5w==
Received: from 83.24.150.40.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.150.40])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 12 Jul 2025 21:59:06 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	s.hauer@pengutronix.de,
	rafal@milecki.pl,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH v4 0/2] Add thermal sensors support for MT7981
Date: Sat, 12 Jul 2025 21:59:02 +0200
Message-Id: <20250712195904.6988-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 32c096a57224f34a4b90e33487e56936
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [0SOU]                               

This patch adds support for the temperature sensor in the MT7981 SoC.
This sensor is exactly the same as the one in the MT7986.

Changes in v4:
 - sorted bindings by fallback names
 - dropped accepted patch

Changes in v3:
 - added fallback in bindings

Changes in v2:
 - added fallback to an existing compatible string
 - removed second patch as obsolete

Aleksander Jan Bajkowski (2):
  dt-bindings: thermal: mediatek: add falback compatible string for
    MT7981 and MT8516
  arm64: dts: mediatek: add thermal sensor support on mt7981

 .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++------
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 31 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.39.5


