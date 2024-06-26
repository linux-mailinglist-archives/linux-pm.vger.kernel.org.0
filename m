Return-Path: <linux-pm+bounces-10053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70149918365
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096C71F211D4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B01836FD;
	Wed, 26 Jun 2024 13:54:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EE172BC6;
	Wed, 26 Jun 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410097; cv=none; b=X77XuqFeKivg73l2fmlR4EUe8gIjeG+60P17Edc2FO6JiybD6ipCIjRuYpIxLIBIBnH+CC/2PEElM+a6+3edI7cZ6iSkUUKM5FJPkcEHUkMHQ4yCRbxvPmM+l7bNR/40nwq3jKOHQnUGvJW6mL1w4zRXfWzEQ3Tm6lE0AQk9UhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410097; c=relaxed/simple;
	bh=illcVS1LrOEXY7ndoClkkVJaDfRukdDd1qOy0AN4TVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EAIful98Td8ycguy3qTpyzy+uR/ZBbavcJzEFUckTvKIaxm/MH+ZR/LWFNC+0q+z+7d6//rMRZQ4BzVN3ecB+oRcGOboluVv1fqDEqOt2S4/YjHu+p0ACEpPJTdvbO1MV5JwQQNiZkt1gbcd84E4BBuv2Gtx9XEBPdTkjvk8jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5740C2BD10;
	Wed, 26 Jun 2024 13:54:56 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B04F2106093E; Wed, 26 Jun 2024 15:54:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240621-yoga-ec-driver-v8-1-daae67d0233d@linaro.org>
References: <20240621-yoga-ec-driver-v8-1-daae67d0233d@linaro.org>
Subject: Re: [PATCH v8] power: supply: lenovo_yoga_c630_battery: add Lenovo
 C630 driver
Message-Id: <171941009471.143534.10357402533490651564.b4-ty@collabora.com>
Date: Wed, 26 Jun 2024 15:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 21 Jun 2024 01:23:51 +0300, Dmitry Baryshkov wrote:
> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
> 
> 

Applied, thanks!

[1/1] power: supply: lenovo_yoga_c630_battery: add Lenovo C630 driver
      commit: db9cc848128eb174b24a5dff82fc3e7589a3bf25

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


