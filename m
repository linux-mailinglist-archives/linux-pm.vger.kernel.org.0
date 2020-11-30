Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8612C82B1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgK3K63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 05:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgK3K62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 05:58:28 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9CC0613CF;
        Mon, 30 Nov 2020 02:57:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id t33so10979918ybd.0;
        Mon, 30 Nov 2020 02:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EhAUL9KFPvsPpct2Xiy52V2R5+SuliKrGbH59F2RPas=;
        b=iQYri6+rGXYbBVlZiTf/yyd7xR40+t/694HUzbevcuXS5Jt+0R2WcO6kFAZ5qtvfmc
         9EsEfFjt4l8Y86a4h7RB75mgVg79alwaUGPbsGqlfogM0hpF3YC9zY9SAnHFu+syXEz6
         maD63iZYgsxiD/YA/sYaEz95tb284OLWNmS33j6Vb01FqbbR0v6A5UZB/BIdHvetrIzm
         3fSLiU9NZVV+2hYPKb/xe9ps8m8qifaRZEJlYLpAM3nzJec9GRX7etPIES3M28JMMDBs
         CKMouB8FF5AuemMPePnL2wHVk6Aaa0+YFB1KA1YRJopGwN5OodLIh2Bvb2S1l5GwTNZC
         3P7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EhAUL9KFPvsPpct2Xiy52V2R5+SuliKrGbH59F2RPas=;
        b=uhGEnfXuuLi5N+XBBQodo7FP+SsDm4uXvItmzT4sDedy7fkel5ZyOLwKYVX1zRRV++
         VYIUKed2kLxZgfFsJ7R+pLk0pw9wFPoPhTSUuZY3FuTrC+dLdQoYPSmQfETdJhyDV0o2
         sgIQXtaPFM4dUTuJX/mE2o2DAxchff9Hl8POHBzDAyI1cgNJ+hR1/PY5CvxLVvvXDFNt
         77BmJAAHqDVAKIkDSLVrjbazIqu1V520UP9Nuzvj8RDqZT3rUjErH3rnziSKcDQHrEPk
         dBPae79+0/Z1Kt+mI45agr22h9Du3enfCnYdpDO8obwfngeY5kZ9mdTtN0ZDYV7wIu04
         AB6g==
X-Gm-Message-State: AOAM531HiTpVLbcIxZ42bM6hLId1kGX+0K86amrZeZn8nCvomFuxcbMg
        kViPZOi2t2Ss6o3LCwGp5q4sdE5+Goaole0bwlE=
X-Google-Smtp-Source: ABdhPJwO9nFiIffAo/r2xbNYCLmHfUEI3G5fTIN8xghODKCyvJCnLN1HEjn+7EXqqv+HP986WLo41m7kCP781HZaI+k=
X-Received: by 2002:a25:c106:: with SMTP id r6mr15124087ybf.519.1606733867720;
 Mon, 30 Nov 2020 02:57:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:63b6:b029:2b:7e30:9bac with HTTP; Mon, 30 Nov 2020
 02:57:47 -0800 (PST)
In-Reply-To: <b98c6196-d3e5-888b-e85e-633deefe1a49@linaro.org>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
 <724ddf78-483c-2cf3-441c-4885af8425a9@arm.com> <1af5220c-f598-58f4-488e-fdd505477ed5@linaro.org>
 <fc2e095f-d417-1547-4075-9ece1aeaaf4d@arm.com> <CANO_MS+n6CTom-o7Hs4dKtPf-2uih5R7_8BnU_b4Jv8g1a5dkg@mail.gmail.com>
 <b98c6196-d3e5-888b-e85e-633deefe1a49@linaro.org>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Mon, 30 Nov 2020 18:57:47 +0800
Message-ID: <CANO_MSKa6BXe_P8Rmzj87xQ__sTzpJWcnYKm8ncbqDA6FOVpqw@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal documentation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org, robh+dt@kernel.org, javi.merino@kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel

Defined per-core thermal zone in DTS file as the following. thanks

prometheus6_tzone0: prometheus6-tzone0 {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm0 0>;
};

prometheus6_tzone1: prometheus6-tzone1 {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm0 1>;
};

prometheus7_thmzone: prometheus7-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm0 2>;
};

ank0_thmzone: ank0-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm0 3>;
};

ank1_thmzone: ank1-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm0 4>;
};

gpu_thmzone: gpu-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 0>;
};

ank2_thmzone: ank2-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 1>;
};

ank3_thmzone: ank3-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 2>;
};

ank4_thmzone: ank4-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 3>;
};

ank5_thmzone: ank5-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 4>;
};

cputop_thmzone: cputop-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm1 5>;
};

gpuank2_thmzone: gpuank2-thmzone {
			polling-delay-passive =3D <0>;
			polling-delay =3D <0>;
			thermal-sensors =3D <&ap_thm2 0>;
};

On 30/11/2020, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 30/11/2020 10:03, gao yunxiao wrote:
>> Hi Daniel
>>
>> Thank you for your the new information
>>
>> I have a question trouble to you
>> We should choose which per-core thermal zone as the IPA's input
>> reference temperature in the current kernel version? thank you.
>
> Can you give a pointer to a DT describing your hardware ?
>
>
>
>> On 27/11/2020, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>> On 11/27/20 1:26 PM, Daniel Lezcano wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On 27/11/2020 10:27, Lukasz Luba wrote:
>>>>>
>>>>>
>>>>> On 11/27/20 8:35 AM, gao.yunxiao6@gmail.com wrote:
>>>>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>>>>
>>>>>> virtual thermal node definition description in dts file
>>>>>>
>>>>>> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
>>>>>> ---
>>>>
>>>> [ ... ]
>>>>
>>>>> It's coming back. There were attempts to solve this problem.
>>>>> Javi tried to solved this using hierarchical thermal zones [1].
>>>>> It was even agreed (IIRC during LPC) but couldn't continue. Then
>>>>> Eduardo
>>>>> was going to continue this (last message at [3]). Unfortunately,
>>>>> development stopped.
>>>>>
>>>>> I also have out-of-tree similar implementation for my Odroid-xu4,
>>>>> which does no have an 'SoC' sensor, but have CPU sensors and needs
>>>>> some aggregation function to get temperature.
>>>>>
>>>>> I can pick up Javi's patches and continue 'hierarchical thermal zones=
'
>>>>> approach.
>>>>>
>>>>> Javi, Daniel, Rui what do you think?
>>>>
>>>> I already worked on the hierarchical thermal zones and my opinion is
>>>> that fits not really well.
>>>>
>>>> We want to define a new feature because the thermal framework is built
>>>> on the 1:1 relationship between a governor and a thermal zone.
>>>>
>>>> Practically speaking, we want to mitigate two thermal zones from one
>>>> governor, especially here the IPA governor.
>>>>
>>>> The DTPM framework is being implemented to solve that by providing an
>>>> automatic power rebalancing between the power manageable capable
>>>> devices.
>>>>
>>>> In our case, the IPA would stick on the 'sustainable-power' resulting
>>>> on
>>>> the aggregation of the two performance domains and set the power limit
>>>> on the parent node. The automatic power rebalancing will ensure maximu=
m
>>>> throughput between the two performance domains instead of capping the
>>>> whole.
>>>>
>>>>
>>>
>>> Make sense. Thank you for sharing valuable opinion.
>>>
>>> Regards,
>>> Lukasz
>>>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
