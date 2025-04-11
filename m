Return-Path: <linux-pm+bounces-25192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2122A8509B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544308A2D00
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40E5C96;
	Fri, 11 Apr 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVGMn9Pb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B517C68;
	Fri, 11 Apr 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331950; cv=none; b=q5iEPwGNf5a4R3LpsRj5TSTUhYEEE+uLes4n3EaKE1P8QeCHQRKUOACxRYP3Cfz7vfh8CnQrTUix0WkRpTtNC34jXDyCcPobmbOdwsIJX7w5EJFo/9YkLLBWf9dRbjAqzDqy6f+wS0K16uXD1jZt15WJgqjzT7TZI0DLKoRqfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331950; c=relaxed/simple;
	bh=iQ5x/Qc96rZ/PCJW8hewnQTM/hC7OymarH96ZYHDwuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWVfOssrfrYf0lfHrlA40Z3YmlJoONA65K7uNjyGFBzv7rN+aH7Q6F3H3kjJKPD9w9OGdblHGUh7HQqDGyIpOUydMAZOrjjb6j0yRcyIjZJIQvJezxE1OQzvOQL5hW8pVxzWDiOh2x0GZe65I30L3Yq2uLawOWYmiMf70MqgJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVGMn9Pb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso13040641fa.2;
        Thu, 10 Apr 2025 17:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744331947; x=1744936747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvlzBRZmcfQZqiC8OpRLt5DZkcEUBfxEVIIuGLShicA=;
        b=OVGMn9Pb6p+MrX9BGzIbwDufFd2qW6jdHKtuEWbuPtM1Hp6e1EPqnUbh+jOn+Cl430
         tEvuY+b5YlQ1k2Ck5fHklKRRuREpsEnuHL8qbH4+LHHm5qWpeUXcDuCH/39SnpLmi2I2
         d9pQfM4eUvkZlA9OSkHco8A146zu7Zql3td3BjsNHYdyFs4W1CaZq+B1MF2tpzqbOeoi
         0dZROagmcQx6xbm1WWc0qUYuLj2LPg724ymK0KW1ir2d+wO38e3R4IA31+eitq5NQ3fK
         zs1aXLIJ2SMMAnHJ2XDDDLZabM6kdapMjeI0icEuoVK8xwgklW6pzWOSrXJjQLY4SAa9
         FFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744331947; x=1744936747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvlzBRZmcfQZqiC8OpRLt5DZkcEUBfxEVIIuGLShicA=;
        b=RcWm53GZ/yAk1uMgnaFa/RUSmUd+KTgxvzxS6ve8X6r4IS2L1KcC05tc5OjBtEGo4x
         89BmBBF6emZB7Wqs1zJHum5ppSB190s27aVZPoYF8c/fBO8XNYic0qoWAmUMoDv0KoZR
         z+8tUasaDn9OZgs4dZAXcfzHcugpJUgMBNxwCVFjReYQNmsZhXs488mk+VP3yFQrz0Zj
         tGY2e7TJwID51D/Ee8tO1x4IaTVTvQARPkt3feaUBC3wiQ/ePhLlcVw95GMQXyPKtGsH
         SCDgUKYs0aXbGeDgnHF7Py978s//8L7u2wZyyLJKH5hcFtzsPoAn8Gk1GxU72wMSy8Ie
         C9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU8NUrASr2CKi8kfm05nd8+20FqZKLFACg8WYdXR80Nr+S80DZdpR0mWA7wF35Uy3HxAj6/a/4OYNWv@vger.kernel.org, AJvYcCXHB+tM5/wM0Pe6JMugk42XUPrICqLIC01gO2pfqO5rtvDaknJLZnFxtFsuZDZEsXnTczbR3tSWzgc=@vger.kernel.org, AJvYcCXv9/6BTyD+i+D44lyIbWwitot6lwfnfPBBBWkIQXIazAnhvGJBSy6aJgi5ZnOLvrI1qf0ZQsz4ScVw9M6i@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTHZXUoTlN+BvJkf2R3ZO/96JhmqPk7O5ArE07fvxyl20QgRC
	Ddx24QafCrHAC8FxLCrE/Mai9fWkqImYs0ccyPyB6dZysp1M0LhS
X-Gm-Gg: ASbGnctK+WWG2zAoiH3Ceiw5f9BMoyzAjoSxk0BobngPUJIChjogd6tOiHzj9i9WDIk
	rS8/t+aO4HMLNOzZn0arMj5WoxMnA1bqr4wp1i+v7ebBmAPgvgPRB9pZGBj4SZSAJ1aJ5akK7sH
	803L601CeYSrIHkFW44VlPaHL0bRxCyBE6MG5g9OBzKNgOvHqOP5JRL1z5qv14Q1Q0Gazie+kJv
	QaCuhnpB2PjGcgdqx2EuwUu6i6TPH/YtbR7fjmxGdPWfZQm6+3kTJGojuReNtGyRgkgcWMmeLpk
	49la+mrqfWpk2q8APXUWkI9kzPOzpMNZeDouttpvG/11Nq/7fpTNqHZhw9m8
X-Google-Smtp-Source: AGHT+IEN5mMmLvML1RixznmVQhwUVwoYFg/6bDCB7jcePQLJIp/PR0tcJr9jJQCpqbPiczh3txeYEA==
X-Received: by 2002:a2e:be88:0:b0:30b:fe19:b07a with SMTP id 38308e7fff4ca-31049a8085dmr1938891fa.25.1744331946976;
        Thu, 10 Apr 2025 17:39:06 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:39:06 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 0/6] Add support for A523 Thermal system
Date: Fri, 11 Apr 2025 08:38:20 +0800
Message-ID: <20250411003827.782544-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds temperature sensor support for the Allwinner A523
family of processors (same die with H728/A527/T527)

Mikhail Kalashnikov (6):
  thermal/drivers/sun8i: add gpadc clock
  thermal/drivers/sun8i: replace devm_reset_control_get to shared
  thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
  arm64: dts: allwinner: A523: Add SID controller node
  arm64: dts: allwinner: A523: Add thermal sensors and zones
  dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |   5 +
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 145 +++++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 154 +++++++++++++++++-
 3 files changed, 300 insertions(+), 4 deletions(-)

-- 
2.49.0


