Return-Path: <linux-pm+bounces-19160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C829EFFD6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 00:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1771887B28
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 23:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D321DE4CC;
	Thu, 12 Dec 2024 23:09:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773441D63E0;
	Thu, 12 Dec 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044951; cv=none; b=GChMy4T/TOFlGstpInu9oU6BUvONlYQg/sJ3tUQy+4Qsb/0Y5jM3Kl44f0SP3WzXtmIAlr7D0ihNylNLqZelJxsSPpiXGnVKM9C1KrcsRIobdV6QRJSu8UtmhYgIc98vyUSoyvzCc9qn9zilCzs/ysIvbdC++KTjuUy+4cGTmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044951; c=relaxed/simple;
	bh=bsBat5rzqPYUOt1ktqKJsKCJLIM20Iykg/xaFrhHLlE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sovBDAmrHHmyMYMN/m1tnHRKWYcXiQ978TtB1LlVjrHSexfSVaP4g/YLsyC0yN9FItWGJeCd3S8XPrHqcTe9zSDlUGWLbjvXA7vf8k7Nqc3yXeFL+9+aRCX8umjqqv0j84t82o0irFpGM36vG+3kOsuzfgHYRUzefOYAyb2n6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F7CC4CED0;
	Thu, 12 Dec 2024 23:09:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id AECBC10604FB; Fri, 13 Dec 2024 00:09:08 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, sre@kernel.org, p.zabel@pengutronix.de, 
 mihai.sain@microchip.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20241010120142.92057-1-varshini.rajendran@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v8 0/9] Add support for sam9x7 SoC family
Message-Id: <173404494870.2565720.7657048690139336001.b4-ty@collabora.com>
Date: Fri, 13 Dec 2024 00:09:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 17:31:42 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v8:
>  --------------
> 
> [...]

Applied, thanks!

[2/9] power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
      commit: 2a16675e254a35f13203c6738a1137093c773056
[3/9] power: reset: at91-reset: add reset support for sam9x7 SoC
      commit: ef4f3ac4be990511a2c958443744d0c0c97deb5b
[4/9] power: reset: at91-reset: add sdhwc support for sam9x7 SoC
      commit: 250bbd612bb1103745ea6c891a2a1d5f5e1576a3
[6/9] dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
      commit: 2d656827a0fc9ca4982c245f1bec3b606fab30d8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


