Return-Path: <linux-pm+bounces-13697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E396DBDA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92361F259DE
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8218049;
	Thu,  5 Sep 2024 14:32:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49218037
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546730; cv=none; b=RsMIH07/NA292WVi8Gg2MLbPofyz9aLlKrnDE9ElsLv93G4KbPOWgkcF1269Yeq7jupXYmNuWqIpiEGgYy7El23BS5W5UZAl6iMeTE+JXjUvvaUoDmtNfF0dMys5sVfG9wL5zG0DAS+OjfsVrf2YnLqLRjZTw5mpD5v6XGJskf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546730; c=relaxed/simple;
	bh=01wjFsF3YAXU/VzqmRRDkqYOxKMrBNgNDVx3DOAu7+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OdtaTzlRh3i/Zm+R75x0Ca6yhksHU6KOMLSwKcl0DteguJY3LpQtFE8kCOV3g+tXUaeatCcg13WLE5vSYfyheFRFXCSoeVw2jqWXdbcwcy7IV/dicFIMdQglMhVZzGhklfId5Qbmbr2EEf6C0KBG+tEONbBEmP9qWmNcYpi8Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EDDC4CEC7;
	Thu,  5 Sep 2024 14:32:09 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2776410604BD; Thu, 05 Sep 2024 16:32:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linus.walleij@linaro.org, sre@kernel.org, 
 Hongbo Li <lihongbo22@huawei.com>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20240904011434.2010118-1-lihongbo22@huawei.com>
References: <20240904011434.2010118-1-lihongbo22@huawei.com>
Subject: Re: [PATCH -next] power: supply: Constify struct kobj_type
Message-Id: <172554672714.1074347.14202629939357222556.b4-ty@collabora.com>
Date: Thu, 05 Sep 2024 16:32:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 04 Sep 2024 09:14:34 +0800, Hongbo Li wrote:
> This 'struct kobj_type' is not modified. It is only used in
> kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
> parameter.
> 
> Constifying this structure and moving it to a read-only section,
> and can increase over all security.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Constify struct kobj_type
      commit: eb1ea1351da0196e355391b4aa7f8a58536f16e6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


