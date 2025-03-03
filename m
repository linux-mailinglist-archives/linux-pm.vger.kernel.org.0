Return-Path: <linux-pm+bounces-23442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291FA4EB39
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A4817FBC9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5940285412;
	Tue,  4 Mar 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndTOULP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E925DCEC
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111323; cv=pass; b=roEjE+BvkpjA7qy9XbyW6ZtME8lBJMQxts/8SrPKdcSe2nXZ5FZbwbvwe4fLiXwltUqEJCDKFFEO8xIlUhdHWBnVRlghbChs48Jn18WBUSJMZZDubWBeaUMlR1x/EnbbS2jLntKgkjNou6AcJadyWqxlP/K374Qqdm2MuHC66Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111323; c=relaxed/simple;
	bh=4HmOj/3Wlib3zncsg3O073eer/GxckvTC0ktgz3VV5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/Cwrti5njdRAyyAGlt13k1I7MPanI4OMajLL09tzG0xXEN2JpVztzpIPtGptG8I2zI55M0kdQhGbuli27BeQu6C34zXsTJBDubCJxgoRSw19oAZb1mEKM3CZb4ikUiA91gu/5Ja52P2neB1s36BJG9YvcqEtGTYBbCvJPwJYHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndTOULP8; arc=none smtp.client-ip=209.85.221.41; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 2717C40D9774
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 21:02:00 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gWr0x5czG2GG
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 19:05:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5B9BE4273F; Tue,  4 Mar 2025 19:05:33 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndTOULP8
X-Envelope-From: <linux-kernel+bounces-541512-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndTOULP8
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id B0BE841ED0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:15 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 47E3F3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:15 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F023B8812
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112B1F4CAD;
	Mon,  3 Mar 2025 11:08:51 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F71F3BA8;
	Mon,  3 Mar 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000127; cv=none; b=lh1V76t1xfuvfvqg/pIhOTFHzcpLnadotWJwlwhqalv1F3Qfm+yA7T/z880/mxuSn6QBcMv+JNvcdBeC3W9tlwJ1Y+U7AXDcC0CbixWWj8u9UFzlqyIPNwC0af+Q6nPvKRdFYo/0TxuORblbIJhVKylTrTGLJzAia7Fdmai0E1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000127; c=relaxed/simple;
	bh=4HmOj/3Wlib3zncsg3O073eer/GxckvTC0ktgz3VV5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMiknJ93857oEdPw1HWS2F+to64GAXl86eB7QT6VpNVMp+AC3EIBieEEVqy3fw6lWBoOohGGZi/qbHb6UEP6tALq2juZljULDLl8XA/hBimqUCxngtcUhn+dEMGEWPdIs1JbQuTyhDUaTvC4TX/t6l59trDaamKuRuoSHOiqCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndTOULP8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390eebcc331so1521883f8f.1;
        Mon, 03 Mar 2025 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741000123; x=1741604923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULoMgnoXr8L1C6JD7W1nPWWFd3ANujjbWRiciG0YDU8=;
        b=ndTOULP8W22qD5RY4DAgnWarP07Q03XeU01X86+aF7XFnB2O1LDV/JgpugI3HSe5E1
         g0jpot9nlbzfxRC9VVEIl4jt7eyemjq2iIO6ZnNDUF3OKACGgA1OeppWEz6mAdsqwyRV
         Sa8ajUF1MCQHJS4aST/Y/LTzWHpKpTsyZZq54JNgjv+jvcZyNPrqw9mCpqaH7hKBJpuy
         ckPCX5SlTn5ca+w92yV4ucWhcwfG0IVOQ5mLu/PzUfGm0v9bOTr/zpzozhQChEA9X4jY
         G+XJF21P2L9h4RdHqqgscZcqjUfVjnpAI1YhO2vOjnVX6OtclY3BeVB9gzOfs0jSupKq
         B0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000123; x=1741604923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULoMgnoXr8L1C6JD7W1nPWWFd3ANujjbWRiciG0YDU8=;
        b=Mfk2bJXFFFCUdZNSEnsjcm0VnOl+SZUmm+aGnkqQccWZhqyzDCSuceAjieWASg+Ov1
         fyE6lKR/nNYbHpTgLBTb0hTsAqn/RWAdAxLhxySSZlWuRTsGWWTsMfsVTv0MrwtkABgs
         nkJ6EBYqFI+erIkp2IqU40f4BNlFeaf29zCTSYDGCu10Rcq7zitEv7P5/HhN6BfA3htA
         utAhKKmOabFx7OX2Ak0Gh1h9GorgXmzyy1zRjz/Upo08YXCrZwX7sJog0n0Y4zwr2yP1
         iX+EGX9KMHoFjbJtHB776mrOWeCrGwAx6jX6L/A34amiwQt6hJYppl7J0wB0ayajNswE
         FjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX36TWtPzwQ0jcc5QHZDXkmKXBf+RkGTlZHz3XAuDNsfg37BrRYjTHOECQijUNgQM2FYBiIKn2zbv7S2bn@vger.kernel.org, AJvYcCWxarpmwoTSBeL0+N0Me2VXykm/Fcx1lFqPrNU3qo0t79MIDzOUkgoovbO+h7Hj61bU/EO+6KV3FXhp@vger.kernel.org
