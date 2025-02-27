Return-Path: <linux-pm+bounces-23076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112EA47F25
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C013ABB23
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47932343C5;
	Thu, 27 Feb 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApZouFlz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937022FF44;
	Thu, 27 Feb 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662806; cv=none; b=JC08JfIdoXV5bbA59dfa8NMlntrGlJp/5AUBoFiEb7i9xYenMkRT5LHVzKkQTBbGQeU5ChTqFPawOi/iySk8hb6nwKjKPuynZo/95mZwXx0mdnzSqLcxUv3k+Fnz5xmUVlbqXq8Sks6T2VUBelu5TZCyzZOvX7pDbU6I/75xuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662806; c=relaxed/simple;
	bh=RC9g2s3NtsKBwCNvPMR9F7//Ad1mLMvFg97XbB1Mns4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4qhldAVMEOrWMMsp6fwRfwpMigfLZt77+QtLKxhyDRbuwib63582ADrNtu+ouRwme2y4LDiX2O9Da/9ekgqAyJODwN0+xcJFnLBUCOQCRlc1/1ICtM56v0fJqgHThOCV2CT8nuDgzMgNQYE97ClcMbUfmCgDrwD5ZVhAOcir6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApZouFlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1311FC4CEDD;
	Thu, 27 Feb 2025 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662806;
	bh=RC9g2s3NtsKBwCNvPMR9F7//Ad1mLMvFg97XbB1Mns4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApZouFlzCoMM3a08NtHo/cO8aR2RuP+Zuvy+v9gYdAE7AXWp3nxAzdasiRGhxZE08
	 Y+On2ijNI+JpMyNukXjvRIsVlofWqXUaz2FtPonBRCRjbrKbTSfmpfjhyR4MLFCDF1
	 kNEH06vftgX3E3dwTHY9Vh1sLX2vEhGJ3eXEQ1HWq0iVTnIRcLejwQ9ZXNI6R+d1ch
	 CfeLpuRyb16wJ8P2oHfPQ+gTLnXyz1ImGGoxseHCPT6/m0m2Km70l+tQkfzkInylXG
	 fsNPrJ06Ol08vhU9iKDkWPKOY9wj/9H6eFOSG5VQkCHkQ0qdYHFT5C4Sk/8rEC6mv/
	 BV54XChRrgOqw==
Date: Thu, 27 Feb 2025 07:26:44 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
Message-ID: <20250227132644.GA1924628-robh@kernel.org>
References: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
 <20250227-syscon-reboot-reset-mode-v3-1-959ac53c338a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227-syscon-reboot-reset-mode-v3-1-959ac53c338a@linaro.org>

On Thu, Feb 27, 2025 at 10:46:13AM +0000, André Draszik wrote:
> Add support for specifying different register/mask/value combinations
> for different types of reset.
> 
> In particular, update the binding to allow platforms to specify the
> following reset modes: soft, warm, cold, hard.
> 
> Linux can perform different types of reset using its reboot= kernel
> command line argument, and some platforms also wish to reset
> differently based on whether or not e.g. contents of RAM should be
> retained across the reboot.
> 
> The new properties match the existing properties, just prefixed with
> one of the reset modes mentioned above.

This would be why we don't do "simple" or "generic" bindings. There's 
always one more variation needing yet more properties to handle it. We 
also draw the line at encoding register accesses into DT. If we wanted 
that, we would have created a language for doing that (or started using 
Forth in FDT).

You need a specific binding for your h/w. If you can make it work with a 
"generic" driver, then that's great, but that's an OS decision which can 
change if needed. The binding can't change.

Rob

