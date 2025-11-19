Return-Path: <linux-pm+bounces-38219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B4C6F02E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 14:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F394FCF34
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D33624B4;
	Wed, 19 Nov 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZB0fy+cS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E835CB8D
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558897; cv=none; b=gQUOecdEmQB9PrdJaFvkS8YpLgZdH0VORZxehaj8AKl0It/vCFgsuQ6eQ/CCPue1IeLL1OgrD25aT8UpjSd4XZh24mDT/koJnR0BOI1nabc/DLgzYMyaDaGvUpozxY3hSExwnKRuUcOpf+HqEzt+IKYU/E4zLtCeMDaeWzf03BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558897; c=relaxed/simple;
	bh=gHpwjjREhsAd8WKsVYT8IYp6+ZQIN7Tnm8WoUEA8aZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmtaSk3TR7ntvVM9DVD8u2UF86W6WbaNpOAnCgnibP8qiTTu3yHWK0cDNpMtkTsA7iBFc+0uuHTJjU9x4KMRAxW4+9sg4xFgnupIMHAz77lgRET2v/GUA/w6KOzzWK12bv8PgTtW+nW7inTjApwk3y0LD4ub4dl1sWTnhXDDNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZB0fy+cS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957ac0efc2so7299517e87.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763558893; x=1764163693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9Fz2SH1ZUm7FuuivONGxxUgBBznVGQP+s2/x19XhOc=;
        b=ZB0fy+cS1xYK9vha6Tv00U0twgMJFjTq4+9aYZ8hfvmNMqly9QfDD0oXfZNzwWRpbh
         JwGFoamRilDGXXJFFu9byVUjYTEGhBvrAkUaTW4zbHsxMiaCmJXWKWGGJ1wn+TY/2Aog
         twpOHdet9yu8ZPQAozLB0jDV4ur4E5xF7GGdhCc+mwzbml3XhLsLF/WkE3y/uHdyVfNy
         WSixf7XnPG58jugGaEQVpZRATC1hb9sAaUkNE1pRhY9SE4CtrJIfLMbXjMgDs4Jd1T0s
         TnaJUFkbVzs4/Wx5SLGTYQ+q9yG5OJixmqZG+sza1llI6xYIr6g9l8B5eKkFJLn7A4Bg
         BWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558893; x=1764163693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9Fz2SH1ZUm7FuuivONGxxUgBBznVGQP+s2/x19XhOc=;
        b=sK54GZ1USpVpRUZVCVfcTbtW8IIXUSINcgF7AkJJGb5sxxZ0I79STIuKxiThxDhWmF
         0o8r0cpdMOhHCQJmshuXw/Kr5Frcu0ye2vevzAGZ+ObfHleIKBABbbltvcfhftwGuAyK
         dBb1PuEpbIHkKR6LCW59X6VtNDkDXm840woPqrksCWiVOe0mW1CQMuwdIhnP8PiTpzLZ
         iCrI1fT32JfFdRKlcitkgJ7/neAiAp6qw8q/n8hkQKGVK5N40SQ1GWpTRZvYhOnt2cvI
         4Jfc2TMvjzZwrVNAqNw0UAlNorxFCwZWlLOCPxoQZByP4rzssh8wVOYhA0RfEGdHCMa1
         w+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXHXx2e3yQv490OIx4tgY5TuR7YDS7jPONMIQx+e6AT4xPN05eYjtKQzabXykDkoGjxmxIKNrfaGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8lk99q5BRwJ/sjfBc6dRk0v5pkHVOQO2cHisQ1Xg5i+sXDRti
	1tsSqLy8VBg/oMZHVamNr8+TBbjloLoCu0fMdgBRzgxdScr0ZmmXGzDajgOI/LyMTZQw6FdwjOZ
	SR10/AX2g0mag4nz93xw14JuBt4NoSddm0EKW7XmCWvVMBcMZouKXHPj6Xw==
X-Gm-Gg: ASbGncu71pbZxlmGI7DhVKNzx83m0o038OjMMdZJSlzZxrsLqZfdW3ylYtkBoMm9hf/
	HXp3H0OTSTzrS4UQSw0LEfK5n27ydWaRjpiTjDqsCkdDHUVjs1HaEhEe6jN4kuW0HMqh7/89kSE
	iGjgNLdcRi9DRoEjZZ0BJX/sZ5g2Cq/eebUtsYuFzYNDlIj3NBpeuElOh8WUbQW+TUFst/vSz/J
	sp2H3jYjZm2ZmUMYVb0uszqovrMDJuTKj35IXwT3xMPsI/wz8d8oGdhVluE1aAH3Roj9JPhih8v
	mh1KMX2xU1fUYhNDxeH2HW8MBWNcjHOMIxGQpmHUobCmIBAJ
X-Google-Smtp-Source: AGHT+IGJBnlU8SfCgN2H396Pf5rcfKBaHkLraBwus+9No1IWypEaF8w8j8PGxkXY9nu4VlhBBrtuUvloX+iTMlSUET4=
X-Received: by 2002:a05:6512:1326:b0:594:2cdf:1941 with SMTP id
 2adb3069b0e04-59604e3f4e4mr1143048e87.31.1763558892975; Wed, 19 Nov 2025
 05:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-9-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-9-97413d6bf824@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 14:28:00 +0100
