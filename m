Return-Path: <linux-pm+bounces-35876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E4BCA9F9
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EDD1A63F08
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6A253957;
	Thu,  9 Oct 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYs47bjt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12521A95D;
	Thu,  9 Oct 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036212; cv=none; b=dgBSkaMtGhUrkrv5FBET0kxl/GUtk8KIJ+fffb+AowAcGfacw08z2yn7SVW/rkxW5JKunUl66dRAalniACnWvcvSBPAnHG2rs3mR3Xp2sTSf1QD5hNgVZ81N60m5dYu3QWi0K+sQ1v4TgTeOmhrulQhlxb+grxlKxzvEuWg2aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036212; c=relaxed/simple;
	bh=NoVJ0xm+H8Ix/8mfqh2bpoZItxqLG9X1U5XWBBIbBAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1QvX44AaGRp8jGtGA1SpJ/lhWIQ2jalRPpKeiJVMk3HCAG8ZRLra+dc9rq+yTzO6vW7HMmrTvCYIPIUUYlywxQihXh8UGdk11cKYVUA64ceBoYNtgTRquzA8YAMDRbTzmgw1WfJqmTP6cePkXVhD+3MDyFR4jzzCyPne/nIQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYs47bjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9122CC4CEE7;
	Thu,  9 Oct 2025 18:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760036211;
	bh=NoVJ0xm+H8Ix/8mfqh2bpoZItxqLG9X1U5XWBBIbBAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYs47bjttmDkjyEKLDlcGOj21k147J67LmwO7PX0bThIeoH7zs3jTCtdxwcY2Qosl
	 p9G5tfwThRtRlvuo9bq32++UJx7KVCSgydLrQPAByIBgt1soYssMkBtZJxDco3hx85
	 C3xjTNuDVwV6M+G8FWHScfT5cOxbX9Q+KXdqBHYiego5EEHPnfeCeeLVP+ilyUlWDq
	 9ULvoCHaGf3Cr0djRsjt5WJ2YBsP4XQ5X8KUE03y5TsxT3i1oarW+eCsx7UE+hD65j
	 wtFxXhhZaoDHNMThGBMuJciWlwgIgQ2fBYkp64yyUa04hhapEGgp8E9sjAbofKg9qe
	 mDU0KLv1U5oOw==
Message-ID: <bd991c1e-69b0-47aa-9373-274f92fce76d@kernel.org>
Date: Thu, 9 Oct 2025 20:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] macsmc: check for missing SMC to avoid crash
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Sebastian Reichel <sre@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251009183735.1288-1-atharvatiwarilinuxdev@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20251009183735.1288-1-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 20:37, Atharva Tiwari wrote:
> Users might manually install these drivers
> without the core SMC device, causing

Installing isn't enough; that's not gonna trigger probing any of these 
devices.
Did you run into this issue?

Hitting this should require deliberately creating a broken dts file and 
booting with that one. But if I'm creating a broken dts file I can 
easily crash the kernel in various other ways.



Sven