X-Gm-Message-State: AOJu0YxNDs1n4RXbVXZ+5sEGakqY6FvnqCB4WdxAFhfnFNnxaOKWFMdL
	HkaLm3q+WQr2tiNFgGjN+iX6YJ7+bQwRg+BhSNa3MhGb9eidDphe5edrS8E9zIWrtaa376fdVF8
	GvghKa9n33rXrO40MCVmC4tOy4Js=
X-Gm-Gg: ASbGncuN3LHcduGcCDEaQJLBmtgBW+qgsNhmTqlHpJppmYreZEOm4h7qzIhp7P7hV54
	8l1PLJfeyFB3vUGTv80m/B6v3dwYFmMIJ6lZ7Ul8FDGb6Rv2VPMxT6XGbdvRLvHNn+jZz4sdHwy
	pj4WDNcodOqmmFL+1fwrEAkMsaRW8=
X-Google-Smtp-Source: AGHT+IFhL1VGqvu6/L+/q7Zc25Yy9RI3MXyS9jJwyfSvB1TiiTDcgln3OoeI7ZBVrGV2krySaBS+BuYN1CjRA1ZLN0I=
X-Received: by 2002:a05:6000:4594:b0:390:e535:8740 with SMTP id
 ffacd0b85a97d-390e535884fmr10020468f8f.14.1741000122764; Mon, 03 Mar 2025
 03:08:42 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082817.56339-1-clamor95@gmail.com> <20250219082817.56339-3-clamor95@gmail.com>
 <99ee61dc-abd5-45d9-8d26-a8f0ae94c8eb@arm.com> <CAPVz0n0uWEY+-evrfpci9-1c3icGyHfTHMbXi=P9Sv=Uh3AUaA@mail.gmail.com>
 <93ddb2d9-ce3d-4e6d-bf5f-0b30b2d04d84@arm.com>
In-Reply-To: <93ddb2d9-ce3d-4e6d-bf5f-0b30b2d04d84@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 13:08:31 +0200
X-Gm-Features: AQ5f1JpD5JFPA8iwOxoXnJ1YeK0i3dfIhf5qwB6Sws_ueobcubuvER9wMFqnBIk
Message-ID: <CAPVz0n3gs_1wUncJ8w5kpSLiDpJEzPUQ_qaaR2TAhHJHtTR5EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gWr0x5czG2GG
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716014.28667@90iVc59qdHvOb2BibJJGQQ
X-ITU-MailScanner-SpamCheck: not spam

