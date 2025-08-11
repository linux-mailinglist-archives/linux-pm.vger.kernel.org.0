Return-Path: <linux-pm+bounces-32119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B11B1FFB5
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC783A4DC6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022592D8DC5;
	Mon, 11 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjfom1Ce"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EA12B9A5
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895599; cv=none; b=W3JmKoJF/hWsNsShdy+B1lkJPT2tgbiMUulaGS20D1gwtBPyHcUHEizvvzFgLrUAGMQ3+YnybHx7f6EA5wywOKE4Io1K5Q7wHETuucULWF/dKO2rxpRUZ6AewcmOHmg8bE5J3vZzsQty+OvKYQjsTOWxfvZbhb7gk7wnCTx5B7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895599; c=relaxed/simple;
	bh=6/Hc1lQyX/sBEffGDpxh2lWdftgec07LrQEgXgC9lnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfoUv0P/yYi4JSGXVGOowvWc4NTHKHV64s7OiNRrBFoPLOo6SYCX/zzKzitROAEX1PZvgPf677n4F+bTQtKujsTQFKWBF/zpvy5/esiiKRCgGngpR3n0FvEOw72LP0DuWz4hzjXK0gaohQVDS6kiksOIbbA7QRmSWgDW2MP5SG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kjfom1Ce; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af94e75445dso717018966b.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895596; x=1755500396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C82Arh4xTYMeHCG/1/1Zlt/WYkQ5vluhkK9Oc1vfKQM=;
        b=kjfom1CeASk++aunXOYIk5vm2FW9LabwTFKIM1U0EVHyUW9rrPGlMtw7zohHGGK8Ym
         cEadmi8dcpKv2MUdEq5eGZuuivAjP8sfclUiD3mGsB3mE5gGnApy9uRojRIvDoGIdgxJ
         fCCq5RZE2gT/TZjcOz3/bU7HRx2Wt/g0Yd0VMeXK3RbYQZ/FuSNSDoWg+UQPn9oD8NGI
         Mz2iN3GOqUJMGg9r0iE9gB0NDvPIbzVbqErSNxNIiW46nRfk5g9nMXIemrfM3WQ152UQ
         7ZujCkBUS2TOfjQThYNmKiJ5a0XaASxeJwyYxaAP+yhkKmhQj+373nfN9wCM1c46yHiv
         +vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895596; x=1755500396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C82Arh4xTYMeHCG/1/1Zlt/WYkQ5vluhkK9Oc1vfKQM=;
        b=UoQ12AUYGPO6f/kxKiWv/Nd2RApxDGjN406Nqa4iH6nMLJnYvAPCrg/uoVbY/xvmig
         J6BsW4yptW7tELtFOeeUp4HlEeWpVpemLsds7sA95TjWg6dvp80P044ey17ott/S6dA3
         q4M4v/+kl48BH7nyZq1aZE91FQwoVrgx7tj6QTqpIZxyZhqvT+nwX1Y6RMZy+z4fa0Nt
         5SSpciWCmkN4AoRzQrBr4ptKaD2DzIYW1dXOaZ9BniKeYTfJofxv+LINbB1vEWrHdk/z
         6VVqk+QRU1F+yJuNNU20dnmRiz0Kj3ug3ZAU8Dxmw2G9zUCxoJx+EjtU4oC7nrg7YnvY
         5K5g==
X-Forwarded-Encrypted: i=1; AJvYcCV6W6T1+7LwPK2fJik3gm5aO5ZXQJxzVb1d3/AABcZlZuPa3SFsoIGvcaaA32y7q9NY2E0PS0Iknw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIDMqlP5/0xb2fYvHCZ/KcIP3Vz6fq+/A9wMgPVi3i5d6yJL4
	qw/MhFRnil+IX/SdhcFzg2ozzQmyxHmgoOzjeJisI2v2w7mvLbhzmc788RNsN3Eu3P8=
X-Gm-Gg: ASbGnctPOwVQ4JxhYfPIs5zipGDrjLcI7sMAz/Le02+FFgOB6ipsQpBiSilLUH0pD5D
	hE1hWa+pKTjrOetHOAG1WPzrkyo3a5gxlFqexP3jLKf7vA7aDeCfiMGbt4p8iuNB8UTZJ/Hi0B6
	gfBQId5dwJ6pmRMQ2ai5BT5tEigT/R7lh6N1njYPuXsfrRsUmoZNakqxVcsbXbtKmg2CvY1uO9i
	lRWwKNhDYX2WvRWar+eZRtgz60YWwnL4RqY3msEpm7LC+PQHHRQQsvvJYR78C8pdUj8VO2UcDYd
	X6n3M4Rl9umEowkAmMrPeTgj0+86A2Z+Edt67lAR5ZsHkLKbxngHSF5Q0u766awEwgt+MIVyf+4
	q/6vCiGIMiICQ80SEBamrrDhotzQRFTw7Ve0Ys2w8dw==
X-Google-Smtp-Source: AGHT+IGqqRfA+YAuUWVO9oMWB79V9bGdz76SAHGkSbTas9+S9/PzMkjIQu0HGns+DPg11457PNpGTA==
X-Received: by 2002:a17:907:9490:b0:af9:34d0:836f with SMTP id a640c23a62f3a-af9c6484551mr1072512366b.27.1754895596477;
        Sun, 10 Aug 2025 23:59:56 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:55 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 0/6] tools/thermal: Build fixes
Date: Mon, 11 Aug 2025 09:59:09 +0300
Message-ID: <20250811065915.3333142-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some assorted fixes for thermal tools Makefiles to aid in building/cross
building.

Eugen Hristev (6):
  tools/Makefile: Add dependency on thermal for thermal-engine
  tools/lib/thermal: Fix dependency to host libnl
  tools/thermal/lib: Fix header file installation
  tools/thermal/lib: Fix dependency to host libnl
  tools/thermal: Fix thermometer/thermal-engine thermal tools dependency
  tools/thermal/thermal-engine: Add cross compile support

 tools/Makefile                        | 10 ++++-
 tools/lib/thermal/Makefile            |  7 +++-
 tools/thermal/lib/Makefile            |  9 +++-
 tools/thermal/thermal-engine/Makefile | 60 ++++++++++++++++++++-------
 4 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.43.0


