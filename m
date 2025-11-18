Return-Path: <linux-pm+bounces-38179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E115CC6A13E
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D44FB527
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C42322DAF;
	Tue, 18 Nov 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Lq4z7uIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE509355020
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476207; cv=none; b=gTSkMHXlo0vldcjH3wPWj4+PpauR1Ar+Qz4C7anv5sS2DVKJZZoxeyRGib4EJmb73zjHU67v9ua1MwhhkHWFL0QmAB/627UK/S8+YsvohWLl8C3TGglOw3HQaNmlSpePsHbCpjl2yuVh2T010shkJ3Di10W7b/Eh9WGS6xUW0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476207; c=relaxed/simple;
	bh=812u0/kE8U6KIifXA4o4gTvauRi/MWbHZ1WwZdLX1Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg8boPUoQx35/g3feZqf4z/yckaZuzZd4QsrfsEoBtCMPZuLYUUUIn00gVoVReac/xqLfqPS1DGkzBAS33J+CCNbE0fEbjv+vQL73YbEDMYiSSwdbT9b7Wig1M476qrSLL0PEDagn/jqHBqoCqezjb5v5mffihEme/HJzLJs3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Lq4z7uIo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-591c98ebe90so6022924e87.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763476202; x=1764081002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPuRb3+haxxFSoGOZ/Vv3ClCGfszWqWGAZKDKrczFMg=;
        b=Lq4z7uIoHwX+T0oZpnQeE7Sgq9N1okHHPsxFDCimKWGvAYYyd1L3RkOxAFX6qqwgAK
         n7bdZ81LqGV1aeevTqZ8wYxo8zm2fcmodj9xNDXKeQJspHWeAezhpEaV3ItXy5cPjLX4
         6lleapZWGYLkpOGJxS/+B70xq3sqzhS76pnHvh3KpwGhTjAk0fG5Bfaevs8HoAynZMpF
         6Y9f9b3Bef5JuVIba38qaCDqJwveVXQ19CNrRhMaBrwVBCOxUcjdGZbK08iPRuO8sCQ+
         nlyYi9cr1Cu3HHRMrga2WbosxHKUD2ZvZJFSImC9bw3VIP1RTXdGahqstC5GX3Xx94Lo
         LSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476202; x=1764081002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPuRb3+haxxFSoGOZ/Vv3ClCGfszWqWGAZKDKrczFMg=;
        b=NRc+9DgbQLURej4VsPT+X8T+Cy+69UPrS7NogeAlaVBkRdryBAAq61LHoJM7syhjiO
         w5pR0oG2K1nVkF+9FCpned54V/gr44Dw6YVehO5TyQu7ke01QJfjkgJ3tj3Rn+K341vh
         A+4tBgEwaTW1PRYX5JsHQIxJjhZUAX1DoO4EkktpGLACbXBwGnDMbrb8YgW95dQgh4Rr
         xNLFvtXKaPbsAcmyGZShzQoMKJyxtn8Znn5x/GKMYA2cg+JStqkuqkschcQ1+0Lw45tQ
         vcZgt1xcyrQY8trGpraQm8MnwTnbBFpVxf2S2ylfmUGRokUjd5k1Zmg4Y6Oc2ass8BG9
         v/DA==
X-Forwarded-Encrypted: i=1; AJvYcCX32BWdWU3GBeL1IIsfESQzTRit2RjZxHmFLeN5v3fHihXxAN0VIdfC4Tn8NCwwBT2vAVRGXtp7WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWOHjTzNx26qTyDxW9YziR3wIpyjgLZvUTzAc/lLk+EjortxT
	F/y1uxVqKYGkTHynzNJMsxHpObLcdoUx28/SMOOhfrckyapK7LNKohFREARacJdrQIIRItrJ6uh
	FMgn/f7NG0bwWJThgbHB2YqEbOQqRa2HZoOs/YKeeRw==
X-Gm-Gg: ASbGnctXG8givZNF39pRixYchvXxQjw9oXFwJPmyJsEqBrwSn8WarlsT0ZyHAT40Mk0
	TeyciAQzKI8gnaB4SB1CUpvTBfcdDqIrf1pRJJ+dRX+RQlwmFusORI1VpWOjIvnIiRWbIaqOFBV
	AHWK/JyL1yNt8Ir7NJ4A3fD83pQig5/nhkCfM7z6UQ5l70wBodcPjhCkl1croyAY/9dVlfmSVM4
	jyX3cx6ijR6GuStSP1vtEQwrQZGo0fhWoFPCftM/4ajTI/MwVJa83OXaiGzWDwyzj27nnGM5FNv
	qkSUWHwVlzXiPjnRNQKJCKTMOfxFi2qPnc/Q
