Return-Path: <linux-pm+bounces-15808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68F9A1511
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64DC2867AD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956F1D54C2;
	Wed, 16 Oct 2024 21:42:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B071D2B37
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114922; cv=none; b=slOv/ZlvoGsY8HsPgg2elcvhYmc7aAnvDZV7CAOMxwC2xpfpYq0R4I6mrMtQ9XyTYRP8JzLZ1ElkJqI4qQ9zHok5LvyVAdiWfTuvtMeL93B6MQ5YAQLLGRf7IBgEhdvSI/zy47jy6jxkviS5kLXo6zC2H7Djs6SbwFZeyC0ggZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114922; c=relaxed/simple;
	bh=39uvMhtLAUbCIv60TtvNBIDt/BiTg2FZcI6CpiSqgzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n77vfXQuTm2gn3aAIl17z0bV9mqYII2hvpv98AO4kE+lOvnExOo2ebFUt2X04PYzuVjGv3+II0E2KI/Mwy6AwLTVwds8/7UgCABJIxRZ7v9v+qXjUqYCyPdrg/gq9NKrvXR8j9UZYhGh3hHh0XXaJkKStTCjyrdR0rNtR9+WUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6979DC4CED6;
	Wed, 16 Oct 2024 21:42:01 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 583DA10604A7; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Cc: sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20240926144346.94630-1-macroalpha82@gmail.com>
References: <20240926144346.94630-1-macroalpha82@gmail.com>
Subject: Re: [PATCH 0/2] rk817_charger full charge capacity fixes
Message-Id: <172911491635.630785.966402085830383621.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 26 Sep 2024 09:43:44 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The code for fully charged capacity is still causing problems when
> invalid values are reported by the charger (usually after resume from
> suspend). Stop attempting to auto calibrate this and instead allow the
> value to be writeable from userspace.
> 
> [...]

Applied, thanks!

[1/2] power: supply: rk817: stop updating info in suspend
      commit: bded860c3110a45fe091f67b2fe6f3b2bb096165
[2/2] power: supply: rk817: Update battery capacity calibration
      commit: 1e5335d00707220b46c28ab09cd09a1837b84978

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


