Return-Path: <linux-pm+bounces-37845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C0C52F9E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B01AE34B672
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6834CFCE;
	Wed, 12 Nov 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X0NM6JoW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBA33F36D
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959610; cv=none; b=CSjDVJjyvm2+tfHzXew07lUtZSnL+bwwxEXA+It92Iv/w1so1Js/JPsUFgSozo9g+4SHF7yOD0K8QyE6QBEm+ZGxyNYcM461/7/fXbyjgb9LfF8APmo32Y8EbIosZlL1zZe5IgfNfyHiUDrzkuMfhpF2F6n8PbMY5kx8q3I69do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959610; c=relaxed/simple;
	bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFeWW9gaXbHl4Nd06GhuWcZ2MNfapkUXbYbASqtvEajC9snz3eOj1ZZ98nPeXhCC/zk2BHrXXCawcmTtFdjWagAKr7Jh+/IESV46VNOjYOMqK92VLfMy0N0wKRxw95L7QLxJNMp3uvx0Dy0DnDvsS8mSc8w6Ess2sj6w9xcl/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X0NM6JoW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5943f39bf9dso787970e87.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762959607; x=1763564407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
        b=X0NM6JoWO3vCIkMCOghqijtCg3SeWhol9lAhtWz18k6Sn8W3yt71kZD3JkmCK+4kR3
         MUnCp18H92Z1iff18JrNUpN/Rd6S6Z5aP2p051Eb8FrVcBoX1s+8YFxP3NgtIb6SxRtk
         k71ekbnddmkWRIJIThxNn3kGT37sYi5u+4eOYidWHisGrH8hJnOl4wlr1igPGFTgvamE
         3zwAODUkvTa4xWIx5sVjvN6qMNLk3wbun6lLxuifjUTKI0eJ9jWpgD7ly5JdtM+kaivM
         XLtdi7C74PsoMrI1aGGZWTI5aHDyXtgo15C8V834ysGrQepz0BMTRU1P4R76Py8iN3G6
         aWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959607; x=1763564407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AitKwurl0RZQ42Z6io85kiDDF35RvnC+HaXcObo6dj0=;
        b=E16NibbFhCI1OlIGDs5Fr0+x2BaqrUOQisS+hjKQtETZQl31lSXn5SxPdxIHiHMLp8
         i8PnFPRbUT6LSVPRwpXmkSB/SIXpJm9zJV1d4nyfhdWrNNgW03G1Xi4an0RYS+rxnL3y
         nQ3xW5hwlTf3cJ443o0b3EeVmUbFDwvbR3ml66uwAR3MydAFyFgBcRZC6omLPWxle77D
         LeBWwrQSCXNDAWIfEYmQFuakvN86KZo58z6vbxu5NFBYZw9zLUid+tIUGIdwnYgO1I9U
         gqn8YCACP83oxCGAr1fjQPtGNBzch8RQdf4aL9KaM7YAoEU2n9Y9o5XMy2jMeIR0MDPl
         Nqcg==
X-Forwarded-Encrypted: i=1; AJvYcCXdxI9nmMS8vsBg2phdU6kCaWGseTxGN97bZuqsawWyBQVWrkK6dXkMW4G9GMkREIODOlcVGZM3ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/XCGDEYmqXeTfj/SCI+Y3u6NCDGQGGDi0jampJVM5FH0WEI+
	ZWvmgXGGK4uyPHgXO0lvfqkOKC61H9fZ4rxI6ZDK+kVc4EPRh2DazFHP7d6q/+hpOBQvAQ6q7NL
	ZVRUZQj44bzzlFokAgio29UoHU6rudsV3+04i4Bmd8yW2NWdBSa2FJes=
X-Gm-Gg: ASbGnctT00lwbGIerNKqRoyM+7xAh8iobYncxju+AxoRmPAjfGa1HPsrpcU8AVF1Cbt
	mrHWZ8EuGGt/U4X5fKz21+aPQw1louhnJXrr2/SX+qxXYFgIKXQSqmb31op4YZCj9ptSbf7/Xqz
	0IwrOA1WXys1hy4g7BjLLEj5nH9P31W8s1ODPYoZ2zmpHAQW9lZs6Q64Fn7SA1beBhZINlhf9gv
	OYZpYqctTZ63PPfHKy/25UesbQenlHiGX6jKLm2hhthGXTXz+GSXPTWBU66lRwI44VglgVIrkVf
	iaXp5GFMMvNS
X-Google-Smtp-Source: AGHT+IHJlMhc97BIbUXAmDMRKBFEzcYUIzG9wOUoHY7EvexUIuj9NB/ckjr2BS4pe1nb7zekpoNjYTR8GQ8gWpKStzg=
X-Received: by 2002:a05:6512:12c5:b0:594:27de:77e7 with SMTP id
 2adb3069b0e04-59576e6adcbmr1074429e87.15.1762959606578; Wed, 12 Nov 2025
 07:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com> <20251108-pci-m2-v2-2-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-2-e8bc4d7bf42d@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 15:59:53 +0100
X-Gm-Features: AWmQ_bmPrX98SnIay2Tpg2LShNsYicURP0Ag78YAbsYoHwDKuqWeMRjHIudWFWg
Message-ID: <CAMRc=Mcoi7koQBDyKPGet=FGX0emExRBhWMKW14fPmk217y2Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/pwrctrl: Add support for handling PCIe M.2 connectors
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 4:23=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> Add support for handling the PCIe M.2 connectors as Power Sequencing
> devices. These connectors are exposed as the Power Sequencing devices
> as they often support multiple interfaces like PCIe/SATA, USB/UART to the
> host machine and each interfaces could be driven by different client
> drivers at the same time.
>
> This driver handles the PCIe interface of these connectors. It first chec=
ks
> for the presence of the graph port in the Root Port node with the help of
> of_graph_is_present() API, if present, it acquires/poweres ON the
> corresponding pwrseq device.
>
> Once the pwrseq device is powered ON, the driver will skip parsing the Ro=
ot
> Port/Slot resources and registers with the pwrctrl framework.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

