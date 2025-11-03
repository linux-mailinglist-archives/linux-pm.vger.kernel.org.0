Return-Path: <linux-pm+bounces-37278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB4C29BA8
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B74188FDEB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A323184F;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A0221FA0;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130921; cv=none; b=l88t7ZEKOUx9fJ42vXnrjfdcaUCOHNt6IsgSKCBYUpffyiE2DU/Hrl0SGcoCwQJGNBvofWAnZ87jFLThxOzgJ/PG/5XR9ihnfqBrIkQz6V+qJTgO46W9HUVj9Trde/8/DypfLPqP84xQLzH24Wj/yqt4UAyebBeKwjj8kWjU4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130921; c=relaxed/simple;
	bh=frGOQD20OIB0FLKp2HLEg73Jo/9xWaklNYdCEqESRDw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rX0pBYQpqT56ZKdgwjQev0MuEteeu+aBPMdTToPCiTYNF2KYyB02KvWEkBUS5HSBQ64O1llUWjeR0HvXUZIo32eI9dttaRhNFyIo+ZKkFjdwRhWZLRkJHIPaID4b0+MEEJqQJ3y3QFYbChsmqHqhbYb6H9b8Uf+sgFIxOLpNrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE54C116B1;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 59CEF1822D6; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Val Packett <val@packett.cool>
In-Reply-To: <20251012233333.19144-2-val@packett.cool>
References: <20251012233333.19144-2-val@packett.cool>
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge
 control threshold handling
Message-Id: <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 12 Oct 2025 20:32:17 -0300, Val Packett wrote:
> Currently, upowerd is unable to turn off the battery preservation mode[1]
> on Qualcomm laptops, because it does that by setting the start threshold to
> zero and the driver returns an error:
> 
> pmic_glink.power-supply.0: charge control start threshold exceed range: [50 - 95]
> 
> Kernel documentation says the end threshold must be clamped[2] but does
> not say anything about the start threshold.
> 
> [...]

Applied, thanks!

[1/2] power: supply: qcom_battmgr: clamp charge control thresholds
      commit: 8809980fdc8a86070667032fa4005ee83f1c62f3
[2/2] power: supply: qcom_battmgr: support disabling charge control
      commit: 446fcf494691da4e685923e5fad02b163955fc0e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


