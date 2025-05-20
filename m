Return-Path: <linux-pm+bounces-27383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E651ABCD1A
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 04:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A442C8A49D9
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB725D1F3;
	Tue, 20 May 2025 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVsdPKdK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859225D1E7;
	Tue, 20 May 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707322; cv=none; b=uaDGOctZinX6QrVdThUAe8NJSvbVryRXchgVBTrAvRcHEfXL1IKLekHirBBSPOL1/8Zv9U5y+pBP0BBKVf85RJLEhDxsmxVOLlPeWjBCgBJG1FON5xX8nh7M8lTlAHm6qz/6HLtkFR7BCZaGpzNio3jgnKh/2EUHk51bNnNEZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707322; c=relaxed/simple;
	bh=sDj1a2CHWVAWzTtBQAwB27Nd2fqFSCK4xyb7LVVr4mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf+DRUu7byBucyNJnmDQnGv9hRRNOMrzbo3MVqg+f8RFkhrCNAsroZ9yF5OaRgw4Yzej6VzF8RPgd3zCsdpQjiy/8KHNGEnwrxlYObjp33RhARuq+YkzdWnOZUJ56NpUxmmwmhvP39y7Yn37QlB+evLRN/gVnVXvAzHP05oPyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVsdPKdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBEDC4CEF3;
	Tue, 20 May 2025 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707321;
	bh=sDj1a2CHWVAWzTtBQAwB27Nd2fqFSCK4xyb7LVVr4mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVsdPKdKQHuA/Cw0N5IFr3R1kzoS9zfEb8KQL71QoEOk4+x9f5KqWlL407l4YAIvD
	 3nRvyZLtow1ZLkH7B9OANBmza0EiJ8QgJOe/2h/C4f7/u9N2RbIz5gjNxojX3l2ZhV
	 X89nl63egA3KLgVtypM6ysTxiFlLOdkzPKAkCL6PBRp6oLrBrdYv2axtxc8pxZbw3R
	 qEgrnBKvSrYl1Tx+lv3jpxmhMSuyuSanGKwEyN5D2ulpriUFwBeZ/Yb91Gv0ZnKfBB
	 Uz3KfqHishp2gRMm97wBEY1H7MH+gfeU9JBdbk3PxJbFkxFDcW4tZisq9gPH+95ZZ2
	 Qgvj78W/MEGlw==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Imran Shaik <quic_imrashai@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] pmdomain: qcom: rpmhpd: Add SM4450 power domains
Date: Mon, 19 May 2025 21:14:49 -0500
Message-ID: <174770727734.36693.8218880275663137820.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
References: <20250417-sm4450_rpmhpd-v1-0-361846750d3a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Apr 2025 22:37:38 +0530, Ajit Pandey wrote:
> This series add power domains exposed by RPMh in the Qualcomm SM4450 platform.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sm4450: Add RPMh power domains support
      commit: 654ac800d4ac6bd4bffa7e98997a1e0d336999b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

