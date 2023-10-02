Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540737B5766
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjJBQAp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjJBQAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 12:00:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92780D7
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 09:00:40 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8195078f69so17526551276.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696262439; x=1696867239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+V/XZ/GBu2X13qk+lVWA+BHXaXbkkjFzVNvIc6hVho=;
        b=X0zY5BAii5sSfS5PbfyX9gkW4Kd5wdftt0bThJKDqX66/SSrcaH5ZshIj76vjT65gp
         yRADAUZrjVJajI+Q1zwmudO+N5MUWbHX1SJyVQWeamFP8nGdLDnSgJebBGf8IDbNZpwM
         bzIf5TX3l5WD6opTJcRIbLOZaeT9LFnBuf/Kh0OU1UXsTdsCJBtPQi0wTmBcL1C2qGhD
         PBfk/TluvFGJZEAKYvYTmmeWsnMFyDetWIfQW0fFiWCDTyxp7lR3sA9cmnQpdCcmIhTc
         2D+k+fiP9hVLbzZLuGijIKX84Zeac3eBKy8otXdDz4C/qDqmBhYCGlnXuHxp8TiwMnlH
         2KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262439; x=1696867239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+V/XZ/GBu2X13qk+lVWA+BHXaXbkkjFzVNvIc6hVho=;
        b=vpM4bBe/KWrElXvRTjFkZ+WG5AzePxujeZTsGI+r1+DU7J3jh4Pm78T20c8PxpvKpJ
         Qt5R2ZcUf7wuvqgceNCykZr3Lz3LyocWSDLiztun6jZAhawPC6w2j6I31J9ISCFR06Zl
         izhTDmB2HKvbO95ebrIARDHH1quYdD4o/pYMCKX8/kL9xEHTmZH8qiKU/UMOgFXiQOq7
         0WQh5tNYIux0Rgw0sS3bsLanSAiJcAa+GcAzhh6IEUDTrfdGO7gcJwZtq6ijzqCb5zlN
         CvbNux2PpsHsE23POPcFu5xyzhEvyQDNr3cspYAJKrkIOCvlGkurMiYHTXSAUT0iHMHL
         DSXw==
X-Gm-Message-State: AOJu0YxGrTJI/5sUakDpwIkqf28OooOuYCxXW/6E2rlVjmrAbOZNnHoT
        OGVk9gGrS7rhijDsXG7+q6UX6roQPHhxxKhKnNjtcQ==
X-Google-Smtp-Source: AGHT+IEpjQ9liIVFx32qRUTSbZz+I8jC2x+161aRlKeXDuRGa/A6OsadJbefZK8pH8hB4Z/EJSy9KcEWN1pKq7rvpvg=
X-Received: by 2002:a25:c551:0:b0:d81:89e9:9f48 with SMTP id
 v78-20020a25c551000000b00d8189e99f48mr11301435ybe.63.1696262439593; Mon, 02
 Oct 2023 09:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad> <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
 <20231002145239.GA12041@thinkpad> <CAA8EJppn-f6R3ObGvagqkg1_KtXGgtNAgRn-LQiN3ORSHQY3-Q@mail.gmail.com>
 <20231002155814.GB12041@thinkpad>
In-Reply-To: <20231002155814.GB12041@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 2 Oct 2023 19:00:27 +0300
Message-ID: <CAA8EJpowGjnecOjr9h4r3=UXSrE4VdptoLADpQq3gDv_W9D3OQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation Device support
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2 Oct 2023 at 18:58, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Mon, Oct 02, 2023 at 06:00:37PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 2 Oct 2023 at 17:52, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
> > >
> > > On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
> > > >
> > > >
> > > > On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
> > > > > On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> > > > > > The Thermal Mitigation Device (TMD) Service is a QMI service th=
at runs
> > > > > > on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> > > > > > It exposes various mitigations including passive thermal contro=
ls and
> > > > > > rail voltage restrictions.
> > > > > >
> > > > > > This series introduces support for exposing TMDs as cooling dev=
ices
> > > > > > in the kernel through the thermal framework, using the QMI inte=
rface.
> > > > > >
> > > > > > Each TMD client is described as a child of the remoteproc node =
in
> > > > > > devicetree. With subnodes for each control.
> > > > > >
> > > > >
> > > > > Daniel expressed concerns in the past aganist representing TMD dr=
iver as a
> > > > > cooling device since it is not tied to thermal zones and the gove=
rnors cannot
> > > > > use it. Instead he suggested to represent it as a powercap device=
 with thermal
