Return-Path: <linux-pm+bounces-40118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92588CEE398
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579FA300E3E7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B82DF131;
	Fri,  2 Jan 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY4PZqWk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E02DECBD
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351438; cv=none; b=h4hrS/+xCnS0th+xAjNFUSMGxkYIdEv+chnjvUs6s/rH/Ze/kLM67Q7Qlns7RlGMsmPfuD2+P8aqgDDw0yJQQVmSwi9uTB+lz1fLQyFvks3KGVdKm7Hr9+LcsQSKjUdRqfBrpgrha1E/pCrUyDfmfwoxGA9T1Xt+/IjNBKtGjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351438; c=relaxed/simple;
	bh=++N4oU6j1RUiKK9UE3P/jRCn1sFUVQE6hBvuMdCpIwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr0zeE8d4BBybn1+tj/Eg1I6n9eWeBHO+8CMumEtkpjXc1hQpzO4o/J2oqRoR1AJ82GXvSUc6bRMo/mG0WVJHe06IylWu7y7f8/nodidZcKS2QJ1WTd+vxe5K7Mi4D2i4kakrKv7P2H+J5hMLACUnWdOKD298tsH2vsQ1AcF3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY4PZqWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A250C2BCB2
	for <linux-pm@vger.kernel.org>; Fri,  2 Jan 2026 10:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351438;
	bh=++N4oU6j1RUiKK9UE3P/jRCn1sFUVQE6hBvuMdCpIwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RY4PZqWkZ4cj4mGAbTkNfYfflY1d62XwekKfzzwhYGAPqMaO8/gKBJdLMSwSKE0Ry
	 vE6KLAi7pYlmHGJscxRt/Wdo2c5T4wtwr2s5sGtS8hkhA5Gje4FaiO9v2bLR2cr2O4
	 hCrMmwn6DMAtwysZmO1WdtGc8kdrmK1unTdFfxR3nl92Y9h61yED394BLP6EFs9ikd
	 13Oh0D4YtLFoljTlp7PljwKpCOi5qbwslJ+1jjv0BA47WR4iGXRd+IZXDlvB9GB/k+
	 Gd2NPQxg/JzXxd4Z8RmdJEihcFKzjQXJYr6tbhO7l5ubzi4AvGzU4Q6T5i27VzAjRS
	 Q1oOGEvE4/rtg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso13557230e87.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Jan 2026 02:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKhoW/+oR0tkmkpwrwZTctD+cDgU1YX6PQeNzu8nYzEn9FPWj8tTcJ1oKPHo32g3DyyC3SlwxUvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJrwwI2EYJj9UHCiX07zSRov5vsvKXJiSruz3WwhIfRhYktVE
	bN9+kEZnJlwRxOj9TqLP8JPAQHqNHh/pm+hcWpBVrfKWPyrbTDjKbTJhZqxkXXWljv5AlfrQtTj
	rw8ZGu4aDRye29JIeAeEVoZmkPwqHlXUBdW9H+BiyuQ==
X-Google-Smtp-Source: AGHT+IH7UClkfKSL9o0IyUvVqCuCUzyF1Fl/7eE9ZBq3Fcg9opKiKnrqvysGr/g9X3iKm+++K/xIFNN3S2f1rN0ocKc=
X-Received: by 2002:a05:6512:4020:b0:594:2e9b:f28f with SMTP id
 2adb3069b0e04-59a17d7203amr14881198e87.7.1767351436956; Fri, 02 Jan 2026
 02:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-2-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-2-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:57:04 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeTeYvonCostCDjW1M3LPSxQeWsLW=KziOXC6UO7XJ7-w@mail.gmail.com>
X-Gm-Features: AQt7F2rbYGQpmqcDgHn3YY6rLPZYpWQ4KhJGUlNFoil6eYDE-QawXo4wPu2S78o
Message-ID: <CAMRc=MeTeYvonCostCDjW1M3LPSxQeWsLW=KziOXC6UO7XJ7-w@mail.gmail.com>
Subject: Re: [PATCH 02/14] Bluetooth: qca: enable pwrseq support for WCN39xx devices
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
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of QCA devices in addition to using regulators.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

