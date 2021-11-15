Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789F4523C4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353963AbhKPBaE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 20:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354284AbhKPB2E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 20:28:04 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D9C08C30C;
        Mon, 15 Nov 2021 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7eaRSnO6DvJcmgSx4Jh9u88P+ZEa+bilmuFqzgTMEmA=; b=fnBzpsc64M38Z6WqKOeB2dosXj
        eSKc5upq/AZOP2TtjbCP1cSDKf4JOovVIfz2FpIZ5TshxFjr76p3biNl5GX6Q154cO2lIM4Zsw1oR
        zr5QGxBJrsOKHrJqCzDD2S3rlIMPYTUFukpe9cxUOJdA/L70GzieAkhJfS6AVyObDubo=;
Received: from p200300ccff0ca2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:a200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mml77-00068e-IG; Tue, 16 Nov 2021 00:10:13 +0100
Date:   Tue, 16 Nov 2021 00:10:10 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, shawnguo@kernel.org
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the
 silergy,sy7636a
Message-ID: <20211116000634.767dcdc0@aktux>
In-Reply-To: <20211110122948.188683-4-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-4-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this all creates a lot of question marks...
One of my main question is whether sy7636a = sy7636 (at least the
driver in the kobo vendor kernels does not have the "A" at the end,
whic does not necessarily mean a difference).

https://www.silergy.com/products/panel_pmic
lists only a SY7636ARMC, so chances are good that the letters were just
stripped away by the driver developers. Printing on chip package is
cryptic so it is not that helpful. It is just "BWNBDA"

 On Wed, 10 Nov 2021 22:29:43 +1000
Alistair Francis <alistair@alistair23.me> wrote:

[...]
> diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> new file mode 100644
> index 000000000000..2797c22dabc2
> --- /dev/null
> +++ b/include/linux/mfd/sy7636a.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Functions to access SY3686A power management chip.

Typo? or is it really a SY3686A? So what we are talking about?

> + *
> + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> + */
> +
> +#ifndef __MFD_SY7636A_H
> +#define __MFD_SY7636A_H
> +
> +#define SY7636A_REG_OPERATION_MODE_CRL		0x00
> +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)

hmm, this thing is called VCOM_MANUAL in the 4.1.15-based driver for the
Kobos and in the 3.0.35 kernel for the Tolinos it is:

// 1:controll the vcom by external VCOM_EN pin 
#define SY7636_REG_OPM_VCOM_EXT_mask    0x1 //  
#define SY7636_REG_OPM_VCOM_EXT_lsb             6 //  

In both kernels, it is set if a gpio is used to control the regulator.
That does not necessarily conflict with your usage. The gpio might just
be hardwired to something in your device. Maybe just a comment about
that issue.
 
> +#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
> +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
> +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
> +#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
> +#define SY7636A_REG_FAULT_FLAG			0x07
> +#define SY7636A_FAULT_FLAG_PG			BIT(0)
> +#define SY7636A_REG_TERMISTOR_READOUT		0x08
> +
> +#define SY7636A_REG_MAX				0x08
> +
> +#define VCOM_MIN		0
> +#define VCOM_MAX		5000

hmm, what does that maximum mean? What you can set without something
freaking out just by setting it? Or the limit where the driver works
reliably?
> +
> +#define VCOM_ADJUST_CTRL_MASK	0x1ff
> +// Used to shift the high byte
> +#define VCOM_ADJUST_CTRL_SHIFT	8
> +// Used to scale from VCOM_ADJUST_CTRL to mv
> +#define VCOM_ADJUST_CTRL_SCAL	10000
> +
> +#define FAULT_FLAG_SHIFT	1
> +
> +#endif /* __LINUX_MFD_SY7636A_H */

Hmm, are that all defines you know about? I am fine with not including
unused things now, but I am curious.
For comparison, here is my "scratchpad" of all the information I could
squeeze out of the sy7636 driver until now:

OPMODE 0
  RAILS_ON 7
  VCOM_MANUAL 6
  LIGHTNESS 5

  VDDH_DISABLE 4
  VEE_DISABLE 3
  VPOS_DISABLE 2
  VNEG_DISABLE 1
  VCOM_DISABLE 0

  -> combined as RAILS_DISABLE in code

  VCOM: 10000 uV per step, accepts up to 2.75V (that is a bit contradictory)
VCOM_ADJ1 1

VCOM_ADJ2 2
  VCOM2_B8 7
  VDDH_EXT 0..4

VLDO_ADJ 3
  VLDO_ADJ = 5..7
  VPDD_ADJ = 0..4 

VPDD_LEN 4 
  VPPD_LEN 0..4

VEE_VP_EXT 5
  VP_EXT 5..6
  VEE_EXT 0..4

PWRON_DLY = 6
  TDLY4 = 6..7
  TDLY3 = 4..5
  TDLY2 = 2..3
  TDLY1 = 0..1

FAULTFLAGS 7
  FAULS 1..4: to be read out after interrupt and cleared
      0  no faults
      1  UVP at VB rail
      2  UVP at VN rail
      3  UVP at VPOS rail
      4  UVP at VNEG rail
      5  UVP at VDDH rail
      6  UVP at VEE rail
      7  SCP at VB rail
      8  SCP at VN rail
      9  SCP at VPOS rail
      A  SCP at VNEG rail
      B  SCP at VDDH rail
      C  SCP at VEE rail
      D  SCP at VCOM rail
      E  UVLO
      F  Thermal shutdown

  PG 0

THERM 8

Regards,
Andreas
