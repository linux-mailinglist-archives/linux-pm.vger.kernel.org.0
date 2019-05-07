Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAFF15FE4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEGI6P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 04:58:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33793 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfEGI6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 04:58:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id j6so18127229qtq.1
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bgt65WYUyh4keq60HSFM9ou9BWNsxqpsxUheEsmJ/Ps=;
        b=LFXHlmUi0/8ulUeaMb6kFoZgCQOYaGhjD0Rv5sOqvJAdFWnGFpVQ9T+NX2HpuBvduI
         C14vwFf0hjhSV2f2O2geQK9TiX/sTj5gFNlhRPzsoJh5tR6YgCfF2VtBRUQjbjagINNw
         +fcIApgzTmb4yoNs2rPZdhdJuD4mwJN06wYHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bgt65WYUyh4keq60HSFM9ou9BWNsxqpsxUheEsmJ/Ps=;
        b=RjmATyBzZyMODli1bsNRyBWSiYGaIBvJLAD//Fhl4e7ju0me6IFyk5T6aV+gFKdxu5
         FGws3kuMCIK3B/BOWyZaGCRVNiNwjOS0HOgbxmJT//q5D/3Brk0xZqrPtAapUEvuOQn+
         CILj+xDF1xMQKeAQCEfzRizw/1/AEy7ZlGvV0I0IPRAib/JKcRsMLuunQHfqPnlGkg8N
         1VM31JWROa/nV2De3Y3iUj4sIzyVtaBMgYb4c13zwcvwYWBVW1AjHbKR4iIF2fEpYFnD
         i3oef3PFvQTMxUgFfa6wzQR99/+spfX2RllWpohyNbTN0uuMi/MxflQOYv+xwiEXmF3O
         JStQ==
X-Gm-Message-State: APjAAAUOVUGgZRZKu7OiWbOdwM7MvgzsTpf7aCc6Pa8+fmmbNfexf7tc
        h3Iy6xZ+M9L1JXfvI0T+wwerIIbHcyderWbIXxcoGw==
X-Google-Smtp-Source: APXvYqxRKpUMVzA6AG7GCIY/+g/BwxuTBk4WFdQofQEHMln8CxbzW33eb9ZBrRV8Z4nlMUPH71Flva1Aw5lznF2Ik9Q=
X-Received: by 2002:ac8:2963:: with SMTP id z32mr25699870qtz.236.1557219493495;
 Tue, 07 May 2019 01:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-5-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-5-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 May 2019 16:57:47 +0800
Message-ID: <CAJMQK-i===iehSxLky1rZMnYhZfrnAJzWtDxT2OLOwRnKwaZoA@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: mt8183: Configure CPU cooling
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrot=
e:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Add two passive trip points at 68=C2=B0C and 85=C2=B0C for the CPU temper=
ature.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 55 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 95f1d7b..0b3294b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -375,6 +375,61 @@
>
>                                 thermal-sensors =3D <&thermal 0>;
>                                 sustainable-power =3D <1500>;
> +
> +                               trips {
> +                                       threshold: trip-point@0 {
> +                                               temperature =3D <68000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       target: trip-point@1 {
> +                                               temperature =3D <85000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "passive";
> +                                       };
> +
> +                                       cpu_crit: cpu-crit {
> +                                               temperature =3D <115000>;
> +                                               hysteresis =3D <2000>;
> +                                               type =3D "critical";
> +                                       };
> +                               };
> +
> +                               cooling-maps {
> +                                       map0 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu0
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu1
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu2
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu3
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <3072>;
> +                                       };
> +                                       map1 {
> +                                               trip =3D <&target>;
> +                                               cooling-device =3D <&cpu4
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu5
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu6
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
,
> +                                                                <&cpu7
> +                                                       THERMAL_NO_LIMIT
> +                                                       THERMAL_NO_LIMIT>=
;
> +                                               contribution =3D <1024>;
> +                                       };
> +                               };
>                         };
>
>                         tzts1: tzts1 {

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
