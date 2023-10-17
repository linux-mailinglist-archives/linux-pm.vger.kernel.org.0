Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB237CC34D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJQMhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjJQMhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 08:37:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F195;
        Tue, 17 Oct 2023 05:37:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd20c30831so635598b3a.1;
        Tue, 17 Oct 2023 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697546258; x=1698151058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yl3XKvfDNY4YlqmwGul51Mx11ikOLsTxoufKMV86Q0=;
        b=VrWVtE5DXL4XU9awQQEZTBSAFY6Qx4qxsJtiSfPgppoMTXh1tx1Wul1OhT4J2hO13P
         03NRBl7Q/qp4loSXYX4s0Zj0UkLNdX3Icsht09h0OKObyt6BTvkhFLkftlWd2PWPzDzA
         R7ida66Iqa4fYakwVWCtW0S/R1NTyfK+KB5fD5uoV37lt753IuEwwM7TKXP3KwsRU8hA
         qx5METMCgXjUItWpQHmyaPTgWsz0HbdSrD6DIm0lVvJ8G9M9cTdc7h8KASDIo2C1YSTi
         Ym1h8MQ31dFouZcaE0bkHE4ASxi6r/mVTeqtvonacJpN4sSv9CCAKZes2UKq3VSvQRJO
         4/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697546258; x=1698151058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yl3XKvfDNY4YlqmwGul51Mx11ikOLsTxoufKMV86Q0=;
        b=KG6NR1aZFv6xc5RuRD1/DxFvzOBJAZ3keE69qajYDWoWcSm6z+0Hrhe4gQXpeHs0RJ
         Kk0S5WW71DH0ByIfUyZvvtPSxNhIPr7fn+9h9YasDYxd8Ec+ioMTjPb589TJXn18c833
         jCTrkhxNGAOwr6hwPS/KAdRpZC+0fD/y/uR2nGJNeQfVPISld0yCKeL+JMLOqMuuKTm5
         9zZcKVr0HFc8TQqQC3D6SMLR2i7ZGEBRnXuOlkdBzRSl6ER2dyn7C0MRsJxeMmTr1THK
         naXc1b0enMHBXPK6gQb2NlwobV3fguLHmr4vhMfsZaeeNfJ/sq5XndtYHuLolNKwpVXj
         xr0A==
X-Gm-Message-State: AOJu0YycoecQhIneeAWg9y1IoeeYAhejidPubabiOQQKvxBCpMQMgWcB
        BwSf62OGWqk5narBhVzZwMID3gq17bhxlYfo89guxPJ4V0Q=
X-Google-Smtp-Source: AGHT+IHEkJqr/HImxh2mg/mBjVRkvypqISRXWPE2SLbLkFHHwaW4ixmRl7+MGA6p8Se20Dyyil9tTMDrjFfIit3dRxI=
X-Received: by 2002:a05:6a20:c182:b0:15d:6fd3:8e74 with SMTP id
 bg2-20020a056a20c18200b0015d6fd38e74mr2126389pzb.3.1697546257871; Tue, 17 Oct
 2023 05:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231006180453.2903342-1-festevam@gmail.com> <CAOMZO5CfW10dwVDYaHkvhTMKeHw38ZAt1kdH8qB=8AM=cqdHvw@mail.gmail.com>
 <83dbd835-c36e-4e7d-a5e4-c572e19c649d@linaro.org>
In-Reply-To: <83dbd835-c36e-4e7d-a5e4-c572e19c649d@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Oct 2023 09:37:26 -0300
Message-ID: <CAOMZO5BMfsGn+rZY-EYwchOtsrYUaSnnEKAaXpNjidrC2Yq5cA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] dt-bindings: thermal-zones: Document critical-action
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Daniel,

On Sun, Oct 15, 2023 at 6:54=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> > Are you happy with the v10 series?
>
> Yes, I think they are fine except one thing.
>
> The include/linux/reboot.h is changed along with thermal*.c file. IMO it
> is preferable to have separate patch, I mean all reboot.h changes folded
> in a single patch before the thermal_*.c changes. It is actually

I tried to follow your suggestion of putting all reboot.h changes
folded in a single patch before the thermal_*.c changes,
but I don't think I can do this split and maintain a logic patch
separation and bisectability.

> orphaned and we should ask Matti Vaittinen <mazziesaccount@gmail.com>
> its acked-by as he is the author of the code you are changing.
> Otherwise, he will have to ack the patches which contain also thermal
> code which is not its area.

The reason I haven't added Matti on Cc on the series is that
get_maintainer did not list him. Added him on Cc now.

Maybe Matti could help acking patches 2/4 and 3/4?

Full series:

https://lore.kernel.org/linux-pm/20231006180453.2903342-1-festevam@gmail.co=
m/

https://lore.kernel.org/linux-pm/20231006180453.2903342-2-festevam@gmail.co=
m/

https://lore.kernel.org/linux-pm/20231006180453.2903342-3-festevam@gmail.co=
m/

https://lore.kernel.org/linux-pm/20231006180453.2903342-4-festevam@gmail.co=
m/
