Return-Path: <linux-pm+bounces-24456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7861EA6DC48
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 14:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E817188F51F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743425FA31;
	Mon, 24 Mar 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M6drabyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300225FA11
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824639; cv=none; b=lWsv4CqKJs+QkgPdKtyb+Jh7fKn1kYH6/FevD5nuj1L212WLQuAxCO/cOZfYq0ewbw9Cz/nUiAOJyQU2x5M7ADnkmmPmKAjEQqR/qSPwfQ9oYtD6dVnNedIVcYIUJah2kYKBP0i97ZmqbaAH9WAuorKPKQ1yrstL1PKLJ/woC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824639; c=relaxed/simple;
	bh=MoEp5ZcQhE/r7CJZd5xBLtT4vzDpLgktl1nQu8ou+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1xwuzJgdZhw4wR0eGGooLPzSzxuOQxhWS1pTZQcIlzlsyXC7OUfC+gDQWVMfiD7A+jVepdfMro+ALKtX+KFquISsoB8BIQMNqPm23M+AoC08AcEWgMzAbt8beMrWn/xNuArUMPqvWqcmHReLZAg+kpY0O3jd5aTL1Ad3hQpT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M6drabyy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39143200ddaso2563796f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742824636; x=1743429436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZXYQlywBGjxUCQ5Y1L04Uo3ant2KBX+A6aBOQRIOrE=;
        b=M6drabyyi/z01OwSHdmg7VKp4cLSJuykKmkO1o2xwiMWEeMwSRQHzdq9GBW2pLnkeb
         0wDrhkAL7RRJ2Yecwz7LjUirkPLcv/4u22jgwreT5giFHDAjmymUn2H+crVBpzYTT9Rd
         evOUDLeyPvg3VDXucjtXN+IW7j1Jw46wFckgE/2Bt2GD+t/LXXo6NOHT6WRRyprwEYDJ
         UgkmqMKYz0/sgDFCM4k24jjJfvbK8/4mo3wICsVHe7efVAEGH/JxzD9wPw8chmOHIw60
         13rXfkaPfmrNCCSXEAwg154H3Oj770VFbDDnRkJFpBIpQsYfngVjr3NIf1i/yjbAlnmF
         20gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824636; x=1743429436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZXYQlywBGjxUCQ5Y1L04Uo3ant2KBX+A6aBOQRIOrE=;
        b=sYdDlLCsz6syyOGlgg5TZ/5EnVsRaDwWHIuvZK9caiTL/eSDomn6XpkcDRpvNcs4l6
         N73PUkzFpy6QQvE0CefYIGSsN0Op1iAZd183PMr5La8JnhT1cV9XlTniiZ8bIfGT+7ab
         1rMZxiZz2Kqg6XLsyb0DBcjy5lSmCwhxAvHve6DTxzGZO0waO/HgCUGossIPFl6SM7o/
         XJd3GmmQRK/c4c4nuRmGYG73FyC8riWXjzsBKcF8fE6joJJHFrIt+G2XKBO2DIP2J2fQ
         tAHp3q2niOd97zq/msjyaEY8eQTaKyb/NCWJ8iKJQbEvJZSyCycPLZBp+sRRX0HX2tNr
         hpfw==
X-Forwarded-Encrypted: i=1; AJvYcCVK6h8jpnu1ekoRU36puw21nLmnOjuJMPMQHX4il/0cHxKVgylUDSYH89d3jtC0FwrIBNf5lO5peg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaoHHMCBF+4xnVtZUDsl30I1zKosRKppdCGpdRjdPCagnjbz6
	Ddfo2v/J1c0FhsYmVhStcS/mWawu+Q28jb99eh7kbzW5S3LT34Lgb7eBSpD5Qi4=
X-Gm-Gg: ASbGncuzOpA9O7I9CU0+gEhcBq6CVtTz93ZMSQBVDbtcgBVyqPCtoz3N88Ioawywtmt
	42zzsnIiFlWTo2gZbdnF1KGY29E2aWPkwkiACb7CjDCa9TQ0Y1XfudzlKwhVZ0nHAkcqbiZ30C1
	MFllDKjRYRo7d6VP1FiBspwK64NLfgDWYT7YDJIuDD4sqp4aC2wF764CIC0HmMTiJqmrJ6/1yKO
	Q1Tw7o0jpsvs1QjhLbS2Q0NyQvfgvd0K0+jl01G9pPPlSeAPZpn0UMaY2ou1Tm2ctfOpzDQfA6R
	R5EK9r1xjxS15rzvLX6oR+RjUmcU3/wUnYM4zxNCQ6gbu1PlrkE9ETsoaUkclKHW445Ybc7l4g=
	=
X-Google-Smtp-Source: AGHT+IHDKpLBvO3q5uFPvr/70DmnnwzOfgKjpHIucZu6pM8ksgy7yC5qAGJIQYpLCs15vezBXQWNUw==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id ffacd0b85a97d-3997f9336fdmr7677171f8f.42.1742824636553;
        Mon, 24 Mar 2025 06:57:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm120146525e9.35.2025.03.24.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:57:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/4] arm64: defconfig: Enable RZ/G3S thermal
Date: Mon, 24 Mar 2025 15:57:01 +0200
Message-ID: <20250324135701.179827-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5bb8f09422a2..79e566f0d47f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -715,6 +715,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


