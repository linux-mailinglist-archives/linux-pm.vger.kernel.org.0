Return-Path: <linux-pm+bounces-17334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EDB9C42CC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F9C1F2169A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376381A2C29;
	Mon, 11 Nov 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMt+8H06"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1EF1A0B13;
	Mon, 11 Nov 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343232; cv=none; b=MRqnJ6XiKjKtY9nNarI6/k3HODRTYtZXvsGLClIm/QbauV7UXvRsAvRURi8c96ldRJTTWPK486C5vFnRPb0/kjTJ/x40mVEiV5rkIKgBB42YHgaKAjQMpQglIPcrUHk5HZK8N7PPJmwUJqUo9EVWtUVPH38fgO1zR5pgJvqDZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343232; c=relaxed/simple;
	bh=4+LfvrNrOJzDJzYO94ZEFGs1qWzyzDFuwT9KH8sin3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt7jsKWyzx2mKtW1CCvnRGjdrL4afPW1s5Sil2PlXpDa8kOzDwAEBp2JVYh6DyiO5CeKO/BkbE5cXgjfU0shxHwOsIkF0xDo/0seQSvPje+LRx2LRWgkU+fLVv+mHpgoNuvk+8gj9+/G6c9q3uT8ogFM0xJkS/Att5h9SucVYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMt+8H06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A88BC4CECF;
	Mon, 11 Nov 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731343231;
	bh=4+LfvrNrOJzDJzYO94ZEFGs1qWzyzDFuwT9KH8sin3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMt+8H06+j+UMFnKWqdWYpA/uT0dG5C32IVkPJFy1ekeDpFk/xR3CP19Bas/1t/HQ
	 HIGWbBx78ZPGrWAA1EMeBKidsMpzoBFLN4Xvj4evuMC2bwtwpvyv2McSfZyxFS7eq+
	 vlSAD0fCzCgCbZHDUFrPMoNRCFi/VRY+YgVU5QpcdDRbe8+cBz0kDx/2Yl1czjc0xO
	 SuBfQMWBaqi2nLzFN4i9aiBK0r3cdDSLyj8lv2mpkur8WkwW3u/WWdZCjsFKRS84Y/
	 Q2JOn4aJALdnlrPXu8mnW5P5sNdg+zkwiIAFs9g8LbOO48J+I35rggVV3eQdHJ4iTW
	 0cyGV/M5pj5LA==
Date: Mon, 11 Nov 2024 16:40:24 +0000
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <20241111164024.GC8552@google.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
 <cd8cc95b59c31418b174bba521dd2599a7929fda.1730709384.git.stano.jakubek@gmail.com>
 <20241106090509.GL1807686@google.com>
 <20241107155806.GA2774753-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107155806.GA2774753-robh@kernel.org>

On Thu, 07 Nov 2024, Rob Herring wrote:

> On Wed, Nov 06, 2024 at 09:05:09AM +0000, Lee Jones wrote:
> > On Mon, 04 Nov 2024, Stanislav Jakubek wrote:
> > 
> > > Directly reference the sc2731-efuse bindings to simplify the schema.
> > > Remove the duplicate example from the efuse bindings.
> > > 
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > > Changes in V3:
> > > - new patch due to a missing dependency in the MFD tree 
> > > 
> > > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> > > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> > > 
> > >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 10 +------
> > >  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
> > 
> > Srini, you happy for this to go in via MFD?
> 
> Can you? AIUI, you don't have nvmem/sprd,sc2731-efuse.yaml in your tree.
> 
> So take patch 1 now and this one will have to go next cycle.

Works for me.

-- 
Lee Jones [李琼斯]

