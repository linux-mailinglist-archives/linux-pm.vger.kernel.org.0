Return-Path: <linux-pm+bounces-36918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15490C0E56D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DCC461870
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0730E0F6;
	Mon, 27 Oct 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+zB1IVX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517230E0C7;
	Mon, 27 Oct 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574001; cv=none; b=CDiD7AuVvKQhqBohY7271AqRr6MP8/dbvzqWEqDthbL3M74F8fmFz1LMG9uL/+9TDAXzpa053RhQzgaj+w8nzT0V0n6z8aw3wFxqtpavbTiijRce+Pai9sHapGZWy7L3phwgNE6Xa/cRsTHz8nl9g4zY2dGkavUWh/iP3RkaA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574001; c=relaxed/simple;
	bh=RGWphRDzzPcM4EqhHgkrtm3hWeUkS83durgAZDKmTaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ/5l2FNpeiMJYmuuGkYFfPg+wp18tw2+NDECXImw/n8HCs4c+Dx8i5MZruJe28AZDSs8+btoNHn6XBlnY5UyvAe9WzyWX0+mjbCz6OarwRI5t9HPxF518JvR9zeAEirfFbOgXMAwIhUJGZhL1upYCQ7htkKOVEyua1Yj0YnMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+zB1IVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F924C4CEFF;
	Mon, 27 Oct 2025 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574001;
	bh=RGWphRDzzPcM4EqhHgkrtm3hWeUkS83durgAZDKmTaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+zB1IVXPTz8c7MqEgNX+GoHbe/uQykjjACSMJRohPMke3BQ5kSqYZYAM7sTieqU1
	 qCq/flhywtDkuLZKyT/7gEMJMqmoGp18R3BhV+z+CCdPiXhg5VcgxhvDOsOXV6OyKa
	 8epEu53EIwWJYcMu2+OYjMvtZPHv7R8YqQ7acCoLQvjytE6WFiKYESiMi5KCtk0BSE
	 3K942iz2LPxbP9bX4SP6SS5pGc7kYCxIEd/YX4cUD1GTJ/2a8/1LjqBXOUdQi6QrRb
	 tEGNyaLT2zAPoiLHsknZ+ttOKHDlVT2/hwYL9jixVZ6xed4ihUh1wlv9To+SdBPeLR
	 ChTlWC6V77eLQ==
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
Date: Mon, 27 Oct 2025 09:09:14 -0500
Message-ID: <176157405461.8818.11028331830314686695.b4-ty@kernel.org>
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

[01/10] clk: qcom: gcc-ipq5424: Correct the icc_first_node_id
        commit: 464ce94531f5a62ce29081a9d3c70eb4d525f443
[04/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to use icc-clk
        commit: e2cf3b73573e24283e1c640eb9a186cfe3c01d84
[06/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
        commit: d08882c66d7a929c321cfaca9dee64e40eba3bd2
[08/10] clk: qcom: Add NSS clock controller driver for IPQ5424
        commit: fd0b632efbbdf427678a7a880abeb828bc4633fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

