Return-Path: <linux-pm+bounces-4237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DD85F65E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026C31C21466
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CF405E5;
	Thu, 22 Feb 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VkMj3gfd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D863FB31
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599629; cv=none; b=Fu2q4xpY5Ry0oAA/+LlnpSYBHeWFOM5pXlaubyLd5KzRjIGAmgPhTLErjdwRFWxPN8RTI/D9LMZSlyn83IWwHqOlRPJ8WGMagsIAecScewjqGK49Xzy0+7IKUdy+7hOiGhDkXnKOez7Gynm0NXQILybY6owA5vYHUQeexMhI5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599629; c=relaxed/simple;
	bh=4SUhFECzfgHvN70ojLHKQ96rAaBsv2JrpKaeoW6p6NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYYs1cLk9ipV/7ywOtRtCIaen7nOK16Q+ZkcJaPI5XIP5GWJGe+RN1wBS/SIQI2ZYxNzdRBTJXh5nS/lxCrAKAacGBkfHk8J8buTaWYjqbz2RJNrjIsfgB5qRI0JaIdjiha2nlg25SZTkpT6b34fKofYflwHjURsi/9aNJt48u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VkMj3gfd; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c852c6e5f7so1061190e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 03:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708599625; x=1709204425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H/VIpoB4an+Mp36arHK/D3Ob8nW5Qqkhlyoj2/3jaw=;
        b=VkMj3gfdcFnz42zo5KLDCMaRFv4b0U0/AkjZW3epTqbYbaaD/h/iHU2FIa7Mnr67md
         RBQ/zLS3xiCJ7ptiCQHAbPPXT3IafWKRdsIVBZfOFupfDQikMwPe+HIUEEXz5hUCweSC
         7iangEDzwS2C0DVrsWpOxQ1BXQquior9uqGpoJhTf3S8FWWEAW5lh1VLiQ7H6pfpAnta
         zQF50G8AMFwP+rxRZrPI8PlG3ULBuAz6yR0FfurGccUNuZrxkzFdhihk0QxIZskLoEfQ
         fpB8b5AMkjka5xduQ7XAaeUdfCGEyQNStzPei9FXlsjUhdP0N7qvAAPEsQ6hTOFCtr/v
         3fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599625; x=1709204425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H/VIpoB4an+Mp36arHK/D3Ob8nW5Qqkhlyoj2/3jaw=;
        b=b4N/RXxcnji4zprqqqPILA5PCm69TrM0OPhBv7QYGGgMUFK5s6dMQRs7yhe5SarjyW
         I7f+PIsEdcW8jT1m7IgZcuRxUxQSzFzPCi2ciLrxXJ4R78i1DNqeiNX4QXLIn2eEM6ry
         lSjJ4eGOhgfUIoXZJaKZXFJsMZrodq8yCXK0r9QIteIt55iXiR2ah5KuD2ov+Dyf4rBd
         pOKVgRhHhDSifZCS34wSiU9i8R3TzBGQYAkxutjLk37TV13RjuHr1Wm2ezE3+vft/23o
         IydKfPyN/lBy/eS9bP7+PqRyjTz16LB4rWnUHuexbs6mOzU2+sajYNXjKBeFjPNOWNsJ
         T9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV4VS6dRJ69AfwROQEBZaaO/wXRACVg87d4T2jdKKHnzgZheLB8Jqs24GzfSPSI1YhqHBJPb7FYScbykelVIXMO85IpuAOvZUg=
X-Gm-Message-State: AOJu0Yw2c97A8quifb4sYE8gnsQ5yBsKY5OZCPs9mdG++0+HyDuJNnez
	yN6u9IJSuDjJHr9TkqpQfKLMnxUobIBLDYQOgDIkF2O9yb5oZO6pg2KJndOfb8hdtmiN+tNHz7d
	5Jqn/f5FWiPA8j+SwjRZTXrQQV9kNGeqLsY6PKg==
