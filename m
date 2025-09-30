Return-Path: <linux-pm+bounces-35594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C43BAB7E6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B28192251B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA42275111;
	Tue, 30 Sep 2025 05:30:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301126FA70;
	Tue, 30 Sep 2025 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759210246; cv=none; b=RtFjDP46nHxnZyW598bumXlort2vrMLslq28xLcNtWOa2vOasUNLbtTnlPcFOMdHWVIVxCSm29SAgl6ukM3haolLUteoroCspky5hcajMIfEEPCjqJhQCnkDk6fC4EA+BzPzjxrZa5zo25PI3M3SvOkmK14S7+7NoCC0Z/YHty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759210246; c=relaxed/simple;
	bh=G1K3zLelWc1h0V+ZNnKn451Ucq74Yv6u/fHbUPKfQWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcRc/Ye/hpCIguxCeP5C9JU/gBE1BjIV2dInCDXh5iWRbLTX7jiXMaoofGVyk8PctLxSWZyw00JuDD3ueqKkBSoqYHjG/EukKmwlOVfP474FCgyP8Q538leyLsrYgUD9H0w0+7zPgh4d2nEQfwM6oNNMJMZFWP5Uq1WlIqBz4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 3BA951C256F;
	Tue, 30 Sep 2025 07:30:33 +0200 (CEST)
X-Spam-Level: 
Date: Tue, 30 Sep 2025 07:30:10 +0200
From: Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] power: reset: sc27xx: Add support for SC2730 and OF
 match table
Message-ID: <aNtq4qyYNqZThjeI@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
 <58441250-1f00-45ee-8583-9863efc938e0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58441250-1f00-45ee-8583-9863efc938e0@linux.alibaba.com>

On Tue, Sep 30, 2025 at 11:30:16AM +0800, Baolin Wang wrote:
> 
> If I remember correctly, the original driver supported SC2730 and SC2731
> chips. Are you sure the current changes are still needed? Have you tested
> them on the SC2730 chip?
> 
> 
> config POWER_RESET_SC27XX
>         tristate "Spreadtrum SC27xx PMIC power-off driver"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
>         help
>           This driver supports powering off a system through
>           Spreadtrum SC27xx series PMICs. The SC27xx series
>           PMICs includes the SC2720, SC2721, SC2723, SC2730
>           and SC2731 chips.

The driver was hard-coded to use registers 0xc2c and 0xdf0. SC2730 has
different registers, which were added to the downstream version of the
driver in [1]. I have tested this with a UMS9230 phone which has an
SC2730 PMIC according to the device tree.

[1]: https://github.com/MotorolaMobilityLLC/kernel-sprd/commit/6165e1afe3eba33089fecc86767d47af9ab176d6

