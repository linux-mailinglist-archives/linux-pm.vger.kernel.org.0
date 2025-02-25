Return-Path: <linux-pm+bounces-22909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05C8A44A53
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BAC3A9199
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280C1DFD89;
	Tue, 25 Feb 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN8U5z0b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649021DD889;
	Tue, 25 Feb 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507504; cv=none; b=EHnkAi16kj1b43bFGrQYNyU76vEp9hRazHLDktUXyR+fPByYvWxeFjAeIIZHeA4WzHN31QbWADCparSomoRrex52UUy1gSXlYv9ZUsrIPEPloT7Ve3eo/11qTWDjCtrQOLwTtP+In18XY/HrbO67Fa1zxLSQKDUJE/hPRP6cLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507504; c=relaxed/simple;
	bh=ZjMQ+pssfFKTIr6yRoammUuYJ/1kG4vQQdLFHhGP5KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4H/NZoyXABvNlHHscIMMrg4lm2hBaV4BvIfXpWTWtEws0tLFAXpcnmCGmgqLVB0Ltf/kAwRU1cJ+a3fHHX1K0G4QSa2vX6o53TK1iCP54JtpyGMahRBlSb2LBf9rdgagO0+5vnr2SlBmJkhUJcB2LahoNsq3CSN5+ZK/HiJj80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN8U5z0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD97C4CEDD;
	Tue, 25 Feb 2025 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507504;
	bh=ZjMQ+pssfFKTIr6yRoammUuYJ/1kG4vQQdLFHhGP5KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VN8U5z0byiOZWqKBk0FoK/1J6XyUW4dWLvIeXcZR9nvA5Nx2pWKNmu2WzPgNCbUuE
	 kyAJNE/bDYq2B/S1BkNvCWW3Fkx64Cr1+fLkc1S31kRP7RBa7KoRwLT6jTcyjy+VTl
	 BhrocBFGwZms9yMXk3cIO/vcWUkIUl3RphQ656+lGd+A69aeNR3VlJlkD0JBQ3Mj7X
	 CGycCkNjR1vSkygHFIFnvYRmxtRo+ipELvlw9GXOHpVIAxlN0nN2UD7ZSovfK4DP+I
	 Gv4Lbx/JiD+Wje4WI+5yeQstbKtt/vXJhFd+cDOgKAOmvXog1Ezihf6kEoeHik1rcL
	 j3QLd80c0cGIw==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: qcom: sm8650: add DDR, LLCC & L3 CPU bandwidth scaling
Date: Tue, 25 Feb 2025 12:18:06 -0600
Message-ID: <174050748689.199016.8043254114817192987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
References: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Feb 2025 13:56:36 +0100, Neil Armstrong wrote:
> Add the OSM L3 controller node then add the necessary interconnect
> properties with the appropriate OPP table for each CPU cluster to
> allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
> cluster operating point.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8650: add OSM L3 node
      commit: 62a770da5327910233ff0b0e1989e14feb3d766e
[2/3] arm64: dts: qcom: sm8650: add cpu interconnect nodes
      commit: c9658c3963b8a5ebe488acfa2609fc641a126b60
[3/3] arm64: dts: qcom: sm8650: add cpu OPP table with DDR, LLCC & L3 bandwidths
      commit: c24db2c178578ab069dba8be81ef278854bad74f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

