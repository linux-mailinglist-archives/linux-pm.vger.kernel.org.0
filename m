Return-Path: <linux-pm+bounces-672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB7803206
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BC31C20A19
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AA23748;
	Mon,  4 Dec 2023 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DETzKrJo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121722EFC;
	Mon,  4 Dec 2023 12:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8506C433C8;
	Mon,  4 Dec 2023 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701691318;
	bh=dj/jyhV+xo1jIzRIWtSaa1FCw41fyfaNus/o63XmaOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DETzKrJoOxI8mNS42lev4LPYJoY7SNqoFhoV3N4JrdRLyKD/fCkaXSGhPRXNmsYP1
	 PL7uXpifJxEZx0a3muC+XCTJv8o/7wr7Dqa4gGjdcpRZBTbb5i8gUfgxw43ktJe/z1
	 Q0klyTAVyoJhyur68luJo4G8dLLR2yKDnoyvB1lAYPZEhVVdLCeYhzjBxYv2vTvrjz
	 SF+p50oSFAHgZDug1a1l9yNHA4VzO5AIb3wbDbhxc5NnaIHluGWRR9Bzj9+vY6d7nA
	 Lh9goruMTArrrp2I4LKGLymul/uMvubIKxj1836pj78p6CdmpDrkaGBIyU7YLjj+gj
	 eqJGF1Mt4OLtA==
Date: Mon, 4 Dec 2023 17:31:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
	myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
	cw00.choi@samsung.com, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	Manivannan Sadhasivam <mani@kernel.org>, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, quic_asutoshd@quicinc.com,
	quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
	quic_narepall@quicinc.com, quic_bhaskarv@quicinc.com,
	quic_richardp@quicinc.com, quic_nguyenb@quicinc.com,
	quic_ziqichen@quicinc.com, bmasney@redhat.com,
	krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
	alessandro.carminati@gmail.com
Subject: Re: (subset) [PATCH v7 0/5] UFS: Add OPP support
Message-ID: <20231204120137.GE35383@thinkpad>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
 <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>

On Sat, Dec 02, 2023 at 08:54:46PM -0800, Bjorn Andersson wrote:
> 
> On Thu, 12 Oct 2023 22:51:24 +0530, Manivannan Sadhasivam wrote:
> > This series adds OPP (Operating Points) support to UFSHCD driver.
> > 
> > Motivation behind adding OPP support is to scale both clocks as well as
> > regulators/performance state dynamically. Currently, UFSHCD just scales
> > clock frequency during runtime with the help of "freq-table-hz" property
> > defined in devicetree. With the addition of OPP tables in devicetree (as
> > done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> > both clocks and performance state of power domain which helps in power
> > saving.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
>       commit: ec987b5efd59fdea4178d824d8ec4bbdf3019bdf
> [5/5] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
>       commit: 725be1d6318e4ea7e3947fd4242a14cf589cfebf
> 

Bjorn, could you please drop these two patches? I found the OPP regression in
the ufs-qcom driver due to some patches that got merged last cycle. Nitin is
working on a fix for that. So I'd like to defer merging of these dts patches to
v6.9.

I can resend them after v6.8-rc1.

- Mani

> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>

-- 
மணிவண்ணன் சதாசிவம்

