Return-Path: <linux-pm+bounces-10006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A25917761
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B8F1C21153
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF814EC7C;
	Wed, 26 Jun 2024 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAKR0Zwp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C14D71F;
	Wed, 26 Jun 2024 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376274; cv=none; b=eRxkEU72/SsIuyg3QzxbZLtP5cr4WR+HewVuLM1KITJRji/ggoIr17c+HbbWB2D2LoB3dCRrQUcIyTnwr2aSK8cm8dH2Bsfcm0vwfExyyGtmWAaZTGdraqQsigR05HgK/2OwBgqnWEgetCBdyFHdVs8tJUDs7j2yID63gz7IkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376274; c=relaxed/simple;
	bh=EpfKXypVeB2ryN0nmSFY6sSkru8k3eROrWZcpydC05E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E24CVlGMNOrYHhk7ps2QOu9JrVvUGwaTCR9zSuJckjrYepLSrAI3l5jLFHIUt7STVYLcJwXGPZ7SdDFTUJpbfvUaPQ/G/3tOStxibf2WcttMSnVIVar9OOxF+IFrwgl1ayh4zWWyGBhxiBTK0f6WrU1D4SkIxfFZ94KasX/62pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAKR0Zwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242AEC4AF0E;
	Wed, 26 Jun 2024 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719376274;
	bh=EpfKXypVeB2ryN0nmSFY6sSkru8k3eROrWZcpydC05E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAKR0ZwpO7/MATnQJURq5q8Jl7tg3+M5h2dT9VB/4YZjuSxhuaC1jh/+sa0uj5BFQ
	 +2SkHpfzYcS5Ona87V/1Pw8xsR+YDrZ+/Y6okslNSGbLfhA/jQP/HCVdyn+keiLE7i
	 m63+8P6GPm2+hav46gKuWDbLMG6TwWSZZ8+Mofiq6Ad+JTsd5oqdvDBBfmHKTUZSfH
	 ZtvAeVRrCNPoYgB3VavWxn7ohCu3F5oIZL+A4OPK0j+YeXrjP8uRAoQR5Uv83t/ogG
	 iqc8hQDc3w+wjW5PeiabzDlEx4nYIzETZ1tgOb0fHuOh8pb5N9saOP5CdBn2HUb2Ya
	 U09n/61YmzBEA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	djakov@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	dmitry.baryshkov@linaro.org,
	srinivas.kandagatla@linaro.org,
	Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	quic_rgottimu@quicinc.com,
	quic_kshivnan@quicinc.com,
	conor+dt@kernel.org,
	abel.vesa@linaro.org
Subject: Re: (subset) [PATCH V3 0/4] arm64: dts: qcom: x1e80100: Enable bwmon support
Date: Tue, 25 Jun 2024 23:30:58 -0500
Message-ID: <171937625575.44413.5172531893949710866.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624092214.146935-1-quic_sibis@quicinc.com>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Jun 2024 14:52:10 +0530, Sibi Sankar wrote:
> This patch series enables bwmon support on X1E80100 SoCs.
> 
> V3:
> * Pickup Rb's and Tb's from the list.
> * Drop OPP table from the required property list. [Konrad/Krzysztof]
> * Update commit message describing the race condition. [Bjorn]
> * Update comment in the bwmon driver. [Dmitry]
> * Add a comment describing which cluster each bwmon instance belongs to. [Konrad]
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: x1e80100: Add BWMONs
      commit: 740bc66960527754d4980e649953fb8ccecf67e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

