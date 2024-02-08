Return-Path: <linux-pm+bounces-3633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8621284E1C8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 14:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389CA1F24CF1
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA77AE59;
	Thu,  8 Feb 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1uy3JXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D907A731;
	Thu,  8 Feb 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397906; cv=none; b=ZRWdJGFCPOPb5ngyqqQiUDs82FLlMCqB4+HdS/PABnzcIKblKs68+qSJOxdPolmTz9Yxla3LUfhysXdwmoZC44ZpryobAm+IMiNalMEwDDteRdFqKQoCqtSsGYUgQezEIHVjWJUTO7VPAEzGUyR6OWwDcYn1JuVNKQGMKOyreiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397906; c=relaxed/simple;
	bh=ThWFfCJ1mJMM96s44EJj+q1fZqPrQBxpeMUzuQEICXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw68qDnnHazAMtMI8yi2/h9I/u54jldyeGgH75dCEZG5b7cY2XCMf/YCCWdhhKtYYV1R9LDdiLdu+svAo/827jUDZfICeQ5XnNLSM+d8I6PE0JW3EaBQOTafXEg09edohHjtNQpPw1Lnr8mwvYzG8rcHfF2ZrnbamxQg9IOT1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1uy3JXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E532C433F1;
	Thu,  8 Feb 2024 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707397905;
	bh=ThWFfCJ1mJMM96s44EJj+q1fZqPrQBxpeMUzuQEICXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1uy3JXG0+psJZsLER2Tx8v2E+vA/YDmg5BRj5+vlHe0c62wZUvb9Cp3kMEitbe/9
	 qTs5gs0gxBvJcwGtzb9vfPjrfg/8gmqZzEc4JJCHq0FcDUQM0F1mNd0E6T/NX862Os
	 SFBeqByHYtv6ldlUG5vgtGuiTj1OWWp3LTzMvykAo9seM+PxNWcFgBiH657gssMp0N
	 6Ej5PZT0YZHazIEjnhLT8u/qzDipJqNEGvk3HW3ZLGfi+v9opq/STX8DYkoZS7EvPS
	 YN7E32BXa84QOBlQ5plkWFPEIUaARbtlsthu+dFTT5DBLJOM3D8yeFWQlel88HJx0k
	 6/li2lFI30zJA==
Date: Thu, 8 Feb 2024 13:11:38 +0000
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
Subject: Re: [PATCH v6 RESEND 0/6] Convert DA906{1,2} bindings to json-schema
Message-ID: <20240208131138.GN689448@google.com>
References: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>
 <170739757961.1020645.7945873817461577204.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170739757961.1020645.7945873817461577204.b4-ty@kernel.org>

On Thu, 08 Feb 2024, Lee Jones wrote:

> On Wed, 31 Jan 2024 10:26:50 +0000, Biju Das wrote:
> > Convert the below bindings to json-schema
> > 1) DA906{1,2} mfd bindings
> > 2) DA906{1,2,3} onkey bindings
> > 3) DA906{1,2,3} thermal bindings
> > 
> > Document missing gpio child node for da9062 and update MAINTAINERS entries.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] dt-bindings: mfd: da9062: Update watchdog description
>       commit: 12f0a4cc845286f331239c52282aab283a0392e5
> [2/6] dt-bindings: mfd: dlg,da9063: Update watchdog child node
>       commit: 19c993f29e8ed2c4e34f4696b9cd0184e404c1fb
> [3/6] dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
>       commit: e2fcaf4c067099a1ebcdb37903e630ad0f55ed2e
> [4/6] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
>       commit: fddee1e686de077c80ad9dd61f4a50fa1d8b6605
> [5/6] dt-bindings: mfd: dlg,da9063: Sort child devices
>       commit: ae3a0d709c240bc88c741d624d119ae96081d545
> [6/6] dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
>       commit: f1eb64bf6d4bef5295ab7633874960fbcfadca46

Building now.  Pull-request to follow.

-- 
Lee Jones [李琼斯]

