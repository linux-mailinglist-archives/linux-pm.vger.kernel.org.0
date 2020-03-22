Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1618E5FD
	for <lists+linux-pm@lfdr.de>; Sun, 22 Mar 2020 03:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCVCXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 22:23:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40047 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgCVCXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 22:23:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so12194287wrw.7;
        Sat, 21 Mar 2020 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioMqBUlgEP197yOqRJldZRP4FcdjiAk47h+WqmBXfrA=;
        b=vIXRN51VH1yI4dp+CvD6MX04O1CKnXPkgl4TbZXa4W9rUq3G7vS392ucc3BQ4CHgTP
         r/huLkYYD+y5ihfiM9K09Tmj0EussGjo/TYnXlRJrzZGUYK82+EJbWm6OPnOgmDCOZTh
         c/k/WtcD2Atl5L9ug+jX2T9Y0sfxUUTl0qiDcMtu374q35nD51SAm/t8SW0oM8iwZ7Wy
         FbC2vtFm4MLu19K+3cRQTFOJyEL83n1amdV6JoynnUbh1oIbiiTwDFD/lEMqk9j0dfzj
         Dx19M2ViyyEWsQrp/PkQwVU+wYi6QRjE8HbQfu69sLyse99XC3LkZDp1N9fkazXq1IGC
         KYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioMqBUlgEP197yOqRJldZRP4FcdjiAk47h+WqmBXfrA=;
        b=sypj7Ksoa+GsKk3ApMHNXpRJk0urmb1rC1jXW5zXRPf2FWY3bJzwIHqKu3LBDAnZj5
         DACCZzmxDcQuwIcurZjd8W5lqrNQ3OI73O9u/bjaBX9OyVbMU+D0L6erV8LyCd7pOd/y
         INQ0yAd/n5jQNtze3xsgwnHuFHRf2+yeNo0dCCvNBA/vSRLrVCs8hLfkohkY8eSMq4db
         Hn2iffGsAqg4XjOcvQpFunE6bfFSQQWJvlYRTeeOhC3PlR8+U+C+hjuuvALpFpx86GcZ
         ATAut+474Pp4vwpkud6DdJuae8sgNexcTpl3F4bTW7xK5a+fzRjcr0D0YBll3M+zmAsw
         26Jw==
X-Gm-Message-State: ANhLgQ1TiVYpoosfMJdeN8zSdHoGSrG7+mHXPa2SrrufkivrCwA3k6a1
        MfPH0kwYJRX+S46RsqIBISoeh63d/SBopD6JSBo=
X-Google-Smtp-Source: ADFU+vsFdmXWrsHJPw61O9GrgiXWOvmQz4H1EzO5bX6oaejYFzkLeS3cOLXLjMwlseimcBcMImN4sKDPyS7I5pYtUto=
X-Received: by 2002:adf:ff82:: with SMTP id j2mr13878951wrr.48.1584843829809;
 Sat, 21 Mar 2020 19:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200319203427.2259891-1-martin.blumenstingl@googlemail.com> <20200319203427.2259891-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200319203427.2259891-2-martin.blumenstingl@googlemail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 22 Mar 2020 10:23:38 +0800
Message-ID: <CAKGbVbvDEkfLyhstd0+akqq0Amt-s-JMayxiQA2OxEfZPwj_CQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpu: mali-utgard: Add the
 #cooling-cells property
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Fri, Mar 20, 2020 at 4:35 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The GPU can be one of the big heat sources on a SoC. Allow the
> "#cooling-cells" property to be specified for ARM Mali Utgard GPUs so
> the GPU clock speeds (and voltages) can be reduced to prevent a SoC from
> overheating.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> index afde81be3c29..33548ca2a759 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> @@ -107,6 +107,9 @@ properties:
>
>    operating-points-v2: true
>
> +  "#cooling-cells":
> +    const: 2
> +
>  required:
>    - compatible
>    - reg
> @@ -162,6 +165,7 @@ examples:
>        clocks = <&ccu 1>, <&ccu 2>;
>        clock-names = "bus", "core";
>        resets = <&ccu 1>;
> +      #cooling-cells = <2>;
>      };
>
>  ...
> --
> 2.25.2
>
