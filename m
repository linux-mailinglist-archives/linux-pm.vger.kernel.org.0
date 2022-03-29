Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9B4EB1B3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Mar 2022 18:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiC2QVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Mar 2022 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiC2QVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2022 12:21:51 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CDB1AD1D3
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2022 09:20:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ea1b9b3813so84075407b3.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+cPcA1MdpcxCl1Fud3F8uMJqpHFql9isbi4TC94PVI=;
        b=xN8WgVCiCYwFm8ilUQje8wkU7kxFCkNusS7kydKR96hcg/btmQgA4JM4cIjX/qC6zK
         OeGMX1SHe/xltwW9/kCA6xoRRVl5ZQA8cruG/WRJSAIUAk0ZLGarCoSnLdsX5JiivA0H
         7U8DvX+AxGkuzzvANWmVO9VTRuAOkQzjrJqVlKjXCvhUqxZC7cfHAaTW6KIGPLTDj53K
         gs5GjT9aSxUpRSfZ4Yr4KynImdRk8VlP9H6vUhHpN28VwPdinfq85owKeJxO3Xa9o/0e
         Vu06YgaIHCAc+cwoEkCGNsFxC51BKdNvkpukCXFdeme19KUAt2HnFs8TqbOPVAlR5G+X
         C3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+cPcA1MdpcxCl1Fud3F8uMJqpHFql9isbi4TC94PVI=;
        b=wcdhPLc6sLDPRh2dKZa9/1AaiQjqZuZ5IzJdV/PX1DhksRM0C148YTfw2RTBKAlTKa
         w61TTieEECi31jcy+S7bXb8on+nJ1VqHR6E8W+MG65mX2Nh/TwbvxoiHBPgDQxC5VHgK
         H13SuDmCa+TeAgygAcBbA4dLIEtW3Y+DOndcC2C0OCbwKh0xVeQinb70jE092bqIrNdT
         ao1Roe7+fOCMtlwVi1P1NKszUgBZ5+MLNYmvD+Xd8E+ge1Vy938HaauQSj7bM4glm+y/
         f0pCwcZdz4cERacOt7ElfJtF4VxeCLaCWkmP368Gh9Pnsmlq9Hn1cb/p5q2P31SvkyI1
         wEmA==
X-Gm-Message-State: AOAM530mSUUWy03IJnML6G8sIEY/+JFxJJL8vG9F5e3Kl9h0B5N2EHcy
        n2tJxK0BMGeyD4duPIFt4GuHY8rjZ9a3oNDSbHa7Ug==
X-Google-Smtp-Source: ABdhPJySCueyNElcU6iBARblDBGTj6cLFwcu/NFFhKAV32k64Aq1Ty4XbqqFM45LeF6b7WU4KU65JrtsLzWyNvxACbc=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr33216518ywh.140.1648570807014; Tue, 29
 Mar 2022 09:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329033226.535475-1-y.oudjana@protonmail.com>
In-Reply-To: <20220329033226.535475-1-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Mar 2022 18:19:55 +0200
Message-ID: <CACRpkdaakmGHo_VWNJsf2ph-EcFY_G_NMVfVFFK7oVUR7Bj_DQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Reset err after not finding static battery
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 29, 2022 at 5:34 AM Yassine Oudjana
<y.oudjana@protonmail.com> wrote:

> Otherwise power_supply_get_battery_info always returns -ENODEV
> on devices that do not have a static battery, even when a simple
> battery is found.
>
> Fixes: c8aee3f41cb8 ("power: supply: Static data for Samsung batteries")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Quick and nice fix, thanks a lot!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
