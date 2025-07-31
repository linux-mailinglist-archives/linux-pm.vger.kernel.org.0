Return-Path: <linux-pm+bounces-31690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87581B17209
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DDF585BCE
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9272D0C8E;
	Thu, 31 Jul 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bQFaVW1u"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C832C1597;
	Thu, 31 Jul 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968468; cv=pass; b=roNDtHZ/AHNY9v9i1qXsRG4FQQbgetfqg+zKhWVeSe9bzu2HscUdfGds8UTLP0ArvE9tdQWp/NgyMEQtAZgCCDkeBaDtENezRfUcdSy92Dy+OKUSONyolOaM35flO2ZPN9+5NNZlF5YKNRwnyjFB9AUI1emy2omdTYb3GHmTEmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968468; c=relaxed/simple;
	bh=COOo3jiK9lz3rMXgTzpbFodohMhA2czPItwQ82+elrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSjqYpcbZpI9BcZl4Bbsz6HvzcOwCstc3Av53Jx4Z7SPysDwXs4xpMcdyfUKrIN4YsjxUN9JXDuxhfuPosWrpoew7aBMhiNHDh70gc/3VVfLVLehmUomqRxgKq2tOGQ+GuI/3K5EwP0DLJGiFQlgkGrGv+N4YXz05/0q3mCE0Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bQFaVW1u; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753968430; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wd157ipHbyNwRd7zSLEBZrjL1NwE7wlcP7m29JHZAl4aMg4StR8Ewkw/JhmY3EjbCNZNTXM4DQXv54EwRb4mHSAJdQXOp9b946vc5Z+TwmfAZjnDqfaiokG8wLtxt09CtEEy3wCY7TuJUy475xOAMr0MA9lAyH7meSZGglcEQ4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753968430; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=COOo3jiK9lz3rMXgTzpbFodohMhA2czPItwQ82+elrw=; 
	b=c/93OTp41HKxDz/ybAc59tvWucKS6YrIVxmfDdwX8QaU9UxYAyo4Ji6EYjsg5M4l2H312fi/hVX77IDTyZMrhseiy96V2y9yNdUTFkza1BSbHaMUmlWX/UJ6jsoIcdVHtwCp7LVgd/cTkF+Ab9q4vIr3aAjRvF+OTvP+KdH1Ma8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753968430;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=COOo3jiK9lz3rMXgTzpbFodohMhA2czPItwQ82+elrw=;
	b=bQFaVW1uRX2HVR53bZ84cWiKsIqBWo72ciak7k08lk82m40VDwUpzVYL1XfVLSdE
	JUYf2Q+Smzow4HogkIHAASadzJPcBckDF0tYa0enXzQcSKhatZxAHMZh789ELm1YIjU
	RMfLfnh1WJ0PdHjyEypz5p2GbA+yd1z1NcAUUGYE=
Received: by mx.zohomail.com with SMTPS id 1753968428292555.3333899104606;
	Thu, 31 Jul 2025 06:27:08 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 1F6881807CE; Thu, 31 Jul 2025 15:27:03 +0200 (CEST)
Date: Thu, 31 Jul 2025 15:27:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Alexey Charkov <alchark@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Ye Zhang <ye.zhang@rock-chips.com>
Subject: Re: [PATCH v6 0/7] RK3576 thermal sensor support, including OTP trim
 adjustments
Message-ID: <iafobb7h4nphjcujm34gig6vwlzfveegwewpayehb4h3tayzgv@bxpdfmhf2hfa>
References: <20250610-rk3576-tsadc-upstream-v6-0-b6e9efbf1015@collabora.com>
 <14c91ee4-3a09-4ec9-966f-0d563d7c8966@linaro.org>
 <CABjd4YzJeNf0Qq9qFeMcoYQV5erZGUeOpmJynRW88AeL9dJNhQ@mail.gmail.com>
 <3560770.QJadu78ljV@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3560770.QJadu78ljV@diego>
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

On Thu, Jul 31, 2025 at 10:11:23AM +0200, Heiko St=FCbner wrote:
> Right now we're in the middle of the merge-window though, so everything
> I apply now, I'd need to rebase onto -rc1 in slightly more than a week,
> invalidating all those nice commit hashes that end up in the "applied" =
mails.
>=20
> So I'm struggling with myself on every merge window about that.

Your are not supposed to merge anything to your for-next branch
during the merge window anyways. See first sentence of Stephen
Rothwell's mails [0]:

> Please do not add any v6.18 material to your linux-next included
> branches until after v6.17-rc1 has been released.

[0] https://lore.kernel.org/all/20250731133311.1a3e3867@canb.auug.org.au/

Greetings,

-- Sebastian

