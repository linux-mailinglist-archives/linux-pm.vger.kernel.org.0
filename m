Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBD64C622
	for <lists+linux-pm@lfdr.de>; Wed, 14 Dec 2022 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiLNJky (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Dec 2022 04:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiLNJkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2022 04:40:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72930201BD
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 01:40:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b13so9475370lfo.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2022 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Na1nf8qjjb1uMGoebJs/VqSMr6q5uwCqvQJ2Ul04o+w=;
        b=YBVPuBr0jQKvXOKcWIdTT4V+PF+IEh9EFO+h1JTbjhB86iMmEgTMXkROy9xjNdDqx4
         jpGYcATEhqkzZ9RjQomgPHMwbMFBmfCT+MuIFYt4KAU/hZ/3PtVIf0k7OgAC/Oy+Gz7t
         pu5Sde0A8HvWabj8UWSQd1hR+2bRnXI8l5G3BWDfayRUqbnVAnABL83boyiBoI4g1KjP
         JCUJaCqOtHUfyIybEzQgcI0ItHC1kgpfx9SXRrszffu05E/dzlJ0kMahaf4hsPK+J4gv
         bYTywPFS6eB5+Bj1CjC+ywEQIULQgC5wjCG7SLXM+Obb4EKuOfB+Jg+UCnvECyGA1/aW
         XeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na1nf8qjjb1uMGoebJs/VqSMr6q5uwCqvQJ2Ul04o+w=;
        b=yCe2hdjRG5HznHCEhOrGwqFBF4RmINJblI2QMO9o3Bo290m0WFPaiUIo2kPmFwA7Ap
         h0tD1JVVCkBk3IBRLWfA933fCp5I3gM9kwycDGMVpGC0cg2QE9rapT4nF5nec58PbOWH
         pforZ0Ov3gv0cNaJpq2UrcCIP+S89V5PEufTukluUBDdgypRvJtPuUF2R8xoxP/l+6aO
         9eAwZo59mL4YZPE5xWNqrmuTVFzUpHIy5pz/KiWEro+pN6eOMtfY8j/5SCTJ5thIqNQv
         aN1DK8CNB1I5zt/OPbZIWfSawtcUL6Wje4IvdH86TBr4lQS0Oz2b3+gALnzKo5eg1x9P
         mxOQ==
X-Gm-Message-State: ANoB5pkQRiOETeYzRTFY/kxgMl5ilqoLzOcR+UltWKsqKHxKwyoHwf/C
        9AyktH/LfWTcM+rxCDHT4PvGRg==
X-Google-Smtp-Source: AA0mqf5bAzf6oxaXCjoLImk3QkwtNBbzrPPDJ1DfSP1B46ND5nVtJkfVfzcY7e3jBODV9kNLTtpEMQ==
X-Received: by 2002:a05:6512:308b:b0:4b6:e4b3:d82d with SMTP id z11-20020a056512308b00b004b6e4b3d82dmr4229361lfd.7.1671010831840;
        Wed, 14 Dec 2022 01:40:31 -0800 (PST)
Received: from [127.0.0.1] (85-76-128-40-nat.elisa-mobile.fi. [85.76.128.40])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9ac7000000b0026c2d2a9b92sm544123ljj.101.2022.12.14.01.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:40:31 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:40:29 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>
CC:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/12=5D_dt-bindings=3A_displa?= =?US-ASCII?Q?y=3A_msm=3A_Rename_mdss_node_name_in_example?=
User-Agent: K-9 Mail for Android
In-Reply-To: <86FA3AF9-5B35-4E27-80DA-8B5BF9E6B3AC@linaro.org>
References: <20221130200950.144618-1-a39.skl@gmail.com> <20221130200950.144618-2-a39.skl@gmail.com> <19e78a06-2f3d-92af-1988-b22dc3ffc84e@linaro.org> <ad7ecffc-3fc9-7859-82b7-9d161fc28cae@quicinc.com> <86FA3AF9-5B35-4E27-80DA-8B5BF9E6B3AC@linaro.org>
Message-ID: <558C636F-850D-41AF-9CA1-CC3E8E5C04F9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

14 =D0=B4=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=8F 2022 =D0=B3=2E 00:11:58 GMT+0=
2:00, Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg> =D0=BF=D0=B8=D1=88=
=D0=B5=D1=82:
>
>
>On 13 December 2022 23:53:48 EET, Abhinav Kumar <quic_abhinavk@quicinc=2E=
com> wrote:
>>
>>
>>On 12/1/2022 11:54 AM, Dmitry Baryshkov wrote:
>>> On 30/11/2022 22:09, Adam Skladowski wrote:
>>
>>>=20
>>> We will pick this into msm-fixes during the next cycle=2E
>>
>>Yes, we can with the above fixes tags but first, can you please send a M=
R from msm-next-lumag to msm-next? So that I can send a MR for fixes to msm=
-next=2E
>
>This would create an additional merge commit in msm-next for no particula=
r reason=2E You can branch -fixes from rc1, or from the msm-next-lumag and =
then send MR to msm-next=2E

Another option would be to base msm-fixes on drm-next directly=2E

>
>>
>>ATM, they are out of sync=2E
>>
>>


