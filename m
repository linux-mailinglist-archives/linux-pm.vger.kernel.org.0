Return-Path: <linux-pm+bounces-34930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D0BB8239D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721516261C3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 23:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15B3101BA;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5B286D62;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150220; cv=none; b=i1qyZ1Q4xGDt1gdSazgsdW82J4XobmFCwJm6hWYhEyMGB8/di7cctxX/uA5v3CdpA3M96hrsJQRN6XNOkJejdrjsDf9EL6dmQKXD7sxC+MjHGnMs7qkVkdkWX5KGZaixFIdhTbtA8m/jtpFICt7UbLmuzCSsIuhONOcb25d8ZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150220; c=relaxed/simple;
	bh=9CtECTK0SVX0Fkdz1HxUIBD2ZUopRnHEfxtXI//qLEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OL5unzy4YTMd92n7snSibY90Lpod2gLOyx9zpgISuyTarpSxNTADhJ4nzUBNZQAzxtrK+PYYjTBV0Mvl7qMUSmgEdez5qdRO3OOzL/IFrSX5sNfNv9XkZ/eY+0kFhr/hO7pAOloLtYvB0iuoldBDA5UofFjWpUn0bW0WjMVuICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306F6C4CEF9;
	Wed, 17 Sep 2025 23:03:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 65042180680; Thu, 18 Sep 2025 01:03:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912065146.28059-1-clamor95@gmail.com>
References: <20250912065146.28059-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document
 charge enable pin
Message-Id: <175815021840.129824.12179531235914960284.b4-ty@collabora.com>
Date: Thu, 18 Sep 2025 01:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 12 Sep 2025 09:51:45 +0300, Svyatoslav Ryhel wrote:
> Document active low Charge Enable pin. Battery charging is enabled when
> REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.
> 
> Svyatoslav Ryhel (1):
>   dt-bindings: power: supply: bq24190: document charge enable pin
> 
> Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: power: supply: bq24190: document charge enable pin
      commit: c3a45c5fde95d319125812f629c579cc63c69941

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


