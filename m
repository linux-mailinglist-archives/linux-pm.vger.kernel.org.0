Return-Path: <linux-pm+bounces-40138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CCDCEF1F0
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3CEB3019376
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200802FFF9B;
	Fri,  2 Jan 2026 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="nNsRIOVh";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="vWa9Yt1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237E2FF178;
	Fri,  2 Jan 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376867; cv=pass; b=g+z3IisZBSTQn6kkmD7ny52IrN7WRL8O9f1c0oNgbDioS0RcNI0jCbMjAq1iW7U3AJcGeVKBlX1xRn5i5gml+KIEDBPRpkT+eaS8al9EncD3jSnbfFa3y7fRYEjAIJ2T9PleFJNaNb0KdVd1CjAml2+64jT8rRZPUttor5gZCto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376867; c=relaxed/simple;
	bh=kNHR5UFXK1c+A06wwM+Zzhkwveo8p4U1JpIy/ZbPaZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWbEe3YXrIS2o8RJtKcWygxsP3J6GGdHpQ6HG/FPmgtaJ5RhyxC/jcQMfLiPT61EjLf1WGms/9IxWjknCzXKiGW5BOB1nam5vl36cznmQwDPsnMXhnz7zmOxQ1n6then1tTnTVWIe7cZv8OteRfMqhfXjqe5ZqyOitmWppiztJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=nNsRIOVh; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=vWa9Yt1z; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767376841; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G/bZ9LgolNZ6iD9eYftg1cYifZztSuTGzlbQYf/gRzPPTEB4K0dji0NC4OufhSS/RI
    Rgdd834RwmFrhwWgoc2SFpvE2U+2CXXgAi8OJjssMNTNH1LqJWd5eQTrYNxtIxLMtSl5
    A0ml7CjL65rqshSxQk4fxzjDxfkqDYQB6qvUrVeujWqJAXquKBzMwmJinD2fELOmapX9
    cnBLAz6S/TNPrD0O2Ybwj+ML5d9IIBvTwWw/kacAt5fVnuGY/y50l/+hks3bzWXH31lg
    kAeiRKjnQWW5hRO643YSYUhoot0cTofRMYhvWmV1eAEHgwRBs0UvZNa06VbW/cFq7RD9
    VzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376841;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HoXLG+S3woHWMACty+9soasUgUY3k6eBEUtX3MmJTN8=;
    b=hqVIinZ+kmvcFbOOpxShkYvyoYsptEQ6xgGt8d9JSWjukYBiNCTyQmJAYI9Tb4mLiM
    Vwm/tVX+Pih9png+/GN57NuwCjDcNh185z9nwNq24T7c8dxaRe24NmY5IBTy0YLVyX+7
    RHrl29oladySufWeuSzqSxCeVZ4L/3QWpaNm8g5NeNQ4aUGPqURQucQTTvGkMnFFXnJp
    eBfZn7vPEY4MFNWKIgEIIvWthlKZs2TivrADfpxJq3IcTCwr16cW7v60xfqsbbPlQYcO
    aRwduI8VL0/7J1V+FZjs7H/g/NUT9QNPz02yxuhAYfq0Ct8ayuy1syjUnyV8xfvyMawp
    7gSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376841;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HoXLG+S3woHWMACty+9soasUgUY3k6eBEUtX3MmJTN8=;
    b=nNsRIOVhoebVVnt3q5Hk3iU5STmfqXogSAkXAaqMFfPq9Ex1YdigqJLBgLlGzaO0Ns
    8TYKSMX8yJienT/+dWb2MzVvDw4l0R4HqPWpnYmCwMC4J59/ziLXj7WVoh5u1cG78EOI
    5d58i0DL5BeSzYFkJmAI3pG5cLo5D/QhZD9RpVmC9E+CZfEBEfRZdxNpmdfRA5zYe+Ct
    eHhDe4D8MaV03vmd9W2YowPSq/9XG9BGWlqy2MNCwGGbB2uUXrylsf9FZqrKdxy1fGVH
    4RWy7d87BBtLWIX5QorBxbzMjL5ms13LxeHvMdWEmX/3AyR4Y4MN2clh+r66MuiaLThJ
    Qcuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767376841;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=HoXLG+S3woHWMACty+9soasUgUY3k6eBEUtX3MmJTN8=;
    b=vWa9Yt1z41VxjDSoK9P9DpC3PJD2XSKKomvF3F7ei6cqFD3i7GBxtngFqoeuTiNciC
    x2xrjtAs3gUnrSEKgEAA==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQivJ4sfKeu9QyRDNI="
Received: from Wablet.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec202I0eEUC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 19:00:40 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Fri, 02 Jan 2026 19:00:33 +0100
Subject: [PATCH 4/4] mfd: ntxec: register battery subdevice.
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-kobo-aura-battery-v1-4-501f2a8fa575@jm0.eu>
References: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
In-Reply-To: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.13.0

Add Netronix EC battery driver as subdevice.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 drivers/mfd/ntxec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 08c68de0f01b..d5059b8862aa 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -139,6 +139,7 @@ static const struct regmap_config regmap_config = {
 static const struct mfd_cell ntxec_subdev[] = {
 	{ .name = "ntxec-rtc" },
 	{ .name = "ntxec-pwm" },
+	{ .name = "ntxec-battery" },
 };
 
 static const struct mfd_cell ntxec_subdev_pwm[] = {

-- 
2.43.0


