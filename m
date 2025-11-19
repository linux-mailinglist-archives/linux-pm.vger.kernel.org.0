Return-Path: <linux-pm+bounces-38217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30CC6E7E9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 13:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AC8E62450D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FA3624A8;
	Wed, 19 Nov 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="f/UovCGv"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339A35A135;
	Wed, 19 Nov 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555479; cv=pass; b=I8XzQkYfzLaD9xjdikbY758P9IMdgX9cfcQAkDK5ZhmeDPVnJ3perzlQbLRkoGXuCbxqcVaIHqNrwHhzJAgIiLdOS90Mer69DAwBXDtpdLPefd0tmd32FeX/qi0g14yHRzMT3CZCrc0Z1mrYP84IAoT/UsAyZoXjhlnncGJ6S4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555479; c=relaxed/simple;
	bh=RwzbdKhF9q2olt3ISTTZiJ9qgI/iDDN9aNM/2T/o93g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCSVnEpzCZzCweOfpfOpSQ3OasZloulku/zgeRvRcEQTIb+D/03V+VwCN8/kqFQ4VgayXaW2lTfL8m3HfU9lwXXtGiXebTvkYdWPFB0iTCpCDU9bYXpVt0VdyKx+oWrMDCY+Mks9huCtt3TC9wkMd4ORv2OJk3MWAfJjMZC8b60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=f/UovCGv; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763555436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FC4abtollYWOgCHR45tp6BsnT0GYBa95NDLQTbL3rTPaBYcF7ElHnPq0/Vo7d6ZbhbfZvPN/NPCjtgTS8dp8tuil9CzT2Mh0qMtDZzNs+Tg6XmqOoMLk4d1phdEEVgmyMiPeanLMuGG72yWmxXCK8n5vM2XgaEGtCZDtOPbOOOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763555436; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAYEP2r0WzK6nN8V/KKyYF/p300y06zU2QmA3CuygYs=; 
	b=GmuCVkRZplgBfn2RXT9Zuk3sJ1unPMzdYglgeBL4jeZ1fARwB8eJ7U+BWpuaGm3CkXQnOzYE4B/hg14r1DYsLJKDw+0ixPUQrineuzBLl4FGwMYd6qgdIkPGExNgxn6IreVDSCVyUoPM1M+5zfdwyYE8DsjdPI2SpNAptZEs1N8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763555436;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=gAYEP2r0WzK6nN8V/KKyYF/p300y06zU2QmA3CuygYs=;
	b=f/UovCGvoeUVLBCFJ4LULHK017R9K0yHbePE4VHXb+nafPB6OGYBiG2GtyMkYelz
	hm0rBqrAoXPAgj/cRbgjWbOlAopc43TUl9+Lu5c2DMGtKODY5BdGbCxndaLzL+Y20iu
	IFH/KnxHkHJ1sia5DrDMdyngSTrNJ1qXpAzyNUlE=
Received: by mx.zohomail.com with SMTPS id 1763555434772176.03240313540152;
	Wed, 19 Nov 2025 04:30:34 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 01/13] dt-bindings: soc: mediatek: dvfsrc: Add support for MT8196
Date: Wed, 19 Nov 2025 13:29:12 +0100
Message-ID: <3772660.mvXUDI8C0e@workhorse>
In-Reply-To: <39fba430-3841-4bf2-9fe7-44f372ff4a16@collabora.com>
References:
 <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
 <20251119-alluring-jellyfish-of-chaos-4f5bd8@kuoka>
 <39fba430-3841-4bf2-9fe7-44f372ff4a16@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 19 November 2025 09:32:46 Central European Standard Time AngeloGioacchino Del Regno wrote:
> Il 19/11/25 08:41, Krzysztof Kozlowski ha scritto:
> > On Fri, Nov 14, 2025 at 05:53:55PM +0100, Nicolas Frattaroli wrote:
> >> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>
> >> Add a compatible for the MediaTek MT8196 Chromebook SoC's
> >> DVFSRC hardware, introducing capability to communicate with it.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > 
> > Incomplete DCO chain.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Eh yes, Nicolas forgot to add his SoC on all of my commits, whoops :-)
> 
> Cheers,
> Angelo
> 

And here I hoped b4 would do that when sending these out, oh well.




