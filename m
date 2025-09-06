Return-Path: <linux-pm+bounces-34093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D36B477B6
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 23:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A9D5A13A7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 21:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295002853E9;
	Sat,  6 Sep 2025 21:45:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9829D297;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195111; cv=none; b=fEQIPrqdbIKKmuUJpk/tlnTBQj0CBFMPsWrdcehSIv2U2KF6rBf3fHy1ih4c7w/gFADcksV/+ncd2ydWv5k+rSjEkL0ArQzIv25ImvvYW0LfzGLKS5iZQ6Kt3TeXs176IDsqCN7q6+xoi6qmQtyZou6fAyBWtjNR8VWN77gX0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195111; c=relaxed/simple;
	bh=CkWfFx///imCZ4ylARdnUZRuL4uo4svqlC6355p4Q+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CmC6GL9GRk5tI9LxZH6X9Zve/UXFeYR1CrMUn6F2jTokDRd0Ldoa+n3IDdeXURpuQmzid2obydCY3973hvcCqYzbeelflaThQljeszg3IAHinQLkeGv0HirV7/PYGGq0usjl9fRI0E3xwMibboWmz1oHn2pavn9/4Z7TanqmNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7860AC4CEF8;
	Sat,  6 Sep 2025 21:45:10 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id C88E1180B26; Sat, 06 Sep 2025 23:45:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <pndzfcekt8w.a.out@axis.com>
References: <pndzfcekt8w.a.out@axis.com>
Subject: Re: [PATCH v2] power: supply: Remove error prints for
 devm_add_action_or_reset()
Message-Id: <175719510781.45380.7018471850966283088.b4-ty@collabora.com>
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


On Tue, 05 Aug 2025 11:33:35 +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: Remove error prints for devm_add_action_or_reset()
      commit: 32f350d58544e2529dc8798275684e97f0a2df6f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


