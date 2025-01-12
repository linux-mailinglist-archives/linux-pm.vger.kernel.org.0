Return-Path: <linux-pm+bounces-20287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7CA0AC94
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 00:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F08A1885EC5
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA571BF7E0;
	Sun, 12 Jan 2025 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="OBYcZSwP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch [79.135.106.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8B1BC9FB
	for <linux-pm@vger.kernel.org>; Sun, 12 Jan 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736723686; cv=none; b=To138iSS5f+9E6CyC/AEiqkOSkgJZMG8aAF6Sz8gZ66II7P+64POHonjE6l6B+LCcgFXAduWzD3IjvkOyjnNo/NP7Hi5+0qwqpI6idz78PfyJ9O0G9Hm35WciBTMMlCwcfcKO5OyaWcAd3mjLdx7gaOooLfsKt5HWclXaH8rdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736723686; c=relaxed/simple;
	bh=RJBy60kKXNMvIyExEUDV0hVHXtHyDCXCBeBi9Tj3OSE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zxi4RuCBuEvTdY6pVJ+E27oG9zzGGqmpfEsTCI9ydjIb8ZdnJ07EpV5pGwxxOa6ODOU5n4kLj6+DQ1cmTTobA3pzw8epSuLzy67YlfVjTf8FPfzXK8R2J3285NutV/qypBmShH3cc/99Mj3lV+lBo86Z/OFYR64Hq/7GleKtupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=OBYcZSwP; arc=none smtp.client-ip=79.135.106.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1736722172; x=1736981372;
	bh=RJBy60kKXNMvIyExEUDV0hVHXtHyDCXCBeBi9Tj3OSE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OBYcZSwP/+kn+ybDJEUNa9gnU/gJRFg9UmnhvjCcpjRepfbyWukkYaBlC1abGF6vd
	 fCvgFcYa61DjSLVuypkZR4eZBquUK+GL3yV4CTdbJGI6O6l2DKVci2BtPUIy47UwM/
	 Mem8GDHtnSbvgPHI4635nRD/DZmMNbAwKAazetOCgw/B0YNlTMwmSbiUz2U2FFEewY
	 cFOYgxoMespHX0DOj+FtNdBS/yTbPTQhfEST1Sdqq9sk0xuRSbG5GK6VAFcF6mRHeQ
	 qSbsRqdZFDouFymHXDvh3HAeodxdCy8p3D98o1KseDW45/Rf50bho6wh20X/GzP+AL
	 ak5aENqFHSWHQ==
Date: Sun, 12 Jan 2025 22:49:27 +0000
To: =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
From: Ben Schneider <ben@bens.haus>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, bschnei@gmail.com, "Rafael J . Wysocki" <rafael@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <aosJmFtjxsJTEZbWlONPNmqzPQRxyZEHnhOknuhn76DchCVqWJNeTebo2QMuVl0AQ5vVxKXNwPH5IWxeAnhiWDhlWz4J3vxQ91QLjHn8Oj0=@bens.haus>
In-Reply-To: <fjdblv62k3nhqgy7decdldtieo4zyv6phxofx72dreyq7jbm4f@qmkp3e2wyplb>
References: <20241125211452.14987-1-ben@bens.haus> <20241212070712.txkxgmiugzji3doz@vireshk-i7> <fjdblv62k3nhqgy7decdldtieo4zyv6phxofx72dreyq7jbm4f@qmkp3e2wyplb>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: de9e1846e9c51310cb99671b423aaab57c6d6552
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, December 15th, 2024 at 1:23 PM, Marek Beh=C3=BAn <kabel@kernel.o=
rg> wrote:
>=20
> Viresh, let me try to test it this week on Turris Mox.

Hi Marek, were you able to test this change on the Turris Mox? If I can hel=
p, please let me know.

Ben

