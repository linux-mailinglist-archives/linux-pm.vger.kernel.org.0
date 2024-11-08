Return-Path: <linux-pm+bounces-17226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62B9C253D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A80284572
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8F1AA1DB;
	Fri,  8 Nov 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd2lWuSK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26281AA1CB;
	Fri,  8 Nov 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092416; cv=none; b=Q0VnmnxakRVPt13T0vMQyk6Tpv068pWEmP5O9b9DTi6invza/LkXw5RliektykykFnnb2/gMd+5iodSB4pDLhzA5kXCbaCJoMv9WcXsJAhUMQoWT0zELI7p7vrSpP8qopyf6OZ0hJzPezSi+CabCX9saPjyU/20cTVfK0tUfr18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092416; c=relaxed/simple;
	bh=OtggIF0KRqr7r/wH0OZd5RllsjUVk+wOmDWHHI2hwOY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BZcYv6oemnEzXv227FHWV0wVtu+S+7EnUx/8EGbHt17eQchrSbZNGLwK9wIKkSvgKgeDVhEBroiHzSvBETjtM1HWrpENSkyrspVZj9eJASEDkjxnOwbt9IV+0M7q6ifVg9cDFcPQmz/gCb6nP7vVhA72vywF2qCVcD30dYqJ2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd2lWuSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D09C4CED7;
	Fri,  8 Nov 2024 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731092415;
	bh=OtggIF0KRqr7r/wH0OZd5RllsjUVk+wOmDWHHI2hwOY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Qd2lWuSKjB662/4MHlN9ZzDVESuRWPC1tDEoQioaBActtNgImJm1mx6R2aN3ZVkSQ
	 wZrsteEOBTYmayH4SCClPM6S8ZUqnuDZqK/L45klMUFvwqoFNoM59rpYTb3zwmLmS0
	 S5k3S/Kd34sPZ/GNjJbWpePCLosGWBzYuZ+pq92JZ19NWCGLbusae2RsEL0b/w+yQE
	 LKuAgQGeE1fIoFrCLBWrALq/q+NK6wpM7zRUp69OBCpFrOAIU77rs159lndC3/GXp4
	 IKc7T7mRGZA3sKofR4Ib1tDg8qZoY2jMwd1Rfu9chaykv8CuGf3LkqBiHuqZFAh+yG
	 aKeIat7LwXw1A==
Message-ID: <e6637dcc85ca23efaf72af906f364328.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b57ccc2-7060-4adf-b896-8992ec05125c@linaro.org>
References: <20241028163403.522001-1-eugen.hristev@linaro.org> <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org> <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org> <b587012e868f8936463c46915b8588c3.sboyd@kernel.org> <7b57ccc2-7060-4adf-b896-8992ec05125c@linaro.org>
Subject: Re: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com, evgreen@chromium.org
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Date: Fri, 08 Nov 2024 11:00:13 -0800
User-Agent: alot/0.10

Quoting Eugen Hristev (2024-10-30 01:28:14)
> On 10/30/24 02:40, Stephen Boyd wrote:
> >=20
> > If the rpmh-rsc code didn't use writel() or readl() I'd believe that the
> > data member is simply a u32 container. But those writel() and readl()
> > functions are doing a byte swap, which seems to imply that the data
> > member is a native CPU endian u32 that needs to be converted to
> > little-endian. Sounds like BCM_TCS_CMD() should just pack things into a
> > u32 and we can simply remove the cpu_to_l32() stuff in the macro?
>=20
> This review [1] from Evan Green on the original patch submission=20
> requested the use of cpu_to_le32
>=20
> So that's how it ended up there.
>=20

Thanks. I still don't see why this can't just be treated as a u32 and
then we have writel() take care of it for us.

