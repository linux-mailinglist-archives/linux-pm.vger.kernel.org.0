Return-Path: <linux-pm+bounces-19210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6379F151E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDDA1641B9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA91E570E;
	Fri, 13 Dec 2024 18:43:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD31EBA09;
	Fri, 13 Dec 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115423; cv=none; b=dWYaIO/MxwPlSt/FvsF1qDN2pl2HInFKpumq/KI8tWGjXbU9J2JdaF+iK88CBQTiKapiDsKIxZLIs5jNAstrKSNttyeSJ5Zko0+/wjgqU+UdZTJdF89mekALG9SuHC1ac81nqWKJ04ZCrdQ/AVQEWakZBg88bTmoI+kQCre+pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115423; c=relaxed/simple;
	bh=bGvIfd5AOwNuYD6zFLGtCpri6iQsOsGEZFDvNR2wATs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nHPuGx1SD2ozzDZFXqwa7snBxB1Vn4AwpP39GNlMDDHtxEoUyud20Wy58yxwfVkBfm8M5qSLAuk9otMchsdVi8YGpbBDf/N0RzFYZtphx5LowCrR6cTcu/TcWMq+pUhzodj4EIcnTd6wBitTvtP+9WOdUMf+DvPsJg8Y9MW8/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01963C4CED0;
	Fri, 13 Dec 2024 18:43:40 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2016410604D3; Fri, 13 Dec 2024 19:43:38 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mike Looijmans <mike.looijmans@topic.nl>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241213023746.34168-1-kimseer.paller@analog.com>
References: <20241213023746.34168-1-kimseer.paller@analog.com>
Subject: Re: [PATCH v6 0/2] Add support for ltc4162-f/s and ltc4015
Message-Id: <173411541807.2640994.986756810907074368.b4-ty@collabora.com>
Date: Fri, 13 Dec 2024 19:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Dec 2024 10:37:44 +0800, Kim Seer Paller wrote:
> This patch series adds support for:
>   * LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
>   * LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
>   * LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller
> 
> The LTC4162-L/F/S variants and LTC4015 share a common set of registers. The
> difference lies in the resolution value of the scaling factor for battery
> voltage and battery current measurement, input voltage, and input current for
> different battery chemistries. The difference also includes the calculation of
> setting and getting the actual voltage setting applied to the charge voltage,
> as well as getting the die temperature.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
      commit: 649399c5dad9cd7a42fe7eb8a32c31627d35492d
[2/2] power/supply: Add support for ltc4162-f/s and ltc4015
      commit: 57e5a9a85bd03d8cc4992cb2e15ca23450e016c4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


