Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85123787A13
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjHXVRf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 17:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHXVRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 17:17:32 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E6CD2;
        Thu, 24 Aug 2023 14:17:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c8cb3c9534so29288fac.1;
        Thu, 24 Aug 2023 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692911850; x=1693516650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gfg67xDwIeREm/U02TCjiTX/OXkral+DuxnEYXW3f0=;
        b=mrgSHEbRhqgjEUKj05nJ5cniKrYNWC+Zlkp2FX435drm0Yoqm6OBuLBUJJAXiwThzf
         8shTdpa1TzXS82jFYphOBgerXu4ZhJzOlm0jhu9m+l4tCk0cVglq7lmkNei+CcynYZ0w
         eAY5qBpsH91zxWVtilQW1YHRETnhxS9UZNCbg2RbPnAhkBwW5Z+CHKMh5M1JUxGleL+3
         cDBNVIMY23w/iXMnq1M9ZTprGksoIuWpeyIBaOlSC9RXlmm4fkzPs1LznNnLyI1fSoJz
         3T/rZ+Fc4GlTqlaOFQFaTfzoFfrV7en0A5wiBf2eV3q1Ey641lRyElBG+mre1+9xNitA
         vpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692911850; x=1693516650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gfg67xDwIeREm/U02TCjiTX/OXkral+DuxnEYXW3f0=;
        b=ZUQ9K60ZVlyoa8wgyrjs7wAgPMN6/p5cEfxWtJW/gIEr5HXitm8sdHdktHwPG84+V6
         zARW5IqSUFZmmBrXLtXxYzd64ZIufXd4XyLbZPMwfEFW70vqvps3FKQ7OV5iEW7DrSpt
         AewAFpvAUFBzhJ5e8SjVt4UZyWdOfGP5q+YR07sbTe2zKw+b6NbNv5g6dOX4gIQmPEHG
         u8BwFfv2cKh1+rd0t00WuuKPMK7T4EwtKfZNLzZivmfcnarwKnPI2snE79ETDtw4gAag
         vHEOXlrFTdKfWOxs9LFS2AoAFGb3NkEma5sEmjHpdM6+e5ELAK2VyGhIphSuPKhpuLTi
         KJ/w==
X-Gm-Message-State: AOJu0Yw2Nw8UK5nw+P+UHUQd88RjLREslz2w5RW4GPBS5dVaHoDk8JdD
        94wB8elUzPYCxI7kV5IEq/hWASPA1wvrv6taLTI=
X-Google-Smtp-Source: AGHT+IFnBO8YWqdMJpsNAeS+hA0DFKKgvXAMdyDOLxgrnC0t5wz7Yg6DpnLnGWs9bUN0Hxa+m5/kIVYcEo0IuN6IQiw=
X-Received: by 2002:a05:6871:209:b0:1b3:935b:165e with SMTP id
 t9-20020a056871020900b001b3935b165emr16400018oad.4.1692911850009; Thu, 24 Aug
 2023 14:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230824165011.569386-1-festevam@gmail.com> <1bf12596-d6a1-8bac-1841-ba150cf135ef@linaro.org>
In-Reply-To: <1bf12596-d6a1-8bac-1841-ba150cf135ef@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 18:17:17 -0300
Message-ID: <CAOMZO5DKYr01ysU=i0Q5XkRrnxoH=gLfk7MUhR_2xDwGOFZfrA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: imx8mm-thermal: Document nxp,reboot-on-critical
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 24, 2023 at 2:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> It still does not scale. If it is supposed to be DT property, you need
> to solve my concerns of relying on specific implementation.
>
> First, you need to cover all possible actions, not reverse existing OS
> implementation. As I said before, If Linux decides to reboot by default,
> this property becomes useless. No, it must be some sort of enum defining
> desired allowed action or actions.
>
> Second, I don't think this is specific to this particular device, so
> should be rather common property shared among all thermal handlers (and
> in the future any other critical-condition-handler-devices).

I got your point and it makes sense.

I tested locally with a common DT property like this:

index 4f3acdc4dec0..782cbb4ea487 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -75,6 +75,14 @@ patternProperties:
           framework and assumes that the thermal sensors in this zone
           support interrupts.

+      critical-action:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The action that happens after the critical temperature is reache=
d.
+          Possible values are 0 for shutdown and 1 for reboot.
+
+        enum: [ 0, 1 ]
+
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
         maxItems: 1

Then in the board dts I can use:

+
+       thermal-zones {
+               cpu-thermal {
+                       critical-action =3D <THERMAL_CRITICAL_ACTION_REBOOT=
>;
+               };
+       };
 };

I should probably be able to post something next week.

Thanks
Thanks
