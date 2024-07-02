Return-Path: <linux-pm+bounces-10340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B1923E66
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7E41F233B8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F019CCFF;
	Tue,  2 Jul 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KXYmwcmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EC16C440
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925701; cv=none; b=ZN9008IOsN+gBDYY8FQx+fKKDCM7/UvDMxGatxZwWOc3NIKnO1eayUsE+w2CXIR5bTHO//s607iZW0h4ud1Cym0HGxtQg2U1VSz0V0WCTDLsWC8ygguWLyzsG11k5ZhuH8Zx7A3GJuVht+6+L1XuN9cQp3tVfYBXd23NwsgG9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925701; c=relaxed/simple;
	bh=S9WAdF5zIp6DOMlbWzRmjzJu0uGlfzXZ7p8RCFnmTG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGLfuyD3D1aeusVyw9nOhSY082boM09PY6/jqyAnv9i/J0LiCheT+0RG6A7HqBX8I/09Ri1HujEfdjsmntUCB/JW+xUhCa+M+lvUvCJs53X/HAUXa8B85cCfpuPsPw0mwQs86X8oMJ2o7vySCRwM4hKRMA6lG5JYeJpi2qBQ/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KXYmwcmM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65011d9bd75so6217217b3.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719925699; x=1720530499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9WAdF5zIp6DOMlbWzRmjzJu0uGlfzXZ7p8RCFnmTG8=;
        b=KXYmwcmMKKYBi5yexqO4pin1cb5HGL430GBaG4HMJDkbBPx86anhXl3g8NSbAHii6h
         /ha4gOQfIPioxjSNw6v7pgeB+0uGeqZ9jJP2jpLlhP54Bh3OoLtrSN+GXml0/V2Xl+eo
         dI7WQACmUfVpkB+pkX6SoPw696xDHwtX0N+lSByeRPAjhl7ula38smq00J9PW+ghCjRe
         cv80+xhPZQpo7t8rG9ZHHbt2epdNNUJ8UaxiEo1OH7ZpcYla+DLFsL/XaXTFILWh0gaV
         aHWN7ewZtO6FUXGuIIDdx+2CwHnuiaXbUowXB3TyRLRHRK42t5qCJqCt8zs/VRm8LjKT
         j8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925699; x=1720530499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9WAdF5zIp6DOMlbWzRmjzJu0uGlfzXZ7p8RCFnmTG8=;
        b=B3MsO1sVAGJax6ZEKl/GKFGweRRQTtkWYkPaVW2HJZcUgR6ueDAZ0VsOhOl/facQtJ
         0jOKuqcuoiwe7ldoiQdBLvpMx31Nw9yXqpHi5vO8aEcE2G4XUdNv3ftR/xpcGwYb7Cps
         BQnUczBD2x640OBtw+m3rUd5G6Sv1PsaWEr5xAGv1s57vNHu+U2evixI6zRyYCof+1HY
         kzyqoPf9Na0QNlNxdbqr0pVXIH0UmzTeD1ogQ4tWxRlaYRlSBxsDgezRPdIrob73M8s2
         ZnPvvzH19K5sbO4Pg3MqUfpbe9PLdrxYvexOO7l59iciqsvMgf+VJ7Bbtui1quZIsTwv
         CiJg==
X-Forwarded-Encrypted: i=1; AJvYcCVahS+7A8rBoWkhjSrLF+WE5YEyQsR9QQ5RpMTFjCv1eD3BhoWA4xDSCDeowuB8OyalEX0X3GcI+Pz1+kHOCMqS65GxgToiBvo=
X-Gm-Message-State: AOJu0YzoxZKapbdPd2H/deqpv5e2blh5CUSclvbqRPDpmwPDpWFcsyte
	71nOUxg2jPSex1nEtsOx99XPp2qWM16p4wIvi6lOMFFeigbJJA+7HlIPWiflg2rMJq7ZKyEIQRW
	JtjoY7v1Y0u6Lqe9D60KPIufaEI8oufdcrXmnHg==
X-Google-Smtp-Source: AGHT+IFd5P5nvAOCFhI34eu3EgzzjA69f2Au+mefSwkWxzhefLYYUPNhJFm+L/KZewGETUij+yyWjdPRQk02bxj11bk=
X-Received: by 2002:a0d:e604:0:b0:646:7b75:5c2c with SMTP id
 00721157ae682-64c718039c9mr86962577b3.16.1719925698688; Tue, 02 Jul 2024
 06:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702114103.16068-1-brgl@bgdev.pl> <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
 <CAMRc=McVo364EruPtBCkLdR86=PfvSQFztTC_HUO0RPRCayAxQ@mail.gmail.com>
In-Reply-To: <CAMRc=McVo364EruPtBCkLdR86=PfvSQFztTC_HUO0RPRCayAxQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Jul 2024 16:08:07 +0300
Message-ID: <CAA8EJpqk+yko_jqyRFo4sFJgtz+YZyEPh2sOEcDa-cYD3pGtnA@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: don't request BT enable
 GPIOs for wcn7850
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jul 2024 at 14:48, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Jul 2, 2024 at 1:42=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 2 Jul 2024 at 14:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Due to having many existing users of wcn7850 in the kernel, conversio=
n
> > > of the hci_qca driver to using pwrseq exclusively must be done
> > > carefully. Right now, the Bluetooth driver requests and controls the =
BT
> > > enable GPIO and so the PMU pwrseq driver must not do it or we will ru=
n
> > > into problems depending on the probe ordering.
> > >
> > > Add a flag that tells the driver not to request the BT-enable GPIO. W=
e
> > > will remove it once the conversion of the Bluetooth driver is complet=
e.
> >
> > This will not prevent the pinctrl conflict if both PMU and BT devices
> > declare pinctrl for the BT_EN pin.
> >
>
> Hmm... So maybe we'll need to modify the BT driver after all. Should
> we see if we have the enable-gpios property in hci_qca and - if not -
> try to use the power sequencer? Or prioritize the sequencer first and
> if it doesn't match, then fall-back to the current mode of operation?

I'd say, try powerseq first, then fallback to enable-gpio.

--=20
With best wishes
Dmitry

