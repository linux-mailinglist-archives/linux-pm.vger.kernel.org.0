Return-Path: <linux-pm+bounces-30771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ACDB03969
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B5A16B6AF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AD23C503;
	Mon, 14 Jul 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX0yo8VO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4A23BCE7;
	Mon, 14 Jul 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481395; cv=none; b=U6lbEMM3uEbigvkwJvXbqpw/sgK7jLbWlGBITLLR1evET9hgLipwfypOBw2DiEDIVRoalSzJzxMqsdSIt26fKDKPkpXkdPd1q/7uu7ttweUyNcTt7X+oX/i/COnCUEcA/26/YoRb+DP6SK8WkvKT1C0hi8r5qPspVwFejLF+Ifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481395; c=relaxed/simple;
	bh=L4F7l6/zYxQr6YTmwMkqwY0oWd9rKPsyg57GCchM8Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKG50+DpXw1gh7QdC1LBEIOWrBx3cSdxDXZuxPB2yOwsfmVDydZWjmUrzaFcWUSWVyBM8fC0m6NMZExB9ZAibG1sEbIBovexj4cn15iQ4uSa6NOjWLnQDqhFK+eAQi66aU90+1OEf9gGtvFOMrVnOfz339Y9ZYeyEJpbmOPXmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX0yo8VO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso4059418e87.1;
        Mon, 14 Jul 2025 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481392; x=1753086192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=kX0yo8VOuUnTTumu9yc8DdXppiYOXrSaxtEuLGtVh6LqboCYttpFfqhVXXpY74b+4t
         g0vZKvzDPr2wKs1JoPRinOfkc/+ZZybgpDXV50G3RhL8IUx+07Xm2S/RGOUz7yXfMRnm
         3NQj/o0N48/HuC6xfoV+dGr1xbQrj0tLxRe2/nn0fUjNtW7lTfK/16YVmFVjA5MR1b1e
         Q3OBpNkPszPcTX3pbZrhi/XXfV1el10pxjXji7YSI8dJbYhMRYWSegADJS6Y12IH7wDO
         gqjE1VGx9bqwnpvmDCIPcJcqHeFxsYxuKmccbQ6SbhNJnVpbI+0jy/himZVgxBOWXoQN
         2KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481392; x=1753086192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSrkbcQygzyv3Mie6iN1oQzHFwmPp08jaxR7FqBTcno=;
        b=v4hS/GKh9aPkBfdSgWhLAFnCS3Nv3xIOfBGjKmkUij2rTGIB442nZWz6MZqgnAJk91
         4py7ISYXr7vN7vi574V+Ys/hgLycuDkaVJcrVIK3dT9h7C0ot+vMiMD8SLr5MXqlGsdl
         4ucEGknabXUcCrKLEWCzRVkjmrg/wfcrM7Kf2EIaf6g+MiXfS4oqhgK/cXdKF6sufnON
         TnWb8ZjLjISi1zMGsJUMuI/SA7AyICLHnmv+0o4Xzp5v7d+L+LEI+ahm2i6ZS5IX4cKf
         T+/A45spI4othqn9wfRe0PcS7+4s54KR7Ha11HcLscMx0xSjKjt8sL1cnTPDCVO5cvpQ
         Z4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3wIyYgUMW271gE662Bg2nQ0GJTB01I3dv7NAOATITkx6Vp1x+2RcnRRWHZp/OU86pEMPi77MpqhvQynMu@vger.kernel.org, AJvYcCXRM7zN+s4KoSMohf23PuFbgvGFTGn+90HphzRHSFdF5bvyrYHt5SipSfBAKcFXMxyfamKi+TCd87/O@vger.kernel.org, AJvYcCXf03R7MxGb+cMiH+57wqZBhm4+s1NEpvwaNIbFqxK2af3Nh4tcOoOsuWmF0zW4eJBB0b1eBjtDCMr4ueM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6WfBttMvBun0xTSGsM3wrxjqdvXNVEW05Aoqj6CrafwLANBf
	+E3trrBGgnYjqgczklvhhwtbdaBZJ57bRBnzxWzsKDl6585m+5t57uG9
X-Gm-Gg: ASbGncsahE19NURF3GIScwg9IL4S1QSfnrCUkqKOTVCqA1D7LxTzRm4WpfSk70aco8o
	sbufAcBjd4wZvC1+826rto9VltQ2OCPdEdDBnkVqXVaar1hax5ffp+BG4TIjdWLMZl9TfJjDw9Q
	aqxVUIN/ofV1hKE7/9glQk9s3JI8AokwJsd97xW2YJjqZOTkN5wh3ktbKf0vKHA48qKRILNMwvx
	9GECzkvK8VvM0oYX3x9xXq+0bCoxAf4eyn+gm10wf0d8jhSK6yv3yN4217G7N8rJuTT7X6u+yWq
	ELFMRq9cJ9i/R0w3RMC1QUiTSivVWeDwF2ros/nNSAt9C69ZBEhi7eI0G9I/v1MG+68TECDokji
	CwYlUYcDY5zFcNg==
X-Google-Smtp-Source: AGHT+IHMAgKkWpEX3FsXPuaRIjrzy0JmSPPty76/YLtFw/J7YCaMvn4uKAxsmtffU09MvZ4cbh+Rrg==
X-Received: by 2002:a05:6512:138a:b0:553:33b9:bd3a with SMTP id 2adb3069b0e04-55a0464fbe4mr3163683e87.53.1752481391576;
        Mon, 14 Jul 2025 01:23:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
Date: Mon, 14 Jul 2025 11:22:49 +0300
Message-ID: <20250714082252.9028-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714082252.9028-1-clamor95@gmail.com>
References: <20250714082252.9028-1-clamor95@gmail.com>
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


