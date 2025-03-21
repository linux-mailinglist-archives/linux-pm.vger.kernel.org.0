Return-Path: <linux-pm+bounces-24383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA74A6BDAB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E4A7A4619
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1C1E0B91;
	Fri, 21 Mar 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRGdw87D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E71DE4C2;
	Fri, 21 Mar 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568835; cv=none; b=i73bOBgpPTh0KAx5/c4Y2quW2V74Mhu+R0QNQWD6xWE+CqbNcjf5qHtl0e3ymmjkk04Xy9VsJeH9JaGIUBU+W4bvM/U2PC/B0ZrjGfQgQCBjVoaAbKZyjqbwaq7BE5I3kz9uEEL4cVO+Hp5dlyB34cCLLeItZUAXEcyjby5O3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568835; c=relaxed/simple;
	bh=2r/XLqMpuRk75VS21Su+p02gUYmY6ZQ8zSCpec3w54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVs0gWJWkWODOZ6NWEIYvmCWqWEKjI4NIVrERR2b59rs63vBv8XKBVsT8EDNPmsbxSBo3cMlwrdgUgge6/zZvJm9JS5iYwZTjbpAYdnCA90lzoWWbdxfj2k5r0xwO3RMD+NQb6/cUPPut4pbse1oC5AMhmUPVbLQzhr1wlSQTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRGdw87D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac289147833so118358666b.2;
        Fri, 21 Mar 2025 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568831; x=1743173631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+v1uOPvAi3S38CktsX9lJnZvb0WY6wb7L0THBmI/Cw=;
        b=kRGdw87DtPYn2eW5p9LIoQdVcj1gR6nZD3eITwb7TcmsoDkPoIRAsAfCh9lVizBztC
         p9xWibjmOStmsSebOAOQQBMr5xWqyCPr7mgGaGHeB46za/k+HcKmnkPxKXiJk1ogmZk+
         gWWQepj/1yt6YwGhgOeAzSkHKzGc0g/qVMbsAdQAX3gftPCp/8vZv0hrtFhbt1rtOl0Y
         nnEtfJDbG19Ukze02/4E/r8cfPBzT8heugFIrrI9p7NUdZkd15Aj2UQwhNyUZ766iFEi
         ka9/MMNNlrNOinF31sxeDDZMl5MXskhiJEXxumh1/Hzkri1C824mkXGbuU6bpbGN0vq1
         aIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568831; x=1743173631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+v1uOPvAi3S38CktsX9lJnZvb0WY6wb7L0THBmI/Cw=;
        b=Xf+kEORccnNecy4HvhX7AgsRb7pb4IUiPoCMLwTn+CdvmDwQcisnrNeySgVUQBAWzt
         JTuImplHAWsoVFgtZ+Gsxzh/9pMmaJAVTlETDWDSHL+pxvLF+wUWAqKeLCNx6czgLKnr
         yYjAlCAW867aVzdcOSpDmN+1DP9FCFpIhQygy4Q7nVV1mNBIgNPAh7nxApGckfkvTUdY
         RfyY7KwXp5aJlAwuvKJCOeWnjkN8lGSA557rj1l7Vt2/TL/yo7G6cMeTy06w2zLPJ9YF
         3Orljzfk/9YYkmHDbFtB9sjHhO/jBSuOZEJJH2NpLOjNvTrGfmav/AcxdaBuPfzByoX/
         AZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQBvjPxAhcOIr80iR7QIk35xHjLAEX5V/yy/QnsYPHEEmSBeeAOW+jA0xPEQZKaVhUosnz99SeMeBznR4=@vger.kernel.org, AJvYcCVe1JBgdd0PApVX71xqAoOsAj36mJI+JDGabgCkGiKNNjAh6IbwKXkx1cg8kaVGUD3k1g/ZJyQX6+NPuqaP@vger.kernel.org, AJvYcCVlzvbJ0Kxt7epsqyJce3Ag8Zns0dBD6n5CFfyeLiStUnl0zEtDbXmC1sGToEbRpID0/s8GI9KeKs3n@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuWdz4cPCmZTFaEbumS4MTSFPn6bMqSp2a9CeUMzNQ8PrfoiC
	joyiMtqSLASItV3sjrZdJEsfHce7tw58UWo4YCRVOfM+FLXy15kQ
X-Gm-Gg: ASbGncvDF1mOVkUamKOgU1fKZSD9dY9+qT/jbw+kR3pGxFeFxyHw4e0935zO/esCNWX
	L1vb76rw/QndhyTEaN+xPzP6VpqXEkjTrzZAMxka2SggEwWBjXza8H0bHoNJvIcuZS3GV5+r3By
	l5bKwkndrfHHVEALDhlJvfbiizKdsmLi3L7N7ic+noL9RGxi/2x8dbhDlZYBmoqi+hiUALFyq+C
	2NXh5xU02vDGKTkHJs2RDzEnIzDSmQ//dhPOEAUh/4LnglXWR2fYSTmbkoEEQmJ3h9B9vOux8qs
	YPKkL7x/sYc1JRnDVGYwZ8sLpkw/JTqi9uiI
X-Google-Smtp-Source: AGHT+IEiGwGWAmAdFOT8Vz4MAwwffwvMYdqyjjzFqRIp6ititJJ1EOtxUtuKIG95Sv8TRxHDbgFxpw==
X-Received: by 2002:a17:906:f59d:b0:ac3:8aaa:406a with SMTP id a640c23a62f3a-ac3f229377cmr366878266b.31.1742568831297;
        Fri, 21 Mar 2025 07:53:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:50 -0700 (PDT)
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
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
Date: Fri, 21 Mar 2025 16:53:23 +0200
Message-ID: <20250321145326.113211-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321145326.113211-1-clamor95@gmail.com>
References: <20250321145326.113211-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document SOCTHERM Thermal Management System found in the Tegra 4 SoC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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
2.43.0


