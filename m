Return-Path: <linux-pm+bounces-22910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB1A44A23
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 19:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB751791E1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00920E01C;
	Tue, 25 Feb 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2uFrPmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8E20CCF1;
	Tue, 25 Feb 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507513; cv=none; b=SId+a8CKSHToOjCXzq7YA5Jcw8EcjH7CoWvT0AJ6A78zgEdSe/puEzIUvKG2wYW0+z8HnA8MkyW4vjKOTryysnBluzQnpQ3ZLkqb373ZL7l6PwipLmUCMA2l5afsG8A+XwvkR1F2uG/xV1AW3lZ26ElIjgx7dDEQxVxbRYgvNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507513; c=relaxed/simple;
	bh=mDv08GG5Y1yFdwnn7TPhlsCD/TXpna3VndLUAg0tHUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qgw9wj2N2z58g/KKtraWJErLILX9Lyp95WM1fdPik+rL/H7tE2heaDFL3E5NuBob65AVHAQt1d6ISIiWPcSj6j+oIFM0P2q/MKZgVMQfWkYUVvqcQRFaG5gwXegIE0nDJFQCrbMds/JwgdyMg98K+vz5ckytrELrREknei/7iWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2uFrPmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CE6C4CEF1;
	Tue, 25 Feb 2025 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507512;
	bh=mDv08GG5Y1yFdwnn7TPhlsCD/TXpna3VndLUAg0tHUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2uFrPmUINBMOyIMPM9AV3N7tjbXBmnu9OeToucXY3hidVuglkmmzxjqBz+BSHj4s
	 tp9Ay9tN7xabzGoi3dNfgftO8WBZhF+8vWwWpPSYEy22PANVUvP7Agkphx68O5QNHa
	 Bue7K2B+o+M/s7QEH1nWgGXvFprZlRuyGcjmWNxaoulMdZ9lyTq4EvLOjilt3Ea6NK
	 A0pDoG79TLMswdHqsWZaAFZTal44qkddCJoc1Vj9bFqaB8PhrOKy4GaINi6bB7njyK
	 ITMmHtIusNeYVffD+fO+FDX2PSzxNQo/yLiF6XQDp4hdrrGE1Xf96oNfWBezDictbs
	 fvIO8RkoNxzvw==
From: Bjorn Andersson <andersson@kernel.org>
To: amitk@kernel.org,
	thara.gopinath@gmail.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: (subset) [PATCH v11 0/6] Add TSENS support for IPQ5332, IPQ5424
Date: Tue, 25 Feb 2025 12:18:10 -0600
Message-ID: <174050748697.199016.9382215187345410231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210120436.821684-1-quic_mmanikan@quicinc.com>
References: <20250210120436.821684-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 17:34:30 +0530, Manikanta Mylavarapu wrote:
> IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
> upper/lower and critical. IPQ5332 does not have RPM and
> kernel has to take care of TSENS enablement and calibration.
> 
> IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
> (no RPM) hence add IPQ5424 support in this series itself.
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: ipq5332: Add tsens node
      commit: 3fe12c798f9abf26933b35b91d7aaaa77349c63c
[4/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
      commit: 9b341f34293f92096044431957a8dbd6793c8aa6
[5/6] arm64: dts: qcom: ipq5424: Add tsens node
      commit: a61adfe29624bd1a4530046e76808ed60927b9ad
[6/6] arm64: dts: qcom: ipq5424: Add thermal zone nodes
      commit: 017c28788a4caffb14f4895597bdf38ee9fc8f2b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

