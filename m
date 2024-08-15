Return-Path: <linux-pm+bounces-12280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9E0953D6A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 00:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6521C217E5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2024 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FC155A30;
	Thu, 15 Aug 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6Ma05/0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09171155749;
	Thu, 15 Aug 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761880; cv=none; b=JzUYOuy3kQEYPjPYlqMQMIb+ywc2RDJuoFFBBvA3/yZuUx+BwBkVnNNHA3Aei6wrvCxfz4/Tc9tP1D86iNsWEjfAdUSwb3HbxnGgY87i3GOtZonhUZvNSIAzJC5H6T53CvcXA4BwGrfgVyB72IuQ56fikiJ2rP2O2khE49wlTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761880; c=relaxed/simple;
	bh=3Qx0tBWdBqRWRwLbebYPtrr68pJ2nhyDUpN/fjSrIL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZAJHxkw70eWVxKMcFSEg7uXGvhIePPkjcxiuzbh8ouX27Db6S9idN6Qv5c5lJmR2LgT41xjWB7M3ra5Pw7r4VKO9SGsCr16NqwGxajC8C2C6zI8uxi8C9+BMHGXwlB3w5sNi9grBBGewW9Yz/wsoop2EqRaJX1YhRKmWSm2kTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6Ma05/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E00C4AF16;
	Thu, 15 Aug 2024 22:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723761879;
	bh=3Qx0tBWdBqRWRwLbebYPtrr68pJ2nhyDUpN/fjSrIL8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X6Ma05/0xbp8Je9T1ekSJuRx4fa40M0ha/JXxbrJxElnXd8232v/2yQx795UiXbon
	 bnjqm9JnRw8eCKIUY6i9wVMVVE67hkFdkdOPNX7M4T6/q4Eci54gDPx2mPDtcJhmzY
	 UVpKxl+PqbKVa6R6o+yotwI5X2SdxwfojqlvaETmxKXqw5NiS0YH1zJztotV5AiT5V
	 oDtKggyPi74SUHF9RiwIeKJ6nH3TabuSUVbNOH7P19eF1rvGCWXLTVfsaYH3lgCnmK
	 b9AFF8pMQ2EQcX0hQdexdwiifPGhsusCq7vfwJ2GjWMkGaNmBp1B6/m5bfqqh2sEA4
	 iKLEpcsqWy1Fw==
From: Bjorn Andersson <andersson@kernel.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	djakov@kernel.org,
	quic_wcheng@quicinc.com,
	quic_kathirav@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v6 0/5] Add interconnect driver for IPQ5332 SoC
Date: Thu, 15 Aug 2024 17:44:33 -0500
Message-ID: <172376187137.1033860.17130088505061446205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 30 Jul 2024 11:18:12 +0530, Varadarajan Narayanan wrote:
> Enable icc-clk based interconnect driver for IPQ5332. This is
> similar to IPQ9574's icc-clk based driver.
> 
> dt_bindings_check and dtbs_check passed.
> 
> Ensured that icc_sync_state is called and relevant clocks are
> disabled.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: ipq5332: Add icc provider ability to gcc
      commit: 8312d0f20f835a58d89edb1d55bf9a0f2aeceafa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

