Return-Path: <linux-pm+bounces-22146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334E5A36B93
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 04:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9551702CD
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E354158525;
	Sat, 15 Feb 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Ug88F8Yc"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420961426C;
	Sat, 15 Feb 2025 03:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739588937; cv=pass; b=S95xKWRmy+7ayT/VgXZtXSSgJhJTu3NKY8iEkX8xB2daW6kApszlbNuroC5YWqp3DMxTWyjo8hGwTVLlcg0jvcpEH/3EWid+hw/THdW1WJHK+eRRqij99lcD1yCWymQ695KkJJddUSHrdGYzYDm83tgJiV2hJECI/tzl4t+yEeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739588937; c=relaxed/simple;
	bh=TSid2wpEec/JFZ0X5ZNXOZleNNrkpu60/3D5KVKRcXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8GyPcbf2vcZ5HYmH+QFLSq7W9rSzF4pMQ5chPL9K5MhWC2/6sbbU3cZtl/ykmxLYS35l+Vi1UffntpPf6/f46DFZjbByaMDnb7XFIOlq8vy9cLdF3OsL+ZmC1+uTnOjsM1IwxZzz8DTL2c7Wr/YCxRgZp7RyCUK1ffp61VZLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Ug88F8Yc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739588911; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ScNgEi08Rzryh3YAb2G/uBfB+/IyMVix5Tf4N8C3OocWx84bQRoR+rqQ0G/nis8Nu5rsiW8eOlBcrQ2j1MP7F+6Uwne9dM5Bv5MvgWJYfcLOrK8lbpMpI3CsJZK3eiToT2crTBp57yzlsPgJWUvcIEHsSC+KWGjtwMgkERmVmb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739588911; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0GHUWF87oUo/UusENMIAUFzoIF3dJeB1mxddebspI48=; 
	b=kn//SUcCOawuARBkxx44NS/oMktPImJzl2g/HeC69XtJNsCokCrzgHjHQtyVhT11X4y59fO+bBK7ZYlwPgvGoSBYF8kF5d9QUEBilzQ4Hy0YIlqvzfvq3F/Sjw91ETKKRfnDEtPxQ0jjKR1bbJ3pcJUspDeEY8v3MWqdtI2J2xY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739588911;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0GHUWF87oUo/UusENMIAUFzoIF3dJeB1mxddebspI48=;
	b=Ug88F8YcLkHOa6do1KcAGr+3xPh4BCwc/H2WB+MVJeHDoMMrCXqf6Lp0nNQYzT9t
	NNmILtV1wNYwZ8UluL7N2unJmYp39ahg5JKgRxuhK7A/VLyDDVV/1cQN3IqgTc+uljF
	YsDIo5eFqtsCGAzDfFif0dy3AjRGVqrD9+kAEgVQ=
Received: by mx.zohomail.com with SMTPS id 173958890899237.694036789018924;
	Fri, 14 Feb 2025 19:08:28 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 83CBF180CEF; Sat, 15 Feb 2025 04:08:25 +0100 (CET)
Date: Sat, 15 Feb 2025 04:08:25 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: aruhier@mailbox.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <7wbot7sxm3y5y7in5ashcn5lpx3mi55abnbfrkz2jta7nm6jep@zk6zvocd3tuz>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
 <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
 <ioiy4ixlvx5gxl3f4pqshwxz35ktrqghju2circpnd3qicgemc@oohazfsfvuag>
 <p5tszocxa7mcazgxsnt3gnv547m523gde2hj2yekiuoimm6rsy@pzofvxngb4ul>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p5tszocxa7mcazgxsnt3gnv547m523gde2hj2yekiuoimm6rsy@pzofvxngb4ul>
X-ZohoMailClient: External

Hi,

On Fri, Feb 14, 2025 at 05:01:08AM +0200, Dmitry Baryshkov wrote:
> On Fri, Feb 14, 2025 at 02:36:17AM +0100, aruhier@mailbox.org wrote:
> > On Fri, Feb 14, 2025 at 12:24:18AM +0200, Dmitry Baryshkov wrote:
> > > On Thu, Feb 13, 2025 at 05:51:38PM +0100, Anthony Ruhier via B4 Relay wrote:
> > > > From: Anthony Ruhier <aruhier@mailbox.org>
> > > >
> > > > The value for the POWER_NOW property is by default negative when the
> > > > battery is discharging, positive when charging.
> > > >
> > > > However on x1e laptops it breaks several userland tools that give a
> > > > prediction of the battery run time (such as the acpi command, powertop
> > > > or the waybar battery module), as these tools do not expect a negative
> > > > value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
> > > > estimate the battery run time by dividing the value of energy_full by
> > > > power_now. The battery percentage is calculated by dividing energy_full
> > > > by energy_now, therefore it is not impacted.
> > > >
> > > > While having a negative number during discharge makes sense, it is not
> > > > standard with how other battery drivers expose it. Instead, it seems
> > > > standard to have a positive value for power_now, and rely on the status
> > > > file instead to know if the battery is charging or discharging. It is
> > > > what other x86 laptops do.
> > >
> > > Documentation/ABI does not define ABI for the power_now. However for
> > > current_now it clearly defines that it can be positive or negative.
> > >
> > > >
> > > > Without the patch:
> > > >     $ acpi
> > > >     Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.
> > > >
> > > > With the patch:
> > > >     $ acpi
> > > >     Battery 0: Discharging, 97%, 10:18:27 remaining
> > > >
> > > > ---
> > > > Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> > > > ---
> > > >  drivers/power/supply/qcom_battmgr.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --
> > > With best wishes
> > > Dmitry
> > 
> > I see. But as it breaks existing tools when power_now is negative, should we
> > change the behavior of these tools or adapt the driver?
> > 
> > As it does not seem common that power_now and current_now are negative in
> > other drivers, tools using these values rely on the status anyway. I'm
> > wondering if it provides anything to keep this behavior.

There are other drivers reporting negative values as documented.
Most of the embedded ones do this actually and there surely are
(embedded) userspace programs relying on this by now. But the
most used driver - generic ACPI battery - does not. That's why
quite a few userspace tools handle it wrong without anyone
noticing for quite some time. Fixing it to follow the ABI would
obviously end up in a bunch of regression reports, so things are
a bit messy :(

> I think it is a problem of the 'acpi' tool. At least 'upower -d' uses
> fabs internally since the initial commit in 2008.

It's definitely sensible to fix the userspace tools. We can't change
the documented ABI for current_now after that many years and while
documentation for power_now is missing, it would be quite unexpected
to have it behave differently than current_now. Also userspace
tooling needs to handle current_now and power_now anyways. And we
surely can't change the behaviour for all drivers reporting signed
data. So let's keep qcom_battmgr as is. It follows the documented
ABI and hopefully helps giving this more exposure (I'm typing this
on a X1E laptop right now and can see your problem with waybar).

But we should document the power_now property. It somehow fell
through the cracks :)

-- Sebastian

