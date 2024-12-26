Return-Path: <linux-pm+bounces-19768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD19FCCA8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D60162B0F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAF1D61AA;
	Thu, 26 Dec 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVsLKle9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF041D5CFA;
	Thu, 26 Dec 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735237640; cv=none; b=QsmR7Rb5iR9UR67SWFm+kQfVD//pNqO/FY2MlpAgNAvZ9wMKWY2FY3d/jZGDxatXypTA4tbXRCiBSWFnw0iic22ZdeIaNJ4VBrHpLPnpLVonInHk7zyUs5+VrWeWuyQvm/53WMMLF6V5nVLPA3wm/3d4OKwXS+2r+hblEeNMoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735237640; c=relaxed/simple;
	bh=xJC9Nm0YHwJstoJ4lo3nMMA7t8v/iMOSBA6NUo2yGWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6Gh2NsgGFrZVOTIYBghmXHKeM4QxfOSYSm5Xngjh+SbtNVu5jDWIgQDkmTKoHfx6Ad4oJtnnbSOBvWKFTVoSZPtQb3gcsEzuHM7kCEdnNjat2Fe3Ea0VIHMXxtRCARAd1Ze2f3Ooov01gP53ZT40FgyYsNKjdN+5OqKoajwt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVsLKle9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD5C4CED6;
	Thu, 26 Dec 2024 18:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735237638;
	bh=xJC9Nm0YHwJstoJ4lo3nMMA7t8v/iMOSBA6NUo2yGWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVsLKle9jLY2CAfCHHV4TBcaXid+hYjqIuejZsZDa/5fN8WV8Bc9W1oB56YsT88lY
	 GHZE37ASl5L2FOgcaD0kHJ57bIGeg/0Aj+DfP/Q60hR7iQ256XpJeyTGy/4oz92hf5
	 xUcHK83PM9zn06Zf3Z8uf3ZPWOIQacJzYIctJSLJekcoPz2Wspo8Rcj9NeEui+NHGJ
	 aKsFI8KuyikCVcG2DWYfcd6GrCUf9gjDiKzAZqp+0eCfKToU/T4ZK3l8y3oAD8W5Am
	 MgRej6EWD254NoXEm4/0ZQXy4GbGS5Vu8uGeYgrqaS9VcftMoCJYlDW8ZFzx8eoq/h
	 bVYoymCbq0lYQ==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	sboyd@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	konradybcio@kernel.org,
	evgreen@chromium.org
Subject: Re: [PATCH v4] soc: qcom: Rework BCM_TCS_CMD macro
Date: Thu, 26 Dec 2024 12:26:37 -0600
Message-ID: <173523761394.1412574.5233882312649238359.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129142446.407443-1-eugen.hristev@linaro.org>
References: <20241129142446.407443-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Nov 2024 16:24:46 +0200, Eugen Hristev wrote:
> Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:
> 
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
> drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
> 
> While at it, used u32_encode_bits which made the code easier to
> follow and removed unnecessary shift definitions.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Rework BCM_TCS_CMD macro
      commit: 2705bce5b4c45e2a0a354ec4df937d2803241cd8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