> > > > > constraints.
> > > >
> > > > Hi Mani,
> > > >
> > > > Forgive me as I'm not yet super familiar with the thermal subsystem=
.
> > > >
> > > > As I understand it, the DT layout here enables each control to be r=
eferenced
> > > > under the thermal zones, at least this is the approach taken in CAF=
 4.9.
> > > >
> > > > Maybe I don't quite understand what you mean, are you saying that u=
sing
> > > > thermal zones is the wrong approach?
> > >
> > > Thermal framework expects each thermal zone represented in DT to have=
 atleast
> > > one corresponding thermal sensor defined using "thermal-sensors" prop=
erty. But
> > > with TMD, there is no thermal sensor AFAIK.
> >
> > As far as I understand, no. It is perfectly fine to have 'cooling'
> > devices, which react to external thermal monitoring events. I might be
> > mistaken, but I think that is the case here, isn't it?
> >
>
> Yes it is represented as cooling device(s). But I do not see any cognizan=
t way
> to plug it with thermal zones i.e., unless TMD itself reports temperature=
 of the
> modem, using it as a cooling device for external temperature events doesn=
't
> sound good to me.

Why? We have compute, q6, wlan tsens sensors. So it seems natural to
tell CDSP to slow down if compute sensor reports overheating.

>
> - Mani
>
> > >
> > > > >
> > > > > So please look into that approach.
> > > >
> > > > Any recommended reading? Or drivers I can use as a reference?
> > > >
> > >
> > > drivers/powercap/arm_scmi_powercap.c seems to be a good reference.
> > >
> > > - Mani
> > >
> > > > Thanks
> > > > >
> > > > > - Mani
> > > > >
> > > > > > This series is based on previous work by Bhupesh Sharma which c=
an be
> > > > > > found at [1]. I'm sending this as a fresh series as it has been=
 a
> > > > > > year since the original version and I have rewritten most of th=
e driver.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.35171=
40-1-bhupesh.sharma@linaro.org/
> > > > > >
> > > > > > ---
> > > > > > Caleb Connolly (4):
> > > > > >        remoteproc: qcom: probe all child devices
> > > > > >        dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
> > > > > >        thermal: qcom: add qmi-cooling driver
> > > > > >        MAINTAINERS: Add entry for Qualcomm Cooling Driver
> > > > > >
> > > > > >   .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
> > > > > >   .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
> > > > > >   .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 ++++=
+++
> > > > > >   MAINTAINERS                                        |   8 +
> > > > > >   drivers/remoteproc/qcom_q6v5.c                     |   4 +
> > > > > >   drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
> > > > > >   drivers/thermal/qcom/Kconfig                       |  13 +
> > > > > >   drivers/thermal/qcom/Makefile                      |   1 +
> > > > > >   drivers/thermal/qcom/qmi-cooling.c                 | 520 ++++=
+++++++++++++++++
> > > > > >   drivers/thermal/qcom/qmi-cooling.h                 | 428 ++++=
+++++++++++++
> > > > > >   10 files changed, 1161 insertions(+), 8 deletions(-)
> > > > > > ---
> > > > > > base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
> > > > > >
> > > > > > // Caleb (they/them)
> > > > > >
> > > > >
> > > >
> > > > --
> > > > // Caleb (they/them)
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
> >
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry
