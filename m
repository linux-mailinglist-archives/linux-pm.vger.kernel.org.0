Return-Path: <linux-pm+bounces-13315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A9967F0C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954BF281074
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14D14BF9B;
	Mon,  2 Sep 2024 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XcGT8ny+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42276161;
	Mon,  2 Sep 2024 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256874; cv=none; b=DljAHxrCOPjIs8XLeYjJv3EqHUqJ2st93oRUtcZh+ZD6W07UAP/8cUNKeaIvmCtXZ5wCTQMbDZGx0EdiSD5xq0ASKwiZlLoxD/mI4Ll9I4PpS2Tx7cs8SgNhx9aGrtQiEou/p6VX2nFEkyK0gmc2bwsvyC+Y7GOknBG/cJ5N4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256874; c=relaxed/simple;
	bh=uFqYDAGst+R76BzrFXSqxQfFeaOgB/jwHSV/x4bw5xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfjO5cvlHJhCAtR2uYX/w9vurU8utZFBT2tJD/+baCrrJhZoMbojprY6N8HTD56LpCYp1eNR+mBM6ctxuEYAQqadLuKL9qsXMazZ7WkgV+798rTQlgxuJge2W202CcoT2cRvRK2HgsMPpwlPOLS5Y2sSkj3FzXx6eS4l79fjld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XcGT8ny+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4953AC4CEC2;
	Mon,  2 Sep 2024 06:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725256873;
	bh=uFqYDAGst+R76BzrFXSqxQfFeaOgB/jwHSV/x4bw5xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcGT8ny+K7EZPFWj7plmSyaw+3DUmYHQrHQM/nEmQbnG+VvCxd3U3HDIZTeX7YiRL
	 1biMvmNuYBWWnQkGh0oHiWSUlCqiK7KZ7mv2ol4roKIvw1j5SP2yZJAPHRBUHL3qRF
	 ShEo26DaXuTOaDOPfo65oFbxkvB50L+QG9bfwOUg=
Date: Mon, 2 Sep 2024 08:01:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 0/1] pm, restore async device resume optimization
Message-ID: <2024090220-uncaring-pretext-4391@gregkh>
References: <20240902031047.9865-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902031047.9865-1-yenchia.chen@mediatek.com>

On Mon, Sep 02, 2024 at 11:10:44AM +0800, Yenchia Chen wrote:
> From: "yenchia.chen" <yenchia.chen@mediatek.com>
> 
> We have met a deadlock issue on our device when resuming.
> After applying this patch which is picked from mainline, issue solved.
> We'd like to backport to 5.15.y and could you help to review? thanks.
> 
> [ Upstream commit 3e999770ac1c7c31a70685dd5b88e89473509e9c ]

For obvious reasons (and as per the documentation), we can't take
commits that are not also in all newer kernel releases, otherwise you
would have a regression if you moved to a newer kernel, right?

Please submit a series for all affected releases if you wish for a patch
to be applied to the trees.

thanks,

greg k-h

