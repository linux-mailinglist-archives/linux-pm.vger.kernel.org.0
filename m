Return-Path: <linux-pm+bounces-29950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE682AF0AB4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78180443A33
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9A1CF7AF;
	Wed,  2 Jul 2025 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="YQtF32II"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D6E10F9;
	Wed,  2 Jul 2025 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434059; cv=none; b=Hl8tN7fiIMWG7V/MKmC9uNDLmWpbTZDjeN8CMwzvzB8/mR46QgK0zgkkRQiXnF1x3pW6byEJTkkqXJa3ObDZvILpjPWY52GppaNI7UXNoF4iljSahBDU6OIpP4TTsdBtS+xNrMcBAFSj/N1JsiN8YY8OZFgejXHB0Z4SYH8QMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434059; c=relaxed/simple;
	bh=snNUAsnORcKOYh9hKd9fSgC1zweCJ39RM4mwSSIpfc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a2jkYeJb5JN7/uUTR3CLpvVAfvoYFluqI+mq/LkXiZDQIsfOPSU1FN3q9nG4wIMKizZJxfe2tvVX9d/d7rejDK2VPCcSstXMMaWsluOc9NAiuwLNAVsWiEcIZ0kKfBA6DUYxVuv1GA0Vm6hXRIX3xvVMuvmej6JqDelZrdNFSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=YQtF32II; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1751434019; x=1752038819; i=frank-w@public-files.de;
	bh=ocX+LiR9BtypRDOe9giWuZ6zdLW4XcmiYNpdeZQm2ws=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YQtF32IIGW1bOIhg/DGGFGZbk++Yq3n5VM1OhIjZgh9ILMQqSVF4TmRQVcWg2RGR
	 Oq3pSuhaDly5IghK1NeTXez4Oo0/XJ0JzHhfg/CJE6fod1fsAGwg34COavNQzEzhj
	 tkJF3NI2z5U+KZJf/+JkzwGIRm0v1cU3o2ORmuyYxFKEZ66YwNXVP1o5p6v+RWS2K
	 eWcsQ0F3QPAOxk4/fzUIGGgfFJqEn/e5DIHvdwcVB2SIPx/eraW4KSZT6LO8h0+4K
	 HYNF/YW6bU7WolpJhkVS5HdpsGu2GFA/Kqm7LOLUx9VYlDclz7ukV4bf9ywR8uSLy
	 UTNwa/ekcFrhbVrAfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([194.15.85.168]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1uD1xL1XCK-00PXM7; Wed, 02
 Jul 2025 07:26:59 +0200
Date: Wed, 02 Jul 2025 07:26:52 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <linux@fw-web.de>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Johnson Wang <johnson.wang@mediatek.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 00/14] further mt7988 devicetree work
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20250628165451.85884-1-linux@fw-web.de>
References: <20250628165451.85884-1-linux@fw-web.de>
Message-ID: <41FC3305-F6B9-4EBF-BC26-0203A7F3329E@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+0ij2U4Sm1jTDlnh1aeuBvKJA+kgKHBWGyfwk5h8SLM8bOL5I+b
 urRm0KZG1vEjPM3lmK/DKQtdzqxf6yJmNBy9coNRFfmn0VihR74jyuyoebpSLYzFy1v+v3u
 vSznWJtdRDX4jentQ7yg63BjAtKB8yMXmkZY5DB1xcRhpRU2e/B3BuVKEM9Ytrk0ItKBqMo
 GgUWENJ4VwIVQTFp5HkSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nq+lDfMhpeQ=;aBgJLF/kLqYk+izV8BvM8GZXlux
 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


>Frank Wunderlich (14):
=2E=2E=2E
>  dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
>    mt7988
>  dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
>  dt-bindings: interconnect: add mt7988-cci compatible
>  arm64: dts: mediatek: mt7988: add cci node
=2E=2E=2E
>  arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
>  arm64: dts: mediatek: mt7988a-bpi-r4: drop unused pins
>  arm64: dts: mediatek: mt7988a-bpi-r4: add gpio leds
=2E=2E=2E

Hi Angelo,

Maybe you can take the already reviewed
patches (except exthernet + switch) so i do
not need to resend them again and again
and spam people too much because of the
ethernet binding changes?
regards Frank

