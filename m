Return-Path: <linux-pm+bounces-34868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2218B7E9C3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D3A1C210A2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CC2F7ABF;
	Wed, 17 Sep 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkICFful"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367535FC0D;
	Wed, 17 Sep 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113440; cv=none; b=sq1IV3ZRsn+80bhxm5X7a5ZZOHEDPPLx1FDhtoOw/7DdRBa7sQmTg2HzDqCDehEpeMyvpSVTDjH+3rm633GL/YB3KmcPC6VMao1FExunjaGdbPIm1KqVyv3Iu2f0Y3+1Zb3f8J7l5vSU0CD0+dDeXMyUMwW7QyJlbYbfUrsUTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113440; c=relaxed/simple;
	bh=CfzR7xf3p3JWB1YNU5e6PTj7XFWB3rwhi6giwyqJNI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHnsC3DvwmvW2L5X54/sUkCoLpY3i+XmSzN13JKuH7wegMfGrlD//vXO6ohED0infFlCYkK2e4oRxPbE3fF7cGqwnMfZbny9f+xFh8NSfamDLramMpMxEOIukcgOHj2Mp4rvxjn+GLF/mTiiTeCu0WXu1JXDf5K+/C/gPGLG4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkICFful; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB641C4CEF0;
	Wed, 17 Sep 2025 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113440;
	bh=CfzR7xf3p3JWB1YNU5e6PTj7XFWB3rwhi6giwyqJNI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkICFful8PIWq9X6GbDOJfnHsnu1ohpy57gcgqm97HzgmWj2KUKd5Ekpx6QM3+Azr
	 /WJgBiD5/G43K51vkeeHg+WwiVvDdVVeyDOWAfZ+aDYPxBqxe24SccmuKi4e0n6sqC
	 HB6P8gPYrz+dtCOieG27+8xpDFC9XmtWziZmlQu675bnkV32yYw4ESHDgg1lP0dmCi
	 xUYqDTpD+yWIDrX8ywVBSYvoZFcx/IfBlBrKYY6DFT1geNvRcnn969Wby2aKMptiy0
	 0YLOHutBDJvXBRUgXYEBW/nuCcQoQaOO4DZ+35O2qLZLSbkBMC94N0llEiow3cZEii
	 A2xDhJ7HMRRjQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uyrcH-000000001ch-0uRx;
	Wed, 17 Sep 2025 14:50:33 +0200
Date: Wed, 17 Sep 2025 14:50:33 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: fix device leak on probe failure
Message-ID: <aMqumfq6w3wJGgeL@hovoldconsulting.com>
References: <20250909073819.25295-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909073819.25295-1-johan@kernel.org>

On Tue, Sep 09, 2025 at 09:38:19AM +0200, Johan Hovold wrote:
> Make sure to drop the reference to the cci device taken by
> of_find_device_by_node() on probe failure (e.g. probe deferral).
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Cc: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Cc: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up for 6.18?

Johan

