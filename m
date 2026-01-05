Return-Path: <linux-pm+bounces-40217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298FCF503D
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AAF301E992
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387A33C532;
	Mon,  5 Jan 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bH6rlJiZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761F1FE45D;
	Mon,  5 Jan 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634465; cv=none; b=IXkycDBeid1QF4uI3YlAM5seUvzo9lXNEL6glV5rR+BDi9XImQoPSEQUGfbp3ZfOC8bAnbv/Mo2okpw5N89/XnDmPI2K8c+5oxE6jMA6lzEKg7Upb8WaWIUaVuEbwyTQp0bqfWviYCF9KrKuYQAYFm57sVtsF0rK3alzpKkzA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634465; c=relaxed/simple;
	bh=XcRilEYH2bfnmuZ1zIL53k3/Kpsk0gDXaMn2E8c+4cM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ECBYJvn3S/puZMDQ9eQwWGJl2z7GZRj1pp2e/okHXuBFXuAiVq98LL+7S6mpJr98ydk03f+yy1zDzIQZPYgBpDqqNP++8CFIqevZWQ8n+zLK9Y3EtByeiBOpHZpk4pNrI4A/9OGE+acBA2Ie82XxN4IFvxTM7r/D3JQ1QiG2FK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bH6rlJiZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E4EE71A2666;
	Mon,  5 Jan 2026 17:34:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B220A60726;
	Mon,  5 Jan 2026 17:34:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A031103C81E3;
	Mon,  5 Jan 2026 18:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767634459; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XcRilEYH2bfnmuZ1zIL53k3/Kpsk0gDXaMn2E8c+4cM=;
	b=bH6rlJiZ7gEgXbfiaCigmNEiRt4RliIin4nbRgNQM9xaoFaJIiaBILIgaOVIBqIK01diFR
	lOKGmw34tDDxAgYVi7xSz7RANxUgUcmFFkp20oavk9pMYWl9jGfGSCaWpVlEVupPmvhPVG
	n6wtaCTRADILAiPvSCgBUMkIdjdrCR/PWKhQlsa6hXzCTGa/SR8F0H9g2ncW7r/6rvhEE1
	5aGqEIC7T5dj0+WcCZZLnijJAIumDveA/UwYQeHZpeYLqGN16XEhr98lM4cmnGAYS7qqi7
	guyeI2lA19oBc6GUBKL9aI4LqUERdvVhHBfJaiwGzt/X/5Oxi3GNQiDwnXxePA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jan 2026 18:34:14 +0100
Message-Id: <DFGU4A5WRAFB.2PVUYY20ACOS7@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RESEND] thermal: broadcom: Use clamp to simplify
 bcm2835_thermal_temp2adc
Cc: <linux-pm@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Thorsten Blum" <thorsten.blum@linux.dev>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Ray Jui"
 <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>
X-Mailer: aerc 0.20.1
References: <20260105121308.1761-1-thorsten.blum@linux.dev>
In-Reply-To: <20260105121308.1761-1-thorsten.blum@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jan 5, 2026 at 1:13 PM CET, Thorsten Blum wrote:
> Use clamp() to simplify bcm2835_thermal_temp2adc() and improve its
> readability. Explicitly cast BIT() to int to prevent a signedness error.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

