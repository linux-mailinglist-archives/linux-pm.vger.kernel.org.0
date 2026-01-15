Return-Path: <linux-pm+bounces-40895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A234D2238B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CB10304D0BA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092D288C30;
	Thu, 15 Jan 2026 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoxfoRC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0532882D6;
	Thu, 15 Jan 2026 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768446014; cv=none; b=pxG1H+usinTjn2bOZpCPYFN85oPp6VHGJxou01/OAvctMI1GuIwaMLL3cCc73ahZwgigBOD0K+/6aH9J1iE8d9uPf13fTgXI4Q56y2hopCaRsB6WhhwICgoYb76xpot9cc7/XXoov2aQe/frSM671X52P0DqhK3API0mIHazvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768446014; c=relaxed/simple;
	bh=J42LSCXNo43KBacwqraKvUzVYW6gsPAF9kFFhN8iRxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzzZ4hN3B0/eAXn2qGfu6Tnc4hAbTO6W39RA+4D3FXGrJC9Iaxo3p1aICdKLwzV9MnBrOLbCfh4qhqvw5jvrklFpV9wXbH9XyuuCQdbqLnWqwFPg7/piWT5d2+fNyUx11IIM6dqI0tNwDVjpqpsYnwGL5EM7YiSjUs02KwMfhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoxfoRC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6513C4CEF7;
	Thu, 15 Jan 2026 03:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768446011;
	bh=J42LSCXNo43KBacwqraKvUzVYW6gsPAF9kFFhN8iRxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoxfoRC3H/hN+Lzm6qbOyUGJX8IrBq30J92L5cWVVciUyE78nQXghAZLEKWPnNobO
	 Ox0W/ksdWaAj2nuWBQzR8EJB4TRtjEl/6Us/ab6TI5bsb7XaMgH/IpfO3SfOlW8x7Q
	 vp8LEKjI978/p+TWaf0495Tbmq9Q/2BGtmdquT+0DQzxwGpGlno0eB2HwkrC8UZGEk
	 hy22Y4pIkxRLp9GOUPgoKlffdx8/pL9vgEB12XXkOG2QyKhB1OVVuDC0NsCpJbgaSq
	 ycQK2a4rWYIBsquojPVOFfO58MyVHdVuf+bRH4Cju0GUm9GyinbOjEbaXlb/c2U0Tr
	 Y9fEoL6AAiWNw==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/3] Enable QoS configuration on SA8775P
Date: Wed, 14 Jan 2026 21:00:03 -0600
Message-ID: <176844599489.144315.9204321098309778105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 01 Oct 2025 13:03:41 +0530, Odelu Kukatla wrote:
> This series enables QoS configuration for QNOC type device which
> can be found on SA8775P platform. It enables QoS configuration
> for master ports with predefined priority and urgency forwarding.
> This helps in prioritizing the traffic originating from different
> interconnect masters at NOC (Network On Chip).
> The system may function normally without this feature. However,
> enabling QoS helps optimize latency and bandwidth across subsystems
> like CPU, GPU, and multimedia engines, which becomes important in
> high-throughput scenarios. This is a feature aimed at performance
> enhancement to improve system performance under concurrent workloads.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sa8775p: Add reg and clocks for QoS configuration
      commit: e7fc2fee4212714485d0efb12cdd9fbb51dde078

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

