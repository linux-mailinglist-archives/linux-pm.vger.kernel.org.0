Return-Path: <linux-pm+bounces-11104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D5931505
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13951F21179
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2718E748;
	Mon, 15 Jul 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK9Y1C0M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4E18D4C1;
	Mon, 15 Jul 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048118; cv=none; b=gKkkZzcd5ESViPYpa5ml06wJFBPS+fNtUzwlWh48n3XEZ2Wh+qHzRYAlD+tZJ0JO0qNDQduYMzl6OjiWNFzl9NhyjxJjN77be16sSzWwVxrG/gf/oyXgZna0uYk2Bfa+J0x8bheHElgpkLUZqXjer6Ydy+MR5Uf3BFGPHKwSWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048118; c=relaxed/simple;
	bh=UswaxFgNYGhQxO8i3hDmSgr/CcfH6MewnSR60PWmTJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttEn5qQmBrQ+8x1hhVAmOkzwj12bubWge/Ol5iQ3KXX4kSLSfM+an8N96Og++/Q0PlYtfpzSh38L5jjec7ZFkn5eahQztngQhGg0zgWmQHHso4fFZTSmEMApSSdSqlRtAUN38+eyHhRCEklEsXVURTFfp4kpTAwQ7PG3HiVnIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK9Y1C0M; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so277170a12.1;
        Mon, 15 Jul 2024 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048114; x=1721652914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGuQaKvthqNvOI+/BVZ1qQqCmj4BP1waMYjE3zo8K2s=;
        b=mK9Y1C0M1pIw7vEdLWwd14Zq8ViWIXSSxys3dSKRcwfEKOxkSpAgY3OVvrlU1HMPOs
         7shuo9y3Ucx/OcQ7JiieJPeGJ6QVf1a151pbwsQD9QS32OmEY8bezPTQYnC91rDtFdSa
         cXgzYcFd626+w1DoCr+MIwRz84CgoekMtDxjRiRcT6SmSleH4HYGc+xVZOvkQfGC+yBP
         LeYt5qBAvU5sIpnclIntHRrcilx4SLejsRgm9IUVtbhdE0xABAokHK6AX76qF3zHCUY5
         CmGfQ27Q8kSiAOMX6Zm3pT1xbjiZJdVZSfaUQpBumVBTqFg2t9+85Vz9CQGBVdI/PD5v
         ZDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048114; x=1721652914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGuQaKvthqNvOI+/BVZ1qQqCmj4BP1waMYjE3zo8K2s=;
        b=dhW1bi3p3Yx7RpjERWlOBPg0ipdquRGIA9XkEzhDMdXZdPWmvM97UOqie0x/y1rvtx
         ruOD2TpP825mPPgW/a6rMmTSbN36ipWXFEwc5bhNjFQLcacTu44Szw9f+hztN/Pd7cGB
         iGZG0VhlM9fEig9t2jCjq0DrOiJNkvEVDv95Ax53/NAlE835szG0AqL8TvyCGjvuNNSm
         h2AQEP1+k13C5IK9w9QM1HPCNrTZebvp26fzcQPCiFws+M93t9OpkQyOH6LWoA+ouaH4
         IfWs3r06JhWNxUN8fNnXM2SLwOx931tt0iFA+thTngmsrAE9JmE6+QwjCaP3mKy+DeAP
         +QHw==
X-Forwarded-Encrypted: i=1; AJvYcCVSE1Pv2Th/xsPZrGfsonWiy3PtB7ZW2RSw00+JOb5XSmvCIKxI4Rw5zcJYknmUhCmRUFwSEAUxOXOPG2eZG5qneecl5GneBQIQKne3Jrll8YkwfJzafddhm/UrT3x1EbRiULSp9b46BPDywho8O5JftXxaXi24l0Gmd7QXYzOnx6LW8tN1mBeyGutDOPJexA4o0Ky0qgNcpL7q8J0RirUfwEE8hdc=
X-Gm-Message-State: AOJu0YzKTo5RZ4qQMg2Cn/pCD8pZb0QuGBYw9hN54Ao8J0ZFnEmNCUCv
	HBfWVCL4I+NghQYNlYOH80uUWiTfP/hvLyw4B2ZKrl3GaqNwxrUzVDqNaukG
X-Google-Smtp-Source: AGHT+IF13yLztEYtO3ThN8vyYl93/m4din/5EPKTD6UXsAFnvdhgrZPhA9eeq1XL21Cu8GDzVWSlJw==
X-Received: by 2002:a50:ccd1:0:b0:57d:3df:ba2d with SMTP id 4fb4d7f45d1cf-59a71454331mr6318170a12.2.1721048114285;
        Mon, 15 Jul 2024 05:55:14 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:13 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:04 +0200
Subject: [PATCH v2 2/9] dt-bindings: power: supply: max77693: Add
 maxim,usb-connector property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-2-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=UswaxFgNYGhQxO8i3hDmSgr/CcfH6MewnSR60PWmTJA=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwp6OhrSlHrko5KiBUj7b51bE1zw8tFe6qng
 QWh1+Lw2OKJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKQAKCRCzu/ihE6BR
 aHigEACEj26TJHPcn6IEXY48/4k+ESHRoKR+3480pvLlXXKJQGt16YcfuChAKdYqUYtGo9Vr306
 eklbsSUah/1GgSqBzCRD3UV1bFMyKMPA1k1KJIbz7/WHXah5wjo2g5ScP4+kt3mixKtd2N6DAnm
 4R1GR5nrZ19SYOzjax9M2FpZmPf3Ql+H2qx+q3GuCnJqC1eTE4ewnYvFWKKsW5qpsvgUiG5GhAE
 KH6aCTz+YuIeMx1L4TMtveMPW51JEFTJDuwP1nNb68v2vV0t0FSWMHGVLRQRg+b64kXog1hm9fg
 g3fW3PF05hf6RaAz0kKERzD1F2VC0/lWhPpXvk36oHacyXxljXQl6dRZ/7pWRTc6ppJQW0GnH0H
 ep6dgNVULP36kORX44a7nPcegyzQJsNt76aLCzFbjGXV/Bt12VOkZP/cEiu55TfT1moN5C8j62F
 /Zm8nlCujXp678QpsoqkgjwJirdmsrSL0pZWSvm4jOm3fZDq09X5Vi7CPm+Hgarp5REazgOUOFj
 D7y8kfQ09t1BNukkcK2yI28MhlG2GThj9ZNm8A8E7z/eJPDSHKp/0bkMl53GN74Z6m3JIkKqPZ+
 Jc2PDm4WMmF+DNwXmGrjonEWeXv21Mv6AS20sVs3oLNKiFvqtkc9n3FvLX5PmAenh5JxLI5cSIA
 G8ml3hlQloOqx6A==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Allow for specifying a USB connector to use for charger type/OTG cable
detection.

The way this is done is inspired by the rt5033-charger implementation.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index 2f4437dafdc0..b70c171bd4b9 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -73,6 +73,12 @@ properties:
     enum: [4300000, 4700000, 4800000, 4900000]
     default: 4300000
 
+  maxim,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      USB connector to use for charger type/OTG cable detection. Phandle
+      to a USB connector according to usb-connector.yaml.
+
 required:
   - compatible
 

-- 
2.45.2


