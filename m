Return-Path: <linux-pm+bounces-37435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6562C34E06
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3619D1883810
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0962FE584;
	Wed,  5 Nov 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lneLXE3T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D92D1F7E;
	Wed,  5 Nov 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335352; cv=none; b=Yi/H9oGLuBz2kkFyzo2w72l8VVfgFd6I4Zgx5bUWuCXcaS3KkNbZ/XBGlvrE4GBhF/vgIWCprO2u63xDtb9+KMzCpqLL2QwlWJzJ3P2qgGti39REMokpKBd8BYfZsiMbUF/eZT4jWAp5zzd6NzwEYac0/e6e+W6y5tE2mIJ1uTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335352; c=relaxed/simple;
	bh=81UYSPD+0lOjQIr/2Q9pkdoxwrWEaQRmME5VjTnZv+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwmRwet3vmQv85N2JJ5IoRPYnEWXdrZ1HE/NvkWsnfSqqB8q4CX5ajoH+NqscBDJFhWB3TA1zlH2//DaZxRjfLen36o/0ujIVRijPaCg8+NN0bMZyd3V6vo8qSDbLjPfxRqVQCG+UQQUk2HZr8Jhv7Ao4RU43I7d3NM/rb3+oQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lneLXE3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF6C116B1;
	Wed,  5 Nov 2025 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335351;
	bh=81UYSPD+0lOjQIr/2Q9pkdoxwrWEaQRmME5VjTnZv+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lneLXE3TvYXMOEdybO5TxbXeH7g1cXCIeTOspbt+mpAsiBjd6V0LIKA0ybfSlEmix
	 IcmJ27k9kDU2PbiZA3JeP65eoxei3zskUXzh2eqVjXmqsvnhthLowHCRH+nF3y3Dq0
	 vsWnqAMUWfBo3mhKIsFAaODLrlrOl4r31EDxQnpWMJoAXgB89aQQsQz/f4TGIc0yeQ
	 8wHX4haZKZkIgIyb9RVodns1ZFlrsLaCpOue6ovqs/JdWAciIPFjZUUBNoBykFkBQl
	 +L9na4f67XIFe48qYUQhooNmmt6fMIJfktdvpO9RWT/RxS3p2jgq9ZyMUwqZAGe/8O
	 TD+aDeqp3fO5w==
Date: Wed, 5 Nov 2025 09:35:44 +0000
From: Lee Jones <lee@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <20251105093544.GE8064@google.com>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>

On Tue, 04 Nov 2025, Troy Mitchell wrote:

> On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > 
> > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > commonly paired with the SpacemiT K1 SoC.
> > > 
> > > Note: For reliable operation, this driver depends on a this patch that adds
> > > atomic transfer support to the SpacemiT I2C controller driver:
> > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> Should we apply it now? The dependency patch hasn’t been merged yet...

And what is: ^[@kernel.org in your recipients list?

-- 
Lee Jones [李琼斯]

