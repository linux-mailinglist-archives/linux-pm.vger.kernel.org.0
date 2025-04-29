Return-Path: <linux-pm+bounces-26357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A5AA030D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 08:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063C217147E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2C278E6D;
	Tue, 29 Apr 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgwMeBFy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0E277811;
	Tue, 29 Apr 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907514; cv=none; b=sYlWebCP/AvwGi5m8xATroBvss71rEdgkmoJFhyFbm69VuRw22S1WGDkvy7bGqBUdq7QG9TR/iD8KhWwxkNxKNBMRKevOEqqtEZ3cSqLM7KhDeOYh87alZakLDTL0i+S6rLr2IXslBCi/woUEnbR2p3QyeFurnx/Nf+Bha/IB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907514; c=relaxed/simple;
	bh=2f0CaTT9zelQrDfKjXG0I0BVgn7IvMO+EP0wNk8wNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYBYNUEWgxd85VUSNW4Wu4n1qoateRxk4TZ51eW4Cd0wIP/0ceVteIsKsGvrrP4Fqdrf13U6Df+zhHCp4IeGTVNVB9o8EyxmbrPxHNSyuj4b7cmMWjt5CGvPzGZhP3KWwvWO2Do37gPnpNpX4ZUJXx+jH5bj5mtZi7p7aislRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgwMeBFy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so9640926a12.3;
        Mon, 28 Apr 2025 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907511; x=1746512311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OO/WYseY5NVfpE0GbGQKDsXswS11ZcaBC1WUYPc0V4=;
        b=AgwMeBFyWvKryDazoun8OCMqg+nUfV/7vPtoZYOB19/QMJPKONv1/AR6aRE6Xa5CF9
         YEnvPMM5VHhKfolajyfbhnAiT5dAwqvQCWbaRAktrblAQzCS9jA9mQzGJlVNPJDFZCGT
         DMyoPPg6vbE3l4T5CQtlWQVYHYHY1Wh7vwRFWx6e5PRJus8nb1AiJxpwKQcT0jQz68Do
         z1wOhuGcn16B99mccFnbsGbjVREI/3cpxa5eI+nzaArZ6/tWvrWTAuEzsREo/KIB1NJl
         yfy4Pp6IMg/2A/ko8yWUWjjRG7YtlL5ImXP97OoV36h9bhMpYU5a/cudVi7mN3w7rzvn
         gmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907511; x=1746512311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OO/WYseY5NVfpE0GbGQKDsXswS11ZcaBC1WUYPc0V4=;
        b=dY0TBTDkcgNNjq8UnnV14n91COaerASGgg0FjHadvaTCwJFFvLy6B9zvRuWTXiW3E9
         X3PFYvQZjwHQqtBvxb38cIy39BOHszfryGy0i4UF4sHAzPCPqTCnJeSovzDFptInV4Ws
         yq5MgmTX5OW881noTqNuCv4qJle/GUAvmnCrX/fWQ1keARLzAUG1RcK+HjbkpOL6pG3s
         hqhn+n8wYGxv7aXi4sHgVoByduBuMKcakXuPovxjYQJiOLy3vsWc/PdYGIOEsVkncVmR
         QCyjoWOgOHROdnmybbdYLFM1gJunaHkSQnJ6f9oyibQH/I/98Ztl4x79LbgujDav4+TZ
         wYkw==
X-Forwarded-Encrypted: i=1; AJvYcCW8cyq84XQ6QKvLLX6rJuVR33WzMeOptl88DwMXpsqBwcu+SL8a/ZlajL6jM9kXIREKXOja3sk3MYwNKBnT@vger.kernel.org, AJvYcCWbdrfBymIXtQ9ZiyKOjB6EeVzoeeJxsKjFjNlVVLbWYTtRZ0FRp9CHHwHxtpy3yL0Jt793tv4WbWqT@vger.kernel.org, AJvYcCX6grcZUyrlx1D2tUOPn+w9q3pfRvxLZ32oRRRV42w+oDDEtYD4ATDjfkZohWzBk5XfsanBZrf2oYs7roY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oypaa66IQk4xIqk08BeQGjlydnIlucHRnAXCYv9Zf8nKuSsS
	BEc/SL1GBKXjQMWcb95El/xqQLuFSA/zO/3hi4q+2eWdXPPh7aDa
X-Gm-Gg: ASbGncvGaMgTfOsOkEz2SP279ABGAuOzeiRZ6UiE4ZAiEso6euJByt4J4nR8L3VIFVa
	QjGJrM+ANtM8Id9L2i8gPJv6VWqfCH6tDU/hRzY8MsjShs4tij7kHs8J0/hPI9RrPNRk1fhVHSY
	AzXU3UfnjFs+dinRkztx3S/1DB3sYs1yceG2gQPeQQTp9JljL5X2rU4mikrRe58n4R4vzKBodUW
	a/u7VbLUgadvzby6Dj6+yfn+7ciYSFN5jGo8g0FB1UnTjVEb5H2g/Tso+r69HENMe3RNA7dYi2x
	9wSfJVu/U1P67ZCuXZe4T3931NrbwHAG
X-Google-Smtp-Source: AGHT+IG/YzJ/U1zZyWrmqVG5FY/PCQgIXKx3v3RwVAoeyQJ/g5ZsEIauG3J+0eghW1+F4akpfQVUcw==
X-Received: by 2002:a05:6402:214e:b0:5f6:c5e3:fa98 with SMTP id 4fb4d7f45d1cf-5f83889099cmr1816137a12.27.1745907510697;
        Mon, 28 Apr 2025 23:18:30 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff9c5sm6996570a12.28.2025.04.28.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:18:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
Date: Tue, 29 Apr 2025 09:17:59 +0300
Message-ID: <20250429061803.9581-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PEGATRON Corporation is a Taiwanese electronics manufacturing company that
mainly develops computing, communications and consumer electronics for
branded vendors. Link https://www.pegatroncorp.com/

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index da01616802c7..d36389aa4d7b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1146,6 +1146,8 @@ patternProperties:
     description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
+  "^pegatron,.*":
+    description: Pegatron Corporation
   "^pericom,.*":
     description: Pericom Technology Inc.
   "^pervasive,.*":
-- 
2.48.1


