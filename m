Return-Path: <linux-pm+bounces-27762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED1AC73A7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4CC7B4D2F
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794862248AA;
	Wed, 28 May 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xyTS/0IS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F522173F
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469557; cv=none; b=qz8RLqfvSfclieWsSg38jUhqP4vksj9Hs7BB3/D4tjQvGiukq021xbp9Hu6I9qBRRjQWWiCOlK4qFLl9kw7c03yIocSAq9Cqf1oHQ7mmJvf5Kd36UTCzBrvoSGoXiOIfGMPNaKFM98e6iQg+V5XwCVvU4ahL3qXmdofmStnjRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469557; c=relaxed/simple;
	bh=yyebnnYOMbojsKMKGZn7b6zqWXbtEPzDW9iqHsQj194=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=egnRNi1Fnco9xb4d9BVs/yvarLZZEkLP43Z48pYd77N56VuhzU1K7fZ8vUiFdWAmuSL5BRHuyVxG0rkUqCVtn0D2OnXDvJx2UQfGP8tn6yPcoruLMcUfIMHYaNkBZEBQcFk60Z+M6hcqATu+GunVW9vsMevLmY96xGLTvXilNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xyTS/0IS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-477282401b3so2855891cf.1
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748469554; x=1749074354; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omqhGSOmEXdWEk90xAF7uWs/RUMkuzL/uGHdLMr4fAc=;
        b=xyTS/0ISigjpP7Axm6ewGMGQrt7+CGWL53KT49AcWkNAStpWCOxm6B6xw8CRQYmE6D
         9W0oPyepbxSE4hZMnWx31r4QcqtXjHtR7KC4EvM0U2Pj1Ld2VWOchAMgWX+1z3T9Vp43
         0zF+ckASBLohDBX8EB78mduf7cQPX9/50uBs4atvDYTEa/IM6A7QVMRSp8WH++BpoSr8
         zkR1HKXCEOS15jCK13yrI84y3OtdnRAxoENi9n3+4cOqyUv7mMFyigaaEGFWS27FwDJB
         u0Z/YwSgfGQEEJZD8Hz28g/Fib3UBGkAvrhQ4POu2qt0tto9sTem4fVp7oEkT/GwrnVP
         AQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469554; x=1749074354;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omqhGSOmEXdWEk90xAF7uWs/RUMkuzL/uGHdLMr4fAc=;
        b=P9St5vvZcswjKIgH1crdpx4bZLxtPL2EYFEmX2alUPmODiEnHk2vcXPeg78V7HqokX
         LehtHcqnqfAB9a7xB13maqXFH7yPp6MCzKM74Ul3ymurFJJPIb/4AaRwQgNcNUbaiRrA
         ammhqjK0HKDmb7fYBxgntmEe5rLOEJyebj1PaKegv/036HW8/A9fU00gnKP6LnFkzp6I
         FtEW/Xf7P08sKuRP0GptHq01l74TvbNfapjERqbNAx20g8OGp46CUJtPZBqNL61y10E1
         JFX03o2j/rrFSVuPJPvLCJ1B4SfjjmHG5oWSx8/6ByhKliYucSqyMV7lUWO2ypKXhpAJ
         8PzA==
X-Gm-Message-State: AOJu0YzYeSEVbubKZd/eR/+slbIlan8p6qWwOPBmN3QbqgglsA6agdRi
	GyTt9vIgf/HWPGAkxIwaX0z7RlauJ6xdLp/VFEtHevuda7ChLARqcA6AOiFtj70e1M1fhIMP5Lr
	h5cobcaI8+g==
X-Gm-Gg: ASbGnctq+IOpS3AWoeIA5M4BAivI+UtbOA9+NfEVusKRUD9+Me+alF0RECkNB4na8zl
	rOfAb8wt2npMP0bIhpn1y/0EsNo/wgDJOq/a9UalH82lToxUOqEtmecRQ+8XY3wkEwQv2RmRPu8
	GqTQbAp8vPud2Cf0QLAcoh4du6o96KGvNcycMdj4aiT9uhD0IL3JkF/37D+zaPpeK7ZmZ1InU9a
	2BlOKnpYJ6KotAltaXTigcjqwEhVGqK5YG6IaRi3BMfAXWk8vStBtGtsBED+fTRidfZzAqBg2J4
	mVGERRwo8o4J6odWi/bsdsLnbOcgt9hA8sK1tNyvIl0hFVKVgA==
