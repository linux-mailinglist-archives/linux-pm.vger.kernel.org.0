Return-Path: <linux-pm+bounces-19269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEB9F263D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 22:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3C17A15FA
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2F1B5ECB;
	Sun, 15 Dec 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcgpaNga"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506AC17B502;
	Sun, 15 Dec 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297815; cv=none; b=tVLvRwENKtR1Z9sjy0YgwE5QK1WVlmLWJ0C+RA5dl1EzriJ42uqMBL19YTx+OlVE2xPH2jDNw6XgWmUNCYWDA/zveO93G6KyPVx96P6tKsEATgUCH0G5CGs8k6pClApX9V8s59ZFOZGvZ14NbzXCMlyv+Tte9fFIcT8rR2Kq9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297815; c=relaxed/simple;
	bh=KS6+EL9vNqjG7g3+LvxPJ54SOryTLzCuwyoq1+EbnPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmedpNx2CS5+vuVdBJIR+N1UHNucMhwv6S/ZiJHWMNAzmwUZv/z4Xd5k+//v7u5QIp5g+DkdDarn6X+W5WKtpoIZ2hCY1Z1t2y3ac6cqO9r2qV+FkAtyXaN2aJ7YH3SRZPO1KyM1HOVMbPTugfnFjkpvRDigvcocz8h8X2m65QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcgpaNga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B42C4CECE;
	Sun, 15 Dec 2024 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734297814;
	bh=KS6+EL9vNqjG7g3+LvxPJ54SOryTLzCuwyoq1+EbnPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcgpaNgaxmuYqSD4nv+IlmqHKoNg5m7pcNlJ2VkE+GMDAGbxnFA7hfbDtNMZNmoYh
	 y8MiXgbkzn7nay9hGIVf/ywW/uBdQvMS7tebxoz653/ce8/Ni686JXVLKKpOL3+R17
	 d9/MeLhXqBcEqHaN+rYaV8BW0rUIv+XvPqAxpoO2rPEx1h9GFaY1NO/Vnmq4xI1V9y
	 81qBJVMvmyGYnCYlcAMOtypnunVbm6GdJ+NDFyLHJggKhjtdn4SgE9Sn+WvSaPnrId
	 X0M8BhLb6BcqOZIPQhUgmWq42CN4pEjmbKBYHGJ6CfdVAm8p88hvXC2LqC7atNN6oV
	 CJUbMEWT9VBRA==
Date: Sun, 15 Dec 2024 22:23:29 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: bschnei@gmail.com, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benjamin Schneider <ben@bens.haus>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <fjdblv62k3nhqgy7decdldtieo4zyv6phxofx72dreyq7jbm4f@qmkp3e2wyplb>
References: <20241125211452.14987-1-ben@bens.haus>
 <20241212070712.txkxgmiugzji3doz@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212070712.txkxgmiugzji3doz@vireshk-i7>

On Thu, Dec 12, 2024 at 12:37:12PM +0530, Viresh Kumar wrote:
> Marek,

...

> Any inputs on this before I apply it ?

Viresh, let me try to test it this week on Turris Mox.

Marek

