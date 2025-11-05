Return-Path: <linux-pm+bounces-37442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694FC35099
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 11:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB20318C6E6E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DE2E7197;
	Wed,  5 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQOL2lY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB12C17B3;
	Wed,  5 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337343; cv=none; b=XB3cE4YpVqmUkbwQOIvepD4UaansXI4AiZV0WV2rNm1re9BR3O3MsYyc07eJe2gUr4xqZOEaTMIQ7pTPcQ0BYGTN+fZyteYRP7JaAN8/FeO6H/4Kg5FWSr7Eeb7X1+sntQK+UL/c2M9eu3qYSQ3kDfyGAxcIIpMMs6fSINd3r1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337343; c=relaxed/simple;
	bh=cBgHojw5RM6tgrcR7jae+abslHQ0IK3ynWrHb++wOTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgBIU8vcUh4dslo73mnQVRPLo4ETGku9IPRJyY6z0PpJRUdugD5Gpnu9vX1ad1oV2YJL8srJEpiwV0PMfRWU5tc1obEJ5LEIN51k7eY11XK2hW4ZRVXrfJ7zA2IWROS26os+QdsZOihLidIf3Uhd1p5ZPGAOprOgp4lBhSYHpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQOL2lY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23DC4CEF8;
	Wed,  5 Nov 2025 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337343;
	bh=cBgHojw5RM6tgrcR7jae+abslHQ0IK3ynWrHb++wOTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQOL2lY+WAFqDzkNhAEc0y7ZWmhpolFDBHNwVYGaP/1ce24yaW7mRUqQNklQKzIpr
	 1ewdESlf2FTCp/A5iTwyeJRk8BqdxmoteGZtSkOLZxJV0TVi9SjBJtBQtzFIYNkI+k
	 lx7Bxc4H8PMstQ90f4aBJKvRXQLC0DBzNJB7WJbulllLlIt0/+3Ae1GZAbL5zzCuS3
	 qD5kglj6rpngbcuP5XrghEF+URMH0sVzPcBdbAIxrZ6J3p8KvHyQmUEtWzKV9bKT7a
	 YFQSuKePREKPkmxxLhQD6c/AcCvVUGs5ZwvihLhlltTRuzxmeCJFe8DpvBLwyvOcpP
	 ynkVQmUkNvJog==
Date: Wed, 5 Nov 2025 10:08:56 +0000
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
Message-ID: <20251105100856.GG8064@google.com>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>

On Wed, 05 Nov 2025, Troy Mitchell wrote:

> On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > 
> > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > 
> > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > 
> > > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> dependency is here.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > Should we apply it now? The dependency patch hasn’t been merged yet...
> > 
> > What is the dependency?
> I point it out above.
> Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.

Okay, thanks.  I was mostly checking that you weren't referring to the
MFD patch, which doesn't represent a true dependency.

-- 
Lee Jones [李琼斯]

