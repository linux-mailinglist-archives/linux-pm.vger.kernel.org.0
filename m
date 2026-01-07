Return-Path: <linux-pm+bounces-40394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C06CFFCD6
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127D2316AB07
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8933E34F48E;
	Wed,  7 Jan 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyYIkfaF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501834E772;
	Wed,  7 Jan 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811111; cv=none; b=U0IfCmxgtsV/E89ZR3krGrRkM6YDvLery329sEon3A89EK0YGyhy0C/ItMuXIth9H1xrqrH3Fg76Ki6B9J5LhzaTZUxh942NG3mW4Nkqxmx+h699lB8VR+6KZ3IlZVSRfUpZ8EDOcmjzNbEAocfFgnbpx0+BHEidg7Qi54Y8DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811111; c=relaxed/simple;
	bh=giwVjXZaInPGem3clXozi1NVnQJ6c/GXXvkKUWc/mdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNgdlhgK7lHfmMFeRzLqG1tcSVSMb/4zrifYB7sfr7SBt1bhC6vF4vt35sfK5DWzp1GWadV4T9tlIr6rm29lBgJ5azYudAmws4BpEkS7VIBuCHnRok0OUHgINbg7k3Fna1qCSBlJbBZX1x+4/RHrJ6My4d+6rpyZ8ACM1xvjPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyYIkfaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27B8C19423;
	Wed,  7 Jan 2026 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767811111;
	bh=giwVjXZaInPGem3clXozi1NVnQJ6c/GXXvkKUWc/mdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyYIkfaFNbrooZvS1bn+upWyNOkmpmanoQJKjmWVyJGSPv7YnzQheRu4wn8uQz8AW
	 T6+mnsZ3Mhl1bFTJoO6+7N9LCrGW0CJVK2s16lwq4Irg9NlTUjXkiBepUnmw2r8018
	 nvXBEvvET+svEA76HYqZgg8wS28wTxjfbV444ObhSh+5zy1PNLGb2X9ZzjaY/QUErp
	 PNZC+SlFWClZAWOPLwFmrrDwFmfVKXIXjVRvHRxqN4NEWHkJogs86UlqeRQ10+ttS3
	 Hq/CcqtPOvsU0WOfo2UHnMd+DqAk9K2D3acqINZC3uBnjvzEEpxpWbKBSSie0nWtwW
	 uj2qrOe+WvoPA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-clk@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/4] Bring the IP0 resource from ICC to clk-rpmh on QCS615
Date: Wed,  7 Jan 2026 12:38:19 -0600
Message-ID: <176781109957.3262943.14829046212346314366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 27 Jun 2025 21:37:54 +0200, Konrad Dybcio wrote:
> This is how it should have been right from the beginning, but it seems
> like nobody took a good look at the initial submission.
> 
> This series is essentially the same as the previous [1] again.
> 
> Compile-tested only.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: qcs615: Drop IPA interconnects
      commit: 8b7f2aa05c02c13aa017a70401b5f8a3ce0c0f57

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

