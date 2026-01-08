Return-Path: <linux-pm+bounces-40483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDFD04727
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CD9F3126A73
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318572C11F6;
	Thu,  8 Jan 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWk2Jfim"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8927E07E;
	Thu,  8 Jan 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888985; cv=none; b=RTx1si6ZJm2keukjNxxeOgbPo7cKiRvnXgK7BWPhnSG+fPGo4et21KCG9VnDt8VA7UeLfcADntfeKHgmbQZjJfHrp5lJEXHdS4xSV7K3jox0hMgdcaPsuzbOFZqvdtYxCgUdz+MsSzuPx2TnFRe0idh6Bhbvu/9dvUq5OOUqGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888985; c=relaxed/simple;
	bh=J4keIckrMN+unKry/5LlXM6rmQEd+113yzhSDK5jTVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju1DpFrpxNtgkkgi1MkvbKkIcWnx8+6LK6uO6GrC51Fbt3Hh0UNZ4mEh5xPq+ycbI530WA5ELr5eyV90MmIUEfBOaJjfidlbL+RGaURdoUW+CAUe1pxuXQFvk6XFOjyQnSGz9gvawxKAum+YpTg+SadWlrdR/vmQK+a4QCYYNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWk2Jfim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0281DC116C6;
	Thu,  8 Jan 2026 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888984;
	bh=J4keIckrMN+unKry/5LlXM6rmQEd+113yzhSDK5jTVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hWk2JfimNRse5PNAU7yEeU9Kb0ZfY5pkbg6Vcx0K2hj4TxJcK/ZDo8o2vVswza2kC
	 SC2+QgQqrfiFb9gRgTgwK6M+DzkazyX4pklBSjLXsmbqqcCS7jVayAYmiM5Ds/0y79
	 kx3ZizU+tMlGOxT40wUxUIoGzsHWGFmPc4/BmyC+ytHAr8LvleOjD1z6aLv+QOMTEJ
	 cxG2wm4QvNnG5EIW/ganrIrQDW+5Pl1AyQKd06HjYPLOJosDhwrXoZfw8Fh8j4x2KX
	 SoUXUQKMEB2m3Xa3oC0CF0/dL9Cp3rGu8kL1Fo2MXrq07C3EY333W4KimQZc92JRiy
	 z/HwUqTiMYE0A==
Date: Thu, 8 Jan 2026 08:16:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Brian
 Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Simon Horman <horms@kernel.org>
Subject: Re: [RESEND][PATCH v2 0/3] net: Discard pm_runtime_put() return
 value
Message-ID: <20260108081623.6323ca97@kernel.org>
In-Reply-To: <CAJZ5v0ifehCqCdC=rE9eUAe7p2jx=QOv8K=HXo3n9D0WefVMUw@mail.gmail.com>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
	<2816529.mvXUDI8C0e@rafael.j.wysocki>
	<CAJZ5v0ifehCqCdC=rE9eUAe7p2jx=QOv8K=HXo3n9D0WefVMUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 15:06:55 +0100 Rafael J. Wysocki wrote:
> > This is a resend of
> >
> > https://lore.kernel.org/linux-pm/5973090.DvuYhMxLoT@rafael.j.wysocki/
> >
> > which mostly was a resend of patches [10-12/23] from:
> >
> > https://lore.kernel.org/linux-pm/6245770.lOV4Wx5bFT@rafael.j.wysocki/
> >
> > as requested by Jakub, except for the last patch that has been fixed
> > while at it and so the version has been bumped up.
> >
> > The patches are independent of each other and they are all requisite
> > for converting pm_runtime_put() into a void function.  
> 
> Any news on this or do I need to resend it again?

All good, just mis-scheduled my day yesterday and had too little time 
for upstream :(

