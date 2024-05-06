Return-Path: <linux-pm+bounces-7542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A378BD1A9
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A11B21B80
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF21553B5;
	Mon,  6 May 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="R5tsKIYp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlKmFDYO"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721F2F2C;
	Mon,  6 May 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010074; cv=none; b=saOqjIrfElvDZ+UZdvn2W9FI/2ognUwJXlsDKsle7b89JfnliTxUbUZEQqfEaIA961tq2S23HwxAcOSzvUYOyHQKwNJpNT97x5awF5xH98M6oAMnS6tOzg/eNyKyrfGjHwQ33YuWAse1/NUoEFYyGdzDUJ9q8BJGIYhPFe6PngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010074; c=relaxed/simple;
	bh=jI6SxOagfPNkn94GUtgsL+r4GdG+O/p6tWlm3rf/lSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foygHNcdICs0IFjlyJ4z5QRIkYGkrox9yXg5Vafk9FgB7d3uAry6GjUghtGJXbowy1R2Ex2ilDCCAaE0QB7fD6doIHqb2mvmLgj7EzAoA3i6S7giVpEA5XaZCUNPTPNHiUsHaUtDfEebMmBRp3dioyK/qp5MVr2nSDZKFMOsq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=R5tsKIYp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlKmFDYO; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id BEB451C0017F;
	Mon,  6 May 2024 11:41:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 11:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1715010071;
	 x=1715096471; bh=AnaIrqFtCLoxaszuMPc1kk1SeqBriwcNO4quGAr4XLw=; b=
	R5tsKIYp5YkOb3bIFjsE0vfu6knQkvcTQAOJvSMQS6Q/aHXj+tVOXCrU3Z7TeFve
	2mhEZKZMNz94QjaB77FmbIpkblcXesvcnb3EiErXelOio/ijEQyxEQ0R33jheYYV
	RIX/7D/FIsuI6RuLKCE87XFa06W7KW1VPD/L/fkFSxELIxKotCJsPU57medMZj4B
	AfNRvdASWccSOD7AlG6Ks1JD54QQmKQwgQdyjru5xBYcJ8ADJ5HVhgZ9XrlcFblP
	dBS1ggm5E+MEMQ8NQKo4ybjGpgGqTvpZpWgEDgSEOqXV1WyrQVWhRN7DgocgSKL/
	qaaxMrAtaweJkYA6HvOzvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715010071; x=
	1715096471; bh=AnaIrqFtCLoxaszuMPc1kk1SeqBriwcNO4quGAr4XLw=; b=F
	lKmFDYO2AKnXy555/IQUxmm3AoRbAcQlhhc8DCfnlUoD+m9Jw/uX1WibcrluDQtp
	uYlTIE8sHTwGRkGmhLnD2nNamdd4N3g9PNh/mVNZS0zb13OhWmJGb3acyqjaJJTR
	adBt6DrMryofh0n6xYO3kHc1tjj44l53B/oTH35oK1u1iFnphnOQlF9SCGvR6Ysc
	RDxVywtHotSIUoW5i1CVpXI8EDzrLA6uFtiww64L6DKSVsVI6FmSAHOsq51yq2Du
	lA10rytnGKb9+liosqox2jUBFa2PhRg9BNRCWNTzbhcMf7GdnVQuGXLsA5z6gbrx
	0/kWre4/uAxwK0+UyQTgQ==
X-ME-Sender: <xms:F_o4Zp_h6qxFL3R3M-m-W7fHha38NDrPUkn68qYTe5o3fA9-bZFbWw>
    <xme:F_o4ZtsGQc_r2qPH734f3fdByXsI0gqyPhz76FN5NF5sg8jSPCZxiPhbWHQbQ-qmb
    1_mSDIm4ux5EvW5z_M>
X-ME-Received: <xmr:F_o4ZnAFHd49uHGxF-qMT7_M8VSMlbv2pbrVlmKRBxvDhanNJU4iM-TveOuEJ-HIoi6gVevG-esxDHpbl_MNGG91vCHG-PZNtIGB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeehiefgueev
    uedtfefhheegkeevtdelueeukeevfeduhefhhfejfffggeffleefgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:F_o4ZtdcYQ1uvT6p3voRKOmoPc2XjZvf9i6cyIJSmq1mbXUdFCz8PA>
    <xmx:F_o4ZuN1VXDCgTnOepOw-5sdOv577l0euKpq83zSxf5JC-OKlBB5JQ>
    <xmx:F_o4Zvm_d6Q8CJS0rRBfSBbFDP6l41uL6iqoK-RtxMlmZNpvdsvkzw>
    <xmx:F_o4ZosEoPfUrMZJwyx-kfnMrT_3tSyEqJRwgZP6y_rF-ZnqBuoNnw>
    <xmx:F_o4Zvgp2E0LaRY1HL68mmdXht8zWMoCh5efEZZ3Uu-vklQ6d84yptUN>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:41:10 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 2/2] thermal: renesas: rcar: Add dependency on OF
Date: Mon,  6 May 2024 17:40:11 +0200
Message-ID: <20240506154011.344324-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
References: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The R-Car thermal driver depends on OF, describe this.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index 1be65a03d290..dcf5fc5ae08e 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -4,6 +4,7 @@ config RCAR_THERMAL
 	tristate "Renesas R-Car thermal driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on OF
 	help
 	  Enable this to plug the R-Car thermal sensor driver into the Linux
 	  thermal framework.
-- 
2.45.0


