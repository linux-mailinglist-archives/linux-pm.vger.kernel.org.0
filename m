Return-Path: <linux-pm+bounces-37271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B0C29B64
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA834E3EE5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06321B87C9;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112C148FE6;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130918; cv=none; b=Q3drmW6SjehUric6FTCZZZtxKxYgdgRHiyc2Oay4+D/ERwbsn/A+hsEsA7L7c1DP2tIFdjaHCdm2awPoxWVj2ynQ2BitaISgLLIBTDHV0p3OU+QY1UgcQDPBrohRQ78Soie0CX2XM26vwd56cnLDJ4VzU7JWw2bJs1ASkkS6wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130918; c=relaxed/simple;
	bh=4aJJSEQbKMYwCrCB76sU7Ppk1UbESUbsL3BTPXhxGzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kXeMxTdezErdBlHJEl2Uv1UpLM4olfnX9Z94VcikdM7GA76U97tgpp2tIxwVSOg/KWZ9Xrbk7t2MKWSJK24Qq50Ibv1Te+pOvCC6zgX8e2cW98yeePcqCcMlDF6WCB+yPplj6g8FMmA2krAP4D30vES5n6y2kO7ozkFcZi65eGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7961C4AF0D;
	Mon,  3 Nov 2025 00:48:37 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 433EE180FAC; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tobias Schrammm <t.schramm@manjaro.org>, 
 Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Sebastian Reichel <sre@kernel.org>, Zheyu Ma <zheyuma97@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20251008120711.556021-1-i.abramov@mt-integration.ru>
References: <20251008120711.556021-1-i.abramov@mt-integration.ru>
Subject: Re: [PATCH 1/1] power: supply: cw2015: Check
 devm_delayed_work_autocancel() return code
Message-Id: <176213091326.301408.1968897537081136339.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 08 Oct 2025 15:07:11 +0300, Ivan Abramov wrote:
> Since devm_delayed_work_autocancel() may fail, add return code check and
> exit cw_bat_probe() on error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] power: supply: cw2015: Check devm_delayed_work_autocancel() return code
      commit: 92ec7e7b86ec0aff9cd7db64d9dce50a0ea7c542

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


