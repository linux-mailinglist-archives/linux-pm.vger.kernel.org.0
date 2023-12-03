Return-Path: <linux-pm+bounces-646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED218020E2
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 05:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CFC280FB7
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 04:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42A6258C;
	Sun,  3 Dec 2023 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmupR+rs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15153B3;
	Sun,  3 Dec 2023 04:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52632C433D9;
	Sun,  3 Dec 2023 04:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701579120;
	bh=+8e4OFe3EdKH9blpRAMonn88ZGbTlQ39Lhkc8fVoJI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmupR+rswIhDNwX/r0GAt9uEm9pAUUKLFhV0BNzQTpsPZnvCrjLleG5tHRZEb8uhD
	 KU0Ha7FwM2r8c9y/f6xaFPHeeTGxlTywOmoywo70vRXsdpEWQquM8tc9SZ2zH8NQr4
	 0gMY8h5jlYvn7EjkZLHwOXEgsqPg7+PmMWCeX9x7YsvqX3hIF/7EHS3RpfCIe6CNrR
	 8MuPW4JGYcMPRHtMC83m/rGEJWM26wY4ig4KQV2TxvV1zrK3w5iKcOO7coESP2wiH8
	 vZ/iqwQHOucrFu8CXHl5IxKeMtZpYYMb8yURwZfNizzRgHMfoJvEf9I+81i7lzwLtP
	 IWiAEqXhpnJHw==
From: Bjorn Andersson <andersson@kernel.org>
To: vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_asutoshd@quicinc.com,
	quic_cang@quicinc.com,
	quic_nitirawa@quicinc.com,
	quic_narepall@quicinc.com,
	quic_bhaskarv@quicinc.com,
	quic_richardp@quicinc.com,
	quic_nguyenb@quicinc.com,
	quic_ziqichen@quicinc.com,
	bmasney@redhat.com,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	alessandro.carminati@gmail.com
Subject: Re: (subset) [PATCH v7 0/5] UFS: Add OPP support
Date: Sat,  2 Dec 2023 20:54:46 -0800
Message-ID: <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 12 Oct 2023 22:51:24 +0530, Manivannan Sadhasivam wrote:
> This series adds OPP (Operating Points) support to UFSHCD driver.
> 
> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
      commit: ec987b5efd59fdea4178d824d8ec4bbdf3019bdf
[5/5] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
      commit: 725be1d6318e4ea7e3947fd4242a14cf589cfebf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