X-Google-Smtp-Source: AGHT+IGc4k4afM7yOHcqPtsyx85w0wC4eDvcktSKZo2fOpRx3WfdsV144zf5agpJ1l8kNtCEpqQOOt7K2tgZtw6QOw8=
X-Received: by 2002:a1f:4a45:0:b0:4c7:7760:8f12 with SMTP id
 x66-20020a1f4a45000000b004c777608f12mr12070252vka.2.1708599625549; Thu, 22
 Feb 2024 03:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
 <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org> <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
In-Reply-To: <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 12:00:14 +0100
Message-ID: <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:21=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
> >
> > On 19/02/2024 13:33, Dmitry Baryshkov wrote:
> > > On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > >>
> > >> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> > >> <dmitry.baryshkov@linaro.org> wrote:
> > >>>
> > >>
> > >> [snip]
> > >>
> > >>>>>>>>
> > >>>>>>>> For WCN7850 we hide the existence of the PMU as modeling it is=
 simply not
> > >>>>>>>> necessary. The BT and WLAN devices on the device-tree are repr=
esented as
> > >>>>>>>> consuming the inputs (relevant to the functionality of each) o=
f the PMU
> > >>>>>>>> directly.
> > >>>>>>>
> > >>>>>>> We are describing the hardware. From the hardware point of view=
, there
> > >>>>>>> is a PMU. I think at some point we would really like to describ=
e all
> > >>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach, includi=
ng the
> > >>>>>>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174=
).
> > >>>>>>
> > >>>>>> While I agree with older WiFi+BT units, I don't think it's neede=
d for
> > >>>>>> WCN7850 since BT+WiFi are now designed to be fully independent a=
nd PMU is
> > >>>>>> transparent.
> > >>>>>
> > >>>>> I don't see any significant difference between WCN6750/WCN6855 an=
d
> > >>>>> WCN7850 from the PMU / power up point of view. Could you please p=
oint
> > >>>>> me to the difference?
> > >>>>>
> > >>>>
> > >>>> The WCN7850 datasheet clearly states there's not contraint on the =
WLAN_EN
> > >>>> and BT_EN ordering and the only requirement is to have all input r=
egulators
> > >>>> up before pulling up WLAN_EN and/or BT_EN.
> > >>>>
> > >>>> This makes the PMU transparent and BT and WLAN can be described as=
 independent.
> > >>>
> > >>>  From the hardware perspective, there is a PMU. It has several LDOs=
. So
> > >>> the device tree should have the same style as the previous
> > >>> generations.
> > >>>
> > >>
> > >> My thinking was this: yes, there is a PMU but describing it has no
> > >> benefit (unlike QCA6x90). If we do describe, then we'll end up havin=
g
> > >> to use pwrseq here despite it not being needed because now we won't =
be
> > >> able to just get regulators from WLAN/BT drivers directly.
> > >>
> > >> So I also vote for keeping it this way. Let's go into the package
> > >> detail only if it's required.
> > >
> > > The WiFi / BT parts are not powered up by the board regulators. They
> > > are powered up by the PSU. So we are not describing it in the accurat=
e
> > > way.
> >
> > I disagree, the WCN7850 can also be used as a discrete PCIe M.2 card, a=
nd in
> > this situation the PCIe part is powered with the M.2 slot and the BT si=
de
> > is powered separately as we currently do it now.
>
> QCA6390 can also be used as a discrete M.2 card.
>
> > So yes there's a PMU, but it's not an always visible hardware part, fro=
m the
> > SoC PoV, only the separate PCIe and BT subsystems are visible/controlla=
ble/powerable.
>
> From the hardware point:
> - There is a PMU
> - The PMU is connected to the board supplies
> - Both WiFi and BT parts are connected to the PMU
> - The BT_EN / WLAN_EN pins are not connected to the PMU
>
> So, not representing the PMU in the device tree is a simplification.
>

What about the existing WLAN and BT users of similar packages? We
would have to deprecate a lot of existing bindings. I don't think it's
worth it.

The WCN7850 is already described in bindings as consuming what is PMUs
inputs and not its outputs.

Bart

> >
> > Neil
> >
> > >
> > > Moreover, I think we definitely want to move BT driver to use only th=
e
> > > pwrseq power up method. Doing it in the other way results in the code
> > > duplication and possible issues because of the regulator / pwrseq
> > > taking different code paths.
>
> --
> With best wishes
> Dmitry

