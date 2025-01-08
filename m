Return-Path: <linux-pm+bounces-20068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E9A05133
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136653AAD80
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5C19DFA5;
	Wed,  8 Jan 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZlgRSJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68819D8A2;
	Wed,  8 Jan 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304778; cv=none; b=YuaOMdNKY0OrSDOQwdGMBRc6cGe5qhMKzIn8g5FzD1RQ3DfhEVKICRZGJw7C5ukfhc19wgZSuchhqdQLnZqp84CNhANH6WZNOYdga/IVcuzaNgfP3BxMN6Evj5Me65SEbKfhDOMYqZCliEXexYphwjYlqHe8+8NRR2+OttouezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304778; c=relaxed/simple;
	bh=RNqtwYaqW7MPjUOYh/8VKVV/dAixoasXf04+2SxYaD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCUGw2316NbxYItm3fr8XR5ZZRQpZseQHJSck9YTc5tSdMv7o7GvUNecptKsooAndGGxwUvooavVY5yuuOAxp8UmGI07sqBGSJENY95hUXTMAY6yLdXl57EFmhGDvExJYHicSLr3b7aOZEalnyjzaFH5odHMT4BnIQJs0CvmGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZlgRSJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB7C4CEDF;
	Wed,  8 Jan 2025 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736304778;
	bh=RNqtwYaqW7MPjUOYh/8VKVV/dAixoasXf04+2SxYaD0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iZlgRSJL2tEgLzwQaxyCk4pkLXsGOQt1N/BK0CyjzfxuU+zZe2GAyP+Go49bR7yVy
	 IXi3cc9Vz3NiDsVvJ7s75dvbJ2sntg2kqTsCy7CPPKX7vzR99SQrsAch0gyAuzwknc
	 YH4ICAgPcd2VVZwYIsqTqxXoGFw3kNn60+NG84GG5zSP9oL5CkmG3ZFTXumR8+0mFm
	 ilIc7/LNnpmxWRltQfQGeA7dh0NZku+PSnqQpToqmpRLqf4r7E1ISbdOGKNIQjl6MK
	 XKgma4LBjHZfCjso5wdlCEyUZjwuyaOwHKAXnBkgVpKMPWW4fcncW3qWfS/uINk0KD
	 5UG74dNYbSNfg==
From: Bjorn Andersson <andersson@kernel.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	djakov@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v1 1/2] dt-bindings: interconnect: Add Qualcomm IPQ5424 support
Date: Tue,  7 Jan 2025 20:52:47 -0600
Message-ID: <173630476483.101108.3442415567679884744.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213105808.674620-1-quic_varada@quicinc.com>
References: <20241213105808.674620-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 13 Dec 2024 16:28:07 +0530, Varadarajan Narayanan wrote:
> Add master/slave ids for Qualcomm IPQ5424 Network-On-Chip
> interfaces. This will be used by the gcc-ipq5424 driver
> for providing interconnect services using the icc-clk framework.
> 
> 

Applied, thanks!

[1/2] dt-bindings: interconnect: Add Qualcomm IPQ5424 support
      commit: 2e1c78bf674024375de6eea33e113acc3473d2e2
[2/2] clk: qcom: ipq5424: Use icc-clk for enabling NoC related clocks
      commit: 170f3d2c065ecb9757ed4e155e463aa25fd1eef9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

