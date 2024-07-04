Return-Path: <linux-pm+bounces-10588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198529271F3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78931F217E2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBB1A4F03;
	Thu,  4 Jul 2024 08:44:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAE17D8A6;
	Thu,  4 Jul 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082641; cv=none; b=j/IIFPlg8M5juKSq8HNBU6xQxZexNdcKJslGNbUtfcB4DQqO5QXE8EAAOcvmJ0Q8rU2QHXHZq+p7rojufPbs47sFacqZupfVp8YX1CGwkfRaWSmYRq/VsQtvUGW63/teyZvIhYZj2Jaz2+cF0pYF9MWwTERAT4aXbPRh9cBNyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082641; c=relaxed/simple;
	bh=hDIJcE+KJmAtv5i4pG6A860g2pb8AFoO9VUIHwGwXd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pBM5y8R0iHDP5gSo0AdDASnQAFA0ddgiiJIvk24y+4AoS97OxzAhUdDhFVnKjn2r6NMSoRBr4Loxoh4jKdKtnaB38Wfe8A8MQYi8p7rFOtWwjMDnB79rKFRS8FcUd4GoKXdRZaTDGYizQ2ZHEdETNto/szqXMZkCcdbATf/qEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68699C4AF0B;
	Thu,  4 Jul 2024 08:44:01 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4E3C3106066C; Thu, 04 Jul 2024 10:43:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
In-Reply-To: <20240702090308.8848-1-dima.fedrau@gmail.com>
References: <20240702090308.8848-1-dima.fedrau@gmail.com>
Subject: Re: [PATCH v6 0/2] power: supply: add support for MAX1720x
 standalone fuel
Message-Id: <172008263829.67267.1505449895198933193.b4-ty@collabora.com>
Date: Thu, 04 Jul 2024 10:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 02 Jul 2024 11:03:06 +0200, Dimitri Fedrau wrote:
> Changes to max1721x_battery.c:
>   - reading manufacturer, model name and serial number is only possible
>     when SBS functions of the IC are enabled.(nNVCfg0.enSBS) Factory
>     default is off. Manufacturer is "Maxim Integrated" and the model name
>     can be derived by register MAX172XX_DEV_NAME. Serial number is not
>     available anymore.
>   - According to the datasheet MAX172XX_BAT_PRESENT is at BIT(3) not
>     BIT(4). Furthermore the naming is misleading, when BIT(3) is set the
>     battery is not present.
>   - Removed DeviceName, ManufacturerName and SerialNumber from struct
>     max17211_device_info
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
      commit: ad0aa2361c8c0d1f29db3d6da4a11be41813296d
[2/2] power: supply: add support for MAX1720x standalone fuel gauge
      commit: 479b6d04964b5abe66c9f5080fad3389b34e2a70

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


