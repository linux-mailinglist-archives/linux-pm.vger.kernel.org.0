Return-Path: <linux-pm+bounces-10727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17080929596
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jul 2024 00:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AC3B21879
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702E14A0AB;
	Sat,  6 Jul 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGm62Djx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269E149E04;
	Sat,  6 Jul 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720303308; cv=none; b=Wynt1VcNCOa+1a9lDKOMSIp72GRCPBiU6Y9ld6sPLk17YDT9907C4RZ4MwhHl+ofxAJqCB2eLHh8qFR+Cv/kjU9Vjja0rLZsGKNxE3PQeGwUDOahU3SEhzWihg3hIb/y8/R6m/bVU0RAuuskwc0Vo+x1kWYcRxHCI6c75/XFBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720303308; c=relaxed/simple;
	bh=zJQ+sv70wnU5ECjnANokUAvYNlF6PCMCQach+GmptIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9BQS95IvVNC889i6iaqvEWIxdvn+fQamk3kEKabaR8S60Q2gTNPlLRr/ra86r+oQ+yBQHf1QJ43kk+W5RO/rIilXC/WtN8PDr9Rp641pwY9Wmc1xw9YYK882Dl9K7fZESQArXYt4aTuSBK35NK+c9MHW1WN/OZ0s3jCygxe+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGm62Djx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E90C4AF0D;
	Sat,  6 Jul 2024 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720303308;
	bh=zJQ+sv70wnU5ECjnANokUAvYNlF6PCMCQach+GmptIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PGm62DjxtiPliLZkuwr2VqqLG2JU2q9OdeDv3RGXNbSlpHWOJvRIm6Hj5yZONeDIK
	 maTYTtJTifco2nMLOfbiGDxbdX56LkgZFU+9W7xj4FfoSRfyNz/kDmXDkNOiVzAqOl
	 3lhNc2YWn96NwphvPYgJZJZnP6akzOkBR1PHL9+VV9ODGrA2CSJNuhiCLqTK7Obq+E
	 BZNh5s6QTh3Yrq0hDfNpjFmCTRr9eaHoqyNNk+jErf9dFmNPGApFZohFo0Ii6qlCGh
	 x2mKJ7ybR9JNhOBPdqguZGX24VQZY4zN3h/FUcgGSfF22UZFcASZmAicBr8iznu23E
	 xqVoJgvNVImwQ==
From: Bjorn Andersson <andersson@kernel.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	djakov@kernel.org,
	dmitry.baryshkov@linaro.org,
	quic_anusha@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bryan.odonoghue@linaro.org,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v11 0/6] Add interconnect driver for IPQ9574 SoC
Date: Sat,  6 Jul 2024 17:01:29 -0500
Message-ID: <172030328815.28909.9070446553779931676.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Apr 2024 12:12:08 +0530, Varadarajan Narayanan wrote:
> MSM platforms manage NoC related clocks and scaling from RPM.
> However, in IPQ SoCs, RPM is not involved in managing NoC
> related clocks and there is no NoC scaling.
> 
> However, there is a requirement to enable some NoC interface
> clocks for the accessing the peripherals present in the
> system. Hence add a minimalistic interconnect driver that
> establishes a path from the processor/memory to those peripherals
> and vice versa.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: qcom: ipq9574: Add icc provider ability to gcc
      commit: 5d0ab61a700214366dfcca5893b87655261e8c94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

