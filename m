Return-Path: <linux-pm+bounces-32947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF4B32D06
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 04:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DDC3AE7D5
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA561F461A;
	Sun, 24 Aug 2025 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVitS7dT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2519D1F1527;
	Sun, 24 Aug 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004163; cv=none; b=BlhO2APy0kTLdufoGfGaLSS7/ERwmHlP062Wj92yA6lzmZfNvM8UZ3myGR97I69Cl4s8AYHCutVGH8vDA7f71GJnG7YL3MkaqwCbhoU2zH0Qzhtut6ub3Yo0GqBtNS6+rtfS2BqwvXedgU4WmEWxKL4A4Rcd6dRnbzPpUVL+5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004163; c=relaxed/simple;
	bh=8x+UbB627SyJ/j1B+W0FdzspAC0kIm99NwlAYZ2UktY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx484tLsALz4eg3LY55vNUU4nzon6Sp1w9btpBydPfnYxW/QdEnM4O5VhJXnvyq8EP2lNU9d5O4+VlN+4/06A9C2CtYWcvM5i/BffRFBasUw4bQrkfgNnqbEjMLzOIsNEni7mDIVAGkEucjA7txTvlPO78AvNmWHND4WYKKG+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVitS7dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A99C2BCB4;
	Sun, 24 Aug 2025 02:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756004162;
	bh=8x+UbB627SyJ/j1B+W0FdzspAC0kIm99NwlAYZ2UktY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVitS7dT64E+P+CmzEsoeBYr00FqP7V0W2h7znwv7LOrGRjFW556Jd7/EMKJUBuXj
	 1Mk6HYFEkcXZmN2k7o3Dp4VKj2FGp8RdLEFVI7o4pdpL2W1CHXTNas2YVOQP4kZSaJ
	 xW29uJ4aPmx08U6aot5Vf17xdEoUnXJE6hZ0a13VSZ/BDIv9R7Abt+hVZ8zLSboNm+
	 1nl76CpR7FvNZ7nejfPEBF1mnMTHWH7nCInixuyMimHwd6aHrAqql0TdLgRxXVu1qv
	 oHM6jKSdxyUgsbwFnAO71knAR2LbDifBONsGKFaLujXZ44d1CIrBAZ7AerVgBOOM0h
	 Mq0ozUusiRtgg==
From: Bjorn Andersson <andersson@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH 00/11] power: supply: pmi8998 charger improvements and smb5 support
Date: Sat, 23 Aug 2025 21:55:35 -0500
Message-ID: <175600415274.952266.6319138445314463147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 19 Jun 2025 16:55:08 +0200, Casey Connolly wrote:
> This series contains fixes and cleanups for the pmi8998 charger driver,
> as well as introducing support for the newer smb5 charger found in the
> pm8150b and other newer Qualcomm PMICs..
> 
> A bug is fixed where wakeirq enable/disable refcounting wasn't respected
> when the driver was unloaded and reloaded.
> 
> [...]

Applied, thanks!

[02/11] arm64: dts: qcom: sdm845-oneplus-*: set constant-charge-current-max-microamp
        commit: cb2347ed822f77c6b04011ee3140f7483d206018

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

