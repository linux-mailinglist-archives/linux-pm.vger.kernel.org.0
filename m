Return-Path: <linux-pm+bounces-32948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3DB32D3F
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381773B053B
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77317242D92;
	Sun, 24 Aug 2025 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp/L285J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB1242D6C;
	Sun, 24 Aug 2025 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004176; cv=none; b=SeaLnaD+moxFjHa1CPwLdGYiNwfKNju540+D6J2Mz/aFblrd5LQnxUG69R5k+njM3VYmPNYmdCLmvKSkjTOeyKDObpFeGSAuhACaztofnKv86ESCJF91TB8PrUhmjEMmdoHSFMyuryZM9UPNXqbRlD3hsY2JuoFWUHchKbiF9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004176; c=relaxed/simple;
	bh=YoBQlm0ulSox3GmjDc721psnQpnF9RNfbeehuLeMArQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkkQOKFhsA9lLarMSEWHL8IP3U3a3aV/HJoPkQ85AfjA4VF1tJuSw2qlfGTlxBBe6vKMLdlzwSB7wqqpBrCQl6WHuEctKg91qOZwfgor55Id2wLJZVUVuz++mHZkOi7dikNPOI6rdfqBBF5t8mlyKCqgjfgJNNv3NT1Xxv4uIts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp/L285J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9736C113D0;
	Sun, 24 Aug 2025 02:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756004175;
	bh=YoBQlm0ulSox3GmjDc721psnQpnF9RNfbeehuLeMArQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mp/L285JmYGRq+LCzcFVp1/DXEJ7HSy6Cc9KXQqpsziPWkWnNQLZK0qZxkfoWnhK2
	 9wMvO/Lbquii8jgBLvTHVP/m0MAmqD2m9rGUHynZmBz5TG+aUIHVk3+N3GL+WkAl9k
	 YbZCC2+FzASNo6EHgrRystdht53vhg8kTBM6i01Wr86FHgWWfAxnWiD/4v/qb3fK27
	 m9R8D+DMEFJNvhkxCY7+30SKVPzfw7ls128wCD9LJLu9s79gWHW0k+jW8UWJqzPwwQ
	 3IHFZtBPS3/ynhQ4mqcdfzqmMeA8U9YnW+B5tKrTGlHTq+nEZCNxOiP0qNUp1SzFf5
	 B7gXsaqrkpr5g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/3] Add support for clock controllers and CPU scaling for QCS615
Date: Sat, 23 Aug 2025 21:55:49 -0500
Message-ID: <175600415261.952266.11240532352802429049.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 02 Jul 2025 14:43:08 +0530, Taniya Das wrote:
> Add the video, camera, display and gpu clock controller nodes and the
> cpufreq-hw node to support cpu scaling.
> 
> Clock Dependency:
> https://lore.kernel.org/all/20250702-qcs615-mm-v10-clock-controllers-v11-0-9c216e1615ab@quicinc.com
> 
> Changes in v5:
> - Update the documentation for CPUFREQ-HW for QCS615.
> - Update the device tree node for cpufreq-hw to point to the new compatible.
> - Link to v4: https://lore.kernel.org/r/20250625-qcs615-mm-cpu-dt-v4-v4-0-9ca880c53560@quicinc.com
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: qcs615: Add clock nodes for multimedia clock
      commit: f9c36698db91780eed4ee3a90794bda2a4252166
[3/3] arm64: dts: qcom: qcs615: Add CPU scaling clock node
      commit: fecc6e0b0260279cd1508903db62f370ef4530d4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

