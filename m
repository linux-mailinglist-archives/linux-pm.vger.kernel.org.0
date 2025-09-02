Return-Path: <linux-pm+bounces-33663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B09B40D4F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F25148848E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87492C11D4;
	Tue,  2 Sep 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FuglPmom"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB81E0B86;
	Tue,  2 Sep 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838888; cv=pass; b=QeHC+Ta/T5VI05xYfU6+k/7n1/DmXcQVLi09QO/yDklBwiJ9LPruLCooXhGTxFJZW6fr/17L/YS7EbOKgCAFE9Kgh3aKwHAVfFIEvDyjSHasTb/jrDOdFUGY+/FRD4un4K4VWxhf2pkHlATC1IsefKNTPxY8LotNXB0WdtiQxbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838888; c=relaxed/simple;
	bh=Q6QgRpiophOD2BOE7xjd4QAgOGDKttIfPUeYsvTMr4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCV2o4kYVhJON+NdDyFJr4KLCLznSIO7a1r4OIFsp/NtNqVeDJsPkkmc3KIr5+brE3Mi5eb7Oo1wxRAo86OturEshcnqaAwVyrZSj06eLE7Uig1kRifPM03b+x0lmDuvj7HkTb+wryLaBSYCkm7Xv7Ffq16ZztUgTE1yU8l+dX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=FuglPmom; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756838870; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n/SY1QV9yd9D5c+Y4l9RrvIdYrk9bEKO8VbQNjYhyIKVKYkFcNfnH1qf0GFDFGKIJgTB3mADN1c/9lRTLaXuGSkAymhdLXSjs5zoBrjJljEXeOIEoG3pWpGFKe0ZaxVQTBX0aFSiBUGcDtXHW47kvXE2Cj3t851gHneMN0Nv//M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756838870; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eEimETXzcFXduDqWg3m47iQxfgsOTltbIThz8vfrKVQ=; 
	b=cn35Bz4qkv3IVDFSuC4vYkkl4+NfEuOGstCC/JHQoqW2lMCecYZuW+BWflNCs9SSAr9r0Q6LqBF3MSHdhJLub0BR4NfykL06/H3Tz5f/2KVr9M3tDG+GKQwtWs3aneZHIH657/NMomEcDnaZw7vwNxWxSOmChtc3ZxR2FhTcG3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756838869;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=eEimETXzcFXduDqWg3m47iQxfgsOTltbIThz8vfrKVQ=;
	b=FuglPmomQFS0ZhcGVYwLUDVC46HBRxYarV2MLCsh/5E57CECcEF3/VL0jpSeczUl
	cKBXfDMCOp8sJrrt0hzWQIZpaN8hjXHjx/nhTyfpqlNc3oQbmSkii/k0/q/4aw3UfO3
	grUOqjZMilyWv5w8oCjW/3/5Ggz1DU+4XkiLCyfc=
Received: by mx.zohomail.com with SMTPS id 1756838867514400.6279332190828;
	Tue, 2 Sep 2025 11:47:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-rockchip@lists.infradead.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
Date: Tue, 02 Sep 2025 20:25:42 +0200
Message-ID: <12734456.O9o76ZdvQC@workhorse>
In-Reply-To:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
References:
 <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 2 September 2025 20:23:04 Central European Summer Time Nicolas Frattaroli wrote:
> This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.
> 
> On RK3576, the UFS controller's power domain has a quirk that requires
> it to stay enabled, infrastricture for which was added in Commit
> cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
> 
> Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> genpds on until sync_state") appears to break this quirk wholesale. The
> result is that RK3576 devices with the UFS controller enabled but unused
> will freeze once pmdomain shuts off unused domains.
> 
> Revert it until a better fix can be found.
> 
> Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

And of course I notice the typo in the subject (pmdomian) as soon as I hit
enter to confirm send. D'oh!

Ulf, can you fix that if this gets applied? Thank you!

Kind regards,
Nicolas Frattaroli



