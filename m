Return-Path: <linux-pm+bounces-16465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D59B0533
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BFE1C2261E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E01FB8A9;
	Fri, 25 Oct 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffoGoGQx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDA13B584;
	Fri, 25 Oct 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865489; cv=none; b=TYWDyC0GUZdZyfdLb1nxfScj7olwBpQSGD/T8IrZObNScv+cb/icSTi7Y5iRqjsQqzOwWXGU9fw9PxCGa9Y/U7dXAnFTsFx2lftzLY+KUoWyNGmDHmIKVLF0tUuWdbOPiFistC7porGtcvmcAEp04eEqj4FbHh7hR6k2y7oDoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865489; c=relaxed/simple;
	bh=tm/4vbtNtiaS+JdouNTCc5kuz8nO0+9LkJM0qC0F/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFXTg4qs2VdM5XjjPKL1BO8dx3kf92N2WLW3ZKRUUyZOkU2sr6pU6mF5ImV4EBFDTYsTR4IdZDXarbihrEDXgtghoDrsoS9G5qSRwHrt2zm/cjh3FoVBciAVX46WV4aaIEdsNyqck4crJQtDMgfz48MLyE/QeVnUh7b78LA5EVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffoGoGQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6715DC4CECD;
	Fri, 25 Oct 2024 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729865487;
	bh=tm/4vbtNtiaS+JdouNTCc5kuz8nO0+9LkJM0qC0F/Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffoGoGQxMqOHARMij0z0esj2E8EIeq3uVhHrdWRL2rYrbRBbAE9poea1iWcK1mVlP
	 zVDTpfCk16r8QwbjjgLFvHIgnameRLBgtyW2bJvFi6VSaX2UpLzl9X7mbNyW4Xhd0x
	 48VUlnWCz8z5qgENba1KwQBli/aAyvigMf+W6eQrEHl/M9kBdXRuPhOOucVBN2/W8W
	 0Lq65v9kkQA7U2Wd8Gm1K9Z9hnp2Ky31mCwwUEqzFvLJMws9AZcvh/kGJ7wWonM1JA
	 hWlg2dXPCOfppHzM31hZjNPADbff5oPzTRkqArvmei3BmOH8lTSM8aHbHL0Quo+Y3u
	 I6QG6IUgy+plA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4L2X-000000006JC-32je;
	Fri, 25 Oct 2024 16:11:45 +0200
Date: Fri, 25 Oct 2024 16:11:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
Message-ID: <ZxunIcSZDoO3ph64@hovoldconsulting.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
 <20241023102148.1698910-4-quic_sibis@quicinc.com>
 <ZxuixxBzQZUdIW1c@hovoldconsulting.com>
 <72a0b7b5-4209-f969-0726-e411b5a74e01@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a0b7b5-4209-f969-0726-e411b5a74e01@quicinc.com>

On Fri, Oct 25, 2024 at 07:36:16PM +0530, Sibi Sankar wrote:
> On 10/25/24 19:23, Johan Hovold wrote:

> > Also seems to do the trick:
> > 
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > But perhaps you could consider starting enumerating the duplicate
> > domains from 2 (or 1) instead of 0?:
> > 
> > NCC_1                           on                              0
> > NCC_0                           on                              0
> > NCC                             on                              0
> 
> We are just trying to make sure node names are unique and
> can't ensure the pd-name correctness since ida starts its
> number generation from 0 and I didn't want to shape the
> fix just to cater to our specific case. The firmware fix
> will be in charge of ensuring pd-name correctness.

Ah, it's a global number space? I didn't really look at the
implementation...

Johan

