Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9442866DA
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbfHHQUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:20:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45555 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfHHQUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 12:20:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so44365761pfq.12
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=rpT1/n0MtDKR55gc7Xe/1ERiGiwTe4vZMPU9Bfy10FI=;
        b=Y7o7tDsMydMyUuzGRnboQKe/5DZGF0GAAcTEKQ3TnqBW9YBJW+NKiPXSdtZCCYObN8
         AtJrE90vxGnVWdwPAxzaJhl9IPp4pUP4BUo49u+TH7K9mJ7N7xJ5Ne1r/mTSLgfDqOqe
         KMeAzvYaE5+sipQTmnJqT9BRA14XUcjFtqt14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=rpT1/n0MtDKR55gc7Xe/1ERiGiwTe4vZMPU9Bfy10FI=;
        b=BytBuIllqP5ol5MTZnuOBjDelNjVQG4hF1iA9IEk0RK6mp5u4n2jtXxfo4BQdsIQhB
         1Mxs4C1ePf9J2EcjPpNNe/lOb+WQ2Cc9DTLFySQT1oTegPiVGBewuJjYEjaKBbTnexv3
         bo7GLceJg6UndJjlLV+J8VWtuiu+3f4eE1Gwz15DWnrJiCfsiX3hziCSHAI4kOiTDKxs
         7Iu4wMXuzMJ1oZzgIsGS0h5dLWc5FXYMfK33gdJyenWOdV9BkwaPBEAtCGFg7xBJ0v6p
         C4PhxEXt5iZwEkY4sFlAwVa7Vp5//fDmXlAg4j9xRROmng1uifD2yq8E9DN6xGjPwmkr
         iAbA==
X-Gm-Message-State: APjAAAUWv8VN25mlPYSgpz2r6utGAOidEyMGnis1fkLx2Jlk8WBJVFgP
        aF6wnPtuVdGf/yIB4RcfsxsI5A==
X-Google-Smtp-Source: APXvYqwrRIJFaN3/EOnl4mURCxYQeFmoB2bV4p9L6PhJ6mv+tvNN2NH1QgEbMDZXoHTTiaqtDYC/uQ==
X-Received: by 2002:a17:90a:c58e:: with SMTP id l14mr4875532pjt.104.1565281206991;
        Thu, 08 Aug 2019 09:20:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j6sm3065998pjd.19.2019.08.08.09.20.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 09:20:06 -0700 (PDT)
Message-ID: <5d4c4bb6.1c69fb81.db640.7518@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190808061228.16573-2-mkshah@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org> <20190808061228.16573-2-mkshah@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: Introduce soc sleep stats bindings for Qualcomm SoCs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, mkshah@codeaurora.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 08 Aug 2019 09:20:04 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Maulik Shah (2019-08-07 23:12:27)
> Add device binding documentation for Qualcomm Technology Inc's (QTI)
> SoC sleep stats driver. The driver is used for displaying SoC sleep
> statistic maintained by Always On Processor or Resource Power Manager.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Your SoB chain is odd. The author is Mahesh? Otherwise, use the
Co-Developed-by tag.

> ---
>  .../bindings/soc/qcom/soc-sleep-stats.txt     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-=
stats.txt
>=20
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.t=
xt b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
> new file mode 100644
> index 000000000000..ee40687ded34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
> @@ -0,0 +1,36 @@
> +* SoC Sleep Stats
> +
> +Always On Processor/Resource Power Manager maintains statistics of the S=
oC
> +sleep modes involving lowering or powering down of the backbone rails - =
Cx

What is a 'backbone' rail?

> +and Mx and the oscillator clock, XO.

Drop the comma? XO is the oscillator clock.

> +
> +Statistics includes SoC sleep mode type, number of times low power mode =
were
> +entered, time of last entry, time of last exit and accumulated sleep dur=
ation.
> +SoC Sleep Stats driver provides sysfs interface to display this informat=
ion.

Can this document be YAML? Then it can be validated.

> +
> +PROPERTIES
> +
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Should be "qcom,rpmh-sleep-stats" or "qcom,rpm-sleep-=
stats".
> +
> +- reg:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: The base address on the Always On Processor or Resour=
ce Power
> +                   Manager from where the stats are read.
> +
> +EXAMPLE 1:
> +
> +       rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
> +               compatible =3D "qcom,rpmh-sleep-stats";
> +               reg =3D <0 0xc3f0000 0 0x400>;

Is this memory region in DDR? Or some specific IMEM location? I wonder
if it would be better to just have a pointer from the RPM node to this
memory region and then populate some stats if so.

> +       };
> +
