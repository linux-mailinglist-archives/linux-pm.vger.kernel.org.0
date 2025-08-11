Return-Path: <linux-pm+bounces-32207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71168B2192B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 01:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1519084BA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36461275846;
	Mon, 11 Aug 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o38BbkSk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF927146A;
	Mon, 11 Aug 2025 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954841; cv=none; b=DDNIZdtEmYDvVaLl3XQ0d+zACNWEE3FmyyvIjPViLiETTybwjxn698TY0/lGqd5SzVQVgy+JDfLYhU+6OkukHjTCmEgksB0cJlRS42m1p7ocm38/67ow8yBtsBbOUj8EFtgIlejedX/AxzxBz2OFJhbeG3vBqY7NfXEHCcuku4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954841; c=relaxed/simple;
	bh=a3tJqycywWx6VYcje/kbsIrUutzEeQbuRrhztsLOoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evXvfScng+nrKquKVj5bRImNMbNT2F94saLGfFT5wa7MHAkDmNWkQKLv+sqEcH2SCOWjOwgCB6hg8/ckFQqJtbm2onoMJlMXPK22emk/1DCGPAlaX3lXBxmY3kUVYmiGV4BsgeqFh19VyHpCrvG1sCM2/uRa7yvBm8oICR3MG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o38BbkSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A949C4CEFC;
	Mon, 11 Aug 2025 23:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754954840;
	bh=a3tJqycywWx6VYcje/kbsIrUutzEeQbuRrhztsLOoio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o38BbkSk2bdeYu+uYtWqJAEdIyfXGlM2zL5q34lwcNldylUKgOhdHN1QI4XcOtgZk
	 ljk7tqta2MKYsDrUnLJc9BnpeNWrqQQKmPC2uCNuHHzFMvVGLiFubWnj5268Q+Muge
	 pFApXmDjlo8xPD+OFj8VY7Fg2DR9JLssx6mzKiSgvsZ1IEdQtcqd0Fq5UuxAarLacS
	 cbD62zq18E90SYYSp7cabAI+PqybGnOtCjqwuVz1UccemFX8e3ZCmZLgmlBdujuklW
	 zykq9/WT+tD/zS4bjUsedvCEHi/KhVcjXknYfoaAuU6HVmOjL83WpMauVXMCKfj9cX
	 3pP1mX8XT2O1A==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/2] SM8750 CPU BWMONs
Date: Mon, 11 Aug 2025 18:26:56 -0500
Message-ID: <175495482452.157244.8001894319000750143.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
References: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Jul 2025 14:25:45 +0200, Konrad Dybcio wrote:
> Taking this series over from Melody, just adding some small changes
> (see below):
> 
> Changes in v4:
> - Extend the bindings as necessary
> - Re-position the nodes to maintain order
> - Add nonposted-mmio for the instance that needs it
> Link to v3: https://lore.kernel.org/linux-arm-msm/20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com/
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm8750: Add BWMONs
      commit: bc6776fab8455762089274d469a67d104e3b96ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

