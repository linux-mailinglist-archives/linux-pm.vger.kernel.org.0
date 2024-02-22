Return-Path: <linux-pm+bounces-4224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250E85F43B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 10:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2AF284ED3
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00639FDB;
	Thu, 22 Feb 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IzH1QElB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FE39AF5
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593784; cv=none; b=bOcesIAApLtvAXkTemanDkJ5i37HnaoAZ2feamj+itDYx4ygVgqMo5WFqdvWJq1Ho6sUyNkdKfji9IOfsKdFkyo5bXoCykwkCYX4rxubZSyv2m7z55TC70ptZI30JJjnFhQPz9dHOIYbMlZt+UbslJ98TCeactQz/Ab3Zu984+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593784; c=relaxed/simple;
	bh=/tDPneuMgzTuY2K3OXDEpnOGw+5YStE/jBmbrb9oImM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtmEPBf3W4MOzC4UKYnZgGxUqehnyeXr4pDYku3gx1O89cxqvtcR5zGF7fQ4v8DaRdTvPxlVoK0VWHd26fRxGB67x1U5dI8yuUwAPIl6+YwTJfHrV4F1XXV+1I02JpJHtYNs3VgN8DeaM1zVYXFMbiCtrIG0TluY4vAe+hXicoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IzH1QElB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso3987692241.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708593781; x=1709198581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRvybTIn6s9bKBT4LwtVbJu6PGSSM9veYTX1phbPcgI=;
        b=IzH1QElBUekrUFyJ+6N4K+w3N8BWTvMkMMsAh5UJC/zmjehcTsJTZwFmcZS/J0BuLx
         P0VuXGgvAGFl02tDKH9nKviiqcPScZYK9w1/NalTTW8l9cczXFbTtrKdqD/GWLRkwd5B
         evZhbsRMAKbxonq+9IRNXzCYpFDcVQSw8gfW3aDfDe0s7Bay8V9VymCFKXfevhHT6yyu
         AOQtHTmN6ZKmBl5OdqmQO/DTIUHEAMHdSNpMvjJ3xzcwpw2dzSfpF+5joCRy6mDPQ/8P
         pJkSWByFaNRwn1pCkJi+pxXIySx9Rte5LbuaMuH0N09K3QLmWAYhRHsCBsbinsQ67j27
         bYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593781; x=1709198581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRvybTIn6s9bKBT4LwtVbJu6PGSSM9veYTX1phbPcgI=;
        b=Wxi/Q3wx6M9jHwiAy6E2We8DLKy3Cz1F1FVYJRUzFvkw0sqhI88ZuCMLRiJ4/pd/l4
         l+Nw+BXHbq4HVDN+feta4ovJpOZPyndgeXbavWKVVHNBulJkr7vC3ZS+AyxHjm+noWy9
         sU+wo8FqZbjdNRdFrHw4zK070ECYcn9ENCyc0GHIyaStnE0X5wDwi7uhN1gNA1ECws9v
         dGz+EYdIzH55Rxz1C03CthTJyXoOJIfrs1IJwkN+4X7G6plvNWi+5TIlheJ9VhrcadOq
         eBjDjIzbC75YI9gjk9ClQwyX9hA9cG94l30Ew4NLZGxiut4vHLQ1T0dL4nj4fZA76uc1
         pWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVClhM7ABnVtyVDVkoq2Z4NWe75p/p/2BJIc3e1Mm5wKAn6D+JXvN2Z06fLiATb4yUNFac0eWvNTWnd/8RTW2ECbDFryRZhD/Q=
X-Gm-Message-State: AOJu0YyEzLMwxws0FY24uOqC7nxjw/Rm38AMFWPik1z6/x0E7OG0DFAu
	lXYKx82gQ45CRpR8U+O6D902QkPCqnTYimtYB18Md3MHPtvmBJnlCIyFf4kjnBTxWKACIJ1qTPU
	ZT9kB43GQvPzqriHWGCV0DPpVG1s3x13Gz0iJVw==
X-Google-Smtp-Source: AGHT+IE7l9v3T8HR1qDkBbHnqiBR7hU5VAldnjvx7qUsE3wswYkR7sU9TWZWgrMsSrKpcb4F7U9NnKwVd53zre/w3u4=
X-Received: by 2002:a1f:6681:0:b0:4c9:907e:30bc with SMTP id
 a123-20020a1f6681000000b004c9907e30bcmr10268617vkc.2.1708593781184; Thu, 22
 Feb 2024 01:23:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk> <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk> <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
 <53f0956f-ee64-4bd6-b44f-cbebafd42e46@sirena.org.uk>
In-Reply-To: <53f0956f-ee64-4bd6-b44f-cbebafd42e46@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 10:22:50 +0100
Message-ID: <CAMRc=MedCX_TGGawMhr39oXtJPF4pOQF=Jh2z4uXkOxwhfJWRw@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for WCN7850
To: Mark Brown <broonie@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:44=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Feb 20, 2024 at 10:21:04PM +0100, Konrad Dybcio wrote:
> > On 20.02.2024 13:47, Mark Brown wrote:
>
> > > Are you *sure* this actually happens (and that the regulators don't
> > > figure it out by themselves), especially given that the consumers are
> > > just specifying the load once rather than varying it dynamically at
> > > runtime which is supposed to be the use case for this API?  This API =
is
> > > intended to be used dynamically, if the regulator always needs to be =
in
> > > a particular mode just configure that statically.
>
> > *AFAIU*
>
> > The regulators aggregate the requested current (there may be
> > multiple consumers) and then it's decided if it's high enough
> > to jump into HPM.
>
> Yes, that's the theory - I just question if it actually does something
> useful in practice.  Between regulators getting more and more able to
> figure out mode switching autonomously based on load monitoring and them
> getting more efficient it's become very unclear if this actually
> accomplishes anything, the only usage is the Qualcomm stuff and that's
> all really unsophisticated and has an air of something that's being
> cut'n'pasted forwards rather than delivering practical results.  There
> is some value at ultra low loads, but that's more for suspend modes than
> for actual use.

Removing it would be out of scope for this series and I don't really
want to introduce any undefined behavior when doing a big development
like that. I'll think about it separately.

Bart

