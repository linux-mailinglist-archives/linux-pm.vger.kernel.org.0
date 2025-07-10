Return-Path: <linux-pm+bounces-30598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E158DB006B3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D482F7BB618
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED432749C5;
	Thu, 10 Jul 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="A2wOi/xc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxRLLAa5"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075751022;
	Thu, 10 Jul 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161490; cv=none; b=O87QTO2W+OfrMBU37YucJ8G7IHqi4XBAS4DjQ7CjXHNBYwTC7Bmmp6gKfmvjS+fG3E4We/sWXkW0n2NGXuf/ezVcvr6X5z2K3YEO54oxucNBp5WTa222uVlxZOox90dsOB0yRG0zi4viNirEvemOO4RGqfS9EReNJdlHM1++w6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161490; c=relaxed/simple;
	bh=VScMit7hJDrzXhm+1UCsmFtiYQl9q5GZBwN1l1xqrTY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fi9PJyf6qpPn4qMXtOJ7F9oTqmz2jxhmE8cFv51yfOd2DxT/6DIY1R2MfSShZblXoeITCfCEeSX/zaDf8nzKgdjaCnZmQvOiYEF8jeuFAN+IQB2lC/OntpWdQqAwBJHs9eH2v/HMA226csb9OWdpnztOYHPs7hpkLowdTa/EcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=A2wOi/xc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxRLLAa5; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id A0512138088B;
	Thu, 10 Jul 2025 11:31:27 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 11:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752161487;
	 x=1752168687; bh=5jUrj7wF3tavgxp+A5jwXCoLfMB42CDUTngvpZIfCEg=; b=
	A2wOi/xcujkvYBDuXdJ6U03+pk5ApP+/Hm/U/bksQZ8pDLCmaN67aFv86rPTY//U
	Z8bgIfq1M7+EheJyEg7zsw0Ex6PtqkzDizZlY8kA0adxBHkfmaU1cGR1PisEMgg3
	8R7UrRdoED/gno3b06oqvbTM387+MdLZNeRv5OQBtE4q9PXqZyKKnsWiagr2oyqE
	+aMEYnXtP25I33oS03keTsJQ5R8QP+EPkPiWYI3PSN7NXJ9S6FsNMYvMOaKt1E+v
	VH/qbkzBDwataCovfwgZJLjSwrU1GqJ1vhSdhcbHOKQOaM3feQayJ14jbZN0gnby
	rEDw2pskXjBdVEp+hQaGXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752161487; x=
	1752168687; bh=5jUrj7wF3tavgxp+A5jwXCoLfMB42CDUTngvpZIfCEg=; b=V
	xRLLAa5ftf+/djbxIIVOUy2swEyflfr3Wcm2xm/8CwXlxUoXOpc0KzUs8z4IyyRy
	pGfFcb5Wce+Kc6aU4WS9rcTeLeMXXuwzom+MJ3E9b4ewtDhA4fxfAHslq02++Irs
	0LuPx9rmezi33WrB+MEH/cD3APAk4r7g3Hc96UqkSR6KFWjz6JxHPXOOU1luGPOK
	hCnzm6i/aUsup8Nntrrr39yIPdKC5NgfrCp8CJMwWjGvZQMedzNysb5v7J8R2+pL
	U/cdO/RagGlMy/Ixs8sMvkcBD5sW2C1Z+kDz+tuDFMaaeHYKxRGpK07Oa9VteDpc
	ytWK8XAqBBnSV937C+8tg==
X-ME-Sender: <xms:ztxvaFNAGKUtZYu0N0KswtdhzYu9hwECN7nxcxY-T6VSzpvuTyEaRw>
    <xme:ztxvaH8RmKMiSTLTrDr7gJ7XaUj_THd32LQ6bIsEYqhbDGqPaskN4O5Hpnhj_cyZX
    zLCrJIjn_hQibphM1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeggedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhouhhvihhkrdgthhgrkhhrrghvrghrthihsegrrhhmrdgtohhmpd
    hrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphht
    thhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehsuhguvg
    gvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdgs
    vghllhhonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvg
    hlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthho
    pehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpth
    htoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggv
    nhessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:ztxvaGbWoEZX-jk02l6nq6Gdvxu83FSgJw40RBJ42ld8yVenI52dJQ>
    <xmx:ztxvaJlyzHXcEXeq23SY4u6B2KyNd-Tcm8UNaFkwXQ-mQggE2ph3CA>
    <xmx:ztxvaKeqrVbRXKgS8wSLnfhRu7YRyyTfY72Vcu15REjOLED9qjwESQ>
    <xmx:ztxvaHtoD0nD09FEd_Lwgvqo8rkTybTh9k9K3EdLk8OoVO0qFn69Sg>
    <xmx:z9xvaEme0p3s8p10qmBksY9jW3laeiHuQoNAU0zOy2kW07cPWmZzTgOu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C4A3700069; Thu, 10 Jul 2025 11:31:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T17e904bff5b9beaf
Date: Thu, 10 Jul 2025 17:30:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Shivendra Pratap" <shivendra.pratap@oss.qualcomm.com>,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Sebastian Reichel" <sre@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Souvik Chakravarty" <Souvik.Chakravarty@arm.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Olof Johansson" <olof@lixom.net>, "Konrad Dybcio" <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, "Vinod Koul" <vkoul@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Elliot Berman" <elliotb317@gmail.com>
Cc: "Stephen Boyd" <swboyd@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 linux-samsung-soc@vger.kernel.org, "Wei Xu" <xuwei5@hisilicon.com>,
 linux-rockchip@lists.infradead.org,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Sen Chu" <sen.chu@mediatek.com>, "Sean Wang" <sean.wang@mediatek.com>,
 "Macpaul Lin" <macpaul.lin@mediatek.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Ray Jui" <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Elliot Berman" <quic_eberman@quicinc.com>,
 "Srinivas Kandagatla" <srini@kernel.org>,
 "Elliot Berman" <elliot.berman@oss.qualcomm.com>
Message-Id: <2d8e17ad-6bd6-47a9-b5ab-0a91689684ee@app.fastmail.com>
In-Reply-To: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-4-b2d3b882be85@oss.qualcomm.com>
References: 
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-4-b2d3b882be85@oss.qualcomm.com>
Subject: Re: [PATCH v10 04/10] dt-bindings: arm: Document reboot mode magic
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 11:15, Shivendra Pratap wrote:

> +  reset-types:
> +    type: object
> +    $ref: /schemas/power/reset/reboot-mode.yaml#

The other users of the reboot-mode.yaml binding all call this
node 'reboot-mode' instead of 'reset-types', can you change that
here for consistency?

     Arnd

