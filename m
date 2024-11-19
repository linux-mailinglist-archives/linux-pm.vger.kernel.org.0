Return-Path: <linux-pm+bounces-17766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C09D2CA5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CB42819A0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455F1D173F;
	Tue, 19 Nov 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPGkx16s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD41CF7C7;
	Tue, 19 Nov 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037350; cv=none; b=LZPoz8kPfY6CSlZugBnMnaa32HX1RJ5P3kUeK8TOrodU42z1dqNfhjboWlgGTOklLgs+twbu3kfon0hT4nRHsrtVflFmUIOgX0MLD2RS+yCRLZ6LnIsRmbsXvd9lzU5r4q/tgEo5Zkfex02WHt0POe9wyC7/03154foj92ULrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037350; c=relaxed/simple;
	bh=nwnrkt+Gz/cJ+4UcqIYdBS4Zd7PrtQFDtK8nhHLleT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McEk4MgcuAdPvxMM0WDrBuLvaFgpQ8LiXSoS6ydYtwrbUyw3A3yM/svi6G3AHwoVNSpjZ6yzFyojjcRY6JftKMEwpsUIO420kAUoWcfeLGPfCdcGKJVKCiYGnMc7V6aAMZeUek2RdLpCjO8H+OZCccSrPQOuwb24YYxu256xplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPGkx16s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9F6C4CED0;
	Tue, 19 Nov 2024 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037350;
	bh=nwnrkt+Gz/cJ+4UcqIYdBS4Zd7PrtQFDtK8nhHLleT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPGkx16sFxtTJ0yxXqhShGQH3mFvG4YY4ntckBh7N51daDE7d6Z8r4zX5QTsw+dMm
	 HcvU6rqFXemPfJ1Fyi4fiTeP/68i06are05yXGVdGRqIDWWTmBRPhfxpIL/v9BuQvv
	 0EXSMFaGtJGq7jBVjdVWTFgryeRashFyQz0DTwg0Zq4t5nEJ1ANUDZFTlb//L0Cgsj
	 d1YuKC6NYdAHuHt8Lx0CefBW3bpEs9CwPBrSxU9SVCWKDOMS243IqJVSS5oWSeCneX
	 aZ0VgVYQY3AKYSfQV4/StdRPyax8GAO1dJe5yo7d/+GX4XYptwbXYmsR0AySlCB3pk
	 q08FshCY+N0UQ==
Date: Tue, 19 Nov 2024 11:29:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hermes Zhang <chenhuiz@axis.com>, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: bq24190: Add BQ24297
 compatible
Message-ID: <173203734756.1854593.11498907587461921270.robh@kernel.org>
References: <20241116203648.169100-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116203648.169100-1-hdegoede@redhat.com>


On Sat, 16 Nov 2024 21:36:46 +0100, Hans de Goede wrote:
> The BQ24297 is identical to the BQ24296 except that it uses USB D+ / D-
> data-lines for charger-type (max. input-current) detection instead of
> a PSEL input pin.
> 
> This is the same difference as between the already supported BQ24190
> (D+ / D-) and the BQ24192 (PSEL).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


