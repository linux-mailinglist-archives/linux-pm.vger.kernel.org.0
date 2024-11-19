Return-Path: <linux-pm+bounces-17756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D760F9D2746
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868AB1F235C9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3931CCEC6;
	Tue, 19 Nov 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE39tds1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71017E0;
	Tue, 19 Nov 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024242; cv=none; b=ndltA5R4Fk9tKe5OcxshdB2vi4fgfmO59AcemBFu/h0DWI1FC4rPc3qw2B9D99AEPLXBovvZKFDSRWCet2pXJidxGLPISy99WR7NRpjBt2uPtYDGW1Ow4h9MBEYEpKpbSwGBCqN/k9f6eCiPmDKU6WbIRcd/qjYWm9vu+rLspeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024242; c=relaxed/simple;
	bh=9Vr1MPxwkShYTEnVAMXZxxEd2d9QIO9yEbNZWlH0Ynk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Remthl3lBdUU5c7CmZPZX50PpRAcYt9ZmKGr53zUBDIl/74OqtkMItllYuKEm12yNzirHc3q7+z71+iaPHcscKb/Y5LcaUrdbeiTJErI8w8HaLlue6qN2UnOO5vnHxjtgDXV5ATuJGzUSBk5mPu2iMHUG06zHr6cPU2s34VZEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE39tds1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93334C4CED2;
	Tue, 19 Nov 2024 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732024240;
	bh=9Vr1MPxwkShYTEnVAMXZxxEd2d9QIO9yEbNZWlH0Ynk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kE39tds10t/0a1ApkP9EnGqw5CPnz15f1GVrfjpz2MxjDIEzJc4SaEJg2wEf70N6i
	 +THtoxb9YzAip4Lwe1MDsS24nxrH4c30Q/yoe0Vc4Tl05U2RIG08oap3Y70XjgGoc/
	 NVUlzuJLlZ0+umamW3ymW1I8UwmB54gXjrLsVtBwEnxyPu0kBNlhsRwtb9kDVq2YAr
	 P3BkLbpC0PnQACUJu4+K7lQd9DvBkBbBlczqaUDLMOnkSFetgOlhgR3Fe09Gv/5Wsn
	 IGrGtJ9ODQbo+s45rQaT1024Mypt3tPqMORQbbMgNhybGDV278s0C45G8z6zE4teti
	 2ut1umgy/O+ng==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso939494276.1;
        Tue, 19 Nov 2024 05:50:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUha+ZiANsdXC/NsziR5JeIK1gTbU3p5DwSGny0Dih3QH/KO3BfXEZJyc2DOchailAkVgewq+mk71g=@vger.kernel.org, AJvYcCUplPcY/bqcwcZi184SW+R7yDhjJ1murJiWZK/9/QP16AtxQC6vifJaPn+aLNXe1x22l8GO1lvZjFNPRlM=@vger.kernel.org, AJvYcCWNdoKcUdeWr0l4HIJbCoVt1HHv1krD1S2XPHXDWqL4hiDwwtCWLgfJyMdCYp7eKYS1B2SmPgfSn4QvYeRw@vger.kernel.org, AJvYcCX13qLkEemWhwa5urLE7joe0qVCk1wqNxYQnMkrndrKYkEalG8goqF/853l6TuAeYz7YFKGj+PVcFH+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cIL6itAhPdZ3D3PPg9L/q/kUTnJMPzSBnpjZakp4CDM/VCkL
	79RrKptoP5bEzgAqpck6iqGA0dASblNgOTMtdQghT3s1zWFm9Wq8+/hmP67KX/Ggqmxqsgj/I89
	j/3JNEzM3bJfF64bN4DGkzxgI8g==
X-Google-Smtp-Source: AGHT+IFrbVWEjcnnhPqVNNfoXdE4uWtL2uLFR/SuylPMYdOzh/UX0ZGOOJf3vv2vFR4zxFt6d8SFt3K6oxKtqNeW4hQ=
X-Received: by 2002:a05:690c:60c5:b0:6e2:1527:446b with SMTP id
 00721157ae682-6ee55bba6ecmr186681327b3.3.1732024239764; Tue, 19 Nov 2024
 05:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-3-y.oudjana@protonmail.com> <20241031161906.GL10824@google.com>
In-Reply-To: <20241031161906.GL10824@google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Nov 2024 07:50:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++_R3ZVrtrXYXbqODuHteJb4akq2NxMoyjO2wRvKYKdA@mail.gmail.com>
Message-ID: <CAL_Jsq++_R3ZVrtrXYXbqODuHteJb4akq2NxMoyjO2wRvKYKdA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add bindings for MT6328
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	jason-ch chen <Jason-ch.Chen@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 11:19=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 18 Oct 2024, Yassine Oudjana wrote:
>
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> >
> > Add compatible strings for the MT6328 PMIC.
> >
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > ---
> >  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
> >  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml      | 2 ++
>
> Doesn't seem to apply cleanly.
>
> Please rebase and resubmit.

mediatek,mt6328 is now flagged as undocumented. Please resend this.

Rob

