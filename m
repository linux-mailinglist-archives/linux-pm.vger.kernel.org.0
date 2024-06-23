Return-Path: <linux-pm+bounces-9833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C7913D11
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE5CB20FCF
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D3183072;
	Sun, 23 Jun 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwjzdEq4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D693C38;
	Sun, 23 Jun 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163104; cv=none; b=D6I/F2T1LWqAZm60fq0vOLVeeEpU37nxAeFuVfeawdXh/hv95YApPeKb223wcLvG1yJEzJWWs5vvo7JvfGjg8R/ZfwgCwwVX8hOXr0QJNRgNG4Lqs6fEULwkCJLdnI1v5ZA5MSeyqs5b32D/UJCwGGNOkoQXiolji7cFRYhUTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163104; c=relaxed/simple;
	bh=o2H7WNnoUyhjrIOYM71K4YzrIznB7Qmx7k9IbzksKBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnD7fZOsbwWQi6ayGE+Pv3B3p85scnPa+mqkMhP+3bYgShnVkoFd5rY0kMiakCm3cnTVwBKVOjhiZfwt7wsp+vJeCo/IhXEazInDuZzmd4+/5L7+kOS4wAsIx3Pj/BFMrZfnPM8pBGkol9tItmkLNipknCVZYXPfcEUDnJH8h9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwjzdEq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D3C2BD10;
	Sun, 23 Jun 2024 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163103;
	bh=o2H7WNnoUyhjrIOYM71K4YzrIznB7Qmx7k9IbzksKBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pwjzdEq4gcweNKZhRQggRBn+t1CK72PX9p8W7mmEqx+a8gVmN0SYUybENbMKl7ZzD
	 QCmUBR48GU6U1LURUXaf2tmYTpwtz5sxXQ0vd2sZz1S4EAfOrvEZ4aedxfbK+qGEbD
	 hfm3vVSy5FAMS19a27fuE1ubD83POBxWKea+JtXnez1pZsM1LEDE9CSsQkZwbIbXBt
	 6qGm9EYR0hdNpWgnfx2bUbiI7xEbt+qcNE9cDPRg3jVkP2a8GLa9OA2Iz1xEEOkAAt
	 TAI/vgnlE6xwfpidWZ3p0apodSFItN5D/CsEfus5IDTbkU6VyqXK41z+Oibw8nAPEN
	 1KHLKfBZYxbVA==
Date: Sun, 23 Jun 2024 18:18:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linus.walleij@linaro.org, sre@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: ab8500: Use
 iio_read_channel_processed_scale()
Message-ID: <20240623181815.7774f17a@jic23-huawei>
In-Reply-To: <5668d73b92eb6318c7f094a9a8fa914c909485ca.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
	<5668d73b92eb6318c7f094a9a8fa914c909485ca.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 09:04:25 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Instead of rescaling current or voltage channels after the fact, use the
> dedicated scaling API. This should reduce any inaccuracies resulting from
> the scaling.
> 
> This is also slightly more efficient as it saves a function call and a
> multiplication.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

