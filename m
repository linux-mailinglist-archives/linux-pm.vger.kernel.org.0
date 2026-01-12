Return-Path: <linux-pm+bounces-40624-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FED104C7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03C54304310B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DA24337B;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45A23C506;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182966; cv=none; b=t3ktTEeAdDl2DghEfO8x5/56PUfI5aaKuZ36A+RxSFsRN43eDPSLrmaE8/5GMiFVYaopL6QuCVkA3mqNMIJ0lKiW4jzkEp5brE+/HDPgjRcyXWvM/ZCYJzlBC9b6jVocEyM9274sZg0yi+o0Vxoz+36cUcjMcbyXOQMBh0djFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182966; c=relaxed/simple;
	bh=6MiylRbjGmEIpV5/vx0stKnsNHaDQ06g4RF9YLBa6VY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cEjXxrou63Fhp8Gszfkrl69XLoJTGgEbMqCKJppaX52TDBBXjdcew/WfPGlql/GZ8Hj1vqKf2ok8bejJlaxbHGXx7o8cJh1IhCkqNQk2gcMZO63qFGCFi3PBTS/zoeTrHNPvvW8/Th+co9x/YIM5gGbrRN2z6vEuTbJMLqvfSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30106C4AF0B;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 11D5818054C; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Linus Walleij <linusw@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Samuel Kayode <samkay014@gmail.com>, Wenyou Yang <wenyou.yang@atmel.com>, 
 Ricardo Rivera-Matos <r-rivera-matos@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Tony Lindgren <tony@atomide.com>, "Mike A. Chan" <mikechan@google.com>, 
 Jun Nakajima <jun.nakajima@intel.com>, Xiaohui Xin <xiaohui.xin@intel.com>, 
 Yunhong Jiang <yunhong.jiang@intel.com>, Tom Keel <thomas.keel@intel.com>, 
 Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>, 
 Nikita Travkin <nikita@trvn.ru>, 
 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Phil Reid <preid@electromag.com.au>, 
 Alan Cox <alan@linux.intel.com>, Sheng Yang <sheng@linux.intel.com>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
Subject: Re: [PATCH 00/11] power: supply: Fix use-after-free in
 power_supply_changed()
Message-Id: <176818296405.643060.14179816348676976265.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 20 Dec 2025 23:35:58 +0100, Waqar Hameed wrote:
> The majority of the drivers in `drivers/power/supply/` do the right
> thing when registering an interrupt handler and the `power_supply`
> handle; namely making sure that the interrupt handler only runs while
> the `power_supply` handle is valid. The drivers in this patch series do
> not however. This can lead to a nasty use-after-free as thoroughly
> explained in the commit message.
> 
> [...]

Applied, thanks!

[01/11] power: supply: ab8500: Fix use-after-free in power_supply_changed()
        commit: c4af8a98bb52825a5331ae1d0604c0ea6956ba4b
[02/11] power: supply: act8945a: Fix use-after-free in power_supply_changed()
        commit: 3291c51d4684d048dd2eb91b5b65fcfdaf72141f
[03/11] power: supply: bq256xx: Fix use-after-free in power_supply_changed()
        commit: 8005843369723d9c8975b7c4202d1b85d6125302
[04/11] power: supply: bq25980: Fix use-after-free in power_supply_changed()
        commit: 5f0b1cb41906e86b64bf69f5ededb83b0d757c27
[05/11] power: supply: cpcap-battery: Fix use-after-free in power_supply_changed()
        commit: 642f33e34b969eedec334738fd5df95d2dc42742
[06/11] power: supply: goldfish: Fix use-after-free in power_supply_changed()
        commit: b2ce982e2e0c888dc55c888ad0e20ea04daf2e6b
[07/11] power: supply: pf1550: Fix use-after-free in power_supply_changed()
        commit: 838767f5074700552d3f006d867caed65edc7328
[08/11] power: supply: pm8916_bms_vm: Fix use-after-free in power_supply_changed()
        commit: 62914959b35e9a1e29cc0f64cb8cfc5075a5366f
[09/11] power: supply: pm8916_lbc: Fix use-after-free in power_supply_changed()
        commit: b7508129978ae1e2ed9b0410396abc05def9c4eb
[10/11] power: supply: rt9455: Fix use-after-free in power_supply_changed()
        commit: e2febe375e5ea5afed92f4cd9711bde8f24ee6d2
[11/11] power: supply: sbs-battery: Fix use-after-free in power_supply_changed()
        commit: 8d59cf3887fbabacef53bfba473e33e8a8d9d07b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


