Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4995F704C6F
	for <lists+linux-pm@lfdr.de>; Tue, 16 May 2023 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEPLes (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjEPLei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 07:34:38 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E081999
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 04:34:35 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-42c38a6daf3so9583413137.3
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684236875; x=1686828875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idFwOkKA0fGw6pFLS5UBe9xd+A2vrOI66qcTi8H6/qw=;
        b=0zbUoGS+pqsIK9ayzGHzeaqSHtB98VNj899VGj+vIFT5cvS0Z93ltgVJp+rEEbMbwI
         eXdenGrrrInN0+rh52pzy5d9EqgoIdr3lDQ1otZaA/eRbmMKx+EhmKy1FVEeeG0/d4Bl
         yXrIcykxZlRcOoTyp+MQbjyfrxRNXlINgSoOgQudpDGfhGf0sLAq+yq//3Gt/A/5I2bD
         hHPZCscT8wROq/75RdVNNISOZ0BGbl+5iB0PzH+TIUnndQmePcZpWJOtmcY1RcfrW1Uw
         aJq1MQxRwiadNJDnB8zvA5OnWg6wxbdPQEtITE8GpuCP5m5OBkxUs5lWhFKR8Cg2CIwX
         m8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684236875; x=1686828875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idFwOkKA0fGw6pFLS5UBe9xd+A2vrOI66qcTi8H6/qw=;
        b=OCHxnQIe8PkElq0Xm8jabSIzhyhA3m/hu6XTq9k09EmEPyNVyKPcIdK9B5ZrbFDwKx
         vty2IU7CZVA/TLlY88N6eaLuwYAAiPlVj8U3VU51MDBAu2vYhr4UBcd5m60kqF3czGep
         QnKzPv44n63WmvGqFuuRKJpi6RTKqrCbNC+kuRlHnIqLDYkBMdHZarNPkPdZi6cpehPR
         +b3uMWan4x0F2KJf8o0LJ1TX5mp5G1f0G7PBXrZW7TA4hxq4R6g4rqWzM1InBDjIbx5i
         ZEB0dQ6GkwoJkoeffBkdOURL5qL3ISGDKPsH/fHwqW69hSkLOUG/IjyogbPU6rIDuhSH
         zLXw==
X-Gm-Message-State: AC+VfDznr4xXlrkzOxmr+pYYE1XWDPc3ygEZsleD5xTX70WqXXMSoT9F
        aYQEk+YuU7gREtJ6+m0yaekHbZmPoPl+Xgec+FVZ8Q==
X-Google-Smtp-Source: ACHHUZ5ik8KUSn9R8XSU1PurakYIeHvnOX2EAXVua5ympDENA0crCKdv7q3eHVoV3tDwn2fnJAi4+OQm6nUNZR75M4w=
X-Received: by 2002:a67:f4d8:0:b0:434:8e5e:f1de with SMTP id
 s24-20020a67f4d8000000b004348e5ef1demr14994007vsn.32.1684236874823; Tue, 16
 May 2023 04:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230417125844.400782-1-brgl@bgdev.pl> <20230417125844.400782-5-brgl@bgdev.pl>
 <CAMRc=MeWEs7AoZSNWS9bZO=_12U5944VBq0ixrY2rx2h2=OOfw@mail.gmail.com> <3af2f676-66fb-1c10-372f-4fcf6f7d733e@linaro.org>
In-Reply-To: <3af2f676-66fb-1c10-372f-4fcf6f7d733e@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 May 2023 13:34:24 +0200
Message-ID: <CAMRc=MdxYXyYQtxFqpT+CxNzDO9Ytg+_hS-T=xy5s6RdOExYHw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 16, 2023 at 12:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/05/2023 12:07, Bartosz Golaszewski wrote:
> > On Mon, Apr 17, 2023 at 2:58=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> The GPU SMMU will require the clocks property to be set so put the
> >> relevant compatible into the adreno if-then block.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/D=
ocumentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index ba677d401e24..53bed0160be8 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -79,6 +79,7 @@ properties:
> >>        - description: Qcom Adreno GPUs implementing "qcom,smmu-500" an=
d "arm,mmu-500"
> >>          items:
> >>            - enum:
> >> +              - qcom,sa8775p-smmu-500
> >>                - qcom,sc7280-smmu-500
> >>                - qcom,sm6115-smmu-500
> >>                - qcom,sm6125-smmu-500
> >> @@ -331,7 +332,9 @@ allOf:
> >>        properties:
> >>          compatible:
> >>            contains:
> >> -            const: qcom,sc7280-smmu-500
> >> +            enum:
> >> +              - qcom,sa8775p-smmu-500
> >> +              - qcom,sc7280-smmu-500
> >>      then:
> >>        properties:
> >>          clock-names:
> >> @@ -413,7 +416,6 @@ allOf:
> >>                - nvidia,smmu-500
> >>                - qcom,qcm2290-smmu-500
> >>                - qcom,qdu1000-smmu-500
> >> -              - qcom,sa8775p-smmu-500
> >>                - qcom,sc7180-smmu-500
> >>                - qcom,sc8180x-smmu-500
> >>                - qcom,sc8280xp-smmu-500
> >> --
> >> 2.37.2
> >>
> >
> > Gentle ping for a review and a pick up. The DT patches that use this
> > schema are in next now so check_dtbs will now fail.
>
> I assume this is not for me, as you got my tag in v2, which I repeated
> in v3.
>
> Best regards,
> Krzysztof
>

The patch changed significantly between v2 and v3 which is why I
dropped your ack as explained in the cover letter for v3. The response
I got for v3 looked like an automated email so I didn't re-collect the
tag. If this looks good to you - could you still Ack it officially
with the adreno compatible changes?

Bart
