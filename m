Return-Path: <linux-pm+bounces-22707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59BFA403A3
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 00:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D053167A82
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A8253F15;
	Fri, 21 Feb 2025 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2gZlZNJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24553253F06;
	Fri, 21 Feb 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181455; cv=none; b=cPKCPudgQt01iC0nEtj9K+moQottndGtLwBN5y31DAOdHiwr2Ax2NH7PapaAQ5SExmazKCX0TCilQmmq/TXb99aE7iCMxbChuKA7cDzVa8+Pyc7zVMArYRQzulCqHhh4THAQoA5tSR6NkP+EAJMgl0OgOx7Bzskvvmt33bXviZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181455; c=relaxed/simple;
	bh=LPuDk+6EvEIOleZ6HMXz7Q2USX7ef9j+avusUpmJAsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTpGLomSYcXPdJJpQeSrQjvRyOSR0LNp/JYJdIcxsZtIqDrTZtOZcuIM5z6CHBl/ufICOcqD9xQ/VNJyTm4d/uht4qbhVnO6sMedc3bH3BEDoa34j7CUuVUfEr2awnmIRxXuRVxpl4G5QhaphbwaBWNoaGikTfOi+yH3VD2Rnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2gZlZNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7310CC4CED6;
	Fri, 21 Feb 2025 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181454;
	bh=LPuDk+6EvEIOleZ6HMXz7Q2USX7ef9j+avusUpmJAsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2gZlZNJ4nhnlglQR2Ul7LtTjncW3SSm33huoq+mJ6vI1LF+w3HUJDumaw0NGpT/J
	 3oi6hEO+LClIxqCIMNUIRHy3fFfvGd1/vDTSey+O4d0QCqMyNrn7GZiPN+piVN9jEa
	 hE0t6mSe49fbNVKQFbkany8o+WWZGT/FO8dgW+fGYY0z31hk76aKztqqwl+YvjxvyH
	 4B77FUdncY/A1ir1+kGuY6SpKVq24iRVU4H9GrjksTBqizc+BEeRvZYaSpFPp0+1Zg
	 7oS49dcHefUDGvpfcDnjGg39MXowMS8ApT/u+FKHDmvYO0fYvOjcbZ5njkM6/qHyIi
	 JlSmnuuT4f/DQ==
Date: Fri, 21 Feb 2025 17:44:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: gpu: mali-bifrost: Add Allwinner H616
 compatible
Message-ID: <174018145089.395682.15107324899674215035.robh@kernel.org>
References: <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221005802.11001-4-andre.przywara@arm.com>


On Fri, 21 Feb 2025 00:58:00 +0000, Andre Przywara wrote:
> The Allwinner H616 SoC has a Mali-G31 MP2 GPU, which is of the Mali
> Bifrost family.
> Add the SoC specific compatible string and pair it with the bifrost
> fallback compatible.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


