Return-Path: <linux-pm+bounces-21713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646E8A2F3BE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB7E1885EE3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C01F4625;
	Mon, 10 Feb 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epcN3QYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209202580D6;
	Mon, 10 Feb 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205425; cv=none; b=ZdKhL02tpCyZRy09VvRSfnt3Z6qYPqawmGFP8zk/femEvKJxQaPvXqAuhNreCK9Nq8e+ls5Yjw82AuTmY8poVbR81C6/G0R9M3XH1opyhMeOMUASBZymguz8siyRLa4kglmddNKfam0NaDGOaAzd2fuYvsMI9qYxOULAU9LPRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205425; c=relaxed/simple;
	bh=pfpzmuq24TwF+06dco5as3bO4qJhodsYwsIa1AqMl8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Zg9rFP1Sqk6rHUSDxCwavtMIvS7CRO7OTnkEiJxzJd9jbey6qXg4IxiwQlGxfoPAQnbvb3ugVFT0i1cMcU/nhaX2p7DJGahV48rCize1kKdZ/L2VNJTn4f9/xx6FSygNAVGiytyFL4xXBXrL7EZKw4Ye1EJO7yxJsEnHVPF3WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epcN3QYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD7C4CED1;
	Mon, 10 Feb 2025 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205424;
	bh=pfpzmuq24TwF+06dco5as3bO4qJhodsYwsIa1AqMl8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=epcN3QYSWuIIIk/Db2P8XQu5Ddu1B8GmBhUxdkPEutuOrxxm03ixaHdmL1nN/8OEX
	 y2wTb9kXguPvZ6dfwKkkgcqPW57+ZApqinbEsUSF6OLgUdqXHtV4ZHU8zffXA+HnUn
	 mEUAgM1Nyd1RbIKM4HEHV8+TZiLR4SKVDCjn/vtpXmf7Mfs/Mt1eBdt/bHxZix2Ofp
	 PYEeOa8eB+D8kmLs59wxxJNbwm5OIthMBpdmAMKj1VsfWBib2KBDYoLI5+1wbPvjEh
	 fHE0/nVh975H4xkkPJJDqoyXC6PIH0mMhODGZ/Qs6iEkhhShEmXocsOJNmB9e7rZxn
	 1bD/BqEd4jSig==
From: Lee Jones <lee@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Fabien Parent <parent.f@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
In-Reply-To: <20241226050205.30241-5-val@packett.cool>
References: <20241226050205.30241-1-val@packett.cool>
 <20241226050205.30241-5-val@packett.cool>
Subject: Re: (subset) [PATCH 4/9] mfd: mt6397: Add support for MT6392 pmic
Message-Id: <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 16:36:59 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 26 Dec 2024 01:58:04 -0300, Val Packett wrote:
> Update the MT6397 MFD driver to support the MT6392 PMIC.
> 
> 

Applied, thanks!

[4/9] mfd: mt6397: Add support for MT6392 pmic
      commit: 896b1eb4ca771b37ea50feb4d90a78dd4e9cb388

--
Lee Jones [李琼斯]


