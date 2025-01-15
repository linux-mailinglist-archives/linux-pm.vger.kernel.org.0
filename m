Return-Path: <linux-pm+bounces-20509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292CA12D65
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE573A262F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7141DC075;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFB1DB55C;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975335; cv=none; b=erjg1Nb83Ep+LL7Sn9mMd2cdfYRfet+lCzrfy0nf5FmC8BKF8yDeWXTkmrl0KWh9HAjNrRXEFs5egSAnEjmizfFTQoz4RK5J733VGZId4ELVE7vNkqbD+vIZmi6XYN4qjbtV8bzx2emLi7Hzx01ajOCf6T6bXD13wKebY3J5etM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975335; c=relaxed/simple;
	bh=GnH4ZUcA/sCwuS7PTVZS2oqb19EZjaPuc4kPRxXcaHI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5e2SL5JlHUQZho3bBTiYLH5mrYTAymfFwMMs96qray6wgKrnUFBbLh9Ovn9I3leqHIPlPBjnk73IHIBYPB7zk8ZeJBpXBOJC8f96qszAoCifIUFZ4Fi+5ieIWQx1VmBiWZ3y5Lc0bRaMyglAK/e9cog34sdajWO7rlF71HAzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C43FC4CED1;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 215D61060353; Wed, 15 Jan 2025 22:08:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
References: <20250107-b4-max17042-v6-0-3d0104ad5bc7@gmail.com>
Subject: Re: [PATCH v6 0/2] power: supply: max17042: cleanup and more
 features
Message-Id: <173697533312.451358.11039936801510899973.b4-ty@collabora.com>
Date: Wed, 15 Jan 2025 22:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 07 Jan 2025 12:31:29 +0300, Dzmitry Sankouski wrote:
> Fuelgauge blocks often are incorporated in bigger chip,
> which may use only 1 line for interrupts. Shared-irq
> handles that case by requesting irq as shared.
> 
> Maxim PMICs may include fuel gauge with additional features, which is
> out of single Linux power supply driver scope.
> 
> [...]

Applied, thanks!

[1/2] power: supply: max17042: make interrupt shared
      commit: bed41f08e222efb6f77a3a68e847b7a1ad994e62
[2/2] power: supply: max17042: add platform driver variant
      commit: 0cd4f1f77ad4f021cd56aad00c1914583c3ddf3c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


