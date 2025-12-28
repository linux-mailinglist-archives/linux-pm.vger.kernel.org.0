Return-Path: <linux-pm+bounces-39976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C1CE5234
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 115093004F1D
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1241299950;
	Sun, 28 Dec 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqW052Cj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5502D1F7C
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937120; cv=none; b=PJsgdgOuuq+lOk1ze/h+n9thtDPdTynTTwus9VEmkBn1URzRb2UXvPJf2Qy1vQo54H1XURghujC/PTxrMNQVprHOHR44j6FcBDYD3sVNx/vI8wtk+jieN6ZtKfdScZ7yMAIRZDnqc3dGeYB3DzQ3LEBEHHBNvGzVxDhNVZHND1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937120; c=relaxed/simple;
	bh=Fe6KnB13Ls5dHY9O1D27EZ0qAE3PZZJ7I6YiRPmbAWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3zRx5KDBQRjqRYRGwjCTJWrZ+6Pz7roH/LMRKdaIciS44RFAuSGrtMO9Ch1v8aHZBHhJMPFMhg4TjAmW3l6IubQDeQSUBz8atu97FI92ss7un8lqGxf6tYfReNAjNNLMmmQk7fIYuuJPruq90QRjZty1sm7TP63JhpF5YzLe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqW052Cj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598eaafa587so9590786e87.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937116; x=1767541916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/m1vxR02WOyUjv42kPGF/giy/R0/NhZdgtsGDSOxAM=;
        b=LqW052CjHKuObDwd0aOvbc8Hb+BKDZQksniFpHNaJXyldvmVpYgC/949zaqWXEa1yk
         msjuVCpkF+Ws62dV5GD8dNX37dFqIiIwNE3RHw2JTV6ZqrzSiDk7OPRi2z2f9VvuJC62
         ALRBbxxiRNw9yl4IaHpVRuS6aLV1QBQd5u8VcGaUXKqKlvRve6l21SjdEmIyQ5ehX3k5
         z2LaAWHpis7ZhyNVCgE/Unf+ilbIB6wa4BMkW6nirzUDuaXEWfeyzdihhqJZWsaK8/1T
         Z41+BHEZ4h+WzgL7+lcL1NkN5JRShwsbQY+q3pqKGsd2lGnZmo6lKdi3b/D21ec67mBD
         77wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937116; x=1767541916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/m1vxR02WOyUjv42kPGF/giy/R0/NhZdgtsGDSOxAM=;
        b=Y8OdliI+0kasiFKUea3wGBBT2lXdAYhSpd1f/5Z0xKV/PhclOcHxJcVD4kZzj+aFNQ
         Bfw1T3jfLTDN4MEuOWGAQw+Y9VMJ2ZxIfin6C165a+wkMZX4aI5YM9EieCRW1WcYFqRI
         YxCSE4PSzXoXrCZGq194zszmYIKs3blX7QT4kAPBkF/RTGi2BWesfQ+xfzmLFN2Wes67
         vfjX8INncQJHYpi/GRZ6qtYLziCGgk9DWilogFD3s8TZhJI3TXyAwf9j3Wg7GbIMAan8
         h0NAu2BPyrcKD3PaoxgBFNQM3zZloDS62HcyrXMBi8xDQMFGSG4+V4R25b/qJawVZiDH
         iT0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRV2i58Ouf1q8Eg4jOWFCvhvB7jHY8JCVbq6clF+g1/sSlwPl3c83AgzEdstHpAES1hZAM4V3Bjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvdjRTOTQJmnqQpJexLs0GLkwBO2Jv3VThJpLFGsofaX5C8vv
	ljN509v6FxKB74uBBIarnmqiqihBFxVgptBCXt500jYJ+2oJdxSQhxH4ITVho2d5ydepVBCmg9W
	KpCJi1bW1KmhaySxobWcRYpLC8Ciitn0cpwaq2nbn0g==
X-Gm-Gg: AY/fxX4I6XwkIjx12laBWgX6QO14/ctEm9QKQm6OYZwmu73pTyk7d1pMkpY6P/HBbYk
	CFzF0TrT+iXPCYHzft9mYg8nxze2MpjKR/mh5e5YzNQOVTD9D046P/gl1Ib7QxhUHFtSmkVec8u
	F8dwlvzku+S/BapeuW4Hqijem9cqJStWlr1soFCZpH9M3aufNY12CguJTxispTecVfumP1ROS0B
	vb9Fw+emOctl5u3klLOoGtp1p8BaN4rdHZ+XI/rbPalO9Ljeu90OqwTPEx9+XFfldh0o0hCSDAX
	jgOq/Y8=
X-Google-Smtp-Source: AGHT+IGB3UutjLANyz+UGrs1Pqtz1ghxCPTBV3dlt5zsd0azNruBIQWwpwIrTOgY2yNs1XyuNUwLWDwXCb5ktjQfulg=
X-Received: by 2002:a2e:ae08:0:b0:37e:884f:b6ad with SMTP id
 38308e7fff4ca-381216725damr72755891fa.23.1766937116107; Sun, 28 Dec 2025
 07:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215-v6-18-topic-imx93-blkctrl-v3-0-51dbd1333938@pengutronix.de>
In-Reply-To: <20251215-v6-18-topic-imx93-blkctrl-v3-0-51dbd1333938@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:19 +0100
X-Gm-Features: AQt7F2rrgyY9PnfhYGRnz3aE_FjJItGK6XwPKeNDQpDGt15NF8-FEH9rM6gu3fs
Message-ID: <CAPDyKFqjJV8=PH7bTkWKJD4Dc7JoT6p02mPMrKA3uGuAKGsYvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] i.MX91/93 BLK-CTRL improvements
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 20:18, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi,
>
> there were several approaches to bring the sub-devices population
> mainline [1,2] but non of them made it upstream. Both approaches were
> part of either the i.MX93 LVDS or MIPI-CSI enablement.
>
> This small patchset decouples the blk-ctrl changes which allows the
> MIPI-CSI and LVDS patchstack to be rebased ontop of this patchset.
>
> Before adding the sub-device supprt, I converted the driver to devm_*
> only API.
>
> Regards,
>   Marco
>
> [1] https://lore.kernel.org/all/20250701-95_cam-v1-3-c5172bab387b@nxp.com/
> [2] https://lore.kernel.org/all/20250304154929.1785200-4-alexander.stein@ew.tq-group.com/
>
> ---
> Changes in v3:
> - Link to v2: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de
> - Add r-b (Frank)
> - Rebase to v6.19-rc1
>
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de
> - Adapt patch2 commit message (Frank)
> - Check devm_pm_runtime_enable() return (Frank)
> - Add r-b tags (Frank, Alexander)
>
> ---
> Marco Felsch (3):
>       pmdomain: imx93-blk-ctrl: cleanup error path
>       pmdomain: imx93-blk-ctrl: convert to devm_* only
>       pmdomain: imx93-blk-ctrl: add support for optional subnodes
>
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 77 ++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 41 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251201-v6-18-topic-imx93-blkctrl-341220f7084d
>
> Best regards,
> --
> Marco Felsch <m.felsch@pengutronix.de>
>

The series applied for next, thanks!

Kind regards
Uffe

