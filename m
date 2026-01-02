Return-Path: <linux-pm+bounces-40115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2DCCEE359
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 11:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1F73005489
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D42DE6F3;
	Fri,  2 Jan 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InwP9xW1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4425334B
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351154; cv=none; b=NSi9sl0TExoPbVK1upRSEZOkvZIE1HFy4Y+L44NUbgDVHb9xpDNswuA325M+XVlSqOqKleRBzUC18t3EE0z2/33nPgBrSAc5WgUd+TQ+p7hmDC0sOoK9ZI8bwHlR07kVClkUVAzqWyDuEWTGOV8jpAHeaCjEoYhwi8K8U7AmE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351154; c=relaxed/simple;
	bh=mhZD+26yEtIqCTAfVl9iT6ZYu15zs4sSgg8F7ighC/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6uRLnoSu26XSFx6aHOliuJ6lDO/W07+Xm2qL4owZ890Zl8mCN/tvGyLKcjbvyXd+8tUYyoCZOJa30OOCxdLEmb+AzndDKBV8F2aybK0EMoB19xb7CqoFOeC+jlSBuxbKOGkP8aNJt2crMgbro45p9VQSjs1FHxJUc4Qiajd2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InwP9xW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2F7C2BCAF
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351154;
	bh=mhZD+26yEtIqCTAfVl9iT6ZYu15zs4sSgg8F7ighC/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=InwP9xW1I1ni08BlWGWK+GAPLve+MXWdoKdtr18MdtM9bF83RPLYXTL/LO5wfhsVV
	 2FVpYHiaVkLTWfu2SFY0Zu6nm4DP53mmoFHo2CIBJsJioSiCxZuN/G63RKPBz89sNO
	 VygW9iZcIfUvCZqP4BLQd7aooFXJDLzM0upAXsjfDCkWv0pVimk/JKi2BAltZY6j3p
	 oQJ0Fcbr124+NePC4LKGFpkKcPgUWjDCURZRYMBGQZMWjjGO/xdEtwZBbuxiAKT4P7
	 FP14WjR4nZmHPP1h4pB6ValPFNTqHR+PcsTiPpqKsZc1hOj7VnOwtMeAnSEk9CeLW6
	 Cd2yxy7XUDrUA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37b96cbd875so99678421fa.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 02:52:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXB7Thv6Ocmx5pai8WXP4t1sFsP3mTL3Vvjd5Pj3pSgP7EvR2pSbtgY2548rr6GvbWyF+dpMCMc5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YztxT/kpA0qxTIZg4lWmq2+ZiJ+IB4k8BjEka1H9/Haaz5qCiiA
	JOEnDruSRYLmCw7+dLivyEzj7fATBf6NgdRF0qDf/FsHEmo+6bs7OuM/B7vfYFX4pFXqngVTfuK
	g/xPb0kylkmL49ZgVb9PB4SnBfqnS5AdWu4aYsvBMaw==
X-Google-Smtp-Source: AGHT+IEkijWZVdRyZfarXVptLNdfZhckPE7YTk4yGXdpMC27+XXwuO9MbWOVBe2OQdvs7v7NIIGKVSPwU/N6XBL+2jQ=
X-Received: by 2002:a05:651c:f16:b0:37b:b952:5e4 with SMTP id
 38308e7fff4ca-381216a3091mr116221171fa.43.1767351153062; Fri, 02 Jan 2026
 02:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:52:21 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mc_EMHUAoZo5KhBGkwX4+ahpD6mp1T+C_snZ1OYwyPnkA@mail.gmail.com>
X-Gm-Features: AQt7F2p_C5Mpx5B7tQglyUSRmxWjVo8OJ-K5UDM9nvA4aAjRO8UklT0vre9Z7fM
Message-ID: <CAMRc=Mc_EMHUAoZo5KhBGkwX4+ahpD6mp1T+C_snZ1OYwyPnkA@mail.gmail.com>
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

