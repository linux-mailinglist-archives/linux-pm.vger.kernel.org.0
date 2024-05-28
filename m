Return-Path: <linux-pm+bounces-8212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A48D12D7
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 05:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6A81C22368
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A013E029;
	Tue, 28 May 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpcHrd3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07F13DDD1;
	Tue, 28 May 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867188; cv=none; b=BIM0F9WifTbaAG38mV/Z6flj0Ys0W5J4wICQ2IOmjfwP41aUkNgnteehb9x+Z8NeTL324wvYIA5UlM884jMzhvLoNBBpplmbrnN8uoucpBm4UCa2dxhobEE2dvlRIpLE405vOuwR0LnMcOt+6esJhFcSro6DqZm9bBRrQAs580I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867188; c=relaxed/simple;
	bh=dmkQhH726QV4tXqveyEfM0J2Tr7bkFkZbQJeAmuA30k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OETJ8Akf0aX5C9uqT1S9irdkHUmIw2UjMLdRzxXOijhKf0tNut2g5kCJjHDNNjmjwFT0G2GyIyNgENUlTGgVfKqfMd/sYmDCiItdJp6+DokN1nucpsr0B4VFT1bdLL1HSd8no+IqTt8USdE07r/OBJYnGcm9sp8sVhVbuj479JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpcHrd3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F747C32786;
	Tue, 28 May 2024 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867188;
	bh=dmkQhH726QV4tXqveyEfM0J2Tr7bkFkZbQJeAmuA30k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpcHrd3peNExvtrcA/QbYMeqt/gPihJJRkcbhvnJo5IAsKHwL7BitrnYh9N5ZMlcc
	 C6LL4vC7xx0yyUnd6/DZFdO+j3HJwFRRBj85TpJDpngQ3ZBPq7mFdt568RZxHzV4q/
	 7LzfR0vo2fkvJ49nII060HF/jXzTZqEQOyoeC8uSOWzaNieJ0ZEaNKlm8xhhSXW5Bm
	 I92ljfyc+ydTqxWeztKsm+6QzUBvoAiL14ank/Hkt839kmTedx3Ms53F5jY+ordVKR
	 tjfAdVwrREflyoEcakJi6RA8r6W4ulNyxkGFUsn8kEQyKcWSVKdZvdD87SyYZrmhi8
	 oRvwtwbagss4Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2 0/3] Add support for the IPQ5321 SoC
Date: Mon, 27 May 2024 22:32:28 -0500
Message-ID: <171686715170.523693.6781951899387448559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
References: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 25 Mar 2024 21:19:47 +0530, Kathiravan Thirumoorthy wrote:
> IPQ5321 SoC belong to IPQ5332 family. Add the SoC ID and the cpufreq
> support. Maximum cpufreq for IPQ5321 is 1.1GHZ, which is determined
> based on the eFuse.
> 
> Viresh is okay to merge the cpufreq change via qcom tree[1] and provided
> his Ack.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
      commit: 27c42e925323b975a64429e313b0cf5c0c02a411
[2/3] soc: qcom: socinfo: Add SoC ID for IPQ5321
      commit: 8ddfb4a8e093689859184abf52fe15cd2523c6b9
[3/3] cpufreq: qcom-nvmem: add support for IPQ5321
      commit: 14ef045bbd27430dc92c8b4613caaf41e82f47e0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