=D0=BF=D0=BD, 3 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 12:53 Lukas=
z Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 2/28/25 13:22, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 28 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:11 =
Lukasz Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi Svyatoslav,
> >>
> >> On 2/19/25 08:28, Svyatoslav Ryhel wrote:
> >>> Add IIO sensor channel along with existing thermal sensor cell. This
> >>> would benefit devices that use adc sensors to detect temperature and
> >>> need a custom conversion table.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/thermal/thermal-generic-adc.c | 54 +++++++++++++++++++++++=
+++-
> >>>    1 file changed, 53 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/=
thermal-generic-adc.c
> >>> index ee3d0aa31406..a8f3b965b39b 100644
> >>> --- a/drivers/thermal/thermal-generic-adc.c
> >>> +++ b/drivers/thermal/thermal-generic-adc.c
> >>> @@ -7,6 +7,7 @@
> >>>     * Author: Laxman Dewangan <ldewangan@nvidia.com>
> >>>     */
> >>>    #include <linux/iio/consumer.h>
> >>> +#include <linux/iio/iio.h>
> >>>    #include <linux/kernel.h>
> >>>    #include <linux/module.h>
> >>>    #include <linux/platform_device.h>
> >>> @@ -73,6 +74,57 @@ static const struct thermal_zone_device_ops gadc_t=
hermal_ops =3D {
> >>>        .get_temp =3D gadc_thermal_get_temp,
> >>>    };
> >>>
> >>> +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> >>> +     {
> >>> +             .type =3D IIO_TEMP,
> >>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> >>> +     }
> >>> +};
> >>> +
> >>> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> >>> +                              struct iio_chan_spec const *chan,
> >>> +                              int *temp, int *val2, long mask)
> >>> +{
> >>> +     struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> >>> +     int ret;
> >>> +
> >>> +     if (mask !=3D IIO_CHAN_INFO_PROCESSED)
> >>> +             return -EINVAL;
> >>> +
> >>> +     ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, temp);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>> +     *temp /=3D 1000;
> >>> +
> >>> +     return IIO_VAL_INT;
> >>> +}
> >>> +
> >>> +static const struct iio_info gadc_thermal_iio_info =3D {
> >>> +     .read_raw =3D gadc_thermal_read_raw,
> >>> +};
> >>> +
> >>> +static int gadc_iio_register(struct device *dev, struct gadc_thermal=
_info *gti)
> >>> +{
> >>> +     struct gadc_thermal_info *gtinfo;
> >>> +     struct iio_dev *indio_dev;
> >>> +
> >>> +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_the=
rmal_info));
> >>> +     if (!indio_dev)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     gtinfo =3D iio_priv(indio_dev);
> >>> +     memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
> >>> +
> >>> +     indio_dev->name =3D dev_name(dev);
> >>> +     indio_dev->info =3D &gadc_thermal_iio_info;
> >>> +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> >>> +     indio_dev->channels =3D gadc_thermal_iio_channel;
> >>> +     indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel=
);
> >>> +
> >>> +     return devm_iio_device_register(dev, indio_dev);
> >>
> >> I don't get the idea why we need iio device, while we already have the
> >> hwmon.
> >>
> >
> > Idea behind this is to be able to convert adc iio channel into temp
> > iio channel without introducing a new sensor which will duplicate
> > behavior of existing one (by this I mean conversion table use). Not
> > all devices can or have to use hwmon and some may require iio channel
> > hooked up.
> >
> > Real life example. I own a device (LG P985) which has a fuel gauge
> > that does not support battery thermal readings. Vendor provided a
> > dedicated adc sensor and one of its channels is used as thermal sensor
> > with device specific conversion table. Fuel gauge on the other hand
> > supports linking in a dedicated temp iio channel to get thermal
> > readings.
>
> Thanks. IMO you can add these two sentences into the patch header.
> It's telling more about the need of this change.
>

Sure, will do

> BTW, I would like to see later how you use it in your battery driver
> (please add me on CC, because I'm curious).
>

It is already present in the kernel. Here is the schema
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml?h=3Dv6.=
14-rc5

> The code looks good, so please resend with better patch header
> and I'll review the whole patch


