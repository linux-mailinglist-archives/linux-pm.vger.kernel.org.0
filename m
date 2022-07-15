Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EE5762D8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiGONeP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiGONeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 09:34:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE87CB52
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 06:34:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id os14so9027781ejb.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=8n3GoEXR9Kkk97aGJD+78x7UsJH5H1Xj3Xfn857goUA=;
        b=tqyVOSW4NZbEYE3o1b8R3/ISFMjNTzS+t4u89ICrhpZNOg6Vo4ea0M/Hxx8zRdmvm4
         Ls+tb53zMCsvDAha6uyMzFs5ovpxI3yaUtASFLl8yIpS5CXBM/m0ovEw5Lw73BrMDrwp
         2xGJgz7Ll3ubL3PqNXFzl+05YnVGS+kec2OZjEUnfmJffr5P1YNJ8Cxg/Dw7yKbSb8ut
         uv45g31iXD1jC6GGGzYnikUBeMoVtTz4qgEWtVFsWRYXyXqCc3t9BmVnQdxDHZrVrsmU
         NzpGy09f+lKzmzXU72w5SCHLhqb6+Xj9TZ2tKelwWOJY8MAjIiEILtx6WjuC/YkYErMv
         jwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=8n3GoEXR9Kkk97aGJD+78x7UsJH5H1Xj3Xfn857goUA=;
        b=D6VqpcFT6MwibF376Zi7A1JK/Iz4kas+D5Kh6dvGuMHUoAw+C5ADLPtB4qZ1LhgPdW
         nnB8glHC6mDFr/7HzoJRx4tzpwmaA1mMMwB3WKlUgxlwWprRkvbam/gNFAF35lEYeRn5
         cd8vJDHP0WzWx1autaC4fU/rKOQRiZmDjNMXsdhn9BrFKzWOIH3cNtpaIGcOslyiKMK4
         HK1Z0rr5oU0w0R/U3/glB97jwH/0epWBgPQ2BkCEFPEfVuqxJJ1+uUjY8sKY8sp/c3kk
         nXxCxpJsDFYohcwGa8T1DyhEBg+70iryGAxNjFz66OJku2yyRiZrB817+Ie9p9+5zCLO
         jPIA==
X-Gm-Message-State: AJIora+WvCtcqU2xCDQ4POi4BKFXEQ5TmPXrrN3Jrh+gfZrE3Y/+et+e
        tqaWJK6oHYqhPL2/ZjJYJbyH+A==
X-Google-Smtp-Source: AGRyM1vOHLDs/wDLOiBjr+Wk5BnQYKkiUmq25vsuDPItAluSfMnaVBZnFRiDBDuuWd85vrgSDnFI9Q==
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id w2-20020a170907270200b0072b307b98e6mr13898069ejk.658.1657892050062;
        Fri, 15 Jul 2022 06:34:10 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id f23-20020a50fe17000000b0043a734c7393sm2824102edt.31.2022.07.15.06.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:34:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Jul 2022 15:34:08 +0200
Message-Id: <CLG9OKW0OMLX.2XWU1ZHFRR9RQ@otso>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        "Georgi Djakov" <georgi.djakov@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Odelu Kukatla" <okukatla@codeaurora.org>
Subject: Re: [PATCH v3 0/5] Add interconnect support for SM6350
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.9.0
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

On Wed May 25, 2022 at 4:43 PM CEST, Luca Weiss wrote:
> This series adds interconnect support for the various NoCs found on
> sm6350.
>
> A more special modification is allowing child NoC devices, like done for
> rpm-based qcm2290 which was already merged, but now for rpmh-based
> interconnect.

any feedback on the two interconnect patches and the dts patch?
Georgi? Bjorn?

Thanks Krzysztof for the dt-binding review!

Regards
Luca

>
> See also downstream dts:
> https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/=
android-11.0.0_r0.81/qcom/lagoon-bus.dtsi
>
> Luca Weiss (5):
>   interconnect: qcom: icc-rpmh: Support child NoC device probe
>   dt-bindings: interconnect: qcom: Split out rpmh-common bindings
>   dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
>   interconnect: qcom: Add SM6350 driver support
>   arm64: dts: qcom: sm6350: Add interconnect support
>
>  .../interconnect/qcom,rpmh-common.yaml        |  43 ++
>  .../bindings/interconnect/qcom,rpmh.yaml      |  22 +-
>  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 +++
>  arch/arm64/boot/dts/qcom/sm6350.dtsi          | 109 ++++
>  drivers/interconnect/qcom/Kconfig             |   9 +
>  drivers/interconnect/qcom/Makefile            |   2 +
>  drivers/interconnect/qcom/icc-rpmh.c          |   4 +
>  drivers/interconnect/qcom/sm6350.c            | 493 ++++++++++++++++++
>  drivers/interconnect/qcom/sm6350.h            | 139 +++++
>  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++
>  10 files changed, 1034 insertions(+), 17 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,r=
pmh-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,s=
m6350-rpmh.yaml
>  create mode 100644 drivers/interconnect/qcom/sm6350.c
>  create mode 100644 drivers/interconnect/qcom/sm6350.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
>
> --=20
> 2.36.1

