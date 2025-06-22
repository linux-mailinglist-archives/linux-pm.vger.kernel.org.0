Return-Path: <linux-pm+bounces-29230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E21AE31A8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5DF1890720
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13611FBEB3;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53831F8BA6;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=none; b=PdjvaDS8G5OAwQ5ghYtuFkkDr4SwBuPkXTF/LKhMD6qtKlzlbmb1G4iX6/hrvV5Pp4Pcafo1/Z7lkkVt2HBBaW7WwBnA/9ZzdTyqHKG00EqivjdVArZTWgXu6r/Z2ySx92GPhJLu40KUUqgeHJwsMqhbwR0JYTlQEu9/yQrn8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=0ad6S+810mySiKFJiqwKajCHd3ugnqp0tZADQUmxvFE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GVJHcn66l280ST0C4mpjcEdLfGRWFoYePfOje1taCrXDC8kA4fOO3MSoba/rlm1K2uAqGvAKBnhszJNIWgfMiLuwVjG74p9lBaDCEUwRfHTXMll6Z+mY6x85oQBn8M+0WTGVb+hr78hw+/hX6osrSj8M/SArTtraVP/HmJ8z+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E7EC4CEE3;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5946218095B; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuanjun Gong <ruc_gongyuanjun@163.com>
In-Reply-To: <20250513123732.3041577-1-ruc_gongyuanjun@163.com>
References: <20250513123732.3041577-1-ruc_gongyuanjun@163.com>
Subject: Re: [PATCH 1/1] power: return the correct error code
Message-Id: <175061959735.285737.11828062873013802869.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 13 May 2025 20:37:32 +0800, Yuanjun Gong wrote:
> In POWER_SUPPLY_PROP_MODEL_NAME branch of max1720x_battery_get_property(),
> program would return -ENODEV out of FIELD_GET error, but it's better also
> considering the error code returned by regmap_read() in case it fails.
> 
> 

Applied, thanks!

[1/1] power: return the correct error code
      commit: a9aece5d7e8fa8bc74f1827d2cf1b189ffe7e8c8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


