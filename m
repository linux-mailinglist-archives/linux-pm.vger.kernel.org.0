Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6278E9F5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 12:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjHaKNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbjHaKNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 06:13:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F8E69
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2023 03:13:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so768872a12.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2023 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693476780; x=1694081580; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7v4YEHKe+eCw/TeGULI02ezKGrSX/6FZe8vszhKShU=;
        b=GDZ07FpT+CNej/aZSh1Np170rhrgZlJvNr7rN2UfCQCEFdE+x0XoodqDWDnbK7AEaR
         7vbJCYHNV9WoepvB26K4Na02Ai3SiwGPSONp7aPVTvCuko0DKAZxhGb5333X2dYucEco
         3tgh+LSaeYPjOsC121NFuJAvWmdasM2Sw3YWwA76BOBV+bFDE1h7kssMqZDaX6hJ5zZh
         t0Z85r0ZfgrBcxWXBsu5UcgVM4e4BLR0UjnTdMF6inOqmHqIBMsxmL1i7t4aBrirlRBv
         LGa02fBEJxENZ575c6mrk1xDPeDNNdHwHp2FmxkwrLGheY6OAKxMI2I3Q63/eCX/f6mr
         VRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693476780; x=1694081580;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e7v4YEHKe+eCw/TeGULI02ezKGrSX/6FZe8vszhKShU=;
        b=TFaUXy425XSK8p8BgoaauqTDTpOlGSMvLGKCVmNmW1alIc0rXmlki5aVRQ4cLV2Suh
         xEtL6HCI238vFxq3jzPVV9vSu+jqspV93MVbxx5XAHjlVup5s2EpvTQls7orzqIFiOFp
         K5tTEYjLg6OsmoUzp8y/4mnCm+d2pnHih265zBVz6YzY/9q73doW5Ke0lNG7B6E8d1Tm
         uwUbpqwt0mvyHSEpmnAX25emDL23tBDFvA8NZSWe1mazbNX5BXmsbjwQpDgHT0vb+xmy
         mhl6RaCn28zzGpRTcqcDNNn5zc7aJV//uEvk0KJEI1kNGRJZlVo9PTWZ5SrgZ47aLY6L
         3GsA==
X-Gm-Message-State: AOJu0Ywkyc0VzFFzHWFun7T70gJ4iChEqOXX2FHzEU3V7InR3QtL40sf
        jxIzopoJIe/BSJm9HrTlfb3tLA==
X-Google-Smtp-Source: AGHT+IEuYVCopo/jdrk+kN9i1QSXZe6VfZ6G0pxlPUpl/QjLI2c9L+8wfjA/Ey3Yg4SWpToT5CAN9w==
X-Received: by 2002:a50:fc05:0:b0:525:680a:6b89 with SMTP id i5-20020a50fc05000000b00525680a6b89mr3661319edr.12.1693476779584;
        Thu, 31 Aug 2023 03:12:59 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id x18-20020aa7d6d2000000b0052718577668sm608976edr.11.2023.08.31.03.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 03:12:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 31 Aug 2023 12:12:58 +0200
Message-Id: <CV6NF0466658.20DGU7QKF2UBR@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
In-Reply-To: <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> On 30/08/2023 11:58, Luca Weiss wrote:
> > Like other Qualcomm PMICs the PM7250B can be used on different addresse=
s
> > on the SPMI bus. Use similar defines like the PMK8350 to make this
> > possible.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dt=
s/qcom/pm7250b.dtsi
> > index e8540c36bd99..3514de536baa 100644
> > --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > @@ -7,6 +7,15 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/spmi/spmi.h>
> > =20
> > +/* This PMIC can be configured to be at different SIDs */
> > +#ifndef PM7250B_SID
> > +	#define PM7250B_SID 2
> > +#endif
>
> Why do you send the same patch as v1, without any reference to previous
> discussions?
>
> You got here feedback already.
>
> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe=
9@linaro.org/

Hi Krzysztof,

I did mention that original patch in the cover letter of this series.
I'm definitely aware of the discussion earlier this year there but also
tried to get an update lately if there's any update with no response.

If you want to block this patch, I'll have to remove pm7250b from the
device dts, so we'll lose some functionality. Not sure what other
approaches there could be.

Regards
Luca

>
> Best regards,
> Krzysztof

