Return-Path: <linux-pm+bounces-31849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E854B19B67
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5984C177268
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844622A808;
	Mon,  4 Aug 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiZ54x9n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCF2E36F4;
	Mon,  4 Aug 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288023; cv=none; b=XxPjBDNI91AY3UHB+tAJSWhNdfIKiP62mFER8bs8KItsW0WTPFsA5nN2rA9pl59ahXlcu9/kxyZsipK0QKk9CTCVA2OsZWfFcByhatZxkLn+496wEdK9uWHV+Gk0Z0GvpW7LeITxu+sfHgEYPoZAZ++SalLEnalO+ORfxvyv1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288023; c=relaxed/simple;
	bh=ouSCa63PfcibmTngtsiZfiLb80eCw/Ck6Mr/TiO6ydo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paFplfuJm5NStG2OSaJkiyLGNoXReLbRNg2STspLUbEDmTP+wJMgT2Q97fOJ9rFdChPOByDbikZOMivej1clMVyriDmWif6ZTbeY0trC2Dk3NQEr0e7gFGbqdgqq/rltOKiF6fMFzm0KVE8rRnNzJcBft/JWcdxtGxEJRmHLQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiZ54x9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0401EC4CEE7;
	Mon,  4 Aug 2025 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754288022;
	bh=ouSCa63PfcibmTngtsiZfiLb80eCw/Ck6Mr/TiO6ydo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiZ54x9nofxjzdr2CQm1i6/GPi3ANL7DIv32SIY1TpPIpjaLd/AiI0LjzGW4MjR03
	 Hx+9OFcVj/dBU3ucCMeaofpTPeF0OhJaahKDui/GKWMYiDZubl6qwLYZnXKsCjK4ix
	 fAuIZngS0SCWQWEG2MuQ3CySmkL4+A9VUK6ib7s6lBe2r0JMH7KqY9TwIjPI5IaEwP
	 DxfCpKirLm3HkobXEGNpQMwX1i0FlJ8w5MF3PoGiS9K/+RQ9fWbi8RyDgfYt+F0nMJ
	 SUA1kZ6q8GO33YjqacAOGtGsqqWznTz4CP2iuuDNlqn8aFAGX00N4dC6wGujI341FE
	 tWPHmccRgKGAg==
Date: Mon, 4 Aug 2025 08:13:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v10 0/4] Add TH1520 GPU support with power sequencing
Message-ID: <20250804-sociable-sceptical-snake-f5ac8d@kuoka>
References: <CGME20250801103104eucas1p1dae57601c48faae879b154f11af8a4f1@eucas1p1.samsung.com>
 <20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801-apr_14_for_sending-v10-0-e85802902a29@samsung.com>

On Fri, Aug 01, 2025 at 12:31:00PM +0200, Michal Wilczynski wrote:
> 
> v10:
>  - Squashed the two dt-binding patches back into a single commit.
>  - Simplified the B-series GPU rule by removing the not clause.
>  - Reverted the removal of the items definition from the top-level
>    power-domain-names property, per maintainer feedback.
> 

You are using b4, so where are all the lore links for each previous
version? b4 creates proper changelog, so why are you removing them?

> v9:

Best regards,
Krzysztof


