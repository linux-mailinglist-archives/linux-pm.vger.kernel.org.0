Return-Path: <linux-pm+bounces-34188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFCBB49DF0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B911886BC6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632E1D5178;
	Tue,  9 Sep 2025 00:19:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740A1C3C11;
	Tue,  9 Sep 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757377186; cv=none; b=ozlrqSddJraGp2TVc1raFqftjVdviysWMxITfm3Hje57xsadwP6slUg/j2WDqvFBdHYbxe3HMRdivb2hkTQSRbCw2taYMlbW++Zg8EpNPEMR1So2n/DYiFgKH0q6QNOZkZW5Nriki9snbpomCSanWCqZsMcaNeBQScjnAFXHXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757377186; c=relaxed/simple;
	bh=tmcdS63HVhCaT0U9HTHFodnlbWxahuD8IDsjhlwL+Ew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GNPuvkZWwoAeGjSflfRl2MYSkWU9Fxap+49TIGuaw9sFUrEZQb1qlN41atH08vHCTBGoaEVEfWbwyegaaU2qKl62AgIaXIb9fa/HItYKeYxtKN42MJQ8kZXC0djpWt3e3yMjTxpuSjgQGkF6Eq1PNr85xmxa84VjEow8g55ukhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D2CC4CEF1;
	Tue,  9 Sep 2025 00:19:46 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3AEE318081B; Tue, 09 Sep 2025 02:19:44 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <2280ca741ef36fe9ed26b8079b91a8e5dfd669fc.1757360105.git.christophe.jaillet@wanadoo.fr>
References: <2280ca741ef36fe9ed26b8079b91a8e5dfd669fc.1757360105.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] power: supply: Use devm_mutex_init()
Message-Id: <175737718422.13878.10547263868458184966.b4-ty@collabora.com>
Date: Tue, 09 Sep 2025 02:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 21:35:28 +0200, Christophe JAILLET wrote:
> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> As an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   35803	   9352	    384	  45539	   b1e3	drivers/power/supply/rt9467-charger.o
> 
> [...]

Applied, thanks!

[1/1] power: supply: Use devm_mutex_init()
      commit: 7d715345a86941b9e6c8e520b40078692baed4a4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


