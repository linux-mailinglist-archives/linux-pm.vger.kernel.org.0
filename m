Return-Path: <linux-pm+bounces-22086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D6A35F3A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B138C3A8E99
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E2263F2E;
	Fri, 14 Feb 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NesmdqPz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAD263C9F;
	Fri, 14 Feb 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539645; cv=none; b=hYhr7rnPT5qTE+iUILNFwzuday6E9L6FBF7QZdikZUodNltx9PkQsNJ1FaCApuoM9UumSA7SqzZWCJmgHqArun5sSV9MvY3KJ5D6dTLqUPjbNoqowHME26urphbvmEwqL8M9DJ23xgRxcxbyvy3Z/IsOabcgGs9GV4uSPw+51Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539645; c=relaxed/simple;
	bh=ExOn+6Xv9dif5rOSXXakPF7thDmgwJ83eFuUxj8W55Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQiGD73eCiG6y9NRYRyf95/TpAB1lJh0q4ODLXHOcMvcJStSRESmMB2zIk1AnAs/OLmBnAoT/4ZyRJM7keLfh1dsvJsY6JFUwkEBFDuQdjlR1Y7vD5BR2nJARWQGYrAAqfD0U77gQZpfjOu07a5K5Ij+oA3vLN2BDPzfNv/GENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NesmdqPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FFDC4CED1;
	Fri, 14 Feb 2025 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739539645;
	bh=ExOn+6Xv9dif5rOSXXakPF7thDmgwJ83eFuUxj8W55Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NesmdqPzlyZuD0NjvF3wh2nuxkfhCMZr+gD1UynnoWYY5RV97ukEJns6jhE0PBE5e
	 GRpVPVkeSM8ZuF90XyaH4QNLjPcRSo3QFTf9YoRO2+0QYqsBCaP2FqVxNa8s7N6VJF
	 DlSRsVAiWVgAcyh+XG3g/ltLbZkXrGIKz5GDjl6bQf0OZV2bvz2FhzQct7vELCQ6sZ
	 4pMV8d8IDQ+fo3mIpUM+JMXn7p/8pB+ExpNveBXOYCXg19hnY6t1kqqMMX3AZJQK0E
	 zHUjH31Fj38s6bG8N0PXbkURbuRbHicf3tWd+K5lPztcDiCB0iTJoH1HqOj0ywzBUU
	 IJrlCrPt4harw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tivjC-000000003HY-1Si4;
	Fri, 14 Feb 2025 14:27:35 +0100
Date: Fri, 14 Feb 2025 14:27:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
Message-ID: <Z69ExkCLfv_xLLUm@hovoldconsulting.com>
References: <20250214102130.3000-1-johan+linaro@kernel.org>
 <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>
 <Z688uKdqVDaQhm5V@hovoldconsulting.com>
 <CAMuHMdXD1yF65ezOmLz2ShP=gnYNNkUfTLfY8RA0m=C+WwtaVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXD1yF65ezOmLz2ShP=gnYNNkUfTLfY8RA0m=C+WwtaVw@mail.gmail.com>

On Fri, Feb 14, 2025 at 02:16:14PM +0100, Geert Uytterhoeven wrote:
> On Fri, 14 Feb 2025 at 13:53, Johan Hovold <johan@kernel.org> wrote:

> > I didn't add a CC stable tag since this currently works, but I still
> > consider it a bug to call these helpers unconditionally when not using
> > runtime PM.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > [ And during rc1 these callbacks were suddenly called and triggered a
> > NULL-pointer dereference as you know. [1] ]

> > [1] https://lore.kernel.org/lkml/Z6YcjFBWAVVVANf2@hovoldconsulting.com/
> 
> Thanks, that was the context I needed to raise review priority ;)
> 
> Perhaps Reported-by: and Closes:?

The glitch was only temporary this time and the immediate issue was
addressed by Rafael's partial revert in rc2:

	https://lore.kernel.org/lkml/6137505.lOV4Wx5bFT@rjwysocki.net/

(and which has these tags).

Johan

