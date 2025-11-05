Return-Path: <linux-pm+bounces-37434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A0C34E79
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF833B6DBE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E959301494;
	Wed,  5 Nov 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXo442xp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A72FB989;
	Wed,  5 Nov 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335269; cv=none; b=BJwcEHfTDgdN5Imh0MdGhwz+WjJ0H2xTcqPBv1ELaCtpxMnGqom/NOXWLXsHbYrki5EB4EYKIyDa+bGnBPdUGMJByDeyDduQyiSRINEfm9GjvSs5HiWLCXiHxnaL4+w+NRYSZX/GTiGV8wzaFGVmit7kSymMwvYE5gk90J9srkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335269; c=relaxed/simple;
	bh=CNrqEy8bwMXrl85WfuykS9g2llTPMr5i0jDD1EzDRZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9jxkIRKiigDI+SsOEW56D3LeSNoWmdWIaicianuQmfjBalPpSPBwcM/W9tuHvXrJlgyDcBGbQVWZOz8QsmgZpEYhIaCiZZrkV/VFC2FKW4nBPbcf60jOIn+nb8/2tJ6tAfmQdl2GsE8i04pNjO7VROXM9+vTWF2X91dWjcADCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXo442xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB799C4CEFB;
	Wed,  5 Nov 2025 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335268;
	bh=CNrqEy8bwMXrl85WfuykS9g2llTPMr5i0jDD1EzDRZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXo442xp9UxvWEjC00AKsPpLYsZO8+DBfmkJYRGPI0roCO1LBJYM6meGIE8DUEGmJ
	 TcsYCCBc0Glg+q4TXtWj/44Vyq3eZlAIZcaVEBdj3EmELGpmrhPcvRGPtJBFyzWhhF
	 /e+kK+ArkXH8H0/tu+UzYkSY4Lk8lghMOe91xBTXOZ5xEVRDcyVYY+yEb6z2rEgPMd
	 hgZhAmBAac+znrUHuzr3AXlqpSvySBX9/tohznS6ZQNVt9lvhgmr90TYdOQPvbl694
	 RbRRIXQPYT9ui1egQFPw8yifhERfESTrjtPq6R3Z5reflIK0mgKkdjfwasgJIAhM1u
	 aQIEUB4dhDXPQ==
Date: Wed, 5 Nov 2025 09:34:21 +0000
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
Message-ID: <20251105093347.GD8064@google.com>
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

What is the dependency?

-- 
Lee Jones [李琼斯]

