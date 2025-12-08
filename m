Return-Path: <linux-pm+bounces-39319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E434DCADF01
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36504304F652
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BA23EAA3;
	Mon,  8 Dec 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMNY6A/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2611DD525;
	Mon,  8 Dec 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765216192; cv=none; b=HTMEb8zVovm37nUDMllWvoVEiIVRCq2A4CYJi5ognYCKx8qvaw5NHePYq0bkVNJ2iHrTz9hf1HqZC1ss3ncTJvBujWEFpkZBMYp6QW01Te0uRgW2YC3RQR97iCOazQXZTUPGWhzSTuhoUnlxyn9k8Iaa4/HhBzDcJFQ8ujy/fcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765216192; c=relaxed/simple;
	bh=f52ZqbwxEl2uUHaSPvSdaBxeSng95zvx/fulBOfx5sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOFYo/0NEYHG5p87TtiIZZGiWefCm1oXMM3emmtaBZSjb2nEt/kuIVKqg4ucHRUSjqeBqlCEZdGW4mSry+g+tGDPU7HVaV5GVSpD20X8e/uxTszXzlXLg+ADhlYKfkp9J+4TRu0brEhDtbtUOlziwmvjHWFQrIX/EeKCgbHhsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMNY6A/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95082C4CEF1;
	Mon,  8 Dec 2025 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765216191;
	bh=f52ZqbwxEl2uUHaSPvSdaBxeSng95zvx/fulBOfx5sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMNY6A/RJu+smMNeI0WFqHTLss5CdDyJtceg9V1kbi9qu3FXv4Gi6NRf14jc0QSoZ
	 lPWChfqHTifgNoI9U1w7izqJtTdbVNfK063uma20NEww+e1vb0+wHPD5rK6R7ZEoch
	 iVzMfU1sXOlfvQmjS9lUILoCS+VxjqRUxksyj2TrwB6YTlTRTsantmKJJKZP9lmxxM
	 NHU8IG/J1NAmqslNNV//00eEKqFeee0R3CkDIh0pT27Q6UxcEHUYTXXh+KcT5KLvBK
	 +/a7Zmxl+eWVwSSSSdseC6E8Pnkw4yVAM01aqnzMkXd8/fxqmyHHnQD5toCdF+pyeK
	 F9oXGIu5qfxfA==
Date: Mon, 8 Dec 2025 17:49:47 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, lukasz.luba@arm.com,
	rafael@kernel.org, pavel@kernel.org, lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH net] ynl: add regen hint to new headers
Message-ID: <aTcPuy2CRtjeTYQy@horms.kernel.org>
References: <20251207004740.1657799-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207004740.1657799-1-kuba@kernel.org>

On Sat, Dec 06, 2025 at 04:47:40PM -0800, Jakub Kicinski wrote:
> Recent commit 68e83f347266 ("tools: ynl-gen: add regeneration comment")
> added a hint how to regenerate the code to the headers. Update
> the new headers from this release cycle to also include it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


