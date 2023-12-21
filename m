Return-Path: <linux-pm+bounces-1527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B681B99A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB04B241FF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99EA55;
	Thu, 21 Dec 2023 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inMr4kvO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE61DFD1;
	Thu, 21 Dec 2023 14:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E524C433C8;
	Thu, 21 Dec 2023 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169205;
	bh=1gBzheN4S/wQ0NJRWGAPZm1B8jW93y3bbdZ6s3dg2MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inMr4kvOzDU80kjBEt1gVj7l3xcguO/scSWCZjpb6SlIZnoe1bDUh7lYy3hRk3dqW
	 VrczdADhPwXgGkBdKylLYtzQOBJ8pyD3t0rDR2jt6OPzFjoQoc8898njAmYgwFvZgd
	 vr3E9ttnAcEgRn83qg488LqA3CVRcO+xBZKHxjYqkwQjYYo3SOTXffWKVDH0WNw6tb
	 RGhC1CC7zO4ADcmFhE5KIOKLanv6fFdLpfZ9hCiqGE3uhnpItpIKLZcOW0ldr+XDIp
	 33mlFuohOu52O8psohKt+FhoPSWQyKAn+LCHb3DGOj75ZVFjVkzuAMznwvivhiGzxF
	 a7PR0fuGRDTEw==
Date: Thu, 21 Dec 2023 14:33:18 +0000
From: Lee Jones <lee@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steve Twiss <stwiss.opensource@diasemi.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 0/8] Convert DA906{1,2} bindings to json-schema
Message-ID: <20231221143318.GH10102@google.com>
References: <20231214080911.23359-1-biju.das.jz@bp.renesas.com>
 <170316812973.586675.6248412029985031979.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170316812973.586675.6248412029985031979.b4-ty@kernel.org>

On Thu, 21 Dec 2023, Lee Jones wrote:

> On Thu, 14 Dec 2023 08:09:03 +0000, Biju Das wrote:
> > Convert the below bindings to json-schema
> > 1) DA906{1,2} mfd bindings
> > 2) DA906{1,2,3} onkey bindings
> > 3) DA906{1,2,3} thermal bindings
> > 
> > Also add fallback for DA9061 watchdog device and document
> > DA9063 watchdog device.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/8] dt-bindings: mfd: da9062: Update watchdog description
>       commit: 9e7b13b805bcbe5335c2936d4c7ea0323ac69a81
> [2/8] dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061 watchdog
>       commit: 28d34db7772f18490b52328f04a3bf69ed5390d2
> [3/8] dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
>       commit: d2a7dbb808870c17cffa2749ea877f61f298d098
> [4/8] dt-bindings: mfd: dlg,da9063: Update watchdog child node
>       commit: d4018547a15a94c7e865b2cef82bff1cd43a32b3
> [5/8] dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>       commit: db459d3da7bb9c37cb86897c7b321a49f8e40968
> [6/8] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
>       commit: 998f499c843e360bcd9ee1fe9addc3b5d32f1234
> [7/8] dt-bindings: mfd: dlg,da9063: Sort child devices
>       commit: 2bbf9d2a8e3bc933703dfda87cac953bed458496
> [8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
>       commit: 522225161830f6a93f2aaabda99226c1ffddc8c4

Submitted for testing.  Pull-request to follow.

-- 
Lee Jones [李琼斯]

