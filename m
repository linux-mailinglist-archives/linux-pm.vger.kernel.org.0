Return-Path: <linux-pm+bounces-34718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B7B59134
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 10:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0177E189ACB8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909C202F7B;
	Tue, 16 Sep 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcynC5oZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8011E487;
	Tue, 16 Sep 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012364; cv=none; b=mMqvZlGaqeFDoW5J1mFvOnIKV/zyW1Pro5zNJ8O8aZLoK6ponm6pcW3mPxTR3sWWN3VI58pwLYNAelkaj96aD4T1Cdg4rW0Mx0HNuOCLegewRmM9DHaqoTfRzV5TlE/4WyyCJJqpKYJU0y+kcKk9nCvh0bpGo+oKVXdpAbuzxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012364; c=relaxed/simple;
	bh=77sPZa74dO+ilL4jTQsgv90SbS3/VbKdxhMZXyEMsKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqC6y8KVSYnRiMy84YD1yo8UAawAOjruvzgU45BliZICPZkUqyXuAiruEtsCequUwQ4E3tIBwQqWfwqGIhw4/56sN2Be6U6hAygOxYmYcmDhpwbKdXpAcI6o9M2/X3zRxM5Xr3V9HVqFTsXx77FkJPA8q58Utjl2spOgnwph5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcynC5oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1610CC4CEEB;
	Tue, 16 Sep 2025 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758012363;
	bh=77sPZa74dO+ilL4jTQsgv90SbS3/VbKdxhMZXyEMsKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcynC5oZR054C8IlSHMpW9uNLnQoiB0U4LtcZ24RUGhdbY86iLAcClADbz0i6LCUz
	 bFuJzBZMFovEaZ4BA0q48uFEiYgyo2IynDNFPJnjhPIrzxiWSun962lvLdRGaTzn8A
	 Wjs6DtakYej6ul09B7ocvlCxDmUlw1qsWgo72D5V+qV0pUSSaAb8zJ1HLTNEZqGJ/2
	 JuEW9JfgmBBh5xUImo4g4lvpl8GeHjuFXosW1JGtTF9jKR++Yh/BdBJTjTewolzfkg
	 t86dJZFBc7BKys1J35myRj4U/rmlVPtqbPjSlSouU7C3rUn4r3By6Kk6wmUZS3NIlb
	 IjzusvJNAQEog==
Date: Tue, 16 Sep 2025 09:45:59 +0100
From: Lee Jones <lee@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/9] mfd: max77705: max77705_charger: move active
 discharge setting to mfd parent
Message-ID: <20250916084559.GI1637058@google.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
 <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>
 <rwnwaen5hqoeieiubishsrzn3wnmhhpbaurx6oukos7ysjoppm@uh6m22r2cdps>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rwnwaen5hqoeieiubishsrzn3wnmhhpbaurx6oukos7ysjoppm@uh6m22r2cdps>

On Mon, 15 Sep 2025, Sebastian Reichel wrote:

> Hi,
> 
> On Thu, Sep 11, 2025 at 08:57:09PM +0300, Dzmitry Sankouski wrote:
> > Active discharge setting is a part of MFD top level i2c device, hence
> > cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
> > register from charger driver is a mistake.
> >
> > Move active discharge setting to MFD parent driver.
> 
> This is quite confusing to read without knowing the driver. I think
> it's betterly described like this:
> 
> Active discharge setting is a part of MFD top level register range,
> hence cannot be controlled by the charger regmap, which only offers
> access to the charger registers.
> 
> Move active discharge setting to MFD parent driver to fix the issue.
> 
> > 
> > Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> > 
> 
> No newline after Fixes:
> 
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> >  drivers/mfd/max77705.c                  | 3 +++
> >  drivers/power/supply/max77705_charger.c | 3 ---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> I think it's sensible to use 'mfd: max77705:' prefix for this patch,
> otherwise Lee easily misses that this patchset has anything to do
> with his subsystem :)

=:-)

-- 
Lee Jones [李琼斯]

