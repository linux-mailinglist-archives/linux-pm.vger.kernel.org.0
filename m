Return-Path: <linux-pm+bounces-23968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E97A5EF11
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96FC17DA92
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13386264607;
	Thu, 13 Mar 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgzPQA3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A632641EA
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856914; cv=none; b=tYlR2KHje6Wb7xzmGNb/fRN20jB07s7UxkCsLTHAy/nPoeq1lnq7M7ukxcOOoKAGopFOXJS3ntz826ngxGaz4KaFFEpT4ErwMv2qSWhsria1m0Q+h4YNWg61HNoNnSMBHaxjr3gl7dPgbtstlvtROGXBGPDM9uVWqTcxklaJUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856914; c=relaxed/simple;
	bh=PbxNz4j52RrqJPz3GT+LV4bF8qpe/4u+tr9NI95kvIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bZ0xXLgYdV871b7SMkQL1RPYGvugOvKyguYi1/v9mUWRGg0RlsJmbszcsnlmNGaX5dyoVp4IDaQXRUG3S0XRojp9SeceJYb75vcGfzvEj/lgchV7FAaixIcayY0ssh2Mju8M8b7bV4kB7iAyv3ej3IEdkJHx4mWg+d/CMjqAEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgzPQA3h; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so31400f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856909; x=1742461709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn1R+ATmllHTaRGwoGw1k9ifxjjFI13zCAnW3ZbN+Lc=;
        b=wgzPQA3hc7pjyxw1zYkpD0WCSoapMWYjrJBI+Y6WI/k9X5V1VJStS7kv7NaI9W8Ekv
         fURVQiK2LWNI/OKQOs9fi1B3iUDP8udB1oJvnWbfdta+5h3upi4nWt2t4Kz7WMDaOGJu
         S8LF3IGdS+84C7zU5QREFduh2DU5cjgDa9NEVYRNBypnUEspBndLe/jMm53DZdZDFZCu
         UvE4Q9GujOjFOTZjiZpjzPtOVEAzqzZ6dD5vPJVNnVN0a81JQRHGwagMOtCzLJbVar1/
         41qaa8aUB37TspDzOaQAUgb5R6v4fE4r/1rUoBwtL6yM3lGN6NCh8JYnDc4kLMmSic/X
         oFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856909; x=1742461709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn1R+ATmllHTaRGwoGw1k9ifxjjFI13zCAnW3ZbN+Lc=;
        b=dCAhGHiJcOs3KVUdLd+Mb5S5dVusB7+YTlfy/TzOpkq+YTL1fc0Wt9aS1RI5kFEutV
         87Vj9RGPkzJy39zWNMwldsr0tptQcTbZBlSCWDKtzDDtfN92jEj42TOZlbH1tZzH2iFe
         2mC7zCRGOL8fUid+eevSb1rriAWgHs4fniq3yRGHNv/D0xH5AbE5q7pvokvo8N8XANKE
         oPsOaCLU6yPb/2iCOafRE15YC52uXrhYnSUA0/BC7hf8Db99j9prmAauIHbrJMdI1wNa
         TNPlq+U4UcukJ5N23zFzBLx7EiS+VkPjCMQvQo8uOK3JEhBXEQ8BpDVzrtsFtIDOCWwi
         6rxQ==
X-Gm-Message-State: AOJu0YxcJlnEOwnRHXTULAbT7XD+M0JIz5SW0TE5orLhaTR4GddX4eMM
	v19hJRS288fYv8gGEROtfwaNDshhtvR9jO0BZUTSAl8cejZYHpknE55L0gNhKXbVrN7BflmgmCJ
	1
X-Gm-Gg: ASbGncuwz+egNJZX1st6kiC/tjPX9P9ZU7kosttHG6bPTLd2s2dI5XNUsMmNsPhVXS8
	gjggENknVqNYxcC98yO1HKtEaNUZuZH24NcpfnaNMcO9XCnwMaNj2iXtr+To6PQ/n9BVGFWFyzR
	RBKLaMd1jGTiS1ztCbNBs8h5DRAY/mnhXnm1///UAXRacjuqBQjya3eIMWhizDdkaxg8nxWyyK0
	2cF2xW+LUvymgXzL3ZOic0EqNbzfolh+JDFszpi//8Cu7JFJ/F7xaL9gfYiQjphSGIx4G8jnOaE
	I2y8zdWcC8nIwcRTnRwlPsewrLvgM/hedVSxW3Ed5m+/B+/KcnKRD5bDetyriq8UKEFm9w==
X-Google-Smtp-Source: AGHT+IFoNWWC1jaAyf8PqpUOd5VBK1Mdfej/CVTPRp+XRscWnB9HJyYphIssmDKBjrAxKD2HrwinzA==
X-Received: by 2002:a05:6000:1b92:b0:394:d0c3:da7a with SMTP id ffacd0b85a97d-394d0c3dbb3mr897240f8f.3.1741856909510;
        Thu, 13 Mar 2025 02:08:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Few
 improvements
Date: Thu, 13 Mar 2025 10:08:19 +0100
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOg0mcC/x3MwQ5EMBAA0F+ROZuEsg1+Rfag7ZQ5qOpYkYh/1
 +zxXd4NQolJYChuSHSy8BYy6rIAu0xhJmSXDapSn6qpG3QHGg6Owyxo488n2nG324oURbCfjG5
 75zutNOQjJvJ8/f/x+zwvNdUxpW8AAAA=
X-Change-ID: 20250313-dt-bindings-cpufreq-qcom-epss-9ab649df8626
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PbxNz4j52RrqJPz3GT+LV4bF8qpe/4u+tr9NI95kvIA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCFReYcPk/t6a0zPxCQJuEofxDw8vS8HVb04
 QGJW9zcSYqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KghQAKCRDBN2bmhouD
 17erD/wOx59i1A3edFPIxjPPHYLwR/Vtp9fBve6w0yseMAocRe42ct5wCLh1k4HtdrULcR3xdEi
 uqGSa02il4AVPSxVi/WxvCMdWZW2UIiRCuH6XYcuvnZZM1udPnjj91QAuha0bFauMmDOhGQJVm3
 Ral9PO/KYPjVZStmnPnI49VMe2kps5IT7OiPNly5kNSAepnqICdj9EWbXnsQi+kD3O4jBYUddhq
 dYKp22qs12FdwG9TuwCq3dg7UTkfbrCQ5W0/ihIJxt9uay2xMsuiwjXAsWMrmvIcduTL7qb5Qlq
 fTz02MaujkQ5hNSUQwQ4yUELRlal6G1NUAZZFZnRUJEPWCCpRd6JTfWb31TIzHzThGSsoZdf0Mu
 K5F4Jop2GxaNis2Zgq0bn6DNr8mUyCN0dQRlsoN9yxVfHcOtF5DfyZUfOifszYM6/XwDlOOn1Oz
 +4+JFZk3DfzqRzdssywzs1M7GvrkEQCW7dBwgOzhD9BZb/BEtvwKdqSDwOkiFhhcqwXz62xYVkj
 CCS8JgGJhZlT67Vx1wpE6z5xfIX+laI22v2ZJZDol49PhC0h4/QqfMTVpSxR2dD0AVniMUgbPLr
 BxKVrKHeGoXMxwO3dHktPn3OJkIFRe1jXVP5K0m5pLrCFKq76m5wS9cmDHKqDMW3CVbXs+oJrTF
 1M2nQ5tKlgFk3XA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Make the cpufreq-epss/hw schema a bit stricter for each variant.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for interrupt-names
      dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
      dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250313-dt-bindings-cpufreq-qcom-epss-9ab649df8626

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


