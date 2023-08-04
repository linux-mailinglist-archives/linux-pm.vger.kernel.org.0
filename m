Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B376F8E2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHDEXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Aug 2023 00:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHDEW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 00:22:57 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD935BE
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 21:22:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-487179c285fso304157e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 21:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691122975; x=1691727775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyxoLO007wer8vGQEULqHDYToyFmbyl5+nKvUOzjdb4=;
        b=HhCcRMkezocHEWPSlGsjN6Df5ziasYgLp+/MegocGZ5QyXALKJUFRvYCyB1ZLBKlxw
         jUbaUziLCoxrwYv3P8F8mSrEdq6K1d+MJ3nxCCoLtPWhZnPyMPmSv5yEmduGjeRi7WIn
         var+a7bGU0jSz/JjRNGVunR0qb/efTwOkTPVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122975; x=1691727775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyxoLO007wer8vGQEULqHDYToyFmbyl5+nKvUOzjdb4=;
        b=R0CNMOQlLjHlUJGVRmBQNU+1IuhHX0Xrs8tlUAG0cZveq26ce94L1jxNI+UZo34My3
         J3ymb1XuTaKmyTqj7dmljB7+ATIVmf+wvES9i3Zn3beChBVhPmvnJSGk4ZHshIUw8V6O
         k7pV9/39i2yl8AJnerLQopKnDYs0S/Vgt4ShdmdsE1XorCZtQ9PCi9B77GA/1tWms93L
         nr7Qo9fd0xuZPNXOmeA944Mw8ZHDw6iHCzDCmp5StxI/pPP1oAs3fD/siXd7EYZBTS9t
         0RTwZqf4+eVyf7O2ITExh/0j53IMqBucXZtwKdmBLAaAxn5oscfdt9SZjldeaEDv/dUQ
         GQyQ==
X-Gm-Message-State: AOJu0YzuxKqnbphsAbuQ/17kQEsUWtmvRTqAfgOHEc/9l1cv7ATOD6T8
        RYVuQC30J8puLlm3YUuXz5ul1pnKSAQbfI8F7yu1+g==
X-Google-Smtp-Source: AGHT+IFYGSRicG0zDcxiQP5nBUEu++Q6FFkpz7aoPRLFhF+eMD9RVVQWfLW+KaLFuSN55QHHLbuYZL2f/A9BObI5TWE=
X-Received: by 2002:a1f:5f84:0:b0:487:1586:4c29 with SMTP id
 t126-20020a1f5f84000000b0048715864c29mr383643vkb.1.1691122975222; Thu, 03 Aug
 2023 21:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230803012341.2388831-1-chenjiahao16@huawei.com>
In-Reply-To: <20230803012341.2388831-1-chenjiahao16@huawei.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 4 Aug 2023 12:22:44 +0800
Message-ID: <CAGXv+5H1LL-0FbcmuwRCtkmnWRmO0L4+0jxzKZeAzJKTWDiZqw@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/mediatek: Remove repeating warn msg
 after devm_thermal_add_hwmon_sysfs()
To:     Chen Jiahao <chenjiahao16@huawei.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, aouledameur@baylibre.com,
        void0red@hust.edu.cn, robh@kernel.org, daniel@makrotopia.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 3, 2023 at 9:24=E2=80=AFAM Chen Jiahao <chenjiahao16@huawei.com=
> wrote:
>
> Referring to commit 8416ecfb32923 ("thermal/hwmon: Add error
> information printing for devm_thermal_add_hwmon_sysfs()"),
> return value has already been checked if ret !=3D 0 in
> devm_thermal_add_hwmon_sysfs(). Error handling has also been
> performed in this case, including print warning message for
> debugging.
>
> Removing dev_warn() following devm_thermal_add_hwmon_sysfs()
> to clean up redundant warning message.
>
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
