Return-Path: <linux-pm+bounces-18629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4349E5BAD
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B93188618E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009322256C;
	Thu,  5 Dec 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KALgSE06"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB72221460;
	Thu,  5 Dec 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416944; cv=none; b=lteTz2AQTij4E7pzFQ6sPGt6U7uMeTU7H+3oC2QCriDsldYFuAXfLEXeYgQc2/Y19HX9slNvHyRgDSXd9D28czLzl0zVpVEc9BYvY0TnGOvhuU6uQI6vvNtESKajKhwIDbhVBHfAkJJ/nOJ5PfLXsu/GDhpvau7YeMw/m5JBlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416944; c=relaxed/simple;
	bh=zNMK5lrZXKiwfx+Tj0AHcqEpcuC/49k4FJeb7BIl8E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2aPdFcRn4wAxKWoNRYYUhSdBCiOWIh3r8aJbU4AaFpbHwjtGNdw5tcmNDyA8XhypS0nr6zlbaKAOvZV8DCceHRMQ5MDszq2PHgVS39XrCap8W8olPLcZikcSF7eVAKIxe9esT7SMXUAv35YUuCF+wrCPgHS2Bs+2M3KWqWIB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KALgSE06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC7DC4CEDC;
	Thu,  5 Dec 2024 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416943;
	bh=zNMK5lrZXKiwfx+Tj0AHcqEpcuC/49k4FJeb7BIl8E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KALgSE06UPl+ohiv959c4JH7g2g7mAMVQCQkqscU/v86lWlDNOuVbn1MloKf8gA0R
	 tVdx+07qamJh8CeJTpfqBDufiToHlfwlQBjLqDgP3BTUmTdZSxeUGfdbyyC4meWtTK
	 UGfdxWV/aSOPSqrqJ6+hFhi4hY+J15WTIT2SjMcwnmwPZP7DrDhnOFT7Hnln+ri/FO
	 lvyJ9cMaES9x9uflmj2963RxQA/xHajdrmesslUQ2kDt83FwTBe1RQLW+q7suQYZTa
	 SYFkW0ntsHTNNsjGoCeEPMdx/EJ4pkEIIPmw1EV7PotVA8tFwZTlr2Ql97Er0VKGER
	 akdxuPf6QKgxQ==
Date: Thu, 5 Dec 2024 16:42:17 +0000
From: Lee Jones <lee@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v9 9/9] leds: max77705: Add LEDs support
Message-ID: <20241205164217.GJ7451@google.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
 <20241202-starqltechn_integration_upstream-v9-9-a1adc3bae2b8@gmail.com>
 <b7e4162a-a7f7-462d-9dde-121eeb59d148@kernel.org>
 <CABTCjFDyoF7g-5tj_dr6k7ScB_313dwEmfdJ+49rwMYfN63x1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABTCjFDyoF7g-5tj_dr6k7ScB_313dwEmfdJ+49rwMYfN63x1Q@mail.gmail.com>

On Tue, 03 Dec 2024, Dzmitry Sankouski wrote:

> пн, 2 дек. 2024 г. в 13:30, Krzysztof Kozlowski <krzk@kernel.org>:
> >
> > On 02/12/2024 10:48, Dzmitry Sankouski wrote:
> > > This adds basic support for LEDs for the max77705 PMIC.
> > >
> > > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > >
> > > ---
> > > Changes for v8:
> > > - join line where possible to fit in 100 chars
> >
> >
> > Coding style asks for 80. checkpatch is not a coding style, unless this
> > came from maintainer's review.
> >
> 
> On v6 discussion, Lee Jones stated 'This is old guidance':
> https://patchwork.kernel.org/project/linux-input/patch/20241007-starqltechn_integration_upstream-v6-7-0d38b5090c57@gmail.com/

I prefer 100-chars where it makes sense.  The future is bright!

-- 
Lee Jones [李琼斯]

