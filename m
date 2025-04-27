Return-Path: <linux-pm+bounces-26304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C634FA9E511
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB79B7AB681
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91489205E37;
	Sun, 27 Apr 2025 22:50:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73771205E10;
	Sun, 27 Apr 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745794220; cv=none; b=p86L7ggbAUHv+WXvQ5xBl7NaYgXhO8O166GGWFTKyX8XMFMLkQ2UxAIXPOMdxVvIIISST1GgCtweDmLfFCWn/5e3Yw8bIMZgiWQC+FoizHQ2uypsmdkqDyWU+utjZzJhsP1I5wOqoBJu9KTMhfW74Dg9Oh7JsImdm3GWpmY67HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745794220; c=relaxed/simple;
	bh=bIefR7abHqZ0OLFrE8m28DahUtmVjQc6Jqf2rjP4FkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ewNKCi9xJM22U5gEX8/1QorH34wvImqQACK77Qxp5OgUxLnCk+hZ5MpQVqXUpIim/vtZ4TmeNoxr5UuJhe4tdAQlg4NhU3f49LdH1Hi1Vdx8RJ44rYO93xUpTv/kR1vNCH5GICMX2ytIInk8QfVAr4pWR7WOZzkVjMFTjDJ0BHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2002C4AF0B;
	Sun, 27 Apr 2025 22:50:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C7643180F9E; Mon, 28 Apr 2025 00:50:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415-foo-fix-v2-1-5b45a395e4cc@axis.com>
References: <20250415-foo-fix-v2-1-5b45a395e4cc@axis.com>
Subject: Re: [PATCH v4] power: supply: bq27xxx: Retrieve again when busy
Message-Id: <174579421680.295785.5362050281749814568.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 00:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 15 Apr 2025 11:40:47 +0800, Jerry Lv wrote:
> Multiple applications may access the battery gauge at the same time, so
> the gauge may be busy and EBUSY will be returned. The driver will set a
> flag to record the EBUSY state, and this flag will be kept until the next
> periodic update. When this flag is set, bq27xxx_battery_get_property()
> will just return ENODEV until the flag is updated.
> 
> Even if the gauge was busy during the last accessing attempt, returning
> ENODEV is not ideal, and can cause confusion in the applications layer.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: Retrieve again when busy
      commit: f16d9fb6cf03fdbdefa41a8b32ba1e57afb7ae3d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


