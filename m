Return-Path: <linux-pm+bounces-9656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9399100B5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 11:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8812B21135
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26991A4F28;
	Thu, 20 Jun 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GF4+2Xno"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1A433BB
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876801; cv=none; b=FdzK0ftbfUX7TdaPxxKEmQdEoeLiJ1oWKv2Q+CxZa/0EJI7qePeowzS9r86BxvV8LR0z1znMPMeBcrIRD0A1I7XwiReI3c49VjYF0p8sgOTLIxCdO37msqO/ryIAijxU36nkFRowAOOUs2RYEyswAvOCYpGnqRyTaRuEkfPqdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876801; c=relaxed/simple;
	bh=PQeDvQdpV3xoa4EoS+6rRCcA8khvc+TkBodiCwJ0nPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKzQJa1y0wUpU3T2ra5hYRkE50huD27S2wR1Bfoct8sKLtExgRxITB5i0SXMCysF2IyD6nXrMAyx8ZIwI8nhOdeIWZ8zc7gRKXEbZghujcN9/cFB2A9x/79aTeZgABzGxzemOKw7aj5MMHBFiJeTqZ2SwfECsh+JcIU8x3PG/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GF4+2Xno; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so7555011fa.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718876798; x=1719481598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C8Ju8XWmp5T/a5fTSJkVEbGY+u2Y8Oaw2wvJKVqwcw=;
        b=GF4+2XnoU8Q3JXTCA7tHT80PNo1AoLZkOLZOSqkdPn95Y1lVZ9IXGU0IEGpnIIqaxn
         YSrIPMBEFUxSn460HIBRvnmPccKJLDtd7ncMV3/fHTBE/KTPMDwHeoVk353yWgbGVu2p
         mN5PxYyst7iWw0rqdC1K140hdORTEHcMyliMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876798; x=1719481598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C8Ju8XWmp5T/a5fTSJkVEbGY+u2Y8Oaw2wvJKVqwcw=;
        b=IzhdKKKHlL2z4CD0wBEpdikzp/06uigzAAgBQ0Uq52w2DJAzfDmtuwOPDptU4pcsq+
         pyxXqyo1fACQ1dLrC8nA+7WFUhV2Ngv+GlgHN42RHmQ/IMa0QJ7IC7n/a2SX4xdqrLvX
         piWDUrlewFEoMfw+qVfUyYhX/IdcQdx83hb7FC9T6b3uAJ4mhNu1AGlemH9zoXfCN81C
         INtm8wm/bGtIBhsMe1279NpxnObM7c3EhIKMRjV0Qb3su4CtvvlL+QrlYD0NqTt0Z1sH
         g0w0bru/TTfXfVDhetAVxHqVpEG2bF2qfdYfrNl8v3B/4ktT7J/O23pzuDOSHoeYpzhS
         90jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5i7Edg4ApujMe9nzhu+OA0xSxGrfkGTA7KCETUpaCFAaKxeb4uM6CKMbBP6YopbR+HtJ8+T+BoROByDDuCE+V4xbK5wkxtIQ=
X-Gm-Message-State: AOJu0YwVd8g52D82xrQCjTfkvsKa42hTKCANy+8EcMmyfLUPS1kz2Sgm
	wQH7iVlhjK8sx6CeTgrqCC/qvvDdwFCWmbrOU3b+VTuCU1VNL/64NJzfBt/NySMhHNg01ICjvys
	ek1Xfm8lihLwEfcDVH/08sojdz9Q5KOyohMXf
X-Google-Smtp-Source: AGHT+IEAch4d9DfYlt6svj7uQiDMS/kkFeiPt+x05ruz/JwQ3l7QJT/Zf3fr43/NzPnYxwZicSzj+aUa/F91bwpokys=
X-Received: by 2002:a2e:2281:0:b0:2ec:3f29:a0fe with SMTP id
 38308e7fff4ca-2ec3f29a240mr23325101fa.38.1718876797983; Thu, 20 Jun 2024
 02:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
 <75826085-fd59-466a-b1de-b4c323c801c1@collabora.com> <CAGXv+5FPG4ob3mTU0Utm8Wgk0_ZLw=NLPbfFerWh4OUeAz7UHw@mail.gmail.com>
 <808db317-4cee-426b-a840-013a5e03098d@baylibre.com> <ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com>
 <940eec49-91d8-4d38-a3d8-e1b7e090b905@baylibre.com>
