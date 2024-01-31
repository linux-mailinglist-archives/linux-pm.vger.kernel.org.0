Return-Path: <linux-pm+bounces-3029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C908439DB
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 09:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838F3B29B23
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF160DCC;
	Wed, 31 Jan 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e78gPVkS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425A69DF0;
	Wed, 31 Jan 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690971; cv=none; b=ryhUjxMZR7IBNSBvzish2VZ53PW3r0WdViaDvCy234ioZxhs8ZOecpYbb7pDKO6760ZZjx26QLwROEQDRKRZUt4UBiRfcrSh6F8pgS7ckYHmxsywPaY4WxzaT/WwiaI7TQWjJ6Z7oqBEnM67x/a4LsrUgh6u8Ao4WSj+eKOlIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690971; c=relaxed/simple;
	bh=DfZcsWA9ZiJQJnhw+Dlmf+rz4QBaLMOI1TuUkGh7YpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcYeZbMw0P3j4Io0ST+Ky7cRUzcVrqoZdrQgwAR9Y+sgs+9PQL1610B6jH6jT/LaqbhQWgyG6q7iNCTblCNw5tfUMd8AbbocPsInLNYt5X/dibSR2zuqVMvViXiqHBIbb6NDI0a6RTzZX+Nu3vcclGSCx1qVy4nbIkLQnAClLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e78gPVkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242BFC433F1;
	Wed, 31 Jan 2024 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690971;
	bh=DfZcsWA9ZiJQJnhw+Dlmf+rz4QBaLMOI1TuUkGh7YpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e78gPVkSswXNVxrTpgc3uqnClcHNOzUx0e+TnHsysfypkrDC7guPj7rnKflIizUtN
	 NUiJaN1GtNrkmmJLGqaaT0TUv+U5ep074UDrDzt+gZe1LtLowojHTMOeYz001u9gk2
	 3OUf70GW/bZCCPY+xd4+lf7eExvmEiMYsQltxViaAwgoiOzsvHBQ+RE9Q4pwqwLA6M
	 CG5xYe5/LHMrt6bP9qs8t1VNW891rQdiDtrsw+NrdI8BT/RAoELujxl2CCMLDWQYKt
	 Wpb5JnjbQaNrrzW/Xgm+Z2QNPhqQQ7xzgGXms59nifzufP/bOgsIa9W78U0el6J7oH
	 werrdYsUuNm6w==
Date: Wed, 31 Jan 2024 08:49:24 +0000
From: Lee Jones <lee@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Message-ID: <20240131084924.GD8551@google.com>
References: <20231214080911.23359-1-biju.das.jz@bp.renesas.com>
 <170316812973.586675.6248412029985031979.b4-ty@kernel.org>
 <20231221143318.GH10102@google.com>
 <TYCPR01MB1126921A54B9260CC33505FCA867E2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB1126921A54B9260CC33505FCA867E2@TYCPR01MB11269.jpnprd01.prod.outlook.com>

On Mon, 29 Jan 2024, Biju Das wrote:

> Hi Lee Jones,
> 
> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: Thursday, December 21, 2023 2:33 PM
> > Subject: Re: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
> > 
> > On Thu, 21 Dec 2023, Lee Jones wrote:
> > 
> > > On Thu, 14 Dec 2023 08:09:03 +0000, Biju Das wrote:
> > > > Convert the below bindings to json-schema
> > > > 1) DA906{1,2} mfd bindings
> > > > 2) DA906{1,2,3} onkey bindings
> > > > 3) DA906{1,2,3} thermal bindings
> > > >
> > > > Also add fallback for DA9061 watchdog device and document
> > > > DA9063 watchdog device.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/8] dt-bindings: mfd: da9062: Update watchdog description
> > >       commit: 9e7b13b805bcbe5335c2936d4c7ea0323ac69a81
> > > [2/8] dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for
> > DA9061 watchdog
> > >       commit: 28d34db7772f18490b52328f04a3bf69ed5390d2
> > > [3/8] dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063
> > watchdog
> > >       commit: d2a7dbb808870c17cffa2749ea877f61f298d098
> > > [4/8] dt-bindings: mfd: dlg,da9063: Update watchdog child node
> > >       commit: d4018547a15a94c7e865b2cef82bff1cd43a32b3
> > > [5/8] dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
> > >       commit: db459d3da7bb9c37cb86897c7b321a49f8e40968
> > > [6/8] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
> > >       commit: 998f499c843e360bcd9ee1fe9addc3b5d32f1234
> > > [7/8] dt-bindings: mfd: dlg,da9063: Sort child devices
> > >       commit: 2bbf9d2a8e3bc933703dfda87cac953bed458496
> > > [8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
> > >       commit: 522225161830f6a93f2aaabda99226c1ffddc8c4
> > 
> > Submitted for testing.  Pull-request to follow.
> 
> The commit dc805ea058c0e ("MAINTAINERS: rectify entry for DIALOG SEMICONDUCTOR DRIVERS")
> in mainline will give a conflict for patch#1.
> 
> Patch#2 and patch#3 are already in mainline.
> 
> 
> Please let me know if you want me to rebase and resend the patch series

That would be helpful, thanks.

Please ensure all of the patches have my:

Acked-by: Lee Jones <lee@kernel.org>

... applied, then I'll know to just apply them again.

-- 
Lee Jones [李琼斯]

