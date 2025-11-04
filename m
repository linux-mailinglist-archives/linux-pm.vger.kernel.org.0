Return-Path: <linux-pm+bounces-37341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D6C2F350
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 04:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25AD189D027
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE432D8395;
	Tue,  4 Nov 2025 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTDPJlgE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475002D595D;
	Tue,  4 Nov 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228180; cv=none; b=QXBe62SD28h79RgFy/UGRHGOf4snTyliKyqTMYSMpzS0kigAKdlYWlhZ2tbNozeYmyiW4tmxlSqWhZ0zGPR3BkphJiut1QJj3BBlfxQlWcdL874UYz2Hzyn/JbZER7mwBsd0XmUQaoZtKyisG5a1/BC1xXHNApmZUX45NkaD2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228180; c=relaxed/simple;
	bh=28NMXwZXCav+Y8gksmH0jp0P5W8Oj7avLSyoMs1PTaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtY/B8tz/nvt9X/4Y9do4AGMmQEfdW8ZCseaxL2hId4gfJ5Ei30RE++gxkarVH/PjgIfAd8t9tu86JUBYmStxsMc4ZCjFkrRGwkkUqSzYACD7++TiV/6a6uYst1JgJLaNAlzkYQhXZjEKzQInj5dyjvDoqQtCbzvhE7Ujc+Brcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTDPJlgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B33C4CEF7;
	Tue,  4 Nov 2025 03:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762228179;
	bh=28NMXwZXCav+Y8gksmH0jp0P5W8Oj7avLSyoMs1PTaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTDPJlgEMJgryPfVB6oACV7cOmtKnXknsS3BlnPfFyQ+j8SWR8naFgo4LegLdEw1F
	 uD371ltSmB83JulAgrefbAbPEUYfu6HYB5Tf9OX0ha7B2wHo6QZ9gWXoWp7pfRVfby
	 CKBMLnauvSubfeDSRQfIo3aJl6sW0qmQiNsJ+i2A5eBF6pDb/uVMMqnvSQQCR7fHa8
	 EVXjAR6toSylX7r/FkKec7DNylwmXSHXqaRsmbqQb4MCDZzij0bSsjdPgy9X3GZ/sG
	 LNpBYMOKTdH0OxDjbNKQ82seU/hainRWISnSWLga3QJVp+xAhFij9m6Bx2gdvaFzpR
	 lWZUP9xK/Ky5Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luo Jie <quic_luoj@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com,
	quic_pavir@quicinc.com,
	quic_suruchia@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 00/10] Add Network Subsystem (NSS) clock controller support for IPQ5424 SoC
Date: Mon,  3 Nov 2025 21:53:03 -0600
Message-ID: <176222838020.1146775.4424499650459139284.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 14 Oct 2025 22:35:25 +0800, Luo Jie wrote:
> The NSS clock controller on the IPQ5424 SoC provides clocks and resets
> to the networking related hardware blocks such as the Packet Processing
> Engine (PPE) and UNIPHY (PCS). Its parent clocks are sourced from the
> GCC, CMN PLL, and UNIPHY blocks.
> 
> Additionally, register the gpll0_out_aux GCC clock, which serves as one
> of the parent clocks for some of the NSS clocks.
> 
> [...]

Applied, thanks!

[10/10] arm64: defconfig: Build NSS clock controller driver for IPQ5424
        commit: 4e13c6aed86f4409d0e6385a6cdad41994575990

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