X-Gm-Features: AWmQ_bm5iCKbfw8hpw1YVmAcjxIFk-iHf3DCtBX1MsQ5hHQ1VM87jgrdbOpF5Hc
Message-ID: <CAMRc=MeyeyuNVP6CWcxNp8XSCT+P9ZNmgSj6Hktrv8ZYNN5kMg@mail.gmail.com>
Subject: Re: [PATCH 9/9] power: sequencing: pcie-m2: Add support for PCIe M.2
 Key E connectors
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
> Add support for handling the power sequence of the PCIe M.2 Key E
> connectors. These connectors are used to attach the Wireless Connectivity
> devices to the host machine including combinations of WiFi, BT, NFC using
> interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.
>
> Currently, this driver supports only the PCIe interface for WiFi and UART
> interface for BT. The driver also only supports driving the 3.3v/1.8v pow=
er
> supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
> connectors are not currently supported.
>
> For supporting Bluetooth over the non-discoverable UART interface, the
> driver currently creates the serdev interface after enumerating the PCIe
> interface. This is mandatory since the device ID is only known after the
> PCIe enumeration and the ID is used for creating the serdev device.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>
> +static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);

Since this is new code and gpiod_set_value_cansleep() now returns an
integer, can you do

  return gpiod_set_value_cansleep()?

Same elsewhere.

>
> +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned lon=
g action,
> +                             void *data)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D container_of(nb, struct pwrseq=
_pcie_m2_ctx, nb);
> +       struct pci_dev *pdev =3D to_pci_dev(data);
> +       struct device_node *remote;
> +       struct serdev_controller *serdev_ctrl;
> +       struct serdev_device *serdev;
> +       struct device *dev =3D ctx->dev;
> +       int ret;
> +
> +       /*
> +        * Check whether the PCI device is associated with this M.2 conne=
ctor or
> +        * not, by comparing the OF node of the PCI device parent and the=
 Port 0
> +        * (PCIe) remote node parent OF node.
> +        */
> +       remote =3D of_graph_get_remote_node(dev_of_node(ctx->dev), 0, -1)=
;
> +       if (!remote || (remote !=3D pdev->dev.parent->of_node)) {
> +               of_node_put(remote);

You could really use some __free(device_node) here. It would simplify
the code below quite a bit and make sure you don't miss anything.

> +               return NOTIFY_DONE;
> +       }
> +       of_node_put(remote);
> +
> +       switch (action) {
> +       case BUS_NOTIFY_ADD_DEVICE:
> +               /* Create serdev device for WCN7850 */
> +               if (pdev->vendor =3D=3D PCI_VENDOR_ID_QCOM && pdev->devic=
e =3D=3D 0x1107) {
> +                       remote =3D of_graph_get_remote_node(dev_of_node(c=
tx->dev), 1, -1);
> +                       if (!remote) {
> +                               of_node_put(remote);
> +                               return NOTIFY_DONE;
> +                       }
> +
> +                       serdev_ctrl =3D of_find_serdev_controller_by_node=
(remote);
> +                       of_node_put(remote);
> +                       if (!serdev_ctrl)
> +                               return NOTIFY_DONE;
> +
> +                       serdev =3D serdev_device_alloc(serdev_ctrl);
> +                       if (!serdev)
> +                               return NOTIFY_DONE;
> +
> +                       ret =3D serdev_device_add(serdev, "WCN7850");
> +                       if (ret) {
> +                               dev_err(dev, "Failed to add serdev for WC=
N7850: %d\n", ret);
> +                               serdev_device_put(serdev);
> +                               return NOTIFY_DONE;
> +                       }
> +               }
> +               break;
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port=
, const char *node)
> +{
> +       struct device_node *remote;

Same here.

> +
> +       remote =3D of_graph_get_remote_node(dev_of_node(dev), port, -1);
> +       if (remote && of_node_name_eq(remote, node)) {
> +               of_node_put(remote);
> +               return true;
> +       }
> +
> +       of_node_put(remote);
> +
> +       return false;
> +}
> +
> +/*
> + * If the connector exposes a non-discoverable bus like UART, the respec=
tive
> + * protocol device needs to be created manually with the help of the not=
ifier
> + * of the discoverable bus like PCIe.
> + */

I really like this idea BTW!

> +static void pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *=
ctx, struct device *dev)
> +{
> +       int ret;
> +
> +       /*
> +        * Register a PCI notifier for Key E connector that has PCIe as P=
ort 0
> +        * interface and Serial as Port 1 interface.
> +        */
> +       if (pwrseq_pcie_m2_check_remote_node(dev, 1, "serial")) {
> +               if (pwrseq_pcie_m2_check_remote_node(dev, 0, "pcie")) {
> +                       ctx->dev =3D dev;
> +                       ctx->nb.notifier_call =3D pwrseq_m2_pcie_notify;
> +                       ret =3D (bus_register_notifier(&pci_bus_type, &ct=
x->nb));
> +                       if (ret) {
> +                               dev_err_probe(dev, ret, "Failed to regist=
er notifier for serdev\n");

If this is optional and we don't handle the error, should we really
print it as one? I'd say a dev_dbg() would suffice unless the failure
here impacts the driver's behavior (which it does, so maybe the
notifier should not be optional?).

Bart

