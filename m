Return-Path: <linux-pm+bounces-10109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40491A5A0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 13:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08331F21230
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766D14D6F5;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+aRYENF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7D13AA4C;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488875; cv=none; b=RMyjbka9uMJe13enxZ/7BO7xZu5WXaIwWFTxlU2ncgQBepCIH+xNlS31wsDEiOLL2nNcQw22Jjcg0rvAB1Fhyd4ZvzVkbA47JaQggvgGKf9JkBP/8xeiIySzYbsyxMhCQbHIPsrSlnjVlbcWs1mo1MPeJSiBgn5WB3DD/lOJl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488875; c=relaxed/simple;
	bh=AqD5B1YwKKcyDo3GQkyVkWdvVTiw9+IO2HJ8jhgiwXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oo51RMi6jP0D4O5eZH5EKttsMnaJBz6gf8vvOvNO2GBgoBvyL5rUV1JteMnxdqB5ZY6IBVZAAR+iDJ6uxp3/UwceILfTKnjXGuKbFewAkX/qjF1QHdMF37BVSpY4fQzM7aic6MehrKGzbpPDTI9WVUhhxQP8Dat0o8RjIDMBJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+aRYENF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10092C2BBFC;
	Thu, 27 Jun 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719488875;
	bh=AqD5B1YwKKcyDo3GQkyVkWdvVTiw9+IO2HJ8jhgiwXg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C+aRYENFOb70zRetwZW4SnFF98c0MplACowYbw9Osk7cHGoATN5z/rwpVhuXly0cm
	 zyeh6LUWGheUe6rdk/9LRtoDRFohVHO1Z0vZP1qnXuYN8D4Ghu/UHmli4COYz8YaN8
	 Bym0jYOdCnrnY4JZg08fceQ+Lua6FE/g25cWVUUV8yyNSNdycnZlRu8GvLsOkfpIWU
	 x1QznlY6k2YW0Ppt5JrBipp8O1EdA1mPjNgpk3Nn8OXx9MtlDtOl36iqjadRZpP7Ve
	 lKuni1Fgfgj35PBPM6zuAm0b73l+LPi5KQEps3UVa+cYRcX8hfbFMuvNeYmvG51c+Z
	 dRguAVdkC3W4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF043C2BD09;
	Thu, 27 Jun 2024 11:47:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Power: A5: add power domain driver
Date: Thu, 27 Jun 2024 19:47:50 +0800
Message-Id: <20240627-a5_secpower-v1-0-1f47dde1270c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZRfWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3UTT+OLU5IL88tQi3aS0RMOkJJOkFMtkEyWgjoKi1LTMCrBp0bG
 1tQCowTXwXQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Hongyu Chen <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719488872; l=823;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=AqD5B1YwKKcyDo3GQkyVkWdvVTiw9+IO2HJ8jhgiwXg=;
 b=iM+aPix2qzXLnRj/1pDN59/EkAe3QJF+Tz3mKsuS3Hbh+C4AwVDZWkg5pc2ye1/YjyydTBabq
 Kqa0jzqnk6JDSOiEKPf7bPE7bH1eDzABCrpkfF3m06l0LbrPn2cqaIH
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add power controller driver support for Amlogic A5 SoC. 

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      dt-bindings: power: add Amlogic A5 power domains
      pmdomain: amlogic: Add support for A5 power domains controller
      arm64: dts: amlogic: a5: add power domain controller node

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 10 +++++++++
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 26 ++++++++++++++++++++++
 include/dt-bindings/power/amlogic,a5-pwrc.h        | 21 +++++++++++++++++
 4 files changed, 58 insertions(+)
---
base-commit: cc647e931a249605e06d3eb3ec89a7e320fc28cc
change-id: 20240627-a5_secpower-bfa1bb4bd9c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



