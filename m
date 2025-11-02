Return-Path: <linux-pm+bounces-37255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA385C2946C
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BB46343CC9
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9E214210;
	Sun,  2 Nov 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViYJV8lA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D67640E;
	Sun,  2 Nov 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762106785; cv=none; b=q718l++V0H/GaEybNp7lmouv4skpl8xDk4mf6zqrQKV0UVLrVWRCURVXunmJ9hnhMAH+lbo1592Ajmil1DPw/rtyhOavQC2r0mbY1p62qGfFOSlm/0nURW+QP/7fho8dANuIzTNsJAMaHXEFshnebgfA86yEbOlYA35brHWWs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762106785; c=relaxed/simple;
	bh=CKxwzY0aA7DUm4DNC0UhHtHkMhCo6hDr/gCSy3gIOCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/MDLkGEto7YMAXDJbmlZIMQ6JWsjAHresllYlhT61TB40XiQIlAR/Ig23jk4NE6oxUhS4haU5gDC08GVEjznI8qwltoBVCzfVU7sQHAJXdh47j4v3BjIuWR3vHFgMYaV1nZE+4K/FOgRTtIRTYKoPoqqyj41Gy9jqntLtu2nJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViYJV8lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B92C4CEF7;
	Sun,  2 Nov 2025 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762106785;
	bh=CKxwzY0aA7DUm4DNC0UhHtHkMhCo6hDr/gCSy3gIOCc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ViYJV8lA2TL+8arEhROZANIFczraMbO25MBCO/S0nvoSzJZAB8PAk2VjiPk2YHrbt
	 aKTdHCxFIQvCD5sWF8NO3M8kmGo6cOWT9NduHw8eTLryw+djSWxYBNBS7uhNkXzbhy
	 niniMvAHiF/Mpel0PI/HyKUxQMEt6RIaqOiLSQ5wu6GoLqnV0N8R1IXi1CuL76OyHx
	 RD21hWRdjduRlfttW3I3qatliYHnLfhckGMnZJbKQrfNe2DF56vSBEiDVMXgTWB3iD
	 f7GxOYIRge6c6NFQx2Bc2AWvue8bgQNpj+QZopPQRor6X4lU/lg+Zyntiefq2Ph7/L
	 FiTJCfPM+9fNw==
From: Bjorn Andersson <andersson@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] cpufreq: qcom: handle ipq806x with no SMEM
Date: Sun,  2 Nov 2025 12:09:44 -0600
Message-ID: <176210698631.937813.14540787970530195151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031130835.7953-1-ansuelsmth@gmail.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 Oct 2025 14:08:31 +0100, Christian Marangi wrote:
> This small series handle a small device family of ipq806x
> devices (Google OnHub) that doesn't have SMEM init.
> 
> We improve the SMEM driver and apply a workaround in
> the cpufreq driver.
> 
> Changes v2:
> - Rename error macro to INIT_ERR_PTR
> - Return -ENODEV from smem probe
> - Restructure if condition in cpufreq driver
> 
> [...]

Applied, thanks!

[1/3] err.h: add INIT_ERR_PTR macro
      commit: 652a86b24c5ac444afaf7625c9340d55aab7f105
[2/3] soc: qcom: smem: better track SMEM uninitialized state
      commit: 7a94d5f31b549e18f908cb669c59f066f45a21c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

