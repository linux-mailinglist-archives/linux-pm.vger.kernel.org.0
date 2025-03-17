Return-Path: <linux-pm+bounces-24192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D2A65570
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E102A7A61AE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DF243371;
	Mon, 17 Mar 2025 15:21:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE89230BEB;
	Mon, 17 Mar 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224868; cv=none; b=O0wYfzLwZcPXamDvj2iTRVuEj5ry68U8nvglY3j9erLQAvFrWUHOf6t3y/c5g1JyofKc0P734kw5ytVzwJprTUj7UFF+z5GUUd8OxDVTVKSCXhYWgKp9bd63BdKL61RpIwuvqtUrOqLtC5W9IjAQzPb0hR12evCOyz2tIeuN+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224868; c=relaxed/simple;
	bh=Nh6H7eC/8nPSTQ77Qc4+w1XU3b28txVQlpzntPPipOs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pNdd3dni/AiRvnghFz8ZIhRAAHsWCFW6nXzervB2guwGsnOTlThOePrb4l5/98sEH9gvJ5pZBTVhnbEvpdM8CeOeW1OSvw+2zDHIvA/yvK3bkorDu4K+qBAwX05GmVIQ2xG9b+pHxmdruDkKW6I0uYnnDjJDkik6vuHxgzDvapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550E8C4CEE3;
	Mon, 17 Mar 2025 15:21:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 454A918082B; Mon, 17 Mar 2025 16:21:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <20250312073729.1430053-1-nichen@iscas.ac.cn>
References: <20250312073729.1430053-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: mt6370: Remove redundant
 'flush_workqueue()' calls
Message-Id: <174222486427.175368.2927346420371391237.b4-ty@collabora.com>
Date: Mon, 17 Mar 2025 16:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Mar 2025 15:37:29 +0800, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> [...]

Applied, thanks!

[1/1] power: supply: mt6370: Remove redundant 'flush_workqueue()' calls
      commit: 0b8d073f6c66d7110ac9fab1f13a09337e03f1b6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


