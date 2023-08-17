Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5B77F261
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 10:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjHQIq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349069AbjHQIqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 04:46:02 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B241FC3
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:46:00 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4882197e0ebso935147e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692261960; x=1692866760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYCpJ77ukc6LNS1A4X/No1oC3nfzVx+pg4F8CfKxUc=;
        b=BHw3mJbM4hiuKYmnePc4eJjfyuFoK/yRMWyAEy7IWaPgRQKpe059qpCObRoV/bBlwH
         uKp+QwZnGCcAgbn6bXRqBpw0Tqecrmhy7Dt4tVldyFCdMlMBQxzMcWLkKMIkpx7I0CT/
         MA7P6Z8cybRNmGJMtvbrQtbbTToOTVaG4Izsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692261960; x=1692866760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqYCpJ77ukc6LNS1A4X/No1oC3nfzVx+pg4F8CfKxUc=;
        b=OdxHUS2dLUeSkDUfjWlWham5fo1ULG47h0G/q2BTae/7KOURFdqBsjKCKl960qmmD4
         EhXeCXOH57s1FSvXAgUk/qZrFF+ovEa0i5JwgZiUTWsERSUTHeiUB3TqHVuz51AJkeox
         qY3lP/CUkUs4h6gqQ1n1pz0LzErpgup8FIRCLS5QwBaABc0vG8KubYTUvF4xpzy85/mj
         MJU5TgLtKnnYNeiKivccXhMGHErB0Cmd4iN1wbjCDenxcR2rusm/vlbNZw2wN+a6CAdf
         Y3q5Cf49IbFUbDM+LXHunT1URkg50sq5QNtD1nJeAWwuL6gkxMDlwtErbrDkRxRKbsPx
         0SoA==
X-Gm-Message-State: AOJu0YyH9xDiMXW5n+sJbIw19AhHwNgtHtLW9zFnMmkp27GCMb5+7y16
        lTQUGzrKPLLN2KvhXXk4RNdWRKe0hM/SK1Au+Oe4yw==
X-Google-Smtp-Source: AGHT+IHXlDV52tzwpRP9Q+YvnVRJMnf3bkME2JfcNlfX9z20DgAbY8v2IRSoiHr9VM/ZIT8Hmy6flouitCaU4ecYlfQ=
X-Received: by 2002:a1f:eac2:0:b0:48c:2b9f:ee1d with SMTP id
 i185-20020a1feac2000000b0048c2b9fee1dmr609627vkh.16.1692261959110; Thu, 17
 Aug 2023 01:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230530195132.2286163-1-bero@baylibre.com> <107678ff-c3d5-4c3a-ad0e-fa292a125daa@notapiano>
 <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
In-Reply-To: <a97efd71-23e2-5ac9-8d3d-427a431353c6@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 17 Aug 2023 16:45:48 +0800
Message-ID: <CAGXv+5EFD_yMF7q0P5rqiRWeyRqm016Or8iB0niwj26HFVp93Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 17, 2023 at 4:49=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> On 16/08/2023 21:57, N=C3=ADcolas F. R. A. Prado wrote:
>
> [ ... ]
>
> > Hi Daniel,
> >
> > just a gentle reminder. As you've just applied [1], there are no longer=
 any
> > concerns with this series, and it'll provide both working interrupts an=
d
> > reliable thermal readings on MT8192.
>
> There are still concerns and questions in the series for patch2 and 3.

FWIW the readout errors raised in patch 3 were fixed by

"thermal/drivers/mediatek/lvts_thermal: Make readings valid in filtered mod=
e"

So I guess the remaining concern is on patch 2 about whether the noirq
suspend callback should be used instead.

ChenYu
