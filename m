Return-Path: <linux-pm+bounces-24140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8972A64778
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A323B3B6441
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0522D4C4;
	Mon, 17 Mar 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5cwXNtB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D5221F1E;
	Mon, 17 Mar 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203774; cv=none; b=fVhKhGUQTAxP4XbhPu/riNkzgNLptJlOBqvIZFmwJi3qPwM5Jkuc1/sbEsKouB44nAMc7ZMT7jQPbEYUmMNtZi87cm5/g8MafFqzXVWhS/cCnE/mAECGklfwBFOONIREdjUV3u9AnLY7/iYGdiX/JXcyOdM5lpoHYpezjB99L44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203774; c=relaxed/simple;
	bh=UtpkxklWPYzDg0Qcde54vhr0h0zr5b3LBx2igEqK4rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgArsKpkNZAYyNfrYXQqqT1dt/DQCze6avgXl+ij0YjFO4XDxx7GdHtryjQQvXiTCxwl6/L7R/A6pQNOFnBg4F9uz6cIv+rrK9d2ixXHRkweU2nO23Ti9z1CuasGL/ZLY1L/Lo14FCack21AcEXlib2NCM8oFfon+i0QUV+TEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5cwXNtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B548C4CEE3;
	Mon, 17 Mar 2025 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742203773;
	bh=UtpkxklWPYzDg0Qcde54vhr0h0zr5b3LBx2igEqK4rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5cwXNtBH41N2OH6H+VzS/LvXLNnzcEkauyP/qA5YMBnJTtKX/JdxaX2J3BCOVqTG
	 336OgLRYNWKB9zDduD0Uo9FYvkkRy4H3vvDXFtyWG9520ka5EFFNLKB5LWm75XZyXo
	 dXocIfr91RzPU3cbzyZXbGbPDfrVUYUVg7nwjoydaK64OCSUifQZgXHv9HaHgdtC9t
	 X7cXSLbj/TOWJoOtrcxJ150yx84rTiuJlEa7v9TiR27XIpFJdYRcvPxPWdOOdtXpnq
	 8yk17QX//8N9G8tIbgk03QiSNGcxTDBenkTqH0EEw7j/h+6qDI5u8mzgz17rV8gxkL
	 Kmv6gRwt/NGTg==
Date: Mon, 17 Mar 2025 10:29:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert+renesas@glider.be, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	magnus.damm@gmail.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	sboyd@kernel.org, biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com
Subject: Re: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
Message-ID: <20250317-bipedal-inchworm-of-poetry-b60fc9@krzk-bin>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-7-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250315081225.92118-7-john.madieu.xa@bp.renesas.com>

On Sat, Mar 15, 2025 at 09:12:16AM +0100, John Madieu wrote:
> Enable the CONFIG_RZG3E_THERMAL flag for the RZ/G3E SoC.

s/RZ/Renesas RZ/ and which *upstream* board uses it? This is not your
platform defconfig, but all platforms and all users defconfig.

Best regards,
Krzysztof


