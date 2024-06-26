Return-Path: <linux-pm+bounces-10005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D191775C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC2A1F22ECE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 04:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F314B96D;
	Wed, 26 Jun 2024 04:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt6hK4kZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964814AD30;
	Wed, 26 Jun 2024 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376272; cv=none; b=EYaX48cERqC5Ol9IJXOs094h3hm9bimL6hM/ay3xJMxV+QLQ4GlJcOyUCOLzw8xI6OYNtUheOTVTerOrqovogDe0Hi2V+k/0nkauDCf4LTpVvxIMbWtHpfKyO3HutA9Fv9o/jd2pdS9ovR9ad3/xkE03YKQv9Klob41r4ymDrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376272; c=relaxed/simple;
	bh=jRrAmThMn+KLnXIClFEf2sOq/D7DxgId2nDtKP2TGWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heAaCiz0e0xHfT1p45jI2nUikf/tZPe9nIdZythnLzRXC9OsJcRMkUQB7fKy5OaEyAcGAUreIPkIjBSCDWuUnmNPxLfWeiIaN1MrzUXQyzHI2Kw/4m0f/AWlaWIwoRHoTblbDmuRxfQDRp3TA6YmDjDvwauezInVBmxhYGze1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt6hK4kZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BB7C4AF0C;
	Wed, 26 Jun 2024 04:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719376271;
	bh=jRrAmThMn+KLnXIClFEf2sOq/D7DxgId2nDtKP2TGWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gt6hK4kZHPhvUmdaxNIZb4PDYEBARU9Y1GCYpMKbCQZm1svnNPbzGAL2hXsJ7ij+i
	 FpnlQ86GEn37dD4C0z6xR/dZC49Yy2avfy0nsuP51tyLxf1Yz1ecdDmtjQBjP/3ug4
	 NgcKySVYamhH9Mj0l3E7liUOqa99c7ojG/OHEEA40V0fjeajhw8Fchr/GXuMtjDbBq
	 v1Oq0H/WGVmfrO5e10NQWBl4U6F2YwVVcJsuqOwaM8Jo8oGyyuKaJzEM3tzeaGTywt
	 v/KTkTMMFWWtBMIUIBai1BNLPlSSBO6gO8zGOzwsvRWzhE2Bahl6vXneVkBCl2/LiR
	 dFdWtIgOgsB8A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Kees Cook <keescook@chromium.org>,
	cros-qcom-dts-watchers@chromium.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	quic_rlaggysh@quicinc.com,
	quic_mdtipton@quicinc.com
Subject: Re: (subset) [PATCH v5 0/4] Add support for QoS configuration
Date: Tue, 25 Jun 2024 23:30:57 -0500
Message-ID: <171937625570.44413.2134077970188921583.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607173927.26321-1-quic_okukatla@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Jun 2024 23:09:23 +0530, Odelu Kukatla wrote:
> This series adds QoS support for QNOC type device which can be found on
> SC7280 platform. It adds support for programming priority,
> priority forward disable and urgency forwarding. This helps in
> priortizing the traffic originating from different interconnect masters
> at NOC (Network On Chip).
> 
> Changes in v5:
>  - Replaced platform_get_resource() and devm_ioremap_resource() with
>    devm_platform_ioremap_resource() API.
>  - Initialized the qosbox pointer in ICC node using compound literal.
>  - Added conditional check for clock property in dt-bindings to the
>    providers which need clocks.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sc7280: Add clocks for QOS configuration
      commit: 2b5004956affaa6dd1d23d431876ad533f10418b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

