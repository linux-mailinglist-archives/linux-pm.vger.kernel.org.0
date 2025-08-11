Return-Path: <linux-pm+bounces-32183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A14B21492
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867BA1A23161
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33952E2EF9;
	Mon, 11 Aug 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFD69BON"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19CC2E2EE4;
	Mon, 11 Aug 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937676; cv=none; b=L+I19pEzWbErr9oD9Q+wdnS5SisupIomWZUftV7gXgr8GJm02fE/vzNNMC3Vy607nT9Q/H3t1ngHmyMaT8JKzd5aZhx0Pd+c3Pg+MsicB5wJTFHLfkY71j/e1OMVYiqvlENTPHSdslGcuX3BOQfWYxW6/X1iS/3wPlS1SOdveH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937676; c=relaxed/simple;
	bh=wRdVneU2myHzAw9c5jGA/JiJKIwsqJlNt2ntxC158ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY9IdkzVmCrFVWmIsC3qDTcQHtQYt13xxmY5X7bdqYzGYiCfzc3UH6lafhWXBe97uf92I5MvNkWuA/5+KTXtvEaJPiI9fzj160ONmQb3kdAjTJMxFv40FXRGSkmkGFb+0qVt4V6N1X6yEbTPUPG5ybRciJSWo28KILHytW792RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFD69BON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD9C4CEED;
	Mon, 11 Aug 2025 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937676;
	bh=wRdVneU2myHzAw9c5jGA/JiJKIwsqJlNt2ntxC158ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFD69BOND9L2lcx2DkNAUPS10GatC2jPTqiL5wiNbnuSDr3FSXMbsuoV9K8XLeLxH
	 Rx9l8nWElQw79MlB2uBSHPppiYTg2zS/A90eT0HacYPbv+htrgUTlpp4818Tdv3Zzs
	 eAgSv2L2+w8uYYha6wY6n6bmGNPNU76I/BLGj9Zjz2yfJ5rl5zV8zhBuqenpbKIpBS
	 a5tWkI5RCkG8c5FPMa9Yl56vKjHES4gDVC61YRqW86669wFRPPI2q3Wbhedd0owgvf
	 wucJsN9aUZji73T+1xCr7aY3Ael4DkFU3g/beSjfhvSDAS6vbB3vURBE1U45smGDKV
	 QQ+ah6EJwHgqw==
From: Bjorn Andersson <andersson@kernel.org>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v13 0/2] Add support for IPQ5018 tsens
Date: Mon, 11 Aug 2025 13:40:54 -0500
Message-ID: <175493766080.138281.13653180985515249803.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
References: <20250612-ipq5018-tsens-v13-0-a210f3683240@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Jun 2025 10:46:12 +0400, George Moussalem wrote:
> IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
> and 1 interrupt. There is no RPM present in the soc to do tsens early
> enable. Adding support for the same here.
> 
> Last patch series sent by Qualcomm dates back to Sep 22, 2023.
> Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
> and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
> confirmed this SoC is still active, I'm continuing the efforts to send
> patches upstream for Linux kernel support.
> https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone compatible
      (no commit info)
[2/2] arm64: dts: qcom: ipq5018: Add tsens node
      commit: 450a80623e3b8bb5dae59e0d56046fc3d0a88f3b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

