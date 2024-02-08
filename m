Return-Path: <linux-pm+bounces-3632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9984E166
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF7528E4DD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B47768F3;
	Thu,  8 Feb 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btuAujC1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3F768EF;
	Thu,  8 Feb 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397585; cv=none; b=tLWnSnWslGRN1GwqEzMOZIQXjGAwc0l/03yfj3oRaeTA6ec+NwvNkJHHSioa5HPLSoKRef8MHndeiDTDa8L9FLT5/9HxKEb2i7KJY4zTfEGmjakAt5QDZ3YZOueWCBfPy341VMnYhswxN0OEkICM/UEAL8RCpEd6+5zOWl6t65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397585; c=relaxed/simple;
	bh=+mKttVNp6/Z3Yzi8mBTdYb3vLHOFQDuYTop1dvL/180=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D4Kyn8MheZwk27EWhBARORDAqT+0Nr2URlNAYPxCtr6p7TDrEm1MW94ddeOrmTBkeO0Ny8ca6Sae1U2e4a8GkfkRx/0zkZwIQZ8vDFIpBF2s2QZeCqevta6HyBKyCibKf+QYgpLhijpyjY0t1FHTpLba3oQUgvHhKK0TH2JJSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btuAujC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D915CC433F1;
	Thu,  8 Feb 2024 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707397583;
	bh=+mKttVNp6/Z3Yzi8mBTdYb3vLHOFQDuYTop1dvL/180=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=btuAujC1NBNUuBgaHgomNCPNfEyMAtjotDOqBbXJ7slaDGCB+ITbxsl8UvA2dLogW
	 zzepsNcjS7tKCnow0MBLvGst5TrHXrNJnifIkAP/FVrUwyxndJqOA5Lc04MQvAoH5x
	 Sjf5saDI7SJEu3rkdfDg3WocWRR/AWBQ/PomnwTdqoUhd9RD33NeKZ5ZpdM4njfWOe
	 l915pF5eRuwc6hMqvhE6N7iamdviqTuFha4yeFHosUEoIp3AUpdIE/6I7hiUvAoaQO
	 wVeR7EPZ9k2e0YizSIKeq3O3IwKzHO/vnocGPwclfgnSZzYtDJlSBJ3317QT51UOmK
	 1FKxPAFyHKAvA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: Support Opensource <support.opensource@diasemi.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Steve Twiss <stwiss.opensource@diasemi.com>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>
References: <20240131102656.3379-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v6 RESEND 0/6] Convert DA906{1,2} bindings to
 json-schema
Message-Id: <170739757961.1020645.7945873817461577204.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 13:06:19 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 31 Jan 2024 10:26:50 +0000, Biju Das wrote:
> Convert the below bindings to json-schema
> 1) DA906{1,2} mfd bindings
> 2) DA906{1,2,3} onkey bindings
> 3) DA906{1,2,3} thermal bindings
> 
> Document missing gpio child node for da9062 and update MAINTAINERS entries.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: mfd: da9062: Update watchdog description
      commit: 12f0a4cc845286f331239c52282aab283a0392e5
[2/6] dt-bindings: mfd: dlg,da9063: Update watchdog child node
      commit: 19c993f29e8ed2c4e34f4696b9cd0184e404c1fb
[3/6] dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
      commit: e2fcaf4c067099a1ebcdb37903e630ad0f55ed2e
[4/6] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
      commit: fddee1e686de077c80ad9dd61f4a50fa1d8b6605
[5/6] dt-bindings: mfd: dlg,da9063: Sort child devices
      commit: ae3a0d709c240bc88c741d624d119ae96081d545
[6/6] dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
      commit: f1eb64bf6d4bef5295ab7633874960fbcfadca46

--
Lee Jones [李琼斯]


