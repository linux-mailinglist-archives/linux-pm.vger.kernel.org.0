Return-Path: <linux-pm+bounces-42338-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsEOyq7iWmEBQUAu9opvQ
	(envelope-from <linux-pm+bounces-42338-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:47:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6B10E4DA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15A73034E03
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73780369219;
	Mon,  9 Feb 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt3lXARm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF81368297
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633870; cv=none; b=tIiRsyrGwUww+9vF8Qle0gsqTwycAkiUMZAvyc1vj810gZNX0+qAEDgmWqwOE6ifJrCNeTO64t048/Vh9niAcgrennh99/X+nLtSD80b1sJrHcuql8nLtnKOdNetsrPGrKTUpSadmYmLUSzY2HzdqE3RXtWuX3H9PY3E7cRQnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633870; c=relaxed/simple;
	bh=0rMc9serpkGe0Fm6CAZ7oAjYMwzI8MQXlyyHyy0L5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWCQODr9u5nfxOulowfF1bqzXOMVjAt9b4Ql2qRTK3reSe1CaJbG4D9TJEUOjlfIK7yCZ2rVyyARi5R5ymzJz8vcIqqE5boEFlJ2XuoTFpx9CS8UDSM05azQZHCX0n30xlAI+dk3djM7biDziFLQnI5Ito723MKex+U22neOHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt3lXARm; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e4993e00aso2064524e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633868; x=1771238668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvOWIK1480Z8Yx2DsXHdUSkuQ/WnPILfKjXKA3uostg=;
        b=Pt3lXARmjg3kVulV3S5F7WLUVPqFht8rBb9v9tagQPuKAud9SSF8o9gteV5jYy9kv0
         pjDE+bPx1h2AqwKfxiTmVeSc7RS9ye+WroCUjeFMn4Q/8e735BAU1aP+hBiErrd4ZYoQ
         T+cgyV8o5BLmg7qTmtoMkV/yCf+hEregYpf64ttZehYgWP9ThvU4FYQhMewZ8u/NPtxJ
         2JMylXD5aPt4yB2GQjbLk1D6CVXpr7mmrot3TajSTupjbkbYJvHkiMlHcWMnK25hFF0P
         OBEZI0JCeR4+1o2N5oY91fEl4r5fmBgvLr+o6NcoX5TVr9ZUS5GlSGBhSZkS2C6QYWW/
         2PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633868; x=1771238668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pvOWIK1480Z8Yx2DsXHdUSkuQ/WnPILfKjXKA3uostg=;
        b=Q9LWYE1WTuypJZvVA4QAB+zZ2sj2Tezzg49JmJnyynRaJxLOpQs1b2p0s6x63gbfAK
         LweDhaCd8Vpsv4kxHuHoIb8hdV16bT8wOVOYkH5qtq0CwHakf3wUXWf8NaoXn6SnxDm/
         2OLvrmhXlet0pZUPrfAGvjZ8fKWyaOe6UMNsQSfRl1Xv8mXmXGQ8zpZgQvcDWBQcIJzj
         Y85YVzK5NXju/zBkN75Q0NfQ6dtqoJPABR/mSGR+kD3kQdBg5JgnVDsoaOwRB6NwnDCJ
         MDXLhJmq81RM2FJdESqlhvQ7g0ExFo9DQIEpod7eH1MatOzs8Sh9yIUTb1N29pSauzMS
         RI/A==
X-Forwarded-Encrypted: i=1; AJvYcCW8mU5CAOOq/wNGV6xNrUrfD+JkLgLTtUnX9hO790plKEsR993QL5qZ896AeNaDRQgO4VTMwiE5JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUzkHh0J2Okj72TnSs5yxwNZxwEYYUi1NK/bzYM7gNwaeMqqG
	GiGWhWXt2FUqaiIuYjo50xRSg5um+pADdF7/ytmYuNnm0H+du6hxIyrm
X-Gm-Gg: AZuq6aIx5SNJJfIuNZhhbxy3AyA+nudiW8KcabCf46N4OGC1/1QFkxEJJw/KpAMs0qe
	KqMeHCoiv8o1QMnNPj3cAWZkHgjlcuzdD7XPVXybPGVfABf/Ir+9I/2/A5SO79khq8jfa7t6LXe
	0NR7Cvkt83B3/YtuNXg2wqBd+HMgAQtq76dCy8K6YFy6kFlKhalGuAJGY64vmCEHJsss8irsebN
	AxpZMJTcJp8O/mhK46bxUBBQb1C3wdxFnhcwfsYZA7WOezJ2q9ylAXm2BzRZQqunwpnUIlYMPxq
	m8SrmZpb8+aTrsoHroNzUavwxaL78dl5glly2NKC081d9WovDCGyMFcXDREe0SOsDFCUWtsP5eZ
	7SNhi4MSbvxprFV5ysSFNehHWNK503aN60PX+Giz41wMOcl0JRCBu0p1G1VTI/dYAFu7Ws+FuPC
	EW
X-Received: by 2002:a05:6512:32c8:b0:59d:d615:4b72 with SMTP id 2adb3069b0e04-59e451532f8mr3290200e87.25.1770633867920;
        Mon, 09 Feb 2026 02:44:27 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC DockRAM
Date: Mon,  9 Feb 2026 12:43:59 +0200
Message-ID: <20260209104407.116426-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42338-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.17:email]
X-Rspamd-Queue-Id: 8BE6B10E4DA
X-Rspamd-Action: no action

Documenting an I2C device used in conjunction with the EC on ASUS
Transformers. The main function of DockRAM (the name used by downstream
ASUS sources) is to provide power-related functions, such as battery and
charger communication. The device is exposed as an individual entity
because multiple embedded controllers can utilize the same DockRAM
instance.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml

diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
new file mode 100644
index 000000000000..0cfde619ba01
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asus Transformer EC DockRAM
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Dedicated i2c device used to provide power related functions of the
+  embedded controller used in ASUS Transformer device family.
+
+properties:
+  compatible:
+    const: asus,dockram
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dockram@17 {
+        compatible = "asus,dockram";
+        reg = <0x17>;
+      };
+    };
+...
-- 
2.51.0


