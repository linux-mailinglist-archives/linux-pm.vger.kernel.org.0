Return-Path: <linux-pm+bounces-32946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA9B32D07
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 04:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF711B2764F
	for <lists+linux-pm@lfdr.de>; Sun, 24 Aug 2025 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C71D9A5F;
	Sun, 24 Aug 2025 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnR50E6Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACF225D6;
	Sun, 24 Aug 2025 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004161; cv=none; b=BtiPnOWRucpmRfXFB0JOVlg8Lu9TSO+ILNNy7YiOQCA2EmahifTTHqgdSfZ+YWugiEADKQjPGMnvx2bSOaPbq26jiXZmBZljDxXYh8ANMOP4WkVWDjGwLB+XzCL07OcssFDteOIKXRFvMdyHLdQ29z1c4Zf7QXQ+qcYk47oxkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004161; c=relaxed/simple;
	bh=+OE4zk2QOOZCHgX82O6BSFFjtdDPcgXJ/GXAHDpLonY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nex6bnfdpy0VIVp/yzfeAaRKfZ7lzCtGp6VzonLAdoyAT3zgZfzMI7tolsTyE7Hm/iwFXr/qopyLNrHXRnBlhgrCRKyKGWdycThdZYu6AWNHPggFngnZrFDqCbKyMyD9zEz/i3j/1Oz4ofnT34d/+PwUuEaIDBnnQ9mlTNty0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnR50E6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD6C4CEE7;
	Sun, 24 Aug 2025 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756004160;
	bh=+OE4zk2QOOZCHgX82O6BSFFjtdDPcgXJ/GXAHDpLonY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnR50E6QfsaE6+wSpYXZysqcrTN9KQ+uP78ptO2NQxUXzvuVhewgxe/RoHsPCj1Sp
	 0TPHDcTpz+Gi5fIOUZFS2d6U04pj2K7nG62H+y3MZ3Do3cxXUFcFUfCa0dCY+JxyPQ
	 pEc569a7+UMwpbFtugTZ3Avhot3Yq1IOAq3PLMe6ztbrUbodgT1sT9dFiEnawpcw0X
	 zKsTHT8dNv8kZfBwhvNf18xNaDnEs4qFV7ZGrq1QMtY/NKv6aT0hIWDSpCAaATdEnW
	 e7Zc+yEHilL1pDTvx8Gnble7gd712hzuqq5IZ33VC/WcogO5syktkLFKpCnRJyiDVy
	 3QVTZ+mKw9CYg==
From: Bjorn Andersson <andersson@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/4] Support for Adreno X1-45 GPU
Date: Sat, 23 Aug 2025 21:55:33 -0500
Message-ID: <175600415279.952266.17398839743993518772.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
References: <20250623-x1p-adreno-v4-0-d2575c839cbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 23 Jun 2025 19:42:05 +0530, Akhil P Oommen wrote:
> Add support for X1-45 GPU found in X1P41200 chipset (8 cpu core
> version). X1-45 is a smaller version of X1-85 with lower core count and
> smaller memories. From UMD perspective, this is similar to "FD735"
> present in Mesa.
> 
> Tested Glmark & Vkmark on Debian Gnome desktop.
> 
> [...]

Applied, thanks!

[2/4] arm64: defconfig: Enable X1P42100 GPUCC driver
      commit: cf0ed173d27a2a832642aa441eb28a4dca53fd19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

