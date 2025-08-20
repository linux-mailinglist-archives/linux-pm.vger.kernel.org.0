Return-Path: <linux-pm+bounces-32708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F1EB2DB6E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0558A5E805B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CB2E7631;
	Wed, 20 Aug 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFFqTNAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1022157E;
	Wed, 20 Aug 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690182; cv=none; b=poQTDyL4sKnligu4wdrP6dBOvbwOOZdyhfGEqbIYafrJCy78jIy3JJwYjk+IQ1+smzkY027mLvP+9LcOh+CFtEgzwJY16wTjE953/p47vwgoi3ARvnrI0wdIq0ZFhGJEee3lRY5B0LfmXTrxLI1wbwRd7wcK5UpcEkrEXjwSbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690182; c=relaxed/simple;
	bh=L4F7l6/zYxQr6YTmwMkqwY0oWd9rKPsyg57GCchM8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1BhorY+D7ya4KHMplTCrWDYRHUJzM4g6EX2ovABygm6wVoFNVwLsUF5DemfQ6+Mcbt8lCC3sBVvkL7vlh2Y2UTk2y7wbgaElSYwtyrvklaScm9+etwV/qWbJx2FDdjSvETlX7OOrj2yFx0HEOUBS7cHRqa2D9LS/hn8AdbDujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFFqTNAv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1154877066b.3;
        Wed, 20 Aug 2025 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690179; x=1756294979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=BFFqTNAvGHCqpRvoPunxSNGgiUdRUqWcL+SnfgKRxYA1XLg+tpmR75eRj463zysJU7
         DrLjFmiQH8lr94Ub7NNLB5bUnTYY3m58YjMyZMoUBE9d6EH8Td85/YkKlPExtWUW+Oi7
         ixPJTjLwdehQU2sryoEWXnDmGxVhphOniI7h3GqFJcL7vQPPZGP4zsWuCwDUV5c1t1G8
         hFIcYYQPn4zGmlkA02KLJorME8nOROFAhNpZP3vIPPLMSIds5SKP+k6zHUrJDVurIPi+
         iHWxqbQ6zzt53MBeJrWA+s+0Z1vX/8agK52PTRx8oKKCRz3u0qMHybS5tJ2R2gs3N5xl
         ZFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690179; x=1756294979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=XJQWf47Wkgu6BN/v+fQ3ne8O+LLV6JBHMI22zYRqJrBa3yeoqoiAQ0mFo5o/svcrhx
         Uejl46wxb18iZtlnc4EHSpjRobbZnYb7RG0nqR5Nlak7Ko+MJ7Hc2sUJckbtCjgsz3DI
         MFQ9cvWSa+VH3RFmPGKBRAoYEPInUVC0kOHFGIJhMqrfR4lAR6nOWADo4vrzDmvrJboH
         X81tw+RZVHd6SLpfIoCaeZeBHIFyk4VBPaZp42n+oWeZmlvrXj3m34ie2wnNqrx1HvnD
         jbsRikFcuZS8D7iGJwIb9AZ/XgNEQtfA9/QMY9NtbydQv2YwPMbqgFcpD508k6VrRtGm
         Y93g==
X-Forwarded-Encrypted: i=1; AJvYcCUD2+ceQ+qvpAPRwGDRqYBG45yQAw5EFfit6omz/b7+sujp3Y4MLOs+3K3zlFkCNSmxVQvKV9ULSzVatPg=@vger.kernel.org, AJvYcCUUAJaGXeLX2Qm8IUkpG8ZECiyDasoVKFT6P9j+Ars3J/Ct0Z7wvpQr4dTXapfAoywHmc6JhwkJ0NEznls4@vger.kernel.org, AJvYcCXdz2y29brggIHD7shQYgM9rmdZlTHnNakOmV6WmEqnA3I3jjA2yCuv3cwfKLFeszbWm41EZ/1ZNF7K@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiUndOP3g2RkPp3rB+WvTaFNJ1TSyl0W9OCTag3YONXfxEsia
	DTCuelO+XaBsTDOTBlj0hbxGGcby6btn+HK48YJgmzNjVNIK4S+soVAG
X-Gm-Gg: ASbGnct9QRk/rH0x7qbN35Pxt7hdGnr6u2wZ8dnL6rrqL1++ORq4w7narpowrzQRUo6
	BO72W5Vu8RvAge/38pA3RXI6O7kP1yvmh+Xoi8Dmanlgb921pnnTZvmGxQa99vr/KVJptNqF7Iw
	9v8ClouFF4V99fIqODN5sF/mOtSrIdplnVV5or4FTKfwPRWVKblR1aAmWOA5OzFlHZ6iJTLcyvP
	9nBa7I4JpIBwJtR3kaGjDt5ArEounhE/MSnSaXQ4FZuBApwjL6Ff8NtdTuEe6GtvFHJOGRCsWfN
	YFlShXJJCcHZOTbmYr/MvLxjgIJxjTkcD6yxhDQ87JVQQ24KNVxLQ5A0YCtVrVa1xO5SH8lSFfN
	9Hu0F1JZTnByvOks5FuqKwmsy
X-Google-Smtp-Source: AGHT+IFI8AgzyV99v8zRg+6mVC13h+rTt4II3r83XMwFOjsMrC9MoEc6gJZf60+FEoPNxBb8odc3lg==
X-Received: by 2002:a17:907:d78a:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-afdf020b7a8mr209218766b.40.1755690178908;
        Wed, 20 Aug 2025 04:42:58 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:42:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
Date: Wed, 20 Aug 2025 14:42:27 +0300
Message-ID: <20250820114231.150441-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820114231.150441-1-clamor95@gmail.com>
References: <20250820114231.150441-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document SOCTHERM Thermal Management System found in the Tegra 4 SoC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml   | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 19bb1f324183..2fd493fcca63 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -18,6 +18,7 @@ description: The SOCTHERM IP block contains thermal sensors, support for
 properties:
   compatible:
     enum:
+      - nvidia,tegra114-soctherm
       - nvidia,tegra124-soctherm
       - nvidia,tegra132-soctherm
       - nvidia,tegra210-soctherm
@@ -205,6 +206,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - nvidia,tegra114-soctherm
               - nvidia,tegra124-soctherm
               - nvidia,tegra210-soctherm
     then:
-- 
2.48.1


