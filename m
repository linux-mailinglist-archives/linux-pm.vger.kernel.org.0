Return-Path: <linux-pm+bounces-29214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56385AE2DAF
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9368189517C
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC922094;
	Sun, 22 Jun 2025 00:57:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681B3FE4;
	Sun, 22 Jun 2025 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750553865; cv=none; b=qCF4kx3A0nDMh4d7TfVJCygIuptYMfGXaztzv01GhOEkK5Cw+F51q/SD9Hl/knqaNDEinviaFG3TPTJfdxtyfyd12upuPRQy9ohBltpVuvJV2agixszfy7zZ0hJp+W39jdGR/ImhcIfGm+eINVZ8oQG24qwPSCIjibRlYGNj2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750553865; c=relaxed/simple;
	bh=B1smkn8OSmGrRCXaD9PDh7JFGYHnFbHF/3FfM2brVe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ouhEYtTTLKVmFKC7a/fnUigh1mG0xzvLixdPJ1MST9XqsyEfS4hqsfuHcwdqD9iPtG00DHnYtcVpuJUojdxi91WAFHqMzzX5aZgtL6ZHCpDMfjY9XO2T/66Mh6Pm8VYAve03dirnD3MwgD57DaD8x4mmRrzwIHj/huPterN7iXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E1EC4CEE7;
	Sun, 22 Jun 2025 00:57:44 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4FC8E1806CD; Sun, 22 Jun 2025 02:57:42 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
References: <20250523-psy-qcom-battmgr-add-lipo-entry-v1-1-938c20a43a25@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Add lithium-polymer entry
Message-Id: <175055386230.233674.6258495087298904335.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 02:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 23 May 2025 13:14:22 +0300, Abel Vesa wrote:
> On some Dell XPS 13 (9345) variants, the battery used is lithium-polymer
> based. Currently, this is reported as unknown technology due to the entry
> missing.
> 
> [ 4083.135325] Unknown battery technology 'LIP'
> 
> Add another check for lithium-polymer in the technology parsing callback
> and return that instead of unknown.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Add lithium-polymer entry
      commit: 202ac22b8e2e015e6c196fd8113f3d2a62dd1afc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


