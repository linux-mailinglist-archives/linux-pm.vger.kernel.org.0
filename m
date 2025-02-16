Return-Path: <linux-pm+bounces-22170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CDA3765F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 18:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4ED3B0A02
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4619D881;
	Sun, 16 Feb 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j/9JlxT4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F042070;
	Sun, 16 Feb 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727852; cv=none; b=sQGf98zRT+KxSyPAJfbNswC1CUHmjIcdfP0DZeb1h5LK25rFOx+xrVZwdehLdBLo3g5wqAOqNnkEl2FQMfTQP7uOP0Vm+wAs2/2Ngt5uxf9nb8NLJekmNRQZMfbHsNls5jEhUpTtLubFqhle2hxlNl5tkmzxDtPypembW2sRgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727852; c=relaxed/simple;
	bh=LTOjVk+4QHTyDDma3KbEPH1FY8x5w5DWJiaF31yDOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRDHxHJTO+SfRsBXPSeLc3PQGoDcylqsBrwFS38ZzZgJwizlrcVwBzte0vyauskL3bR8Bo8OcYWnr0PvmBMq6QZu1YeooOvh6CpH3GpRWFRjs2zyp/lqWO8IJ5PCg97q9Q7SODKn7gCfEix2MRifuhd7BYAQ9ttg8kdFdVPJ818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=j/9JlxT4; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YwtSd0Dcwz9sp5;
	Sun, 16 Feb 2025 18:44:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1739727841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTOjVk+4QHTyDDma3KbEPH1FY8x5w5DWJiaF31yDOKw=;
	b=j/9JlxT4IEo8QlXbMmRMOo+zggf7UGKFoUqsQ0TIh/KrGxM32QNQUWhx2IeiOCej30RQ2e
	CT4n0x9tf8bX8S8hZs+pW69StYwip1QI9HBA56jmauFh33umaQc4197JFw10j3Vdn6UGG/
	lg5mh2sg3Qlz5ireoieZQBDcPA7cweJ2E2ZKk/P/RATxgQouOwLYEwHmPifCemGZwGGzVX
	awMR8T+LvB5IqWS8PH2TOOlVxATsxNBykxIPJlLM2KcVSkZGea7fEbDqGEnjEyCxHZvO69
	oRZOQ4XZW+qBxFad7NaoZdNpEpllZJPKiIjwDw/RCfTzW4U8p5AgG/qf/vRpJw==
Date: Sun, 16 Feb 2025 18:43:58 +0100
From: Anthony Ruhier <aruhier@mailbox.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <6w6pq2d2nlrun6cz6tq4fjzqri52n3sskrf2frj6wj4jxzzrcg@z3a5bykeixsu>
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
X-MBO-RS-ID: 093cea7cce9679a1858
X-MBO-RS-META: a9sgno18t6wer8kquh3rbd78d1597mc4

On Sat, Feb 15, 2025 at 04:08:25AM +0100, Sebastian Reichel wrote:
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

Hi Sebastian,
Thanks a lot for the detailed answer, that makes sense for me.
I was sending this patch more to know which direction to follow (changing the
driver or the userspace tools), and you answered it perfectly.

I started fixing the different desktop tools I use, starting with Waybar:
https://github.com/Alexays/Waybar/pull/3942

For powertop, the fix seems straightforward. For acpiclient, due to no activity
in almost 10 years, we'll see if it goes through.

--
Thanks,
Anthony Ruhier

