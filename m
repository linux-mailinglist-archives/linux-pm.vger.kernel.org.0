Return-Path: <linux-pm+bounces-34090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1152B477B3
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761CB3AA829
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE929992B;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5F2949E0;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195110; cv=none; b=HYNxwjFFwA6ZZZ3MkJFbMdXcwHVJKFSo7jM3XN07NVmyUJ6S6LlJv0SyEEoxUpnkC3/GmP6nb5vPNdS9GS9e/68atqsuSsvnrksQthGo2Yh8NMl3FXmEwcP3D8jjnFwzT4//0GKWZfegdRz5C93FwDu4z2Q9DpHZRLWoPwGVXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195110; c=relaxed/simple;
	bh=Om2wsWKzfBTumU1uMrWiRYO/VKpdX3KrMlYogK6co3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F2b3ExVg/BRw3V+BKI0ZZdoG48JBEQB+U01VJLY4w8Nhp95kqO9I5UMpw7JjNZGuC6YMITK1LYfbX2iMV6KlJmgdKAsQZ8tGlRhyV3nbvOdNCX3hg3kvnDUdtuQcpVEK5OXfEC/18K7PdtsEjartflfW26pD3ZMIGfRtnX6kHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D20C4CEF5;
	Sat,  6 Sep 2025 21:45:09 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CB4F2180B28; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250807121349.460862-1-colin.i.king@gmail.com>
References: <20250807121349.460862-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] power: supply: 88pm860x: make fsm_state array
 static const, simplify usage
Message-Id: <175719510782.45380.3925400276927678009.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 23:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Aug 2025 13:13:49 +0100, Colin Ian King wrote:
> Don't populate the read-only array fsm_state on the stack at run time,
> instead make it static const, this reduces the object code size as
> the data is placed on the data segment and this removes the need to
> have code to set the array up on each call.
> 
> Note that making the size of the strings to a more optimal 11 bytes long
> does not seem to reduce the overall size. Making the array an array of
> pointers to the strings increases the code size due to the dereferencing
> overhead.
> 
> [...]

Applied, thanks!

[1/1] power: supply: 88pm860x: make fsm_state array static const, simplify usage
      commit: cb03556acf83b235dfb2e9f86e14f5e5b8a5f1e7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


