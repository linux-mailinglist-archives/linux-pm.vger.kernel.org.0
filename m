Return-Path: <linux-pm+bounces-40307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA942CF818D
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 12:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E67309E324
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC3E327210;
	Tue,  6 Jan 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3pWQots"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F18326D4F
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699244; cv=none; b=mnGPjKX11k9PpGgmeXIMGUOwuX+EIwEqcvRdj0WGSPauzckpY/XoEx87tbOMSC8o5UxBvxuCiyois7jSsoFGbU6m1q/BGZdRsMzxWi0b5sjzGpAQTEfbAQWjCqt118U7+tlrhXd7rYtQGQprWPSyKmDHzC8CtoZ35bRgBMtxmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699244; c=relaxed/simple;
	bh=e7aQPfqZchv7cdvTlfV1PMxXNwB4FVHC6zfkDDRF1xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfeiQgYw5l24vz67NSqHGiUliGcRIY6siWbns8Vch6AyswyRCtJQjquPUc6sGGvFmqvsJlOfQBgNyzlXVl66R3nOG8TcYfVdwRc7Lkt73IutuKraSRi3MhEnFp7acW5Gy0Eom0hGSnSCeCgmxJdpgKKMo2nfxJFpqaqbZHpug/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3pWQots; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D73C116C6
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767699244;
	bh=e7aQPfqZchv7cdvTlfV1PMxXNwB4FVHC6zfkDDRF1xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D3pWQotsytWQtCtlHl5KBBCHpCDnrh7CFamjX4YScQ7WoLh13Zl9OaZHtoCtxxxl3
	 o0QGkHNE4AHUeZuUk5AJtntDfydeVGfflbOafjnQfozmfyrnJn1MaRBqBdaVHykAzY
	 mOXtOYE837Zcjo6/WqWZp+vYxZnlPesQJdM/nfQAOAW4yjdVeqZZTeWQBJ+w9K0264
	 G3//SWOkJj73OT7eYK2X5D3hskxFA9Bo6bJEdpCNwP/m1bGkuD9X7ja82R2IJM2InP
	 czZFhnEW5bVPb3TQMvEURHBmVHoV/4180rwsrSsV9pNvOtqDKyMpqH5CzAzax77nBt
	 R/IIOShwS8LAg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59584301f0cso1029555e87.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 03:34:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8gied0P1mFpoRtZW/QHGdnu+SrDnUGqBMRep9DqoItMxrUIYT4x6GFZKtEAl4lsSo6G8IhaIJwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywee80ZAAQopuJ6Igx0Snck8LbP44pbM8A3qvIE8cRgqWepecLh
	RLKBqUgxIpjSpwryl9ACH0q2zqTexc6+oCvvwpL7M7qWmDVaC0h61Q+7y5OtW1ohTZvFAQJaMbJ
	epmuwvilsWr/0HaP+nVIR+mG89CSB61garFRGBLCvPQ==
X-Google-Smtp-Source: AGHT+IH6WUvrwJ3e6JIw+OZTKRmcLjomwAx5325+HpSyUiSTaP3mUf/7LgYZd13U9tO3lCh2JtbVraYQqOh0LYYUFzc=
X-Received: by 2002:a05:6512:32c7:b0:595:82ed:ff28 with SMTP id
 2adb3069b0e04-59b65258a07mr1027826e87.32.1767699243013; Tue, 06 Jan 2026
 03:34:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com> <20260106-excellent-pygmy-puffin-97f7d5@quoll>
In-Reply-To: <20260106-excellent-pygmy-puffin-97f7d5@quoll>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 12:33:50 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfVsFY1T_PpT8nQ5AjcYrk_hy2Rgd6L0-Z7L0oB8D0uMw@mail.gmail.com>
X-Gm-Features: AQt7F2pSNlyD56O3PupToeH6RHiDz4jFG1ufbKtVNPwZRdtJy5ouVmj8OutkSdU
Message-ID: <CAMRc=MfVsFY1T_PpT8nQ5AjcYrk_hy2Rgd6L0-Z7L0oB8D0uMw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] regulator: dt-bindings: qcom,wcn3990-pmu:
 describe PMUs on WCN39xx
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Tue, Jan 06, 2026 at 03:01:11AM +0200, Dmitry Baryshkov wrote:
> > WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PM=
U
> > (clearly described as such in the documentation). Provide DT schema
> > covering other Qualcomm WiFi/BT chips to cover these devices too.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  .../bindings/regulator/qcom,wcn3990-pmu.yaml       | 100 +++++++++++++=
++++++++
> >  1 file changed, 100 insertions(+)
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>

Mark, the bindings describe a device controlled by a pwrseq driver for
which C changes are later in the series. Is it alright if I take it
through the pwrseq tree?

Bart

