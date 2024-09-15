Return-Path: <linux-pm+bounces-14317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646D59798BE
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 22:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5592826CF
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666913B298;
	Sun, 15 Sep 2024 20:41:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FA2F855;
	Sun, 15 Sep 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432896; cv=none; b=tv3RZp9Ifoii+MWB5ly8+uF0SgVXTkTo1sD5+EQzgMwmJdajE3v3OWuEkGG0eHEQt+MVcxDjNdgaJYI1+VBkzBJ0bMFcuxNOR2Hc8bbJXgojpatMLazq9FAHAo7/RkKg5BHnoifLSj8biYNwsnd5RuRUNRe8edQplpdLaY5nHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432896; c=relaxed/simple;
	bh=jE/nY/ymqrDd8H/i4SY580Ou1ckndQqBdWXgPTipSmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iEtvNgid4kiHybJqJ+5zv0Ue/jR8keZ5D7bYEZ+3IAVc+xZ61pgK74SRunFcUnlfaZPrcbrJewXBY5wwyZXyoWsc+SD0OJ+uRZUVfbLZ8FdshtDLF+qvhrNbTsuYG+qm+YxEbZTme+D5iruwSCCFnV7s5vzGEgnNtCfvorJE2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9557FC4CEC3;
	Sun, 15 Sep 2024 20:41:34 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 22A7F1060578; Sun, 15 Sep 2024 22:41:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240908185337.103696-1-hdegoede@redhat.com>
References: <20240908185337.103696-1-hdegoede@redhat.com>
Subject: Re: [PATCH 6.11 regression fix 1/2] power: supply: Drop use_cnt
 check from power_supply_property_is_writeable()
Message-Id: <172643289209.396623.7155743134468420806.b4-ty@collabora.com>
Date: Sun, 15 Sep 2024 22:41:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sun, 08 Sep 2024 20:53:36 +0200, Hans de Goede wrote:
> power_supply_property_is_writeable() gets called from the is_visible()
> callback for the sysfs attributes of power_supply class devices and for
> the sysfs attributes of power_supply core instantiated hwmon class devices.
> 
> These sysfs attributes get registered by the device_add() respectively
> power_supply_add_hwmon_sysfs() calls in power_supply_register().
> 
> [...]

Applied, thanks!

[1/2] power: supply: Drop use_cnt check from power_supply_property_is_writeable()
      commit: 78f281e5bdeb6476fab97a2c3fcece1094b42aaf
[2/2] power: supply: hwmon: Fix missing temp1_max_alarm attribute
      commit: e50a57d16f897e45de1112eb6478577b197fab52

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


