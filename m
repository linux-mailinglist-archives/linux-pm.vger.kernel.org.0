Return-Path: <linux-pm+bounces-23181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB2AA49D64
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60C43B4D88
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2E2702B9;
	Fri, 28 Feb 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JkZu9ZW0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF11EF38B;
	Fri, 28 Feb 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756357; cv=none; b=kJdLWV+apbWkFv3L3RuiuP9o3OhBhlFzlWOPFBeufvVIGpJvll5WARaqkU+X9Mgc2eqG+k15G5bcq/27ph/M6rAq0KA4SRkD/nCOiCm+dcCC9nvE6voatLaiK2kbxdq+wDHRDYv2cI6/bBYGFP3khCah0W9ayIgfEsDz4mwb84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756357; c=relaxed/simple;
	bh=iSHhu8DojQZ/z0Bux1fFHThPhnvaqOETluuPREszvKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs0oyw9Nc0RDAnIl9D1IdgjIsyUOIRHfS54kVI6DPVqdT6Bd9UTIxx7mLfBgBiFq27LvEWdjoexovSACZfTkjRePg6E4krisCGHvFtw9D8b+ARlba5hfKhqKf5j3f0PCorDZtUIhx+D0o4lgh9nHxL+QDstxqt+JJCYbvCz22Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JkZu9ZW0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z4Bqd6q12z9scl;
	Fri, 28 Feb 2025 16:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1740756350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/zWPmaHu9T0gtGq/CPJkALifQhwYRPAKcGYrmHsfn4=;
	b=JkZu9ZW0h0xb10B845As94XNc4ElaqnNKHtZ9LcuuIYuDz5ZvU0moGCdVvXmtbgB3h4rwY
	nlcFOqQQwDKjK82vIZN5m+ZATxjTi+3Zcq1fpsm+PLSKHYzKk3QE4l6FeoAa84W2DynmHv
	nNPstEFd8wmGU7eewLYBDULVS5K5mRs2NWkiROlKvBbA3n0rYCvHOURycwqYmL256NxkYR
	Q3RwVNesB4OSrjNypRmNVkMdmRB498AZGkGNMomoAiQR5R34ieKY0gxFhhqEmTxYj8x679
	Bz6+E1mqjnEMOcKEFPdmnIWuY7fBWSxelgNV29HulthBCXh3Ksa5b9ffCOX6yg==
Date: Fri, 28 Feb 2025 16:25:47 +0100
From: Anthony Ruhier <aruhier@mailbox.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <ycz7kwtr5d6bnrjjfmauktq2s7vtwsunpg7nfunfywxu5uou34@gfgoeeyarh46>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
 <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
 <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>
 <p5tszocxa7mcazgxsnt3gnv547m523gde2hj2yekiuoimm6rsy@pzofvxngb4ul>
 <7wbot7sxm3y5y7in5ashcn5lpx3mi55abnbfrkz2jta7nm6jep@zk6zvocd3tuz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7wbot7sxm3y5y7in5ashcn5lpx3mi55abnbfrkz2jta7nm6jep@zk6zvocd3tuz>
X-MBO-RS-META: jxo8su5z4w5hog8w3ppqqzf45qezxabu
X-MBO-RS-ID: 43b314216067739c03d

On Sat, Feb 15, 2025 at 04:08:25AM +0100, Sebastian Reichel wrote:
> Hi,
>
> There are other drivers reporting negative values as documented.
> Most of the embedded ones do this actually and there surely are
> (embedded) userspace programs relying on this by now. But the
> most used driver - generic ACPI battery - does not. That's why
> quite a few userspace tools handle it wrong without anyone
> noticing for quite some time. Fixing it to follow the ABI would
> obviously end up in a bunch of regression reports, so things are
> a bit messy :(
>
> > I think it is a problem of the 'acpi' tool. At least 'upower -d' uses
> > fabs internally since the initial commit in 2008.
>
> It's definitely sensible to fix the userspace tools. We can't change
> the documented ABI for current_now after that many years and while
> documentation for power_now is missing, it would be quite unexpected
> to have it behave differently than current_now. Also userspace
> tooling needs to handle current_now and power_now anyways. And we
> surely can't change the behaviour for all drivers reporting signed
> data. So let's keep qcom_battmgr as is. It follows the documented
> ABI and hopefully helps giving this more exposure (I'm typing this
> on a X1E laptop right now and can see your problem with waybar).
>
> But we should document the power_now property. It somehow fell
> through the cracks :)
>
> -- Sebastian

Hi,
As an update around this topic, I sent some patches in the different tools I'm
using to correctly handle negative values in current_now and power_now:

  * Waybar (included in release 0.12.0): https://github.com/Alexays/Waybar/pull/3942
  * Powertop (merged): https://github.com/fenrus75/powertop/pull/173
  * acpi-client (included in release 1.8): https://sourceforge.net/p/acpiclient/code/merge-requests/1/

It was quicker to get this merged than what I expected, which is good news!

There's probably other tools to fix, I just fixed the tools I'm using. I
encounter the issue on other tools, I'll send a patch.

--
Anthony Ruhier

