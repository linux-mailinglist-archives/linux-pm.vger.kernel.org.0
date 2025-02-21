Return-Path: <linux-pm+bounces-22591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52DA3E9E5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 02:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BA3BB131
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 01:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85719D087;
	Fri, 21 Feb 2025 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="D03StydJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902878F5D;
	Fri, 21 Feb 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101064; cv=pass; b=LDgtuoe5KELNRLU3xcqtu3I6+O8sWe7S1iZlCMePdLiJX4nxjDoI+bgIPkWj7wh6wZsknDBtQVg/c7vvW6OPZ21PNB0dVDjkqr1T/fdrFrwK2RSiVW6B4fTKpbi+59i8BcOm2ZlpoB/zn0pIZBF8e5YYmr6k2l/5t97+Hvrec4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101064; c=relaxed/simple;
	bh=3Sm7DDI5Q3UUXjF6i7tR75Y3+dqUV1skgvyKaKwQc5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6Bi77ezmVrClr345XtaA1t4q8rJmEIZ7BH1HEt0p9KugNceJl/4Wp9l93Bl8EQQTgv9LXG2M+x0Cl14TG5tNa02Qxg57GzdjEAiyUbFgXMIOgDIxkratUrfFOJ02gdRu4Ug8ZNBeHrwmz9ia4EQVpjVrzCA+gIILxJnXZqsvAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=D03StydJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740101046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XhvEn896bySa73zf2SMJO+WnEZWN1fHFTFN2xqzqaYHRU3Ajab5TbTF2oRi5ftx3N2dtTa1Z/SCGJgy4e7lgq/FE/ZX0R/GOi54FBwl5uIcn3vM8PCpvlsRnjPcWK3Uurs3mNAWDcz0+3icIieMxoE/lpW69in8DjdLcZAGxYfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101046; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mI/T5ROJs8elFBTHxKYFGNMmgHI1d3zveSjCBP4h+sc=; 
	b=BCBzVjbgd844t4bj1IN9w3G7oN9d6a/czM51AXigkPQlwK3NjVNN8kuhB0mNwns8pp/le/5yVoWhfjOsBA3B7sQrKmN2Lc6jU3j1LVsYNLshem7k0kyn4Gs1mm5a9EaQfjKJgYXnISIdEz0ycDzdVhUYHTTkfktrmMsdL9dn/Ig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101046;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mI/T5ROJs8elFBTHxKYFGNMmgHI1d3zveSjCBP4h+sc=;
	b=D03StydJsNd0cSJtFcp51/4Iqm14tQIeU+qxkoYUOmozFgeKHc5KLpbJ0IN48mnJ
	MqbSqMgXioY8n9udo9otz/epyVhjIjBPcV6l9pha6fdcHNMWSXEgrC2v4KPXSAQ2nZU
	SRRD+KMU5BdBZNXgcMmAeC5K9NMf5ZIPAqARtA9o=
Received: by mx.zohomail.com with SMTPS id 1740101043632123.4475557336358;
	Thu, 20 Feb 2025 17:24:03 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id CEB621835EA; Fri, 21 Feb 2025 02:23:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V2 0/4] Fix RG35XX Battery Charging Issues
Date: Fri, 21 Feb 2025 02:23:50 +0100
Message-ID: <174010090154.20358.12342040950217986728.b4-ty@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250204155835.161973-1-macroalpha82@gmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External


On Tue, 04 Feb 2025 09:58:30 -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> The Anbernic RG35XX devices sometimes fail to charge when the register
> for the battery temperature sensor is set to the incorrect value either
> by user error or an incorrectly programmed efuse. Allow users to
> hard-code if a temperature sensor is not present (which is the case for
> all Anbernic RGxx series devices) to prevent this issue from causing
> problems. Additionally, a bug was identified with the handling of PMU
> faults while this fix was being tested.
>=20
> [...]

Applied, thanks!

[1/4] dt-bindings: power: supply: axp20x-battery: Add x-powers,no-thermis=
tor
      commit: 626006541069d4d595128f03cc3a1b70a482805c
[3/4] power: supply: axp20x_battery: Update temp sensor for AXP717 from d=
evice tree
      commit: bbcfe510ecd47f2db4c8653c7dfa9dc7a55b1583

Best regards,
--=20
Sebastian Reichel <sebastian.reichel@collabora.com>