X-Google-Smtp-Source: AGHT+IG/8x599leRbcc55AKG5x7ewC54AAGqLK2r1ZPyGFLtbdnyvhRmFu7yQc8cTfZdSXpR6fRtj7AIKLBehJrw2m0=
X-Received: by 2002:a05:6512:3ca2:b0:57a:2be1:d779 with SMTP id
 2adb3069b0e04-595841febd2mr6716947e87.31.1763476201587; Tue, 18 Nov 2025
 06:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-8-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-8-97413d6bf824@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 15:29:49 +0100
X-Gm-Features: AWmQ_bnS7J2LiofnEnjv4l_cFHHTAIWcbKZPMExzLrGKBD6vTSaTLBGi1oU52Ic
Message-ID: <CAMRc=MdRw+spjN0ySJ7We_GJ8GaDU2Nb4unaxcnr2ZLjLOeSrA@mail.gmail.com>
Subject: Re: [PATCH 8/9] Bluetooth: hci_qca: Add support for WCN7850 PCIe M.2 card
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:45=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The WCN7850 PCIe M.2 card connected to the UART controller exposes the
> 'WCN7850' serdev device and is controlled using the pwrseq framework.
>
> Hence, add support for it in the driver. It reuses the existing
> 'qca_soc_data_wcn7850' driver data.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/bluetooth/hci_qca.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4cff4d9be3132561ee9bae4ddf2c8ac0bc13ecd7..09bfb3bba93698f496947775b=
f6b31f2f20279f1 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -26,6 +26,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/consumer.h>
> @@ -2344,6 +2345,9 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>         qcadev->serdev_hu.serdev =3D serdev;
>         data =3D device_get_match_data(&serdev->dev);
> +       if (!data && serdev->id)
> +               data =3D (const struct qca_device_data *) serdev->id->dri=
ver_data;
> +
>         serdev_device_set_drvdata(serdev, qcadev);
>         device_property_read_string_array(&serdev->dev, "firmware-name",
>                                          qcadev->firmware_name, ARRAY_SIZ=
E(qcadev->firmware_name));
> @@ -2384,6 +2388,15 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>         case QCA_WCN6855:
>         case QCA_WCN7850:
>         case QCA_WCN6750:
> +               if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
> +                       qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->ctrl->dev,
> +                                                                  "uart"=
);
> +                       if (IS_ERR(qcadev->bt_power->pwrseq))
> +                               qcadev->bt_power->pwrseq =3D NULL;
> +                       else
> +                               break;
> +               }

Did you by any chance copy this logic from commit: db0ff7e15923
("driver: bluetooth: hci_qca:fix unable to load the BT driver")? This
commit is wrong and it flew under my radar during the summer and I
never got around to fixing it. It doesn't take into account probe
deferral.

Bartosz

> +
>                 if (!device_property_present(&serdev->dev, "enable-gpios"=
)) {
>                         /*
>                          * Backward compatibility with old DT sources. If=
 the
> @@ -2740,6 +2753,12 @@ static const struct acpi_device_id qca_bluetooth_a=
cpi_match[] =3D {
>  MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
>  #endif
>
> +static const struct serdev_device_id qca_bluetooth_serdev_match[] =3D {
> +       { "WCN7850", (kernel_ulong_t)&qca_soc_data_wcn7850 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_bluetooth_serdev_match);
> +
>  #ifdef CONFIG_DEV_COREDUMP
>  static void hciqca_coredump(struct device *dev)
>  {
> @@ -2756,6 +2775,7 @@ static void hciqca_coredump(struct device *dev)
>  static struct serdev_device_driver qca_serdev_driver =3D {
>         .probe =3D qca_serdev_probe,
>         .remove =3D qca_serdev_remove,
> +       .id_table =3D qca_bluetooth_serdev_match,
>         .driver =3D {
>                 .name =3D "hci_uart_qca",
>                 .of_match_table =3D of_match_ptr(qca_bluetooth_of_match),
>
> --
> 2.48.1
>
>

