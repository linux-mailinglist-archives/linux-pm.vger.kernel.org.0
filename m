Return-Path: <linux-pm+bounces-24642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B7A764BB
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 13:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24733AA5E4
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F11DF973;
	Mon, 31 Mar 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwAhWdBb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E82AEE1;
	Mon, 31 Mar 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419293; cv=none; b=LLR8NeHFkZE+9kNCgetJJBJ3Vi93U/Q06kLcg7ljkZjMvsNkfH5OK35sBANE7WTLSskUTBmOt3q4Sw0QZm+P6uIfNpbHk/86z9VK8xxn7QTv+NCUbSTa+IwbTibowISeZV+hfIiXKcz+dvKNCdzmotGPgsMTvLBJHHKQrJLkR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419293; c=relaxed/simple;
	bh=ABbYmkdZot2xo1j9ZE43O5qMAIZuh7Wo1WZXf7p9nQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HPDyAWi2JmSFEZvabpuwiMZgdJUZI70GAGR4OOS/1l2qD+83/U8IIhL7vcdYiEr0D6JYUWIJM9OZU6scdO/2KLENOndp1YySv1fOaxqbsq6k8DR0JYxfBZhqU31nw3zvFKbU7CH6FHbLJ8speQh/4q273XRqMWLvHPyp+85+gnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwAhWdBb; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2240b4de12bso55787585ad.2;
        Mon, 31 Mar 2025 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743419291; x=1744024091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQQM3Yu8f39BKq2Mg/PjZ0Uv+SRmBe59/r9UjuQMsco=;
        b=KwAhWdBb9yClGr6oBYYq7h0Uce6u9C/fr4gs6276sgoisCEJoEHRjimA+0U+fCfutp
         TxBLzlXr1BWHhKLRffUxWUD0yJ+2TVS2NF792s4DFrysWmFWvgy6EhM5mctCihOPaaYm
         gbSQJlEvQLoeoFC7B/cWAz3yV+MaNPiwJovyqDwRGARGGoHtHfcLqSw6U7IcT315iWZZ
         esPNmqjnUlbWqYde0+Ud2+RFR04/+QR4OGPHQoii5nyeikGWsMQHeXv6zBbBUk5Sx7ns
         KbPSRm4Cz2vzZbnsHr3kaUYv5H+WgJu3rufmoVk8hJuOUS8V28pyi+RHAbC9nGs324WF
         +oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743419291; x=1744024091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQQM3Yu8f39BKq2Mg/PjZ0Uv+SRmBe59/r9UjuQMsco=;
        b=PrbdtSBxBTdvy8AoZWUh1GPEb/wxnzuQgUQZI4gOfRoFdO1aMNCtGSg7CBqbx8/i11
         LmKEUNUci/d4hmf0z8oZNIHbIuTjVJUaQieG3s4yxakYa8YuYGdUXh9q1JRegFT04h8Q
         s/ggBA30uNjKoFBkWlPuc90L3UKn5YsR9jwja+RLd4EZUKhZBlFNdVGAr4uuohsPVTFX
         Knt9TfMdBJrElC6QKOUAm60iMtjnuYKymmReqYFms9tl/9TrriejYBcxX3QDu4I7ythw
         HnY8H1N1krLIQD5oossitbmQkTrfN0MdN8RSapmb7iSXUOH6Oezg066+eeW31nyVt8Zv
         XrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4h8dDwjdG2z+7mGTtPAczcXDanXwBCtNxMz1X77gHGZE7mv5pT04NZEDk2QariRFXDNvoqHm0mrjkSSsoaIrFEhE=@vger.kernel.org, AJvYcCWc/dovgWD6Ld/kTGB3hLzfJZ1IC94SCpoxfz+qR7+02pxQrwHHa2j533YIGqczx3fwtc3s0PEXCyxVW8o=@vger.kernel.org, AJvYcCXYc5veThWirG4Lhvo0wB4703gkMQxO17y5Ptjnkbd0LRfeVgu/lAz/3GmwxX/41cstoNs7D8oenq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22YuOsE6xo/bp7d2xGqCriCsrOhD/fzWnMTcDXRNGhvQT8ZaT
	8lPsGzhA32Njk3tuhIYD+YXCDUHuuVV/HS01ATq2MnuFYekg3hgw
X-Gm-Gg: ASbGnctrc3OQDlmNR9vFMxRPv9FFEeIyCqZWT9srtXqjtlhJP8ojWnanK3gfGW10HOu
	7Fqpka0R/XiReuWK2jljCwe1Y8dYCxfBmfhhWtuY0WwgbRpp4Ddfq0PZOeIbwbT0uNS5mIDSJad
	59lu+4UOE5T6fuL/Q3vZNumAPp/Nq1L+UWt186uyv33TLHi2Q0TbCpgk71fbaVukW4o/W9JPLxp
	iMOe22oTw+D4uc+Z6dtP3q6HQdX3RKOwQz9WCE9QtkaiUesbWTfCwyeYEicFo+cNSYiPfsktJIy
	iAAFxdQKUKnbQ0cv0Kgr0arRdevLe9xRzUuHqMOCAArt5IUxCokfE8hVw7kcoV+y3D8jlyg=
X-Google-Smtp-Source: AGHT+IEfDTgHboSZ6iP2dwOP4vEW2XdDO0sbdpyybIi/mimcrNizy0gR6Y/LkkD3gFM65fgc+CAQ5Q==
X-Received: by 2002:a17:902:c408:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-2292fa010cemr150564165ad.49.1743419290986;
        Mon, 31 Mar 2025 04:08:10 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dfbb4sm66890615ad.198.2025.03.31.04.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:08:10 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: djakov@kernel.org,
	krzk@kernel.org
Cc: s.nawrocki@samsung.com,
	a.swigon@samsung.com,
	alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] interconnect: Add NULL check in exynos_generic_icc_probe
Date: Mon, 31 Mar 2025 19:08:02 +0800
Message-Id: <20250331110802.9658-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function exynos_generic_icc_probe.

A NULL check should be added after the devm_kasprintf() to prevent potential NULL pointer dereference error. This is similar to the commit 050b23d081da.

Fixes: 2f95b9d5cf0b3 ("interconnect: Add generic interconnect driver for Exynos SoCs")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/interconnect/samsung/exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 9e041365d909..3dccc84f72cf 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -134,6 +134,8 @@ static int exynos_generic_icc_probe(struct platform_device *pdev)
 	priv->node = icc_node;
 	icc_node->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					bus_dev->of_node);
+	if (!icc_node->name)
+		return -ENOMEM;
 	if (of_property_read_u32(bus_dev->of_node, "samsung,data-clock-ratio",
 				 &priv->bus_clk_ratio))
 		priv->bus_clk_ratio = EXYNOS_ICC_DEFAULT_BUS_CLK_RATIO;
-- 
2.34.1


