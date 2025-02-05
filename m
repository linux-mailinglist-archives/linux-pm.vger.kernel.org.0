Return-Path: <linux-pm+bounces-21397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2690BA28ADD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 13:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697DE7A360B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002614884F;
	Wed,  5 Feb 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ics1Y27U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336713B58F;
	Wed,  5 Feb 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759964; cv=none; b=GzXDCSf+K9NMZ4FiTcGzki47LjPa+tgVYQZPz0nA+Hej+TR4t/546woNf5AdJAIH4fxaSq2n3tcWB2t6cR4YimMIojefj9/w0fpnkbHe7MqZy9l9xHTWlnQlNZTu92kmt7ZABKHvOR2SHErWiZRtEaou6t34pKnTqFfdL3ALpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759964; c=relaxed/simple;
	bh=6Ldci5NJcLk9QDLef0QdLFO2TFiUZ4r9u/pld6Lsudo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fT15tS08od0gPpEgO4joRZHH4TBh+e0MafeQxg7FKosdzsMbZLO/mQLiE3fKzb4gqE0qBJZw+eDoM01xOJX63VNmREMWp8O35s3yOu/6JnM5/XXQpTuQXNB7dwL6qJSclvxOa9b6C8Djco5Un+yYshirmWRu/TWQIvF8XZuuzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ics1Y27U; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso9361474a12.0;
        Wed, 05 Feb 2025 04:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759960; x=1739364760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnyUK6beMeleaf/vnmqhL9TlcUqLD4J+xrVEoCblRp0=;
        b=Ics1Y27UzFiEi9C/1wM7dQARYSjriT6r/M5jrd3U2/Zkh21fWFBYBvihq/1ZLtVzJx
         ZKKzB85fSiAvd2X1XvL031cvteQfBy0/ZQz2W1QYpbF3Xp2KaelMwBQj7OP5lPT4IbT9
         v40JdVl37u35q232iNRCt8/T6caoLmC1Nzf2DpynNFUCxyrp+kIDrkeWY7rUDxwaeE+Z
         kVtT6A80DJ2qknfRiXHlNw0TLXecddyCEhs8aD692dLJfrrffbWiSRPHnYLS57DEtzMh
         iQUH8JOqMjcys7wUOrl3aoVZHHfYV2SUlFuiEaZJNIbIRHelkZjw2uRV9WGtxerBGoCg
         98zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759960; x=1739364760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnyUK6beMeleaf/vnmqhL9TlcUqLD4J+xrVEoCblRp0=;
        b=e/J2gep7uyPJP3Blfqp7UIFKhzvBWG3kCGA8aq3Pt6jlBY7A5rxf3gAFKlVCJCyfst
         K4+tqI3S/F4iaKVMqFL5RF3ZXLf36x82Pd+EdmSH5E5xNEWQ8sHwlerddehyo2x02Gql
         FRH06DECTuq8K/EbgNpjZ76UbzPNN03GE6lBZ32dkUmB9VDJGMhg5OaIbfj/qgIpbviq
         9ZxOxOm+J5Mg9HoUgaVgoyLKfxbZVj/W7fszSq97vo+cRIjz5YDZEtF3taM/b4SS7Sxa
         9W6mB/Gf2Xn9vBOtsFv5GjRlLMQLNBDHNGI/IrqC+nnTfi47HaMpO/UCvXjOcpYTKJ3o
         sgMg==
X-Forwarded-Encrypted: i=1; AJvYcCUyrAA4VKU3mFu/qY/Te/WEcG++j+tyyC77Uyp4zVVmuH/Gk4LD7rGmDusHoqPz9Yut8RZnTuhhWrEb@vger.kernel.org, AJvYcCVDlGWo9TmBgpyIUGYDYxoUmSsu5l0CkvIAWt5rYU5u/smSNVcz0kkZZN5/MSPb+jMJvecR4jI7vIjJ+MkM@vger.kernel.org, AJvYcCWEKEB1GwmYpVdVcy/am8ScAR7BFVq+rYUQ7LUvC8F5/Jb9EW4Q6mWCmUox2aODK+A29vSl9ZVGd5U=@vger.kernel.org, AJvYcCWOZ8lfozlY6tzTKoQ+l/RR1/taXzoXXbbFPC7o05xQOoWZiH1xuScVZYhPnIk4bFyx0sXhl+hi9zhSvw==@vger.kernel.org, AJvYcCXt9KWqYUPZSJA9K5QIuD4+aDqpuQ4sk08CT6aIM6OJEoqo65ait34lACtPr4RV5CpEuVBm4Y52iMTq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4cv6fMoV3XfM1hE0VYLNP1UaFFhsKbAeU8RMBsWxOR5vzlp3
	dY+BlToo7pTvU9N6MTrKaQat4ouoFuBo7MN5tfMuuJ29WG3OF1Pp
X-Gm-Gg: ASbGncvmcOue1hgtAhYNLyVA0+5v6AjpkF36CX+Xp78+3vFR0JLHzwEdUVs9N+ef+KI
	I/BQ58mzGviD/1hla5/rzuAiVYb4BcdSVWvvj6b9ge8eso0pW1OW63L8t2GynCdpckCtJdWqxzi
	JboersQSk0cJuJ9nin1w4YfhQ0nZzrn6ispgnliLFK5UI2q7HFLh3zGpFgX/S4iTBTVJMH2AmP0
	g1mRskY6jXr2corzwiPqU1bzYJC0M97ywyK9MOaca2x5txa2lp0NJIGsZOM1J4bq6CMsVvIhW3/
	npTzAKUjPM9qYtrxCIT7LKD5PgArFFkaMdFgarnrffAemQ==
X-Google-Smtp-Source: AGHT+IE0wywWb/Z15BOQfyDS/LKQnpnhSIPGUcQiGwnAhhs+76luZoRksyVgrmGjUEmSc4D72uhXsQ==
X-Received: by 2002:a05:6402:388c:b0:5d9:8877:895a with SMTP id 4fb4d7f45d1cf-5dcdb732cd0mr3410442a12.17.1738759960294;
        Wed, 05 Feb 2025 04:52:40 -0800 (PST)
Received: from localhost.localdomain (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm11559997a12.45.2025.02.05.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:52:39 -0800 (PST)
From: Andras Szemzo <szemzo.andras@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 07/10] dt-bindings: phy: allwinner: add v853 usb phy
Date: Wed,  5 Feb 2025 13:52:22 +0100
Message-Id: <20250205125225.1152849-8-szemzo.andras@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205125225.1152849-1-szemzo.andras@gmail.com>
References: <20250205125225.1152849-1-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Allwinner v853 USB phy.

Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>
---
 .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index 21209126ed00..815742c4f5fb 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -19,9 +19,11 @@ properties:
       - enum:
           - allwinner,sun20i-d1-usb-phy
           - allwinner,sun50i-a64-usb-phy
+          - allwinner,sun8i-v853-usb-phy
       - items:
           - const: allwinner,sun50i-a100-usb-phy
           - const: allwinner,sun20i-d1-usb-phy
+          - const: allwinner,sun8i-v853-usb-phy
 
   reg:
     items:
-- 
2.39.5


