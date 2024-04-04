Return-Path: <linux-pm+bounces-5908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607DE898258
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E7B286FF4
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE35B1F6;
	Thu,  4 Apr 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="bniGJiMB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUua5pCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC881F95E;
	Thu,  4 Apr 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216669; cv=none; b=ZKah+WLq/BohlfQYYI22rWHz/2WWYysck/43DcQjYEbdtHKWnM9FTtsqaaVwChkQeaxcnjFKhOkGOBo7Zfwg5cLspfu9z5Alrfffz9gj3bnXyzb9D9f24KxrtaSlYQeGHoybwlEhC3mUq03n3Ohts3omDdRiaS02Q9oA8syzhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216669; c=relaxed/simple;
	bh=W+Dq4jP2nVCkMiWd/KQ2w2Am8sgtY95tm7jMKgnkLiM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=TiRWkUquCRmQk47btvlD18slygUFs7cgIJUvCtjlHNXhEXjeFCRVkRYLPZ6qBeN3r67Px2q2+kyprkoBmZWyWLk6rkZVfqcxvLiULi7LAO2Sjw6pos6ypGmJXpHIiVZxBPmEKjJfKIe/e7c09NIzo7qY1QhqTuE1U5zMf/qaK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=bniGJiMB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUua5pCw; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 79AE01C000F8;
	Thu,  4 Apr 2024 03:44:24 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 03:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1712216663; x=
	1712303063; bh=W+Dq4jP2nVCkMiWd/KQ2w2Am8sgtY95tm7jMKgnkLiM=; b=b
	niGJiMBXGZvMdyWBsZkpW1LR1J8qhwtttfcMzoZUwg2Sq+lVz+Auv9bQ/AuanVTG
	MZDF46JFdeb7OqKv/3N0c+OPX6KhwYFihR5xYfG3Xxx+RQlnRzOZ/xRCCfM9jatk
	+OOlbCTH7/QAOhmz5VVHUc76KpyAeS1Ky/WiFJ+YhZd2AQ/9MHE5P2wYksAgQmqv
	bixoGj2xyylKY+uQbGpIFPvje1RPF5BnNfCBK+8DAKghxkadMNjLV/0H+oBBr33b
	nZjXFT5cSz8633xOeUJGoEAkhXRvE258SrGZRCZ9deRIiNdSLCVjPiaL8UAdr9DZ
	pqLfy0lXHZerRFvLNNUvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712216663; x=1712303063; bh=W+Dq4jP2nVCkMiWd/KQ2w2Am8sgt
	Y95tm7jMKgnkLiM=; b=dUua5pCwDb/WRGEFgAh40ue0FHjf/NeeTRtxBN/qfe5S
	+yXV5em8pW8uM3fCTTHASxMvYCXZm/mEbmGObfYk7vVVNfFsnUVEnv5PkklTgNV9
	mxoTnD8IrV8TDzSLSg6XrEjZSY/HLgN535LKdj8mTiP5lPdQqDJaLmTDTVVLVON4
	oU4L9qNw+QRlQoyaK1DJd9Cu3Q4hjU0WtcJcn6ei0G5e/M4H40uguuGS71v+S8JC
	rcmhBpMV0pVvpftyeEF0t1qF57YIjFesD3Sf1TTDDnpJZ7qVH5LML+xTmt7mqZh9
	Y/vpxe3xgE2vhN/t+a7ZkuUblPHJVrfFdZsafaMfBQ==
X-ME-Sender: <xms:V1oOZpoDsQlFB93kR6lIu9Gld6YmV43uwXzUlxhZMNzv9aXbod0SBA>
    <xme:V1oOZroAiU8D6oTcfHGgF5vFlESySQr47pEhYDxY4ebEiiuEEHB6Q6mIEcbArYsn8
    W-IeT3aN1cwJ42ZzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdft
    higrnhcuhggrlhhklhhinhdfuceorhihrghnsehtvghsthhtohgrshhtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehvdevieegudejueefgeffhefhffevudfhieejgfdtffetlefg
    teeuveeiudeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrhigrnhesthgvshhtthhorghsthdrtghomh
X-ME-Proxy: <xmx:V1oOZmPD1OKeb8OBrS2njTLd3J8UTugBUy4mq4H5H5Aw9PtGtBWgEw>
    <xmx:V1oOZk6PSfom6uVB4LYFJ7VO5bksTBEXNFPpudaVfwz82PN2VsnSdg>
    <xmx:V1oOZo7cPaRW2zBto_u0K7tIjJQj5kdvLh_8bL8owfNV1fEpPXhx_Q>
    <xmx:V1oOZsgYTXq7J_J16aVvvJ8paj2lNOK_1_d1ylD8wwCeCA8fR6yMYg>
    <xmx:V1oOZgoTCDUm6dzFrgQA9jS-A6hMN6f9N6ALqUr4lhVDslEiVvs25VHm>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2CE0EA60078; Thu,  4 Apr 2024 03:44:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e021133-f8c1-457d-9079-d9c972e0e69b@app.fastmail.com>
In-Reply-To: <20240404064027.shjqvqih7s5rnv2i@vireshk-i7>
References: <20240329141311.27158-1-andre.przywara@arm.com>
 <20240404064027.shjqvqih7s5rnv2i@vireshk-i7>
Date: Thu, 04 Apr 2024 20:44:02 +1300
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Andre Przywara" <andre.przywara@arm.com>
Cc: "Yangtao Li" <tiny.windzz@gmail.com>, "Viresh Kumar" <vireshk@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@csie.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 "Brandon Cheo Fusi" <fusibrandon13@gmail.com>,
 "Martin Botka" <martin.botka@somainline.org>,
 "Martin Botka" <martin.botka1@gmail.com>,
 "Chris Morgan" <macroalpha82@gmail.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 0/8] cpufreq: sun50i: Add Allwinner H616 support
Content-Type: text/plain

On Thu, 4 Apr 2024, at 7:40 PM, Viresh Kumar wrote:
> Is it okay to merge all the changes via the cpufreq tree ?

I have tested this series with an H700-based board, and have at least one speed-bin (1.032GHz) is not supported although the governor attempts to enable it based on the opp-supported-hw bitmask, and I am unable to reach the 1.5GHz bin at 1.16v (or higher) despite it working on the vendor BSP (kernel panic at boot if enabled), so this may need some slight rework.

I have reached out to Andre on IRC to debug.

Ryan

