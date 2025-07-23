Return-Path: <linux-pm+bounces-31312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA4B0ECBE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2117E581EF0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3527A44D;
	Wed, 23 Jul 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQmfOxAC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79917E4;
	Wed, 23 Jul 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257982; cv=none; b=eAp8iwMhmrN4FKDBuAS1ffkWtnaJd2XFnq3Z7YgKqJpmwAa3oluoHgkJ9LWxcPHBLk9x+WfAYz/YRLEbfPCpZ73NQqhNQB0v0TSdB2Id51bcE5BxtxrubiS92tx0zAg7S4NqStJ8fUPNDMkhRWZ7AA6aR+P8AodStbNHJcEbiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257982; c=relaxed/simple;
	bh=WnDG1UA1bGrhEYDV9mKGmbyJ7Yrsf0tyvjUYJ1ZzAvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvDMzs7i/No8YJ8vNyzPNMjZj5/dcLSl6Jb3oRtdjdqUa9n+kMEdJm08Zwe5xX43uwq0j2CEVDUQRYjnwxPrG531DChbjkMHtTLghSI+6njStXn0Y3XmPBWvA1jfSCUIS5IN5O4zb5IigWYyYBRAz0mkxg53o0ujsgNJ7scYK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQmfOxAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D561C4CEE7;
	Wed, 23 Jul 2025 08:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257981;
	bh=WnDG1UA1bGrhEYDV9mKGmbyJ7Yrsf0tyvjUYJ1ZzAvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQmfOxACvj52LQJCTXJJSVC97NHeii7RnfXwQtZajVUVCh6qVVnKCQhXtLVKTubzS
	 qEMuTVr1bnUw/YdzP7GBpJNzsA+Bk6Na7SMh+sPJgWxGdJZ1qRXJfEJdUcKX85onE3
	 k8k74Ywa9X4YdCH5RrJ8GaDdkRNjGwS77CwvWJBBRZHc8gbOcwESB6TaozTRID0yDU
	 g3y1GnTvIWGMgetQ8SSpavu1oma51gSVxmKqqJ0/2+SxuCDUoi/dx2hovZvFfx6vyg
	 UFPEcIHsmvF/6gg6AlIUJE1oOljDZSlzETOpQspQ+3KZ+O13D48FFOrBB75u/mUoqe
	 FKQxr+lpmAWlQ==
Date: Wed, 23 Jul 2025 09:06:15 +0100
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>, asahi@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Hector Martin <marcan@marcan.st>,
	Conor Dooley <conor+dt@kernel.org>, Janne Grunau <j@jannau.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v7 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
Message-ID: <20250723080615.GM11056@google.com>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-7-556cafd771d3@kernel.org>
 <7297d4b1-84a2-4bb1-8a33-29c827247df7@gmail.com>
 <d6b778ee-02c0-4dd2-b33f-cec16c17807c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6b778ee-02c0-4dd2-b33f-cec16c17807c@kernel.org>

On Sat, 21 Jun 2025, Sven Peter wrote:

> On 16.06.25 06:13, Nick Chan wrote:
> > 
> > 
> > On 10/6/2025 23:29, Sven Peter wrote:
> > > From: Hector Martin <marcan@marcan.st>
> > > 
> > > This driver implements the reboot/shutdown support exposed by the SMC
> > > on Apple Silicon machines, such as Apple M1 Macs.
> > > 
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > Signed-off-by: Sven Peter <sven@kernel.org>
> > > ---
> > >   MAINTAINERS                         |   1 +
> > >   drivers/power/reset/Kconfig         |   9 ++
> > >   drivers/power/reset/Makefile        |   1 +
> > >   drivers/power/reset/macsmc-reboot.c | 290 ++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 301 insertions(+)
> > [...]
> > 
> > It seems that the reboot driver still probes even without the smc_reboot node in the smc node:
> 
> 
> That's odd...
> 
> Lee, is it expected that a mfd sub-device declared with
> MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),
> is loaded even if there's no corresponding node in the device tree?
> 
> I'll have to re-add the check that makes sure the sub-device is available
> then.

Yes, that's expected.  MFD is orthogonal to DT with respect to device
registration, unless you specifically disable the node in DT.  If the
node is missing, the device will still be registered, but no link will
be made from the (non-existent) node to the 'of_node' pointer.

You have 3 choices; provide a DT node and explicitly set the status to
'disabled', optionally omit registration from MFD (i.e. do not call
mfd_add_devices()) or check for (!pdev->dev.of_node) in the sub-device's
.probe() and bomb out early if true.

-- 
Lee Jones [李琼斯]

