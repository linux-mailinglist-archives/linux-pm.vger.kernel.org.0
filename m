Return-Path: <linux-pm+bounces-33009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D6B33CF5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A03165926
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1F2DCF4B;
	Mon, 25 Aug 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHbHIJ6N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D232D97BF;
	Mon, 25 Aug 2025 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118453; cv=none; b=Vhj1dl4JVI8C5o2UlMVXGHWqZDEthiyyV/B3tx/JMkJJ+bfMPqpNnVV8doX8HwWGbExJQ7QCw4muzyL5CQGyX71BJhWQLfy1MMXlff3PsY9gGtPki6lQn/lNd6Tl+K6Sx5KYUJXOjYv0Bc82R+2Tn4UDa6Uw+Ca2pNg4/KUSm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118453; c=relaxed/simple;
	bh=L4F7l6/zYxQr6YTmwMkqwY0oWd9rKPsyg57GCchM8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohOVg+FOIQbT5+5Y+5F919M8DWiIu064ZW4dw0ArisZ4k/HYk5pPNSkH8JZArpvvVdLk1JwSNGTyrYJQiH/TuklgylBciPTJRJmGhEXWe34cPRDcgwh+ZnumjaZ40nBVSgIBJzft/1BW5uogzC1WK6KxJJH/Tq76Cg792DOyyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHbHIJ6N; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a0442bso683899166b.2;
        Mon, 25 Aug 2025 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118450; x=1756723250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=GHbHIJ6Ni1vq/npisC2kXKybgnXEISHbHNqIhyph7zmE8/wQfy5KwxAGd4TGG5i7+m
         dCgdat1OA2q2w3rbciQIFAMA6ptyOX9g6F1HtTKevexZBnEgCplAZIs6ngxKP6tKBWXj
         y/022FEQsdof14Ve+0NMYrAcELhQQdnmeDuuPXzBl6PcPrtB+myrxW0v6vEm/yV1+yLY
         9E0KtCz8ji8BIzOuJp77yeJ4LKY7m5ZOpOLqLBhkci+iIwy2hIoQDMjvHP23yZU8wVv2
         EdFos+2zIflmtK18cO7DrLkUAynTp1qtmQlAI6U3zzq/cXBMFOFMsTgC1ssAsQ2am5Sb
         yfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118450; x=1756723250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=CHN3piCuwl2wiQIe3esBlh0tyeYa/U21bh8KD2pIdmBZI8K9xtH/WB7WVxzGYaQNzy
         uNNo5OJNmlDBKC7N/qBLarMxkONT3ashTEx7+M/emm81wNOa9eYHqarR1dcSXGgcsgwi
         nfowRlu6x5sDa+K9wHQToP+sUXgaiq5hOh9aaL4EaI91QGGeHPojaQUOyjOvJGwEBJOH
         qCUwujA0jNHHsM4pBC2ZOz7rOgn2wPiEMXqxi1yt1XPWEdByZBMnGAZewxwlRV+lRXq0
         i3xASHfeRb3IgXCajMzYZjDA/kcuWaXUUWvxC5ksaJcbOkUyEHDMPW1eSkCnu2eQFauD
         cE2A==
X-Forwarded-Encrypted: i=1; AJvYcCUZuwZrw4JxbUKUKqYS6NoiSKEYpBZ7Jc+5Zij2yjnn6jgG+t3Kc9rjuov/bHWPnY3fVTi2GuKmtFGPuwqF@vger.kernel.org, AJvYcCUoKy4MVojt6fibkSa+l2mVgnz6hMDsIcYNj9R3/+YfSkbSTJCsrNKhHVApuftq+lBF1WO2R5xrELlskWM=@vger.kernel.org, AJvYcCVUGs3oIcUZuMwP3Q2R/cKAg6/LvzCyWeEpFhwjFCaODAUSd9swnMN0k8kfr3zEnrPsQ26aAUlmQcyl@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTZKHXcSXSXDZ8fYVfNlxW1ROHicV/9EEfqqjMnGXdmNYPmMk
	IiOBJW8H3QBzFQJb+BICCvpmhMQLunXNM2atvFgYGpdwBUE66TI60J0D
X-Gm-Gg: ASbGnctaDmLsaskPQZ5A2m/sfsns+02A0gzj9R4aAO+3kjEb3z7yBQwgxtZzEmdvgd/
	L2rIGE/BElNiJgbd6YwSzZ5EyoQDM5010gx1qK817NB0XmVvR6i7RxJflaormTJLXCMxUfZG0Hf
	QZJVIJjjqz1XeTC8D9F5lMh2OKN0jDrc+X6IzFMMZCxleGSYCs9Ux3JFZMr+FJaoVh27pfcjqZv
	QOtuFIHzQ3K3+PaIOVwxRwqIXoC2wFthta8JSlIEAX8X5t7xK48AYA9UZvwWmnQjwLc7PqaESbj
	qdrZhBUi3RIsVnHQvvEnYXTeX7eVJJ+D6MPqh7IR4kg/q+qPe6F4NY/uIgoDcybZxfX+nTb/cBV
	DbEF+pXBKjEI0MQ==
X-Google-Smtp-Source: AGHT+IHAfkFcoQRhraeiFz0ZOQDIyEc89aUV0fmUXypSf12mRipHjKJQ+jiBaTi9dZRqm/RQFSAIBg==
X-Received: by 2002:a17:907:7fa7:b0:ae9:ca8f:9642 with SMTP id a640c23a62f3a-afe29046523mr1079798166b.15.1756118449894;
        Mon, 25 Aug 2025 03:40:49 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:49 -0700 (PDT)
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
Subject: [PATCH v4 2/6] dt-bindings: thermal: document Tegra114 SOCTHERM Thermal Management System
Date: Mon, 25 Aug 2025 13:40:22 +0300
Message-ID: <20250825104026.127911-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825104026.127911-1-clamor95@gmail.com>
References: <20250825104026.127911-1-clamor95@gmail.com>
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


