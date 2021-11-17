Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707AE454F7C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhKQVnD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 16:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhKQVnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 16:43:01 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C33C061570;
        Wed, 17 Nov 2021 13:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JFZEUOPWf1/nxGeGtVRYuWseGaRsxvnuJVELp2zrJLw=; b=cI6tiWIw8UrB0NnC9bDlb7IRkj
        9VyLjEXqJiZ+ikt0/0lKIZ2hFeU19SmbUsmRMKLCMLoGhhZVZv6d2n1qo0FaLeXNe7xo377hbPO1j
        pfztujetrGwJ3qq+Ri2v4hSEzw143ca3BxZLu0Qq2wwK+beGN04s3lCP7b7BPRzVbxpU=;
Received: from p200300ccff0ece001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:ce00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1mnSel-0004n2-UB; Wed, 17 Nov 2021 22:39:52 +0100
Date:   Wed, 17 Nov 2021 22:39:50 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, broonie@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-hwmon@vger.kernel.org,
        amitk@kernel.org, linux-pm@vger.kernel.org, linux-imx@nxp.com,
        alistair23@gmail.com, shawnguo@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <20211117223950.3a7eaf7a@aktux>
In-Reply-To: <20211110122948.188683-2-alistair@alistair23.me>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-2-alistair@alistair23.me>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 10 Nov 2021 22:29:41 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> Initial support for the Silergy SY7636A Power Management chip
> and regulator.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../bindings/mfd/silergy,sy7636a.yaml         | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
> new file mode 100644
> index 000000000000..0566f9498e2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
[...]
> +  regulators:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: silergy,sy7636a-regulator
> +
> +      vcom:
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        properties:
> +          regulator-name:
> +            const: vcom
> +
hmm, this is what? If I understand it correctly, vcom means some
voltage for compensation. On other comparable pmics (e.g. TPS65185
which has also a sane public datasheet, MAX17135) I have seen some
methods to measure a voltage while the display is doing something
defined and then program this voltage non-volatile for compensation
during manufacturing.

If I understand the code correctly all the bunch of voltages are
powered up if this one is enabled.
So at least a description should be suitable.

The other comparable PMICs have at least regulators named VCOM, DISPLAY
(controls several regulators, started with delays configured via
registers) and V3P3. MAX17135 source can be found in NXP kernels, 
TPS65185 in Kobo vendor kernels.

So I would expect to see something similar here and a description or at
least not such a misleading name as vcom if it is for some reason not
feasible to separate the regulators.

Regards,
Andreas
