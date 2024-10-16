Return-Path: <linux-pm+bounces-15802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8389A1501
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABC71F2344C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1441D2F6D;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD501D2B1A;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114919; cv=none; b=lRDym14lJmDxHL3MBIJHS6FvtgJzAjjDEAebQCe883YodRwq798nLsjKlwAhRMaAvn5IJiCEuDHdSXwZA2ozF9xshe/HEimq92h+96z8MAINw4TlvwS2eZj90ImB4j3PpuBIi2s7jxq7VolMfoVJsHfMB9bEANrJXm/+bT2rwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114919; c=relaxed/simple;
	bh=/6y5g0m6O0+fk05eterbm4ntycsxyuN+VaQnCIO+K/0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K7mEEj2SLk3xhjQFJuTZAO2zMZgWl2KCJlBaAknF2U8agY2nwYQOxrJkhVJ+AAkJPkEKFYpBYjlGYNXMecyMwnpk8taF4zByvoGi0c554zd7N3oL8gcHYVBj5CdmxNXGWMshVtBMbFhvSgI4xGPal1ghK5b5KDpgEWjYjgF04mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C640EC4CEC5;
	Wed, 16 Oct 2024 21:41:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 41C91106044F; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: khilman@baylibre.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, tony@atomide.com, 
 linux-omap@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20241016080314.222674-1-andreas@kemnade.info>
References: <20241016080314.222674-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v5 0/3] power: supply: twl6030/32 charger
Message-Id: <172911491622.630785.377200401875530760.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 10:03:11 +0200, Andreas Kemnade wrote:
> Add basic support for the charger in the TWL6030/32. Supported is the USB
> path. AC path is not handled yet, also there is no entry yet
> in /sys/class/power_supply with type battery yet.
> 
> Without this series, devices will happily drain battery when running
> on mainline.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: supply: Add TI TWL603X charger
      commit: 421aadd19a622852172ccc15ad4049201fd1f80b
[2/3] power: supply: initial support for TWL6030/32
      commit: b45cdceba64d79a2538aeb36926fd9a065f0f753

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


