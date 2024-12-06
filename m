Return-Path: <linux-pm+bounces-18667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782379E6285
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 01:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394312838EB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 00:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FC1CA94;
	Fri,  6 Dec 2024 00:52:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB672193;
	Fri,  6 Dec 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446345; cv=none; b=GhYSE/fH1PGAPuWLv9qIAwykfkc3c/qh8VgiKgCn6FDlnCeVXl8xpnp9AiP+LKWJsXwDh5RAvZAu3XH/LQ/wGTvooc2GJYHIFk64LDMI5iKaix0xjtV1oDDbAB0qY9YqrAM3QaHGXcKn8Cgjykt0h2dBB7ACp2nPCuJ1Y/y+NZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446345; c=relaxed/simple;
	bh=xIB/knOaJd7/Xpl9CowsvKD8MXod/cucus7paEk4tTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yp4pCoJ/ikZwHXhtxN7EbznxWeE4JnG7NaZNSg8D72s0cvVvS1IvQ6QQxbU6Y/l9WRX8+ZpNhsKVI9Tbx36e3VLfXN8y6bnWvGL0PXYJAy4HU3kn8ulSZxQW2wsOrCjGULli+JtUmebtP8YLFXP/fzLf1O+bMlZlB7cYKIo8WrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA71C4CED1;
	Fri,  6 Dec 2024 00:52:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7595B10604B0; Fri, 06 Dec 2024 01:52:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Sho Tanimoto <mojyack@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205084601.2720462-1-mojyack@gmail.com>
References: <20241205084601.2720462-1-mojyack@gmail.com>
Subject: Re: [PATCH] power: supply: bq24190_charger: Fix typo 'jeta' ->
 'jeita'
Message-Id: <173344634243.1506109.5653372508019347963.b4-ty@collabora.com>
Date: Fri, 06 Dec 2024 01:52:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 05 Dec 2024 17:46:00 +0900, Sho Tanimoto wrote:
> The sysfs file 'jeta_iset' was probably intended for 'jeita_iset'
> 
> 

Applied, thanks!

[1/1] power: supply: bq24190_charger: Fix typo 'jeta' -> 'jeita'
      commit: 88e4a7dc04b7828315292eb3acaa466c9c123d8b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