X-Google-Smtp-Source: AGHT+IEeu/ru0xTIC0/zY+95mafro63ViqPTFWl+O1vbQhm3YH/mab55TTmjjT4Phvr/wnuUzcgNMA==
X-Received: by 2002:a17:90b:1dd0:b0:311:c970:c9ce with SMTP id 98e67ed59e1d1-311c970d207mr9821264a91.28.1748469543377;
        Wed, 28 May 2025 14:59:03 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b9337c6sm119747a91.31.2025.05.28.14.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:59:02 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH RFC v2 0/2] pmdomains: core: add support for domain
 hierarchies in DT
Date: Wed, 28 May 2025 14:58:50 -0700
Message-Id: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqHN2gC/42NQQqDMBBFryKzbkoSjIauCkIP0G1xEZOxGdBEk
 iIV8e4NnqDL9z68v0PGRJjhVu2QcKVMMRSQlwqsN+GNjFxhkFwqrqRmy+zibCgwT5hMsn5jMaD
 FaWKmbkbj6tZppaAEloQjfc/4C56PDvoiPeVPTNt5uIpz+qe9CiaYVqLVvOXcNvo+mG2iIeHVx
 hn64zh+6Prit8wAAAA=
X-Change-ID: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=yyebnnYOMbojsKMKGZn7b6zqWXbtEPzDW9iqHsQj194=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBoN4cmQojOk3Ihl9E9SAPUH/nPBbWT/ptBi3GKE
 yto3X+2wKKJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaDeHJgAKCRBZNxia0/vG
 ZReYD/0UiVWQ8Gm6D+kFMfawkv1wkZcTcoS8aCapvqjbHOU06U54DLhNtqjXVwJZN8SdGkWEzXK
 XCUIb+sR+91FDipIxCQWW4Y8S7xrFpCf5OWEmpXsgNsZtoqa8waPcqpuZo5ymhwZQZt1DxXQCGs
 q3trDyhh1vm5jKR0hWnfgBB+O1xR5IHdAIxKrup8TyeSq8xzDaKWvrhLBAFcbPmQz3FHMOJdXdW
 De0UXcS362k8GBVHyvaRYDA5Y4nG5pmKh5ekpFtw4GEBmojphBna2wZ0IQYgdZVleg+fBfcmymo
 WUNuALb5gFUn5lvQQitX1wqw8vcvmISdmJpUYO7BheCZcJhZDJd6rtO8R50a+6utWe2igSVZJ5m
 bvSHn+VIScsCGcHoQlkBoCBZIYsj6OknD8FC+NLhIlddV9uoCsGzXiu6mRfNPtiCTATg37LNJS9
 Wy5CE65DeVd6UJceBPCa9izXgMWcmHGh3bN3Q5E4V8k8zdBiyG6eR2ZakDWkyWYPQ3PU8z38tTz
 M9Kn4E1+0Henp2Ks+cVffVM3wqs6DFwBAhu12AqjU0UzuD4y6gTCmHwYOpqc0ucR1lJ5hfZKcll
 t6oIbAgdnIMHgTK45eRmxEeOFrcnfMqmpxIXGCfzNPA8+aHRzZuPSjGDiWVnvsNaxu5obhE3q/+
 8tZEFD0oL5da76g==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add support for oncell providers as well by adding support for a nexus
node map, as described in section 2.5.1 of the DT spec.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Changes in v2:
- Use nexus map instead of creating new property as suggested by Rob H.
- Link to v1: https://lore.kernel.org/r/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com

---
Kevin Hilman (2):
      dt-bindings: power: add nexus map for power-domains
      pmdomain: core: use DT map to support hierarchy

 Documentation/devicetree/bindings/power/power-domain.yaml |  35 ++++++++++++++++++++
 drivers/pmdomain/core.c                                   | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 201 insertions(+)
---
base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
change-id: 20250528-pmdomain-hierarchy-onecell-a46fad47d855

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


