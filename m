Return-Path: <linux-pm+bounces-30625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF53B00996
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432213AA4B7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178272F0C4A;
	Thu, 10 Jul 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="b3EKh4Us"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45C42A9D;
	Thu, 10 Jul 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167473; cv=none; b=tpN+pB9Rl3r9NMQRC3prfeKz31ZStoaoHF+Bm7QOmrGn8qnX99OojKgYvsP2odM6a3E22OkI8SNBGK7y4CYYXARDU01OdNca0GGp9cdMgLXuaHfxYp6N0RpPZ1CqRm4mFxNzj54gXn04udYG8tRPtstxSdRvdYejr7mgvEUvchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167473; c=relaxed/simple;
	bh=UJxE7MH5etBS3FvMayEvh6E0enV1XbZHglL/BKvpz1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRO4wXmU+7RbGzX5dQ9ZuMq47IbKR4f63AHHmFJZN1eqOTFT9ciiptZCo5XACV53T0GiosxQGKwqOhVmMWO1fDX/5TvOQ0rvh6UnujSQFHFo029T9kd9CKV8ha4CiUDTvumvlWANPncV0qgMlDZllbe79oRrTeF3Qn0BTb1QO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=b3EKh4Us; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BEDCC3D8762D;
	Thu, 10 Jul 2025 13:11:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BL83nm-GV8ik; Thu, 10 Jul 2025 13:11:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 280353D87635;
	Thu, 10 Jul 2025 13:11:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 280353D87635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1752167469; bh=pt37oDazBqf4Xr92huoZCBKHxOLg2cy5Xjk3xp+O5To=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=b3EKh4UsIFGvXObB+RauVDaW6NSSizXqMfCbw59YQxcOOka/5GNYn8uEgC2QKfKNs
	 G+LfqNkUh2SzA4qmy2dd6gFvHWTvAfAyimYxyrITdtoIbDdN3HkF/YP/9AoOPk5Zm0
	 LFUpmdB90krxURsMaM/DSr2XrBkP1mYBYmWpZgCZsjA268uYfQSGqrA7baUC/FxZBf
	 0+FBt9KzdsQHfhTVACcgsCMkU/zurfzbRuT5x5wCdczq3NGnB3NvqyRWLuDkvLw4mx
	 QFFlezKKcA3XgVNiRI5KpbtufVpWG2WXq0VY0J4Y7G/NxunI2YP3c0F5ygrOwIPJ+s
	 iVJ23np66j91A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id obxHbGWsTiEk; Thu, 10 Jul 2025 13:11:08 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C05EA3D8762D;
	Thu, 10 Jul 2025 13:11:08 -0400 (EDT)
Date: Thu, 10 Jul 2025 13:11:07 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 2/6] mfd: pf1550: add core driver
Message-ID: <aG_0K2qN06JHS0__@fedora>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
 <20250707-pf1550-v8-2-6b6eb67c03a0@savoirfairelinux.com>
 <idqtxdptxq6s57r452staq3xv6zzs3i5bbapzxdlu3o7cdahaq@j257j4okrw52>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <idqtxdptxq6s57r452staq3xv6zzs3i5bbapzxdlu3o7cdahaq@j257j4okrw52>

On Thu, Jul 10, 2025 at 02:54:38PM +0000, Sean Nyekjaer wrote:
> > +	/* Regulator DVS */
> > +	ret = pf1550_read_otp(pf1550, PF1550_OTP_SW2_SW3, &otp_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* When clear, DVS should be enabled */
> > +	if (!(otp_data & OTP_DVS_ENB))
> > +		pf1550->dvs_enb = true;
> > +
> 
> Thanks for upstreaming this :)
> 
> We need to handle DVS for SW1 here.
> I'm using the A6 variant that have DVS enabled for SW1 and disabled for
> SW2.
> The A1 variant have DVS for SW1 disabled...

I can add checking of the OTP for SW1 in the next patchset.

Thanks,
Sam

