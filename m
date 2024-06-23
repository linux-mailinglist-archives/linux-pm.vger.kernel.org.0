Return-Path: <linux-pm+bounces-9832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7B913D0E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43B11F23160
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C931822ED;
	Sun, 23 Jun 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHNqIeMQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766913C38;
	Sun, 23 Jun 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163022; cv=none; b=Kokd7VjxV5cE12+GJ4+oftwMn1Cru74niWX8nXQ66OwTzBl5YhJNpvwol1uc7gQ5T1R718XTw+LtHBaogVadmUJkrHFRpN6eSQuBYXkeEQ7eMEFX++jLogoeX+She/TK8eJdY9hocAgpb/uPIc+juEqVQiix1hmYj9PclL2mBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163022; c=relaxed/simple;
	bh=9KtSfSaQPkCASSv8gVxlAxMqOeAiISu170quyMY6ijc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXFmBZnZycGBvxjNJRe+Yrqx1YTH5zQKhHv/JbzkQhXDSxmy2FuoYVaBLvHaY6uYKu7Yir99FGfsfN8Y1ixVuxGPiBQogYYtpKxiYC3EXoP1YBbR+G3Y2vt5ZoOf1pc9ZDulZdnFiaS/LtXM80SuIVM213z5x8+5q98rir2nwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHNqIeMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A0BC2BD10;
	Sun, 23 Jun 2024 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163022;
	bh=9KtSfSaQPkCASSv8gVxlAxMqOeAiISu170quyMY6ijc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHNqIeMQff9bNPC4+QraF262KlfG5/t0BGXt3fq8Q6CUZbMJY/RuCf0YAV0LxHkwa
	 QcOcFBZ3zXUsGhFPGhmu5OpnKpX+nr23kaEGt4bcOe6R18UFtctgdRU1eQN7Vcwpjj
	 lZFPY/sShn0OqSBPayBgWSk2sdUM+GQorFefBLUOGmMV2uMVv1cSrymsAv3SMyiwqV
	 qj/r3SHTICltsfnZ8emgvjCYRidMTDOItaQYd3/qssJepSJ3GIe3I/EinLI240N9EW
	 wYQUzXLgJf72mMsjtsWzzSD+Cq+/7t8I7QZdxT58icl7TLnVhEOi2THs17HGGVuVI9
	 3sQ4mm5g0/hOQ==
Date: Sun, 23 Jun 2024 18:16:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linus.walleij@linaro.org, sre@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: ab8500: Fix error handling when
 calling iio_read_channel_processed()
Message-ID: <20240623181654.3fe94bbf@jic23-huawei>
In-Reply-To: <f9f65642331c9e40aaebb888589db043db80b7eb.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
	<f9f65642331c9e40aaebb888589db043db80b7eb.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 09:04:24 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The ab8500_charger_get_[ac|vbus]_[current|voltage]() functions should
> return an error code on error.
> 
> Up to now, an un-initialized value is returned.
> This makes the error handling of the callers un-reliable.
> 
> Return the error code instead, to fix the issue.
> 
> Fixes: 97ab78bac5d0 ("power: supply: ab8500_charger: Convert to IIO ADC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Looks right to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

