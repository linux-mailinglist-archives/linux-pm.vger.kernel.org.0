Return-Path: <linux-pm+bounces-26308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABCA9E573
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A33A483F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D01A270;
	Mon, 28 Apr 2025 00:21:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB254623;
	Mon, 28 Apr 2025 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799660; cv=none; b=LFq8qDzWYfX4Ow6JP3cHROTRgJeKAxPtP8aEB7ob9ylDN2FoQvOis/FLESpSSd3lG48eadwTPq0hj045jENlSfIi9jVcPCtWbKKaP9Z4gMAANsxXN6537F6O2yvfPm9lNxAawtuC9msJBZEr2LGb72BwtGgnfbk9obWnXZowBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799660; c=relaxed/simple;
	bh=Mxmm6OSm0KCuNa6NaZX4AtZ+skV9h8LKyFNJT6tIPyI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RPM1s1RxNZJPgmDVZnxw8ScMurGFFIs27/n8igXNh/9ZG0MBWuFTTe61W6Cgb570Z9m6feeRogITb9jeoBN1nJRy1PtjOSEDQ99mGDhjDRcSFE4Fs4xZZIM5JTYGPvItPlAOr/tJTRnd4S5nj9tmFU3KoQL5ywytZOqSo7La/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D26C4CEE3;
	Mon, 28 Apr 2025 00:20:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1002F1808BE; Mon, 28 Apr 2025 02:20:57 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-pm@vger.kernel.org
In-Reply-To: <0edde57b691db7f920d121fdbd5ebc3fb24f30f1.1743787625.git.christophe.jaillet@wanadoo.fr>
References: <0edde57b691db7f920d121fdbd5ebc3fb24f30f1.1743787625.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] power: supply: wm831x: Constify struct chg_map and
 some arrays
Message-Id: <174579965704.310722.16935712011735151878.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 02:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Apr 2025 19:27:38 +0200, Christophe JAILLET wrote:
> 'struct chg_map' is not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> While at it, also constify a few other arrays.
> 
> [...]

Applied, thanks!

[1/1] power: supply: wm831x: Constify struct chg_map and some arrays
      commit: 883730c192b5cf9d72cabefd83bfb3dcd1aadb6f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


