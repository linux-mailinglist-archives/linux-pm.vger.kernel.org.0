Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2AEE195
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfKDNwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 08:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfKDNwv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Nov 2019 08:52:51 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E2621E6F;
        Mon,  4 Nov 2019 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572875570;
        bh=By6g0hm3TZiFVPLysIIsZZ4/DGUA9l8/pS5v+EHrReo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TM7Ei1O3egCe5sMxOAjkB8RDO64+7FWfrmihBYMVk415TwspxzQenD0Bv3hdkSBqc
         e7Y4laBqSBo93hAZRlS0j32n8HM0HRjFT9ts18FkQsPiJOKitybpIBoy+SaJIaq+s1
         vwI71N8SXEJ91/zAOTUe2IGmlnm2PCXYxZ4nUasU=
Received: by mail-qt1-f175.google.com with SMTP id l24so5691139qtp.10;
        Mon, 04 Nov 2019 05:52:50 -0800 (PST)
X-Gm-Message-State: APjAAAWdbuRcgSsc9Jl0uvUEHRtJbT/1X0Uv7sskViTmhlYQTGKdUiBj
        fidJ0arNRLgJU8YH1zF9d3gtcculj83qgXX2ew==
X-Google-Smtp-Source: APXvYqzom7BkNjxSoNWY4xju2M9bVpLAWq9Yi9k0q1ua8c/IY+7LsJFI00hzK/jaLhVTn7iAKlZ/UIWagsutp0tHxkw=
X-Received: by 2002:aed:2706:: with SMTP id n6mr12458734qtd.224.1572875569519;
 Mon, 04 Nov 2019 05:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20191103220801.10666-1-paul@crapouillou.net>
In-Reply-To: <20191103220801.10666-1-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 07:52:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
Message-ID: <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Document generic USB charger
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 3, 2019 at 4:08 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add documentation about the devicetree bindings for the generic USB
> charger.

What makes it generic?

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/power/supply/usb-charger.txt     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/usb-charger.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/usb-charger.txt b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
> new file mode 100644
> index 000000000000..fd46734cb0e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
> @@ -0,0 +1,24 @@
> +Generic USB charger bindings
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : should be "usb-charger"
> + - phys: phandle to the USB PHY
> +
> +Example:
> +
> +usb_con: extcon {
> +       compatible = "linux,extcon-usb-gpio";
> +       vbus-gpios = <&gpb 5 GPIO_ACTIVE_HIGH>;
> +};
> +
> +usb_phy: usb-phy@0 {
> +       compatible = "usb-nop-xceiv";
> +       #phy-cells = <0>;
> +       extcon = <&usb_con>;

extcon is deprecated in favor of usb-connector binding. See
.../bindings/connector/usb-connector.txt. There's also some pending
patches for adding GPIO based connector controls including Vbus sense
(GPIO input) and control (regulator via a GPIO).

Rob
