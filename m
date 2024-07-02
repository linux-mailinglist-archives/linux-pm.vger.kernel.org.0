Return-Path: <linux-pm+bounces-10339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD134923CCE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819FB1F210B3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D414D703;
	Tue,  2 Jul 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k2kfU3xi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9D1DFD8
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920894; cv=none; b=Q2gN4Eor+e716skstgK6MmZh5VRq+Q816Z+ydRkitdPGzZKTRPR8Z400EODxIkBMRy85tCyNb7I8K8Qh7vSdUILz9x2eLsl7UImu6Mxru2ROPveMzQUKoFFAu02f59+lvDwRWyKmQdq/4MuRm5qgEJnkfbaNRI+1tLgjwtw93q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920894; c=relaxed/simple;
	bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGfBCZ4QK3NzUc7UnCKMu0W6MY26Xwyk97Td1EsfuO1KYLDSZtue9Abilde2am5M7vhr4HJ14I3ITzGVeZtf1ybHIBvuI07SRwlasZXUHR8wPBga//XqJA47tPaItEDwlCh16X1bp3sfEQYogAszO6Gp4K+X+7DMzjGXzOywD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k2kfU3xi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso43353391fa.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719920891; x=1720525691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
        b=k2kfU3xikfYi1UDFshkUsg42cOuzIpcklVFzdpdG/4MLc9TYYy1PhqiJtL4pvjrD2G
         NPx+ntX9mfRgZFUtdUhMVb8/fcpdakiGDswo8+8xTD8ezgRHGccosoRItdYX2Vlt6NOt
         rNBQJCDbtQd2QfCNxGLx1ylFrJNx5v4OdWd4jL4bZpIEH1uD1kVTqlMJuKuXn5GI9T5X
         4dEnfNL/Smt8Cojkbb5rP1UtHWwMKT+JqhooOCyPUlYPft87lW4TqnZQf+DMWIIvQFZL
         NyK+scHXFwV8iFbj+SSc/JCe/pqTFGxKfJJkh7edn9uegHRpljo9i4iDDCEkUYoBDlAW
         cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920891; x=1720525691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+IFH/UAtx0MadyzuFPkt42kK2cdz7LHsWds9tSV8Ac=;
        b=IlxyuPfUyOrX/onFkb9S1V5qyuTyOq5Iu/QCUJzG/uypM3VnPqlTeIu2L9Dpwq9E6W
         PjXN7p5BEohI6c/Ygfi5xO2XYlTSd1wAZGhsyU2CecskHPgDLEketdOa0xnPgjeWk4qC
         471HckO9/+BqqfnT4d8wR2wCtPNDMIi+wxLjRIGb0dfat32iM61c6XSCcRSHqUQb2Ebn
         u/OqEDvwoj/jnAxkinB+GRBxMXi8mdCGhTdevHsmLUoc8KbG6T+lN0yGikrsdSBig9JT
         zAKZbIgBtRBv/AIfIFI8ojak74wppPPU7C4PFRV4pkf8ufiv6FTU5BS4d6lGZMxSIFW8
         j1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXOW/CbzpZgEMN5YzB4ux0BdODC4SAdvRtZ9SG7xZt8gLIxhE8BDQJIDZBtqHbxyzlXUNDNv4u8oPUTiMBA2lIfzrAVORva/xY=
X-Gm-Message-State: AOJu0Yw1dfGm4B4L+xLXnCz9IcPQeIX9mvTuH59L6iDkjP+ooCRY4Dwy
	gMxYc5EXhyYTU3t5nxlAuE+nD+n3vkttfLUDyoh5h+Cr+GHSW3IYpopr79a1L/qpZbzn0cOIWCq
	vY/NRdI0j+DBzSeywCDCYlBHQUT5FyeTo6sbpEwAGGr8Tegyi
X-Google-Smtp-Source: AGHT+IGYlnBmWEqJp+GJI605I3OI/Z/NbtE8viKRB4pNaGMzYRQDjSTGWfLQ7W+EGMfmgv9q+2mq30gnD2xwey5TD5M=
X-Received: by 2002:a05:651c:1509:b0:2ec:5603:41a with SMTP id
 38308e7fff4ca-2ee5e345927mr55982491fa.2.1719920890946; Tue, 02 Jul 2024
 04:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702114103.16068-1-brgl@bgdev.pl> <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
In-Reply-To: <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Jul 2024 13:48:00 +0200
Message-ID: <CAMRc=McVo364EruPtBCkLdR86=PfvSQFztTC_HUO0RPRCayAxQ@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: don't request BT enable
 GPIOs for wcn7850
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:42=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 2 Jul 2024 at 14:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Due to having many existing users of wcn7850 in the kernel, conversion
> > of the hci_qca driver to using pwrseq exclusively must be done
> > carefully. Right now, the Bluetooth driver requests and controls the BT
> > enable GPIO and so the PMU pwrseq driver must not do it or we will run
> > into problems depending on the probe ordering.
> >
> > Add a flag that tells the driver not to request the BT-enable GPIO. We
> > will remove it once the conversion of the Bluetooth driver is complete.
>
> This will not prevent the pinctrl conflict if both PMU and BT devices
> declare pinctrl for the BT_EN pin.
>

Hmm... So maybe we'll need to modify the BT driver after all. Should
we see if we have the enable-gpios property in hci_qca and - if not -
try to use the power sequencer? Or prioritize the sequencer first and
if it doesn't match, then fall-back to the current mode of operation?

Bart

