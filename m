Return-Path: <linux-pm+bounces-40206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8682CF4260
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD2230E4A07
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC826334C1C;
	Mon,  5 Jan 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE1u4f1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF9334C06;
	Mon,  5 Jan 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622091; cv=none; b=pi+jAvIlqKXkFVqSKi6ekBVMSoiNAfAFXi/RwisLgb5LY8Z32kEnccyK7rhaiH61NLVOW5laJGNSIpeSXuCCsVCuQdhAC96yzoWVYMqV/yEC9kDw9lY+T+cdbrHg/NZFxaDjyE17TWs2HV+2emcLlg4sCR1Ay3dvWaVXEVrfz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622091; c=relaxed/simple;
	bh=JbU6/9RTZj0D3k+N0ksRUgHeEcLhzPVkjOPCWjbnR3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzjvnVt+kjL70vXz7zqUoNYKsoOlyciJpnROAZW2jVS8uWL55yncGAbkafwYFlXDIvgqlDuThSrnBBQMRpSKwkD332W5TQDutjnF/02eT2KjUVsL1qfAB8V7tPDFadPlIE2udkrUnykitAXatG/9cGFcNJk8ddI7wUgU5TUWqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE1u4f1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C96C19424;
	Mon,  5 Jan 2026 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767622091;
	bh=JbU6/9RTZj0D3k+N0ksRUgHeEcLhzPVkjOPCWjbnR3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VE1u4f1oKtMGMAxJ73glVXHgah1CU6v+nKvD2R5qHByQOysDuoe1nHE9YDMph34gc
	 oBerRwcWP8IHV+ydHnumbnK2uu3l8Jy0Lz6/vtRs21lmF9XwnN2gykZ9IJplXGciG+
	 jcqFTJ1CD3pxuaQ6UNnjsMLufGqTvZN2PUBiT7Gwl1Tk42Jb7a/IWD+/jcxnZAu5bZ
	 asYzgo8ElRHDGq6m4A5cLXCNgfSF51sWg1TWRWgU5kdE7GKtu7wEYYKHBgvZogFYD8
	 /w2x8G0E2QoJ7lJ6QjA7/ER5kCst+TIlCHMqCSihmyAn+pQrh/9DZI2aUQrkKRaSk5
	 fzygvuoZ10lJw==
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
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	George Moussalem <george.moussalem@outlook.com>
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH 0/2] Make standalone compatible for IPQ5018 tsens v1 without RPM
Date: Mon,  5 Jan 2026 08:07:21 -0600
Message-ID: <176762206407.2923194.17383971400718113415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
References: <20250818-ipq5018-tsens-fix-v1-0-0f08cf09182d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Aug 2025 15:33:45 +0400, George Moussalem wrote:
> The tsens IP found in the IPQ5018 SoC should not use qcom,tsens-v1 as
> fallback since it has no RPM and, as such, must deviate from the
> standard v1 init routine as this version of tsens needs to be explicitly
> reset and enabled in the driver.
> 
> Accordingly, update the tsens node in the IPQ5018 dts and remove the
> fallback compatible.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: ipq5018: Remove tsens v1 fallback compatible
      commit: 60fb18fbc234efb2d59472a889282dba2df3402a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

