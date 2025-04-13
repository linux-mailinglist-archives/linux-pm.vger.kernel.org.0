Return-Path: <linux-pm+bounces-25336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0944A8742F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B440C3A6BB5
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120DE18C031;
	Sun, 13 Apr 2025 22:12:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F518B47C;
	Sun, 13 Apr 2025 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744582370; cv=none; b=eqgN0oW2VLZchl8yH0Rxe5YG2Rh5pfiYCzJNhVMWXKcqoFluV1wuvw0j7AjI4ooWrB0ZeQE0pjHKXjSQfUJtvMsVtRdnCeAi4xZZpVhJrJNhgg65bNliNXDwO+GQXcu3tay5r5Uc7MmtwyuQvrcJ4uebHZ4Rvoxu6dgIdav8758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744582370; c=relaxed/simple;
	bh=j7o4TmN6qMjf7TFwhhk0Y8oqqNUQI2mLCa//MN18WCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt9eNMcgXTjUQG4CytrpNqv19mBrPCFa6VpGmX8Eu42CC1UlQmTgjQBVyxmw2tuQzVdFnbZHR3yB2t3aINczV4pqqWjb+pgqUzTUV1qaZlHBLAj3yKmZRCsRFZaeQNMAAtN4VMv9CowyEI9U92/HIVPznofBi4ouLGzcX+W1P8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C820B169E;
	Sun, 13 Apr 2025 15:12:44 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F7D3F59E;
	Sun, 13 Apr 2025 15:12:42 -0700 (PDT)
Date: Sun, 13 Apr 2025 23:11:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH 0/6] Add support for A523 Thermal system
Message-ID: <20250413231128.75983a60@minigeek.lan>
In-Reply-To: <5084c2dc-d268-4268-a827-2ae445782a4e@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
	<5084c2dc-d268-4268-a827-2ae445782a4e@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 03:53:08 +0300
Mikhail Kalashnikov <iuncuim@gmail.com> wrote:

Hi,

> On 4/11/25 03:38, Mikhail Kalashnikov wrote:
> > This patch series adds temperature sensor support for the Allwinner A523
> > family of processors (same die with H728/A527/T527)  
> 
> Based on 6.15-rc1 with dts patches from
> 
> https://lore.kernel.org/linux-sunxi/20250307005712.16828-1-andre.przywara@arm.com/T/#t

Chen-Yu merged those patches already, to the sunxi repo on kernel.org,
under the dt-for-6.16 branch, so you can reference that instead, and
also base any new patches on that.

Cheers,
Andre

> 
> > Mikhail Kalashnikov (6):
> >    thermal/drivers/sun8i: add gpadc clock
> >    thermal/drivers/sun8i: replace devm_reset_control_get to shared
> >    thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
> >    arm64: dts: allwinner: A523: Add SID controller node
> >    arm64: dts: allwinner: A523: Add thermal sensors and zones
> >    dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
> >
> >   .../thermal/allwinner,sun8i-a83t-ths.yaml     |   5 +
> >   .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 145 +++++++++++++++++
> >   drivers/thermal/sun8i_thermal.c               | 154 +++++++++++++++++-
> >   3 files changed, 300 insertions(+), 4 deletions(-)
> >  
> 


