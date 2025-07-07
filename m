Return-Path: <linux-pm+bounces-30297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780BAFB71B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C1E189F198
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB182E266E;
	Mon,  7 Jul 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="mnUIlcp6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA829E0F1;
	Mon,  7 Jul 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901568; cv=none; b=YIzWNZc7ce4C7NrTEO8ftyXMRT7oDczzSqARmi46qm50cAjt9KXBwQ4+Dxxg1ghcu/nIPL7N5BhqPzMbpRegqP0yGmdiJYQQCrkrh6Mvi/Ak6zNIfo41hMJtpzB1pjZhrHoQ1O7AJDrwZ4Ba6lZxtCDTMbgxpRstfnHweImJETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901568; c=relaxed/simple;
	bh=tpkTBLlGyBed8stpAJAlUgzSTNIlCkTBXutlqDe25tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvhxayO4wPpjab/3DgBFz9J6ayEfGOMvu/Waer7nNyMOnG3o+aGxBQt+9hIuhVKnzT7xuHeB68aq9OKsU35WAvxIAGC0Gv9kQW6T06wbbYPN0KXav/XGhAvcuHDVhf6wagXOdW1tgoq/Np6YuubbEHaoEdGuAhTP0TSk2Tf1CcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=mnUIlcp6; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 94C1F3D87636;
	Mon,  7 Jul 2025 11:10:19 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RXGVUZCcsYqL; Mon,  7 Jul 2025 11:10:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 124E33D8763B;
	Mon,  7 Jul 2025 11:10:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 124E33D8763B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1751901019; bh=0aLD43uKvFCDnAlmsPAwmEzg9CJOxrOo22s1hwxDcjw=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=mnUIlcp6yxDLXPETEAONZ2EVz5p5fLXqjxrXOiWPta2jbFMcubESKsE2/R+IyF3aa
	 W+4l/Qk/adEJGyDl+Ov/smsRqzG1g4YuUVbc0IJaJf3qAWAWkALcZh2gV3NiTxyinU
	 gpe5GbOGgYBWNLrQVVfDt2pYxPQQUD/rGLxZf1M/xRok9SvFRcmvhDT4KYHQiIW1di
	 Yy9Opts23Qz/XKXy85OGek8kFuGy7PiW587OuUbNLVZHIpwydeB9bzMFgqVKBtL9Xa
	 0lLSSJWS1ieY6JbbTYjkZ0svSGo9PGW8lnqRP/YlC6usjwacNmhZOggiJcgyWHN5Mi
	 4tX4lAjPBHhYQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wZubokswAwAj; Mon,  7 Jul 2025 11:10:18 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B11DE3D87636;
	Mon,  7 Jul 2025 11:10:18 -0400 (EDT)
Date: Mon, 7 Jul 2025 11:10:17 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aGvjWbd9FRTuqWNN@fedora>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-5-0e393b0f45d7@savoirfairelinux.com>
 <xgwx65axwiebh27hrq7rluuf7jynb7v4o77mf2zztsf64bx3bw@iagwzeumk2su>
 <aFwFhYoaWoSXcFdR@fedora>
 <i7qehdo46eegyj7ebp4hetr7jtwkxceoate6tqw6aukw4cbgsl@pl6lgh4k5m4o>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i7qehdo46eegyj7ebp4hetr7jtwkxceoate6tqw6aukw4cbgsl@pl6lgh4k5m4o>

On Mon, Jul 07, 2025 at 01:33:36AM +0200, Sebastian Reichel wrote:
> Hello Samuel,
> 
> On Wed, Jun 25, 2025 at 10:19:49AM -0400, Samuel Kayode wrote:
> > The pf1550 charger receives a VBUS power input which can be provided either by
> > an AC adapter or a USB bus. A depleted battery is charged using the VBUS power
> > input (VBUSIN). When no power is supplied to VBUSIN, the pf1550 switches the
> > load to the connected non-depleted battery.
> > 
> > I could have two power_supply_desc, one for battery and one for the external
> > power?
> 
> That's acceptable. But don't you have a fuel-gauge for the battery?
> If you register two POWER_SUPPLY_TYPE_BATTERY devices, then your
> board should have two batteries. If you have a fuel-gauge it will
> very likely provide much better battery data then anything you get
> out of pf1550.

The PMIC unfortunately does not include a fuel-gauge.

I intend on having POWER_SUPPLY_TYPE_MAINS for the external power supply
(AC adapter or USB bus) and POWER_SUPPLY_TYPE_BATTERY for the battery.

Thanks,
Sam

