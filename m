Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C344C7756F6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHIKRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHIKRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 06:17:49 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3D10D2
        for <linux-pm@vger.kernel.org>; Wed,  9 Aug 2023 03:17:48 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583f036d50bso76418947b3.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Aug 2023 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691576268; x=1692181068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEb5gxOXelpxfGxoU9oTXJDU7YfO7a8EGS7GYtTve84=;
        b=ayPakcWTRiCg2/Nzsfs/hvr0YBFhcIKgPyNDuWdqLgbTTMODOzj9/33BSrrDuwsL6n
         QHLoRy5JXOiZMhtIhj5JwLVs0lQK5Yr02ajFjiFx1KqdbTCCUxltyTfddVCU2hCDUaup
         j5AYmRuEwCD75fICz1kuYiZENpXVBd+NBQZ7FOkXVSv1h1G/4mkCpy46wt5canqpSNOS
         g6K/s+1LG34KUxJXMPDhlPQU6Rst6VcB8xuDT4GsVKZZLDOtinkZBZycaJJMUH1uDSAq
         xhCLcmLGtE/Xa13fg0A5YHeAQ2H93pdEZONfbqAme2ZvjpyiirtV3bwsPhTZ1bUvMlKq
         453A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576268; x=1692181068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEb5gxOXelpxfGxoU9oTXJDU7YfO7a8EGS7GYtTve84=;
        b=kF5TSPMb0ivXMaQ6tA/w9hnKDCo10aNdGaghuGN15xmFEkanm/wAUqxfbcaQxRdrQ/
         YHhuy0EzlyzAzRGye09X0JLTb1IZ8cTuv4v1NM95cTb533WiYmakRDXGtS+keM/Ccben
         LCidyn9FMEYsTZWIhaSD7RVWDnaicdd6pwGlPffh89Fucr/vnhGfvftQQuU6gH58ITnG
         kc9iSp5fuW7h1GMq6w0x6irPsCUvNcMOT26tQ1p5NgXX606fnFUpBpBC+1+1Da+hf1LR
         Pj8k9W0weGD3rL5gFVtbe0eXrssRjOXhOAL6rbz29z7UeCPzrrkyQwd8Kk1viElPIWPm
         p+gw==
X-Gm-Message-State: AOJu0YyNaIoAXlXH4/gj0Y5T4xN6pWZWd+gvSoZ8lhAJFzKpoIwE6vKf
        Kf2PCe2Rj1Uh2CBwfmS6swinv5n17NMBKisNbHOYumWDWjhv0ne/
X-Google-Smtp-Source: AGHT+IFefhAc40QBAZil+4cDL6rhuIPjgGPtTNl31S6y+xWCF5kwnfvVYAH5omYFt38DvEm0o0/Y00Mso+TPW5V90Sk=
X-Received: by 2002:a25:8585:0:b0:d42:e245:a4c3 with SMTP id
 x5-20020a258585000000b00d42e245a4c3mr2578045ybk.14.1691576267926; Wed, 09 Aug
 2023 03:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230809101439.2663042-1-ruanjinjie@huawei.com>
In-Reply-To: <20230809101439.2663042-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Aug 2023 12:17:36 +0200
Message-ID: <CACRpkdZG35sA5QqkiXXA9dteMdxRT=C+3pabU49F5H9cU6bn2A@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/db8500: Remove redundant of_match_ptr()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 9, 2023 at 12:15=E2=80=AFPM Ruan Jinjie <ruanjinjie@huawei.com>=
 wrote:

> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Wa
