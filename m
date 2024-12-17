Return-Path: <linux-pm+bounces-19391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B19F56FD
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 20:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFECE16FF70
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 19:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFDF1F9ABF;
	Tue, 17 Dec 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE/E7kri"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AB1F9A98;
	Tue, 17 Dec 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464454; cv=none; b=kv6fpiM6nU7mmBNWpYEMPXQv8aArClO78alW+KAE05iD0BxZCSVz8PobA3R4WUYqLBxjWwQ7xhzeG4bQasrIX9/e1Fe18knIjHbwSL1FgG34T7cWxnOLw4pf7Ghjt6Luh2JONLNYyakNccsmRGKs3fi2qwswP/21TGBE+JA71V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464454; c=relaxed/simple;
	bh=sMWxwMc5jv9BCRlE6TvdrDoir8ne0lP4dSkKb9txpdo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Hbeua076MB4P/2aoytSnSWy3mh7BMmtyXf3L6JjeWWa/+VsjCoTWYYYsLtD9FSBVskIcJ80wsqoKjL5uYrKyHlwy8RaagMXXk+ZRvT6UQBh1I6ye4Bf3GKGIcZBP9G23m/Dk1IxRo0Q65PE123W1IGgs2a1c30Rp7J4vl+Mpgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE/E7kri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C60C4CEDD;
	Tue, 17 Dec 2024 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464454;
	bh=sMWxwMc5jv9BCRlE6TvdrDoir8ne0lP4dSkKb9txpdo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZE/E7kripekEf6Lm0/9RX3ufX/1nbhN/fOJVrQoyenTTT8qEQrBYdlBIWkpVfp8Ko
	 ITFq8vDwPfXEAo7fzrLgguh4wwWMOv02zTpjtyYVZtFsL2gmr3vSWcBDmw/Km6IM2y
	 8MJSB1qk+Xcczy5KZcN5RoC55KpyIxr+yzFL9frXSGSNHxjdQ21FCzMbK519njemtQ
	 d+K6zokf879oSxhreMBAXt/RlAOwii3b08YdQ2UcmXXWM8RR+oPkf3lr/ihLp7l1zN
	 xZMWA617d8DwipEp/Olq6czk8Nh9ihQIyftPCV418doR+fcD3V4fudys3hhyaZriOG
	 qhywlLoyQU1kw==
Message-ID: <08d2d8977847e1bc0bfcb1b884a6fb59.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241129142446.407443-1-eugen.hristev@linaro.org>
References: <20241129142446.407443-1-eugen.hristev@linaro.org>
Subject: Re: [PATCH v4] soc: qcom: Rework BCM_TCS_CMD macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, konradybcio@kernel.org, andersson@kernel.org, evgreen@chromium.org, Eugen Hristev <eugen.hristev@linaro.org>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Date: Tue, 17 Dec 2024 11:40:51 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Eugen Hristev (2024-11-29 06:24:46)
> Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:
>=20
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades t=
o integer
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades t=
o integer
>=20
> While at it, used u32_encode_bits which made the code easier to
> follow and removed unnecessary shift definitions.
>=20
> The use of cpu_to_le32 was wrong and thus removed.
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---

Thanks

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

