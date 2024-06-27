Return-Path: <linux-pm+bounces-10093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8531891A03C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DBE1C2124F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FE48CC7;
	Thu, 27 Jun 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HERNeb5T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A921F5F6;
	Thu, 27 Jun 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472648; cv=none; b=SITSCqyfcdyIeejkUD+G8XJqzEkvDQ80DxK7jX73B+cTrfgOiL+i4TBnZE/xM1yLG7JMqwrsJ6uLI+X4QqmikJ5z0iXtw32b5DMth7GMAwanOZ0YHDuuzcFFiXP6VOVHbmgE7XinNloTdTZ3sa/QY/dpIC/bmnS4ST/QFowLzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472648; c=relaxed/simple;
	bh=wMJcr2AWNXAAqsBo+j58KGQEpUUJMlJJ71UaBYzBD/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CbjoUqJycZjfzjGe85B6wzr/lTdcOSjO8onil2qbCjn8sjOT7P/zw6zOdAkJyMX8WgB1Gog/bYBmF0eqZx3h4FG+dpWolbL7GNuAUn9atR6pM6N1xpcZ+ycigGTyqJZ6kDSs+jFHsKAa7CuOZCk9mH/R4cIAWt78/XXjdnyEsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HERNeb5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E36C2BBFC;
	Thu, 27 Jun 2024 07:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472648;
	bh=wMJcr2AWNXAAqsBo+j58KGQEpUUJMlJJ71UaBYzBD/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HERNeb5TFl8wr6/bUfHVUH53eTiaDWeEyKLJokpGnAdBM+PnVnvwt5MA7klY17/5Q
	 GGn4I/pBdr9thz4SDFbRldbx77fbw5wkKMPd1kq9eVSpc2SkluIawQc2088xXs9TSj
	 Xgx6cLPeCCam+aV2I/tQx+N+X0I5PfS4h2rmIG0F6MIXrq23huuv4UmeeJSRlzPe96
	 w9iul2HYRPEOzl8nVVKeAaGoWdlB3kOzx8eI2YCioEy7VPI+fD5B/D18BD+omx0jKm
	 s78cSBo3FIIGIDS/b3H8wR69hfbwydRIDjOK96D9LNytEg/ss67x0hzwXTRmfREnjh
	 jzH0FD4lyoIOw==
From: Lee Jones <lee@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Bryan Brattlof <bb@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240621-ti-opp-updates-v3-3-d857be6dac8b@ti.com>
References: <20240621-ti-opp-updates-v3-0-d857be6dac8b@ti.com>
 <20240621-ti-opp-updates-v3-3-d857be6dac8b@ti.com>
Subject: Re: (subset) [PATCH v3 3/5] dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-Id: <171947264540.2846153.16605174762988368253.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 08:17:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 21 Jun 2024 11:39:39 -0500, Bryan Brattlof wrote:
> The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> various components on TI's K3 SoCs. Add a compatible to allow the
> cpufreq driver to obtain the data to limit the maximum frequency for the
> CPUs under Linux control.
> 
> 
> [...]

Applied, thanks!

[3/5] dt-bindings: mfd: syscon: add TI's opp table compatible
      commit: ba5901bc8fd7206fb0db445fa405c72e93e36e46

--
Lee Jones [李琼斯]


