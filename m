Return-Path: <linux-pm+bounces-13850-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274199705DC
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54401F21EDE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236A1411C8;
	Sun,  8 Sep 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPnB3wpq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DE13DDA3;
	Sun,  8 Sep 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785251; cv=none; b=VOMNvTSb9DtRvZMwMfZQHn3ajjJdHWgucOxHvPvJRBL0yhJNet+jHs4sJtjSNFXfXCa4tyamzYe0UYaLgFAoZzpZZEqJJ6ZWVftO19ewPWqo3SJ037Oj5imB8JgD6giOYy6CICr7etr8P3yjYYwpxDq3WyBgG7+tDPpofdnpbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785251; c=relaxed/simple;
	bh=I5sxYl65FXj1bReWOukIcqvrR1M53LH1xySBrKJBkgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq7eUUB3dBuAIrPU+7kMZhhx5Ar7DGg5a09pOSsRiDZe8hfWN8w5hkfxD4PnFZd3Bp32SB16ulO6jazwb/UZeLVzSJC5LUv+n/ty4VWQuYIG3RoadjbtWafB/XW9eLzU1dBl5iN7havEp+FZK054Y1/lxEQ1dW4RcXQ/fY2j9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPnB3wpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC10C4CEC6;
	Sun,  8 Sep 2024 08:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725785250;
	bh=I5sxYl65FXj1bReWOukIcqvrR1M53LH1xySBrKJBkgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPnB3wpqgznQh64jDiSSdVl0Vi51VB/cdzUhIrU9EbLBajm4/JG5x1w/sGSJWh3sP
	 2Ho65QHP7MWHvQiSBoUpi56Lg+46QcwcPKQherROZ19NwJYG7qu9nmDz0r8OGv6A52
	 gREd/YZmbB1DGpbTT6sOpkFhk0iL29KPRZe2P5fO83vdAlOZUJIvHmGoaA9zuU/sM2
	 N6qQzfs3tJ8EkVdxUJMwPRDN80BesbdW75LrdglHRFdAUL4gZtFzAnDluCgDYQD6tV
	 VtaDClSuW2kD02kE0EKCNeW7ZmgsCHgo1Qo79Btabv0GWP9WtvBLynvtp5cZho3vVg
	 7/2Dg6ILBb0Dg==
Date: Sun, 8 Sep 2024 10:47:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq256xx: Add
 omit-battery-class property
Message-ID: <6jdweloqynw2fu6legthfbzctnoirzzkxhduxfcrowegaztd6a@ilak6fagpokv>
References: <20240907-bq256xx-omit-battery-class-v1-0-45f6d8dbd1e5@mainlining.org>
 <20240907-bq256xx-omit-battery-class-v1-1-45f6d8dbd1e5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240907-bq256xx-omit-battery-class-v1-1-45f6d8dbd1e5@mainlining.org>

On Sat, Sep 07, 2024 at 01:07:45PM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Add omit-battery-class property for avoid system create a battery device.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run  and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Your SoB does not match.

Best regards,
Krzysztof


