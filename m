Return-Path: <linux-pm+bounces-8608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723C8FBFE4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A24C1C228AC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 23:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832214D6FC;
	Tue,  4 Jun 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypqfFRu+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D114B97C
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544107; cv=none; b=XQEVrY0Wcf9cAbbQAZKB3TN1gOGYxq5YM0zjLXwnDEdvYtJUYt6plE91ikkTXCoiI9Yyyo69WO0dQTrLIKQDT0YnDkN5h7OuSafKR7Bx4e7oA3S0hDKsM4T52PsWVnWk/ilN7+Pf3vPDSzRtAwADm5MI8TYSR3x4U+JVutMDA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544107; c=relaxed/simple;
	bh=ljUZwH0wfZx09w13YocP3uzPKY+TNatl/gsxBoW/3SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmeyR1q/JuPcktgVem9/G8WfhndvLnpjKP8i75InK72bjOF4MUJJF+uepttrOureS3ibrSB++AA1UUtQgZqa3JzY6LSmgFfdtu4+xG7nZPSdOyWwW2qsIS8n1Ix3Gt/6yoZlxxmGBjwwDd9gjvwwaVzO/k9WdEc4zv4wrkq3Zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypqfFRu+; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso313552276.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 16:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717544104; x=1718148904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U5F59Y5F210ARWzU6IxQVbEufFPE5a5xbmD+TtWexxk=;
        b=ypqfFRu+uPKXPjMQPgBOuDv7GombmJURsrNzvb1dhGyJL++QPuKNJMwtjg7mzX2AGO
         EpJEE5DgnWwRbsoAbNI5wz4OPG1sEnjRhFT0XnPgxPWcjCEj3pZoXjhI6otg8UvBHBYO
         xl7w8Dcmya++BneGdZupinvOiyoHiLazgcFy+i1VS0V1rLcOMnh0f53A4K0rGqFAB1Ut
         xQlM465D31D1Jx6qDraao/DDsh5dKo0pArqVwUWIfXHPmkJeAmWgQWe/LfNLRmzsz4al
         rwFDPwRo2zLhMz6Ho4YTCJM+GDISJ87GtkipLCy4iQwWlfly7cXr8iDr1MiZo5t1Ofly
         jpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544104; x=1718148904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5F59Y5F210ARWzU6IxQVbEufFPE5a5xbmD+TtWexxk=;
        b=ZqAE5naKQ0v8I6ba0pgc7EzF9n1sJFtPsEsgmZBlwtIkKtrPVIVttNvFssLPz0pxhW
         pMSyqcDp2lexR//oAOeJ8JQoXE9E8m2SCQlXaOFwLl3LTvlKOOf+Jlt7hvMzYw+sdaiP
         v6a5B7dGgmKjwOjLO4lgoN4pYbRsvP70YKvPhFnVL9KAO0bfwvvs36q5TRxmJuENm/VJ
         7mxJdvk4vvP4aXMLSUPdCOmah6VMz3fjxEbGUrFF7Ywed0h+djraVxB/U4OcgvG4rGha
         gmiSAVfh75MQP3Rzx+86jzImxQjiUcGPQoFiLggAJxS1q6GvkrQvVPVNVJx1ur4Brg+a
         /GDA==
X-Forwarded-Encrypted: i=1; AJvYcCWvUxK9iqIotUBhCfKOHhRu9pHLzjyGm9x4aZrRlRm1/KImkJCusgTXd9QQ5sRiQYMad1H/q3Rbs1F0yjGmKugdFy4n3+E2w+Q=
X-Gm-Message-State: AOJu0YzwMwKOYtavwVDTgD+AxCTs9u4pjBdOEWOLMpKJOlZg3H0ZQXvD
	zsWPlfT5cCR7Uc6LnbitF8p4xYGDZn6b7p+rjRkl/kxJdNiJA7nwKR+PXs6IfK7jSKyK0QUFClF
	UX+796rLEijDb1EDC8dmWkssCGmIffvletPF9Dw==
X-Google-Smtp-Source: AGHT+IFdoTto+OyWazk/s95VUduCXVBIPATg60NiVpHEaONaANNsRtZaVqiKS3evRYjowXOhqIkWoq2TlII04CwtgN4=
X-Received: by 2002:a25:dcd0:0:b0:dfa:48d9:b0 with SMTP id 3f1490d57ef6-dfab8b0312fmr3125447276.22.1717544104107;
 Tue, 04 Jun 2024 16:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-pwrseq-v8-16-d354d52b763c@linaro.org> <20240604232347.GA740032@bhelgaas>
In-Reply-To: <20240604232347.GA740032@bhelgaas>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 5 Jun 2024 02:34:52 +0300
Message-ID: <CAA8EJpomPLQmQbW8w3_ms_NMKHoSPcqBa7f2OhNTTOUSdB+9Eg@mail.gmail.com>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 02:23, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a PCI power control driver that's capable of correctly powering up
> > devices using the power sequencing subsystem. The first users of this
> > driver are the ath11k module on QCA6390 and ath12k on WCN7850.
>
> Can you add a little detail here about what benefit we will see from
> this driver?  E.g., something that doesn't work correctly now, but
> will work with this driver?
>
> > +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> > +     {
> > +             /* ATH11K in QCA6390 package. */
> > +             .compatible = "pci17cb,1101",
> > +             .data = "wlan",
> > +     },
> > +     {
> > +             /* ATH12K in WCN7850 package. */
> > +             .compatible = "pci17cb,1107",
> > +             .data = "wlan",
> > +     },
>
> IIUC, "pci17cb,1101" and "pci17cb,1107" exist partly so we can check
> that a DTS conforms to the schema, e.g., a "pci17cb,1101" node
> contains all the required regulators.  For that use, we obviously need
> a very specific "compatible" string.
>
> Is there any opportunity to add a more generic "compatible" string in
> addition to those so this list doesn't have to be updated for every
> PMU?  The .data here is "wlan" in both cases, and for this purpose, we
> don't care whether it's "pci17cb,1101" or "pci17cb,1107".

These two devices have different set of regulators and different
requirements to power them on.

-- 
With best wishes
Dmitry

