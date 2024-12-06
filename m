Return-Path: <linux-pm+bounces-18718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DB9E7A7F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 22:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9239728661A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C285213E97;
	Fri,  6 Dec 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLozwkjv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754B213E73;
	Fri,  6 Dec 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519789; cv=none; b=qodJOUi3aQShORIXv9LJsc/z8gHdQiankfOqt0EOLwLQlO960ywiOBR0hMFTEyhD6F8uMS02dPfKeJ6w2YRdDpgBY1e5S15a0PVjX4+XyFSwCoL3SfguvWR1eP3HLdERB7bsPCr3JAoxj80IVC6qXaBG3iLg/9ADxAansgORuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519789; c=relaxed/simple;
	bh=zOmh9qAGwU6c3133KkRN8o4kWKNoEwXt1SHwu/dxEBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWvQvSX/cJWodJXnGNt6Nly6BRlvOZrukg8rlnhjP7uKPIybUaP+ax7aruZ57NJ+gtgmv7KjeWE0FjnbGDP93do2jQLsnsEq4iMWerO23AQqlU1Mwxy9K6pGTUF9Niecn8EBLxKSqUhbfDO8xsPL5YiPRq4m3C9Ap2OnzX+rxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLozwkjv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434ab114753so17105805e9.0;
        Fri, 06 Dec 2024 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733519786; x=1734124586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRW+iOVyps5/7zvlNQKW1GtyxDHbc6Ru5QmYKpc6JyI=;
        b=cLozwkjvvDJ0fO7v9FQP3904H3OH2IC8QJys1MabluRDMnD0LkJTdJqVvoKRvaeyY3
         69I1P98b3MXEqmwqULcxVaUaRwzTXeLGAZhkk4XxZqJrPphXIQITXF5e+KDt1LG/WBaw
         crV/tX1jGlMkLw5j3n6We4Ympcq0Qm5wuivSOnJJSeYZueMD9CSwUlz/68iAqlt3MKWF
         Kf4EaXOncgleq/XhU4diArk5XWNamrqR48KH3w3GdaaZIFd/jHgrbMVv0KvTSqn0pyTb
         8ER9PHN2lmrXJaeJwgt9dLcSftC7qxCgLQdrbO0pX4DMGo3OCmqlXD9J6hSbqyzZStQi
         C6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519786; x=1734124586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRW+iOVyps5/7zvlNQKW1GtyxDHbc6Ru5QmYKpc6JyI=;
        b=UIp8sp+g7ldfc89B4pwMK5s5eXicKEYU4zqKzpcoRnI5kl40sMPceMNvtR8K+BHpcN
         rSbIucdMqn7FKkM5938jQEwHGWqsFplsTABWK0aRo3+Ff4eeN3eOc6kDuP5j3IJRYEpN
         +aEXSrFUVKLyF0BXo/ddjZc2mkjWxKtbQQqJae9xOQOaHV9JPGMeP3PZyZFOKTnzHfgn
         pjxxV0OgPnnQFMjiRUaKDtbk20T0wanAYE2xD1KlgCJJUWV234csGhRUS2dvKCqCvIhO
         oTzsMqaN98vW/o7YazGdzjcsCtvHdu6nkYsH48QJKW+T3sNJREjMbL2JjQMJGIElZtm5
         PGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVSOjYOUdFTOw5NwtVgjBa3RJNQasuMCG2nqfKUzZAXG2kI9svMC7URLusnyFBdDL6G0hwTIHjxL58I@vger.kernel.org, AJvYcCWo/gWOPSniUPSlsQZW68q+pgAxpxX94OdzcMb6r/DDHFV05JknkhpE3yWemXsj2tEapC5ldJRDL7k=@vger.kernel.org, AJvYcCXZZsrqjzwvW2e2u84CwjOi8zMfQC26f6F/Ogt6/gzoRPqw0eDaJ3soIdAfus1/R/qLohcHwW0A3BLJDbKl@vger.kernel.org
X-Gm-Message-State: AOJu0YxWu75om19ma4IQVpqs2zrYhFvQJ++VtKG3FzzE3ex6C4eHNW4z
	a41RQz3KJO9IhPJuQaTnqq7Gd5JJH+bhIcJ5X0rUJS3l25znVhXx
X-Gm-Gg: ASbGncvkpyRM7I96YX+acBYIMCBimRpb5NqHkCcT09XBKphzzu8cIvobGI2ztVECFw1
	jZKKyw1xCw/+6b+kNNpertBP60aAr+wz5YVwqYifVnhWGtZeH67AaMNwBdEBMlwsMyj+V6Ld7N2
	8wStEW97y0FwHY/lXwvf9SefDudSeUqNmGcBSYbQIG6YnmwwxjDlnglC3iaVmO21a4T+XwB0FdG
	U7vxednMR69AtxRONgB18mXN4HftOeaYofhB1dOH5UGwtPbuVFrKQRPZBTrCdoWe7BhOcvrXHBU
	zOUPzZ+XZwN0D0oCotc=
X-Google-Smtp-Source: AGHT+IEIKgSj99gQZ0yfIujLV4jW/0ASuy6eVEaAycAy7rwgJQxjyx7hj/onKqQL6rPYk6CO5v+K8g==
X-Received: by 2002:a5d:5f8c:0:b0:385:e1eb:a7af with SMTP id ffacd0b85a97d-3862b3e7bd7mr2996674f8f.48.1733519785502;
        Fri, 06 Dec 2024 13:16:25 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d526b375sm105978835e9.9.2024.12.06.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:16:24 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
Date: Fri,  6 Dec 2024 22:11:24 +0100
Message-ID: <20241206211145.2823-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On newer Airoha SoC, CPU Frequency is scaled indirectly with SMC commands
to ATF.

A virtual clock is exposed. This virtual clock is a get-only clock and
is used to expose the current global CPU clock. The frequency info comes
by the output of the SMC command that reports the clock in MHz.

The SMC sets the CPU clock by providing an index, this is modelled as
performance states in a power domain.

CPUs can't be individually scaled as the CPU frequency is shared across
all CPUs and is global.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes v7:
- Add more info to the description for usage of clock and
  performance-domain
- Drop redundant nodes from example
Changes v6:
- No changes
Changes v5:
- Add Reviewed-by tag
- Fix OPP node name error
- Rename cpufreq node name to power-domain
- Rename CPU node power domain name to perf
- Add model and compatible to example
Changes v4:
- Add this patch

 .../cpufreq/airoha,en7581-cpufreq.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
new file mode 100644
index 000000000000..7d4510b3219c
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 CPUFreq
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMC commands
+  to ATF.
+
+  A virtual clock is exposed. This virtual clock is a get-only clock and
+  is used to expose the current global CPU clock. The frequency info comes
+  by the output of the SMC command that reports the clock in MHz.
+
+  The SMC sets the CPU clock by providing an index, this is modelled as
+  performance states in a power domain.
+
+  CPUs can't be individually scaled as the CPU frequency is shared across
+  all CPUs and is global.
+
+properties:
+  compatible:
+    const: airoha,en7581-cpufreq
+
+  '#clock-cells':
+    const: 0
+
+  '#power-domain-cells':
+    const: 0
+
+  operating-points-v2: true
+
+required:
+  - compatible
+  - '#clock-cells'
+  - '#power-domain-cells'
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    performance-domain {
+        compatible = "airoha,en7581-cpufreq";
+
+        operating-points-v2 = <&cpu_smcc_opp_table>;
+
+        #power-domain-cells = <0>;
+        #clock-cells = <0>;
+    };
-- 
2.45.2