In-Reply-To: <940eec49-91d8-4d38-a3d8-e1b7e090b905@baylibre.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 20 Jun 2024 17:46:26 +0800
Message-ID: <CAGXv+5HpRvsYz3ZJ_hNM=RhDHbnEZA73Xwm1YgjuWWPXhymT9w@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal zones
To: Julien Panis <jpanis@baylibre.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <npitre@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 3:58=E2=80=AFPM Julien Panis <jpanis@baylibre.com> w=
rote:
>
> On 5/29/24 14:06, AngeloGioacchino Del Regno wrote:
> > Il 29/05/24 11:12, Julien Panis ha scritto:
> >> On 5/29/24 10:33, Chen-Yu Tsai wrote:
> >>> On Wed, May 29, 2024 at 4:17=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>> Il 29/05/24 07:57, Julien Panis ha scritto:
> >>>>> From: Nicolas Pitre <npitre@baylibre.com>
> >>>>>
> >>>>> Inspired by the vendor kernel but adapted to the upstream thermal
> >>>>> driver version.
> >>>>>
> >>>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> >>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> >>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >>> I'm getting some crazy readings which would cause the machine to
> >>> immediately shutdown during boot. Anyone else see this? Or maybe
> >>> my device has bad calibration data?
> >>>
> >>> gpu_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       +229.7 C
> >>>
> >>> nna_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       +229.7 C
> >>>
> >>> cpu_big0_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:         -7.2 C
> >>>
> >>> cpu_little2_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       +157.2 C
> >>>
> >>> cpu_little0_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       -277.1 C
> >>>
> >>> adsp_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       +229.7 C
> >>>
> >>> cpu_big1_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       +229.7 C
> >>>
> >>> cam_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:        +45.4 C
> >>>
> >>> cpu_little1_thermal-virtual-0
> >>> Adapter: Virtual device
> >>> temp1:       -241.8 C
> >>
> >> It's likely that your device has bad calibration data indeed. We obser=
ved the same
> >> behavior on the mt8186 device we used (a Corsola) and finally realized=
 that the
> >> golden temperature was 0 (device not properly calibrated).
> >>
> >> To make a comparison, we run chromiumos v5.15 and dmesg output was:
> >> 'This sample is not calibrated, fake !!'
> >> Additional debugging revealed that the golden temp was actually 0. As =
a result,
> >> chromiumos v5.15 does not use the calibration data. It uses some defau=
lt values
> >> instead. That's why you can observe good temperatures with chromiumos =
v5.15
> >> even with a device that is not calibrated.
> >>
> >> This feature is not implemented in the driver upstream, so you need a =
device
> >> properly calibrated to get good temperatures with it. When we forced t=
his
> >> driver using the default values used by chromiumos v5.15 instead of re=
al calib
> >> data (temporarily, just for testing), the temperatures were good.
> >>
> >> Please make sure your device is properly calibrated: 0 < golden temp <=
 62.
> >>
> >
> > Wait wait wait wait.
> >
> > What's up with that calibration data stuff?
> >
> > If there's any device that cannot use the calibration data, we need a w=
ay to
> > recognize whether the provided data (read from efuse, of course) is val=
id,
> > otherwise we're creating an important regression here.
> >
> > "This device is unlucky" is not a good reason to have this kind of regr=
ession.
> >
> > Since - as far as I understand - downstream can recognize that, upstrea=
m should
> > do the same.
> > I'd be okay with refusing to even probe this driver on such devices for=
 the
> > moment being, as those are things that could be eventually handled on a=
 second
> > part series, even though I would prefer a kind of on-the-fly calibratio=
n or
> > anyway something that would still make the unlucky ones to actually hav=
e good
> > readings *right now*.
> >
> > Though, the fact that you assert that you observed this behavior on one=
 of your
> > devices and *still decided to send that upstream* is, in my opinion, un=
acceptable.
> >
> > Regards,
> > Angelo
>
> I've been trying to find some more information about the criteria
> "device calibrated VS device not calibrated" because there's a
> confusing comment in downstream code (the comment does not
> match what I observe on my device). I'll send a separate patch
> to add this feature over the next few days, when I get additional
> information from MTK about this criteria.

I couldn't wait and sent a patch to provide default calibration data,
based on the values and code from the ChromeOS kernels. It seems to
work OK-ish. I get 4x degrees C on my MT8186 device.

Also, your previous patch blocking invalid efuse data has landed. So
I think this series can be relanded. What do you think, Angelo?

ChenYu

