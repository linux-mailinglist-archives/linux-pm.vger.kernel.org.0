Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE179BCFE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbjIKVGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbjIKJ7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 05:59:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F6E68
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 02:59:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f2827131so400115766b.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1694426381; x=1695031181; darn=vger.kernel.org;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4q2sE+nIlzdDQo1wwer1+w9izjQ9tSODQcg+90cI/s=;
        b=jSD15mYGTWO5ekKGi593w4g+e7ueZOOCflWEaLq7haQESzPQ+DLgErskn11aF13xXg
         iyw2/SLAmXrkNHr53SgbII/b0SvFZV0ZGQnRxrw4T9hg3e6mH7zVz17YbBmV3cMShYay
         bCVph7bj1UAZzTMdZRpgQxvd16qkzHxRcykHgL/0dslYH/0UjrdJTzyASEvDvsPao4le
         riLhYhmaj3+bW5Sv2ZLFuKBMY8M7cVWFMMz7ASkiEYTAu4C/vlt9FSH/+Tx2R86BR6/1
         pKNK5MuhxIXEgxnom5cSYkTTqysawLsJdcHIxfDJPWz2pxH3UsPwFM6cWzx1+YfOJPRC
         1U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694426381; x=1695031181;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4q2sE+nIlzdDQo1wwer1+w9izjQ9tSODQcg+90cI/s=;
        b=lrnc47Vi3yxdw6/MDw8uxvCm6Qtx/rpvDavy3Z1Z1vZf2prGrdjHYuL6kl0xIhe9g5
         ujgy804MNZAnEes1ZyrKfM3EZUwRpxc0c7i6cszeEQY4aKEGSIeJxv4w0cRKdRu7LNKI
         kZlvhYauOSGHJuWsyREK+co/6xWR2TfLxViekYR6gidvDI9EGwD+SWlOATXfwbez7YyY
         hVJS5acZ+DtBlX/k45BUrFdFzM/sNUfQLL01Qd7C053+bJDWsl9osijeNeBunJcAOVzR
         9bUZ/FNz5I9wnE86mQkxpdt8hpuILlR2MSM8VH5sXBUueMcDkY4RA3FWyeyPpkJOKXIG
         Ebdg==
X-Gm-Message-State: AOJu0YxYTKvzkadwYdTw1Am5I7WKTuUgt2/9roex0PBlHFt14QHWU+7D
        5Xs6Q+FLrCXy2xAIaiCAjrIcGQ==
X-Google-Smtp-Source: AGHT+IHaH1tUVrRWgxCIcILhOE8tAFxtIWyr4iIxgNdhrWJ59XIwWMwYw8gM0nfQEgcQ8f2sEyoPJA==
X-Received: by 2002:a17:906:5a51:b0:9a1:ffa7:d2da with SMTP id my17-20020a1709065a5100b009a1ffa7d2damr7237115ejc.17.1694426380363;
        Mon, 11 Sep 2023 02:59:40 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906718300b0098e34446464sm5104386ejk.25.2023.09.11.02.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:59:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Sep 2023 11:59:38 +0200
Cc:     <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>
Message-Id: <CVFZZ0YSWQ6J.2AKRML6LWRMUH@otso>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
 <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
 <CVAUDGBO4S08.1F0O66ZE6I4IG@otso> <CVFY7D7ND3WS.2B2EYB4ZO86P@otso>
 <cae7261a-6727-6163-1420-01039bfb8396@linaro.org>
In-Reply-To: <cae7261a-6727-6163-1420-01039bfb8396@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon Sep 11, 2023 at 11:44 AM CEST, Krzysztof Kozlowski wrote:
> On 11/09/2023 10:34, Luca Weiss wrote:
> > On Tue Sep 5, 2023 at 10:30 AM CEST, Luca Weiss wrote:
> >> On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
> >>> On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> >>>>> On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com>=
 wrote:
> >>>>>>
> >>>>>> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> >>>>>>> On 30/08/2023 11:58, Luca Weiss wrote:
> >>>>>>>> Like other Qualcomm PMICs the PM7250B can be used on different a=
ddresses
> >>>>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make th=
is
> >>>>>>>> possible.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>>>>>> ---
> >>>>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++----=
---
> >>>>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/=
boot/dts/qcom/pm7250b.dtsi
> >>>>>>>> index e8540c36bd99..3514de536baa 100644
> >>>>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>>>>>> @@ -7,6 +7,15 @@
> >>>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
> >>>>>>>>  #include <dt-bindings/spmi/spmi.h>
> >>>>>>>>
> >>>>>>>> +/* This PMIC can be configured to be at different SIDs */
> >>>>>>>> +#ifndef PM7250B_SID
> >>>>>>>> +   #define PM7250B_SID 2
> >>>>>>>> +#endif
> >>>>>>>
> >>>>>>> Why do you send the same patch as v1, without any reference to pr=
evious
> >>>>>>> discussions?
> >>>>>>>
> >>>>>>> You got here feedback already.
> >>>>>>>
> >>>>>>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3=
f313d9fe9@linaro.org/
> >>>>>>
> >>>>>> Hi Krzysztof,
> >>>>>>
> >>>>>> I did mention that original patch in the cover letter of this seri=
es.
> >>>>>> I'm definitely aware of the discussion earlier this year there but=
 also
> >>>>>> tried to get an update lately if there's any update with no respon=
se.
> >>>>>
> >>>>> I think the overall consensus was that my proposal is too complicat=
ed
> >>>>> for the DT files.
> >>>>
> >>>> I proposed to duplicate the entries. Do you keep QUP nodes in DTSI a=
nd
> >>>> customize per address? No.
> >>>
> >>> At the same time, we do keep SoC files separate from the board files.
> >>> Yes, I'm slightly exaggerating here.
> >>>
> >>> I think that for PMIC files it makes sense to extract common parts if
> >>> that eases reuse of the common parts.
> >>
> >> Hi all,
> >>
> >> what can I do for v2 now?
> >>
> >> 1. Keep this patch as-is, and keep pm7250b in device dts.
>
> This was NAKed by me. What Qualcomm SoC maintainers decide (or not
> decide) about other options, should not cause the wrong solution to be
> re-posted...
>
> >>
> >> 2. Drop pm7250b patch and drop from device dts, until _someone_ figure=
s
> >> out a solution talking to the PMIC on different SID.
> >>
> >> 3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
> >> changing the SID there, and using that in device dts.

@Konrad, @Bjorn: Can you give any feedback here what's preferable?
Otherwise I'm just blocked on this series.

> >>
> >> Please let me know what to do.
> >>
> >> Regards
> >> Luca
> >=20
> > Hi,
> >=20
> > if there's no feedback I'll keep this patch in v2 of this series and we
> > can continue to discuss there (if necessary).
>
> Sorry, I still do not agree and there were no arguments convincing me to
> change the mind.
>
> I gave you the solution from my perspective. Why do you decided to
> ignore it and send it as is?

I get it that you are not final decider for qcom dts changes but it's
quite difficult for someone sending patches to not get any feedback what
other change to replace this is appropriate. I doubt it's a good idea to
just implement some random pm7250-8.dtsi or whatever to potentially
immediately get a response that that way is also bad.

That's why I'm trying to get some info before working on something and
sending it. Hopefully Bjorn or Konrad can add their thoughts above.

Also I don't recall me ever reading a "solution" from your side but
maybe I need to dig through the old emails again.

Regards
Luca

>
>
> Best regards,
> Krzysztof

