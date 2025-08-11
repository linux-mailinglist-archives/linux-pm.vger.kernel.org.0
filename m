Return-Path: <linux-pm+bounces-32134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E71B2013A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6640B165033
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669702DAFCF;
	Mon, 11 Aug 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfTBHuw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D12DA750;
	Mon, 11 Aug 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899490; cv=none; b=Yy9+ybj5nJ+oodShekjK1NWL5BMoyRiAByduS1CM7HXcOzgzH3pJx39b61bjErtjJdPOBDImrJn+2nSlJ+ZK7myhmh+XtfwGScyNkMAPxQfIesdzWqWM0PvUAx0q+2N2kEAn3qOw1/uThlXc5WDeAtU6kGclDRUMR2PpROTsEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899490; c=relaxed/simple;
	bh=L4F7l6/zYxQr6YTmwMkqwY0oWd9rKPsyg57GCchM8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Eip5jSEvQOXU4QVnBQmsY451VlF7emnF9VUlklv2jQ5Lip6CDcAB7Aeho3wi0IETA11efFLrrPmy7nc6JQe/Y3sLHKFmwdt57Qf6jIh4ZzUYf4r8r9LSAAExPN6AZeHY96MYhO0XI4hKzoO/kV58omiT/iL6RaDM+xtMf3xRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfTBHuw0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso3076696a12.2;
        Mon, 11 Aug 2025 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899487; x=1755504287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=HfTBHuw0cVcQzedrulRPkD6Yv4IpZsB5icmHwQDDltbhB6M9YSZeoBRo5okcbao54t
         FaxmefqcsLEFfs8Jd6TZvgr0I0JUUahzhCNk3GWccaOZNM9HEcO6DxqqM0Uz5BPAoaHf
         y5Wr1mubu9Ja3bokG5zr4ICM8wHyHC/yXM8ftMeNM2FYv0V/W4nF+14odFUo+9h12HH/
         itIi9cY52GtNEx0t+qJSjVQ1+nAwIpGvqXuAc9wv1TOWr+IJlfGUq44KFN7+1x69WL4y
         ptZp1MyeOLdpzmqmkXwrv+4JKvU0xQ0jCdE7FX6sFHKmiKjICN+Ua1S5hpiWCK3ZQ/zm
         mLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899487; x=1755504287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=ugUM3Nn5RYdj1Nd//VtZSVQA+nxX6SoFdYucCb2zD1jf/4UekWOM7OiEztjHZZClS3
         YkSCz6ml7cvhun5ekOY4qvZsdHDs4cAJTEGeLFoU1W7LJ55fSp5A0xvkh9VBKyADyMdf
         b/1ulbWljwjQQvfxmJsg/a1PolfWKzM/GKs/4LlpEJE0Mc7+SRzMeUCXStrIGVL0bqnW
         jZZp0pw4EXIOFInIaO3iiqc8xeCvMpc+phv7O1/rdLOeXEPkW3bf3jgPoAd0eyg4oVq0
         EZ2Yvj6oqsR14yfGhCLsn5LeYuRkkxJmQ6ctulbizlvP6bImb6xsIMQ497lawN9HjM8k
         VChg==
X-Forwarded-Encrypted: i=1; AJvYcCVVlIO3Cv1LZVO8vCNaoTs2rW5QvU+DT8tD5cMrZnm4gzFNz8quZyZ7BV716LR8ToEjKUzXyah/sRjDiNQ=@vger.kernel.org, AJvYcCVubPxzTmMQWWyP2NWSKYpg2/ELXZtRBUj/NtZ56GNdy9IHmTM/3CI1h3GHbYSI4kO3dA6e+cAuGcic6WsA@vger.kernel.org, AJvYcCWcqlj0BRHt4cxK4ax1NultGgB9VjQwNpJSu3ayL11wEtuXHtQSrhZ/ETc8hKRnojidPjpWhi+ipK3E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+A7CnaEc9BpghQ4O9g+sMFTrK34rS0nTMUd/MQGxr4Mf4untl
	pN7OLXLRmGEpUCXS1r2KPVDSSl98Dzy8sX+wsURdkphdBGLBbRC2GAgo
X-Gm-Gg: ASbGncsgPkHwsPvN7gGS81Vjbkgtet/jX0ALrWzJkTEbAtLXMIn8A3aVYDfGnjzE36i
	iQpknjT8gAhJhaIi0YM39Y5afGUQVyvMIGU2Jg0uE79zOQdEekj0boJdKS0+c30iKtXrkS2HSky
	MqPah1on6q0Um/J0KB1DS7wkWcHWZjf6ml35TPeTwIs8oEbdBPX6WvdNs+F6rC3j39hWb++/g4Z
	dYhWVWosjL8d89XmEBN2adA7ap3tNQRCSNn64773TJkZ+u/+4Tsv3ar6mx1kRIE+sAdSbuiYnxe
	Pm96fCvjAs3VkLCfAEKgZTqS7DXaSGToWmXQL5A5xJlt7iH4cHNTS8++mScP/E4CANxeuDoo06A
	0uIsSR3e0goiDOA==
X-Google-Smtp-Source: AGHT+IHB6M7SGwUJ2tRZfwCzH64DsUsSxsbiwb6G9W2l201EHQHJ4866GRslagyC8SPRnoVDmoE1mw==
X-Received: by 2002:a17:907:7855:b0:af9:e1f0:cd33 with SMTP id a640c23a62f3a-af9e1f0d283mr427375966b.2.1754899486800;
        Mon, 11 Aug 2025 01:04:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1956446566b.97.2025.08.11.01.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:04:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5 RESEND] dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
Date: Mon, 11 Aug 2025 11:04:19 +0300
Message-ID: <20250811080422.12300-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811080422.12300-1-clamor95@gmail.com>
References: <20250811080422.12300-1-clamor95@gmail.com>
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


