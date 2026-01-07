Return-Path: <linux-pm+bounces-40355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A158CFCFDB
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D333D305E856
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 09:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446E9309F0E;
	Wed,  7 Jan 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGeLT8rz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9043054D8
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779486; cv=none; b=P9bZtEabk56Oyn9dH/eHwDk4nDCVkiWYO1rL4FPSs6cFlHPXzHCVe3g6Ef32iKT2mgmBA0nIhjfzzMMdFsbRBl2DvcaTD5rYzESLnPAom7x7Sm1trOsPwDmA5x2S+7Dbtq4Lkfi45QeLe/Y/UfL+aQdWbUC2k0ODDNsM8y88BJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779486; c=relaxed/simple;
	bh=NmLMzAzCpWZoeHjWGioABuXSbYuv+EuUrRg7mmBjYnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0TFq/MDcq0hBmNtRHt60jCY9XzaXIct8eGupTUFcsHa9iXZKNuQrmMP2tIjnFd8C2XmhFFJzHqOBn+a3qCKTXGiQVdEaUrFbuUUh09OsGhTNxX6AvbSBs4oRJfjrcN/9/0k0VQU1e9FETpyHtEvcYL7R1+VGt+c5Nq9xMy5EOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGeLT8rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0116BC19424
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767779486;
	bh=NmLMzAzCpWZoeHjWGioABuXSbYuv+EuUrRg7mmBjYnY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGeLT8rzryOa37z3RZZFI/qYuvMtWJyefGcugLj9TMGUVRzof6EdRfa0kYu3Q+LVQ
	 2DKdzzsKPhlK0agbYQI59g31Ywvyz/CILBKHWs1xgYPfEgfUHq29yZvakPAQ2a0JLm
	 vpPLDSnP0Yh66Bu78VKWqK57ZY4aDEbGYhfschOn1YzJDhdwO0qq+1KCDSTkAU0U70
	 kzE9ItwNOHYKvydB2NV7bXx9s2kmWvw/+ekHyCbwbRzdfrOeLqlI5e2hL0A4G/R7km
	 fqZ/zQhhQnJSIzIciUk9+XGYjWdXhaRE9j8eRYSwqc/KdKEquCeMXXAKzTB4TdR1mi
	 aALpbhGjMcxUw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-382fe06aa94so6308031fa.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 01:51:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRTE5s7+8zCEplZgm1jsMkAd8NZpRiGkUi0ROeLFkeAzeB0YuG2JokWL8b1XD5+jru4ezs3mLplQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5o8wn+07QrQmAPbidALcVrNPsu8k8AFCB3N3nCvFrSeqGBYuT
	tcwpXb+5kg61J+zjW42eIj185yJXDO2A872JSQ2IKQ1jjYFguJ1h+oPNhWS2x9pawkUVOOP34nT
	S4A/oWt0bg0McKxbpqh0wQmAxY56/7786EybTlDYn+A==
X-Google-Smtp-Source: AGHT+IGsOoksfiYs3d/2Uvo17brphOFA2kNch8Yl6j6+wfFkNrmovd56yuzo/tpGa0rkoqkNNyxiklr2IQiXyV/Owns=
X-Received: by 2002:a05:651c:2227:b0:372:8d61:c26f with SMTP id
 38308e7fff4ca-382ff68f13amr6143751fa.11.1767779484574; Wed, 07 Jan 2026
 01:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
 <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com> <CAMRc=MfPq7+ZbWTp7+H388hqHoX27qbbHsLHO+xeLaceTwZLVA@mail.gmail.com>
 <z33axfsiox73f2lklhiaulekjnqxnqtkycfylybwqnqxtx2fck@3qtas4u6mfnz>
In-Reply-To: <z33axfsiox73f2lklhiaulekjnqxnqtkycfylybwqnqxtx2fck@3qtas4u6mfnz>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 7 Jan 2026 10:51:11 +0100
X-Gmail-Original-Message-ID: <CAMRc=McS8a-1cH_y+kpze=zj2-PksHDO3SE=p3XnbEueUQt9xA@mail.gmail.com>
X-Gm-Features: AQt7F2pY9Ypb4lLMQKTc1ZxHjn85KZ9DgQjKFvp34cr91yK650oitQF5-K0QY8Q
Message-ID: <CAMRc=McS8a-1cH_y+kpze=zj2-PksHDO3SE=p3XnbEueUQt9xA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:39=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> > > +
> > > +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct pwrseq_pcie_m2_ctx *ctx;
> > > +       struct pwrseq_config config =3D {};
> > > +       int ret;
> > > +
> > > +       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > +       if (!ctx)
> > > +               return -ENOMEM;
> > > +
> > > +       ctx->of_node =3D dev_of_node(dev);
> >
> > Since you're storing the node address for later, I'd suggest using
> > of_node_get() to get a real reference.
> >
>
> If CONFIG_OF_DYNAMIC is not enabled, then of_node_get() will just return =
the
> passed pointer. I always prefer using dev_of_node() since it has the CONF=
IG_OF
> and NULL check. Though, the checks won't apply here, I used it for consis=
tency.
>

I think it's just more of a good practice to take a reference to any
resource whenever you store keep it for longer than the duration of
the function even if the actual reference counting is disabled in some
instances. If ever we switch to fwnodes, the circumstances may be
different than static devicetree.

You can also do "ctx->of_node =3D of_node_get(dev_of_node(dev));", all
the NULL-checks are there.

Bart

