Return-Path: <linux-pm+bounces-19467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD099F70D6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9997A28B3
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8421FC7E3;
	Wed, 18 Dec 2024 23:36:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCF19CCEC;
	Wed, 18 Dec 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565013; cv=none; b=XdQehd+ELcnybFRULWyTX4bKwg2cmiB9oihwsRBkwIQYizZAJZPpGmtCXAlMgKw4QUJPldf19WYjSw/zI4IJtqUcK8cwQSM1+HZCAnSwTM/Qao3Bxwnwppz0N8GyeUBfaXjqaugRmPRhlQzexXoC+bH3TqszZNG+IuKIjIZLoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565013; c=relaxed/simple;
	bh=JRqMwUt13IUZIdFgku1ZTHb7PBdzVVQLWSjal1NN3HQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RONa1OEPej3U5saKGSEUr/kaUlv6ATiup2NoFqcw/MPOODhWFRVpR+4BZpT3eyTTTVT17HpTdutHfoZXfWqcHuFfTUkP8ZnaDr6QkHSXUMlTWB3vVKg8lEWKE3194XfYcaehfG5p+dxs8LgZMW8rq6Z+vDuyV7pa94QE3x/KDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB6C4CECD;
	Wed, 18 Dec 2024 23:36:52 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5AD661060345; Thu, 19 Dec 2024 00:36:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Hermes Zhang <chenhuiz@axis.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20241116203648.169100-1-hdegoede@redhat.com>
References: <20241116203648.169100-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: power: supply: bq24190: Add
 BQ24297 compatible
Message-Id: <173456500732.3120615.6151094372116724323.b4-ty@collabora.com>
Date: Thu, 19 Dec 2024 00:36:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 16 Nov 2024 21:36:46 +0100, Hans de Goede wrote:
> The BQ24297 is identical to the BQ24296 except that it uses USB D+ / D-
> data-lines for charger-type (max. input-current) detection instead of
> a PSEL input pin.
> 
> This is the same difference as between the already supported BQ24190
> (D+ / D-) and the BQ24192 (PSEL).
> 
> [...]

Applied, thanks!

[2/3] power: supply: bq24190: Fix BQ24296 Vbus regulator support
      commit: b3ded6072c5600704cfa3ce3a8dc8718d34bda66

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


