Return-Path: <linux-pm+bounces-34343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B029B511F8
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D5563894
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3083126B9;
	Wed, 10 Sep 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="itj2Rtyc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAF3126A9;
	Wed, 10 Sep 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494846; cv=none; b=kEY+J6ZEifxq/62Br+FoWGPRik7xhr+p9IbjK4GoFRdNgdePSliq2pXETvk53WuPwRJtnYrUcdnwLQNfhJpMIFTStKFTja1ArxAt7V9mNfRitZuSsXLx1c9SgCgxR+qPGYSN/dBXfmZNtZlJ/fP4gRB6btr5b/Ont0mzSGp06b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494846; c=relaxed/simple;
	bh=1NeGNR8ppiTRmS1Pkwf5TXsnABtuDP09G4iG8YpA3tY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyVs2ZGdrMoeuZ2IdXifa7HD3nOtQ+Tj/6f1+qk8ovCsiZ50S775ohCamAMS7mezWB+IpCPAeVJ28Oom0zWwpb2bJybphxytsOivJGctUBncUrKC4Oyt1L6XVBWJYRK9Fftd0XMKqNoPEN7h6fIXcwjNAuCEHU5Sn3GLn1WkmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=itj2Rtyc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 38780C6B3AC;
	Wed, 10 Sep 2025 09:00:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBB2D606D4;
	Wed, 10 Sep 2025 09:00:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F648102F27B4;
	Wed, 10 Sep 2025 11:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757494841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m8aDYS4mb5TWDdaf7wgtI6EN6s0r67hielYnU+r+pKM=;
	b=itj2RtycbgPXsbK3nwmGIwNwvUvT9lbFpDATR7OBuQWgiiXbA+3u4jMP10p+eeJd14/iwb
	R5kPAZCHPX3lnWcVUZYoUvosqs1vmbHDn8qNJIoZIEs69ZQcrVCbhvJieSaJ4xPKdID5x9
	T2l7AOKWw7SagqA8aTk7YSF5k7Bg1w5WT5lXF04uC/hohNXNdbSXD+gJULVXTcoYl6aBPd
	HnTALLS0Gg9anIm96Q0A+tZx+mb0ohMJEKFMDFzMItlUWzm8ws0i5UKM4ujk2eUGENvXD8
	XUChcJ9eX5tYkSDgvbIjlm/8Lw0ZfCmUgmolmqTHgEXsEFlYIUFIbueblCZ+ew==
Date: Wed, 10 Sep 2025 11:00:21 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>, Sebastian Reichel
 <sre@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 9/9] power: supply: max77976_charger: fix constant
 current reporting
Message-ID: <20250910110021.7ad15002@booty>
In-Reply-To: <20250909-max77705_77976_charger_improvement-v2-9-a8d2fba47159@gmail.com>
References: <20250909-max77705_77976_charger_improvement-v2-0-a8d2fba47159@gmail.com>
	<20250909-max77705_77976_charger_improvement-v2-9-a8d2fba47159@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Dzmitry, Sebastian,

On Tue, 09 Sep 2025 21:29:19 +0300
Dzmitry Sankouski <dsankouski@gmail.com> wrote:

> CHARGE_CONTROL_LIMIT is a wrong property to report charge current limit,
> because `CHARGE_*` attributes represents capacity, not current. The
> correct attribute to report and set charge current limit is
> CONSTANT_CHARGE_CURRENT.
> 
> Rename CHARGE_CONTROL_LIMIT to CONSTANT_CHARGE_CURRENT.
> 
> Fixes: 715ecbc10d6a ("power: supply: max77976: add Maxim MAX77976 charger driver")
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/power/supply/max77976_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
> index e6fe68cebc32..3d6ff4005533 100644
> --- a/drivers/power/supply/max77976_charger.c
> +++ b/drivers/power/supply/max77976_charger.c
> @@ -292,10 +292,10 @@ static int max77976_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		err = max77976_get_online(chg, &val->intval);
>  		break;
> -	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:

Indeed CHARGE_CONTROL_LIMIT looks like a mistake.

Sebastian, my concern now is whether this change would be considered a
userspace ABI breakage.

Other than that, LGTM.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

