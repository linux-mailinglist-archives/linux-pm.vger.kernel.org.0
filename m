Return-Path: <linux-pm+bounces-23902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91716A5D6D7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 08:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41C2160E69
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37A1E9B07;
	Wed, 12 Mar 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kJ9OTHo/"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6D1E9B03;
	Wed, 12 Mar 2025 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763289; cv=pass; b=OnGQf0KIrMt4vdaPpx4GDwMxTkU66Ze5ww2QYHMbTTu/jpHNZIHXdtt/cSkApjjyE5fBJF4BzLl1du+Zzq2TODWQB4c5lZjg+qktXpu4EzsJuFDBqkMPidDFCbfX2mVXDkkd+yOjQ99SD6O/tl1ffWO8X9XFWOLGPctcVQbr8Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763289; c=relaxed/simple;
	bh=7p+oikyacJJiwMe3yE4e0yhCjIBDfQdiAL3MxFy3S8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2SGUQdCLjx9dmwlHlxByIP7+fSd4V8ZnL0SO59Emd3rlIKztFbP3Ba1MrZ8iQWYajXfKILQ4ae9zUT+/IeZm1tQ2liJaslBMU62T9BHoXlq4RxHOAwaXOtShfYEAtC4VIqkTTHw0Cb96qX2VbGazqSUD0dZTztO920cQvJ29Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kJ9OTHo/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741763271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZEgAhjA9ROguLoLURQbtlk4kKj3eGazq/UZu/KQIVZBFgfKgZDN7g0T4Pd85wAG6vYGaVBbMt4YR63Hrt1hjvSrAyza6DgEukNFAkCfydDrTYrcoYRWBtl0VZq5/gqtSWQqIzfpNJNmgXv599t4zCy2I+8h44mfzNqDtP1fCDRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741763271; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q9IvHI9mqvEQpha6UampmBD0VpGntMKKcQNMy0X+zKY=; 
	b=gNWddLqyTzcWYVSXNBfLmfW0NSONHfv9MkjqTABcuKHiGTfvypaB/sdlV0Q7YYYdr7hnBJP8CGSX1M7HhJTf63Qp4GNLsDPDNuw5f+KCDA5xxbBSR02RkK201PXmSsgjy99GKt5xSgnNbhkAclUuPpUFU7AjDd7ZtR8A1axzI30=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741763271;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=q9IvHI9mqvEQpha6UampmBD0VpGntMKKcQNMy0X+zKY=;
	b=kJ9OTHo/2qpO1zlIl5ERCIJ9qmhWJp7trS5Dq9bqjcHXqhN7J1glBEeW9RXQXsRO
	hawHn1Y/zk2UCXmEOjx/wtYjThJQP/3IuyPxqvX7YqC65M1DdUeoGYTDzkESBVrQ0qo
	OKDbFX6pQ6Wyw/GlCZX8vLjV4VsACA0K96/YJGGc=
Received: by mx.zohomail.com with SMTPS id 1741763268591919.6531374825976;
	Wed, 12 Mar 2025 00:07:48 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4FB3C1806F4; Wed, 12 Mar 2025 08:07:40 +0100 (CET)
Date: Wed, 12 Mar 2025 08:07:40 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Anthony Ruhier <aruhier@mailbox.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <tncsjn6qbcq4ybot3iwbljozrqby4m7xsvo57cod7alojtayos@x4iag47r6tp2>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
 <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
 <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>
 <p5tszocxa7mcazgxsnt3gnv547m523gde2hj2yekiuoimm6rsy@pzofvxngb4ul>
 <7wbot7sxm3y5y7in5ashcn5lpx3mi55abnbfrkz2jta7nm6jep@zk6zvocd3tuz>
 <ycz7kwtr5d6bnrjjfmauktq2s7vtwsunpg7nfunfywxu5uou34@gfgoeeyarh46>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ycz7kwtr5d6bnrjjfmauktq2s7vtwsunpg7nfunfywxu5uou34@gfgoeeyarh46>
X-ZohoMailClient: External

Hi,

On Fri, Feb 28, 2025 at 04:25:47PM +0100, Anthony Ruhier wrote:
> On Sat, Feb 15, 2025 at 04:08:25AM +0100, Sebastian Reichel wrote:
> > There are other drivers reporting negative values as documented.
> > Most of the embedded ones do this actually and there surely are
> > (embedded) userspace programs relying on this by now. But the
> > most used driver - generic ACPI battery - does not. That's why
> > quite a few userspace tools handle it wrong without anyone
> > noticing for quite some time. Fixing it to follow the ABI would
> > obviously end up in a bunch of regression reports, so things are
> > a bit messy :(
> >
> > > I think it is a problem of the 'acpi' tool. At least 'upower -d' uses
> > > fabs internally since the initial commit in 2008.
> >
> > It's definitely sensible to fix the userspace tools. We can't change
> > the documented ABI for current_now after that many years and while
> > documentation for power_now is missing, it would be quite unexpected
> > to have it behave differently than current_now. Also userspace
> > tooling needs to handle current_now and power_now anyways. And we
> > surely can't change the behaviour for all drivers reporting signed
> > data. So let's keep qcom_battmgr as is. It follows the documented
> > ABI and hopefully helps giving this more exposure (I'm typing this
> > on a X1E laptop right now and can see your problem with waybar).
> >
> > But we should document the power_now property. It somehow fell
> > through the cracks :)
> >
> > -- Sebastian
> 
> Hi,
> As an update around this topic, I sent some patches in the different tools I'm
> using to correctly handle negative values in current_now and power_now:
> 
>   * Waybar (included in release 0.12.0): https://github.com/Alexays/Waybar/pull/3942
>   * Powertop (merged): https://github.com/fenrus75/powertop/pull/173
>   * acpi-client (included in release 1.8): https://sourceforge.net/p/acpiclient/code/merge-requests/1/
> 
> It was quicker to get this merged than what I expected, which is good news!
> 
> There's probably other tools to fix, I just fixed the tools I'm using. I
> encounter the issue on other tools, I'll send a patch.

Thanks, appreciated.

Greetings,

-- Sebastian

