Return-Path: <linux-pm+bounces-17370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720A9C4E1C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7331F24DAB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEABA208999;
	Tue, 12 Nov 2024 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OOROsmSN";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eurYevQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPt3vMFa"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130271B86E4;
	Tue, 12 Nov 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388937; cv=none; b=mvHNdYvlEQwaT6ecTHsT52aUSFd2NTjAzqenrAfcg8VCmkNhQf6VBdXLOL9CwCkOvevA+KoaXxxh+T2bJ4S7wiAQm9jPMEEhABeffUuP+/e7I+iW8WhcD8ggucXFn8FENhMHPbLwPcD46QjR9jLczbMv9lMnsppgI8YCwqgIx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388937; c=relaxed/simple;
	bh=EgAk20EvJCg88PMVz2QRMrI6zJZOF2IbzwRr3YmAPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXfPTB2gXsnRXV1nh3/iBeyB4t3CiekMhQsGIZ7632HzxTXzvaW+AebMH6NMRAFeMhdYWQAsopUd6lg522lKE19k3CXjwsD+wtoeenMgJk9e6JinlC4GVEFGv5EUanPED0At4YK5gcxxQNY6i18X7w7g/YzwC4hSH9xmpEIVIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OOROsmSN; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eurYevQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPt3vMFa; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F3E311401D1;
	Tue, 12 Nov 2024 00:22:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 12 Nov 2024 00:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1731388935;
	 x=1731475335; bh=8kK3U8pQ/oVsZSw+Ik49NDaOUzj3r9K2JH8mb1XDC8U=; b=
	OOROsmSN51+kdEIZyYaKT1mqI2yX2LIxaWjlL5m7f2PIib14HlQiX3mbNlfV281D
	3usjqHWfLupuoDHU4w+JD+BWiFXCthumm6AQGBhxV1h4ZnIZthjg2FLyQPcs7EsO
	lckkyahvAiwv3kmt1KvbRXY7ZM/BvV4gNI5wAitqG3g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731388935; x=
	1731475335; bh=8kK3U8pQ/oVsZSw+Ik49NDaOUzj3r9K2JH8mb1XDC8U=; b=e
	urYevQt4J3NbEfLryNaK9IF308g1dkBj17a/JcSnIPxQYzSy3OlO3E4Q4UrDqamQ
	yUmpFY6X6nLWIDVSN6MAzKn37tWHpskm+F6i5Ooy+gNSjsHWLaiJZymJKFD/5F98
	9Nn19RsBbZJjyGSbEgwJTcKqEkpKRp+CUxhBkFDe7uHRw3D6Kd5tXs0FmyywF8xQ
	U38xPggFEx1lVpfF+gU8of3jYg4XP2lON/HSJmdCyO5FZduUiKOStYX2KcddxtF3
	/NgtJD9N8o5PB98yQ0AvBhW6Oddo3EdnkfDOAAqQbREwpLDjA0Uhxb0YDz4gbQOv
	KFE8bRddeIp1SUjgbbA9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731388935; x=1731475335; bh=8
	kK3U8pQ/oVsZSw+Ik49NDaOUzj3r9K2JH8mb1XDC8U=; b=UPt3vMFa5wj4iU3vf
	3j4n34PWJy/ZVhyhSonlxnJV0xrfzQh+XONDax+Kqvv066EgWobO/PMYl8NgsgQ+
	+FZWffxamm6BNquBUfFby++2XE4jA67iqEvsPXyAboLwM5o9rY/UXwpNw/T9PBOV
	HEAogTVG1y5TLAysvgY3r2K9M8QVYjMo2eWNu0B60PTAorOTxJ8MjIQGnioezf6K
	UTQqq8YMHFUqOFgX64EBrDJ5RCHIHuoWw75o7paN9m3OjGPUvnEpvsEV5utlyL0Y
	lJjmOo86dAHGX0N7Pb7+SxZKdB/cW/SbNlDulsvsRQP6T31tuuo63R7v6lrGceA2
	Mc+CA==
X-ME-Sender: <xms:BuYyZ-rPwDh2cca5q_-DRXpjj2X_FLIDr-QYbFVik6MY_hx09uwV2Q>
    <xme:BuYyZ8rekkQvaZCz6jVASRQ5N_u83qXjcEBqXkrP31f1qI5SfxnyPuw_ojNfrYLOc
    iy8BUMYr0LulXaBW5Y>
X-ME-Received: <xmr:BuYyZzOwSqwIx9QOv_XED7P_G0EzKIu1HP4ZJk-P8YnIu7vR4NcFgBF-9bxQHZuEDW-py1GyLIU8UNpUeJegv4-sXLVSMJiF0GoIx2LdueuZMiQtQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedukeef
    fffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggsrghilhhonhessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdp
    rhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BuYyZ95DAmQkpnkiXu71U9pHIgZF2pXwm0a8yiBDCv6HDhgV2YeBcQ>
    <xmx:BuYyZ94d3O4Wur8h9Hk7QrzxUyliobuTeDGS2kXFWo_cAv_kqhUT0A>
    <xmx:BuYyZ9jHHATl5FLVbbUrb80rwcVkS9oql3vXD3tZooXpL9QC0wikdg>
    <xmx:BuYyZ364ipkOzpLwybVrtUCBvktEV17Pg68u658RsXuFk9FqMRAHvQ>
    <xmx:B-YyZyEYyIabCCCkZWkBlmqeooF-eaKtuB9beXAGmtHnF2RfEsl18BUv>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:22:14 -0500 (EST)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 01444ECB7FF;
	Tue, 12 Nov 2024 00:22:14 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/5] dt-bindings: thermal: Restore the thermal-sensors property
Date: Tue, 12 Nov 2024 00:19:39 -0500
Message-ID: <20241112052211.3087348-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112052211.3087348-1-nico@fluxnic.net>
References: <20241112052211.3087348-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Bailon <abailon@baylibre.com>

thermal-sensors was defined in thermal.txt but when the yaml binding
has been defined, its definition has changed, dropping support of multi
sensors.
Since we are adding support of multi sensors, use the original definition
for thermal-sensors property.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 0f435be1db..cc98f87633 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -96,10 +96,9 @@ patternProperties:
 
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
-        maxItems: 1
         description:
-          The thermal sensor phandle and sensor specifier used to monitor this
-          thermal zone.
+          A list of thermal sensor phandles and sensor specifier
+          used while monitoring the thermal zone.
 
       coefficients:
         $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.47.0


