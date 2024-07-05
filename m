Return-Path: <linux-pm+bounces-10687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D4928790
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E8F1C21F3E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3F1494D4;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0Igj83V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94951482F2;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178008; cv=none; b=SYICl1dGyE94CnxnFEGd8REp/LmCHNLszzSmBw1vDPI9nVTHNCDZwxXboqOuGIQd3Swp3rfdvcnE4Mr4XrUVF1O1lVBVY92yz/wLHsamMteTCJyyj9dG25k8ZNOCBvgbDarzYH/CjZhnrABmw1/FvPaXvM4+vtLgSDVbiCwsGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178008; c=relaxed/simple;
	bh=NR6dERoCSDaycJgCgMkPX5tK/ic6aM93Ky3+ivQy/0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PjvrXBGh2xT4kcszVkDI7UOXUdMLNWPLPj76s/tHaVLvDLFxioBC6VWz8TJzIohY6g1MJgTqgfYQP+JYQPlxEGj2etu/6kJHCcMsDQopYE3F8608AO0Yp3so13B+lXZvpDzh3BMVRIBsWJNT7hAKSgCXT3yki/yRn6C3u9u0NBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0Igj83V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B076C116B1;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178008;
	bh=NR6dERoCSDaycJgCgMkPX5tK/ic6aM93Ky3+ivQy/0M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=e0Igj83VW4dexvk2eseLiOsVCM8RzTMofF5VtcjVyHBHvThsL2wyPDpuAkHnOJQWe
	 x2NTMLieeWXSVa9ajSo6Bn9yInzvmVtKeY82J0jAYDJUtzZNhnG+eENa5a5jVG49ak
	 axD0aNMI6+ZMg4IY0EzY44G7BTRRAQWvcJnVMFJW7Zj5JoZWc9x4ySCusVgvzsbBTo
	 u6tK0XqHGgQON3yYK0TDhG7wPR1qj1psTbQA7TcJiZQDRhgycY6rMu9TlfY85dlYQl
	 WG3+WWSrza3QOyIdn8henS8lYyo2uA96veUosDkUrYUFlfM+fb3bGzxvaNNwuy0+h8
	 QXVYlL0Zepigg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F146C30658;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Add power sequence for Amlogic WCN chips
Date: Fri, 05 Jul 2024 19:13:24 +0800
Message-Id: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXVh2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwND3YLyouLUQl2jZPOUJDODNPPEFEMloOKCotS0zAqwQdGxtbUAlrI
 2IFgAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178006; l=934;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=NR6dERoCSDaycJgCgMkPX5tK/ic6aM93Ky3+ivQy/0M=;
 b=hz7wspgeRvBvZlGNqvwuOnM9aoR98FrZ0S3JTGFxVGzumsGu8kh7uXFHMDfMyAzZ/cVLa2ndf
 MtnmewNrcbRBpd06Pt0pgoD17OLx3Khm9dUuvGh/f+bvlX1EV8HYpls
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

Add Amlogic WCN power sequence, including dt-binding, power sequence
provider with Amlogic, and enable POWER_SEQUENCING_AML_WCN in defconfig.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Yang Li (3):
      dt-bindings: power: Add power sequence for Amloigc WCN chips
      power: sequenceing: Add power sequence for Amlogic WCN chips
      MAINTAINERS: Add an entry for Amlogic WCN power sequence

 .../bindings/power/amlogic,w155s2-pwrseq.yaml      |  62 ++++++
 MAINTAINERS                                        |   8 +
 drivers/power/sequencing/Kconfig                   |   7 +
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-aml-wcn.c          | 209 +++++++++++++++++++++
 5 files changed, 287 insertions(+)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240701-pwrseq-2c7db60f7ad1

Best regards,
-- 
Yang Li <yang.li@amlogic.com>



