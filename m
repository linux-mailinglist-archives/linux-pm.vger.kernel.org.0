Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1D763523
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jul 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjGZLiO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jul 2023 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjGZLiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2023 07:38:13 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91919BF
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:38:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5774335bb2aso75013117b3.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690371491; x=1690976291;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96J8ue6w3N5F5gQkGyEj5Vzg0FhfRUkwh2AMDzs/Bwk=;
        b=pWCZqK6isJZEbeKRW05LbGEYVOd9qGVDaUHCDqNB8XV77k/4+ShcYXqow3sOvysiw6
         E9m/tENg0qME2SxnuskjNxc0v5jF4eoSJbr6Huqd5a2eqtKuk5FjynIeQKz1jjJ5Bklb
         w30k81PLreQXrnwIgUYB5w6v7lWNiGBfsk26D41ZK0o9ATHJeAXmIndF03fuywKOMXeg
         kHbJSqdI0Uy2rKzchqHzrRco3lfZFWd+nbSK5hy+3EeIv9MvKq9gLS+JuYwxW3/4y/XR
         eK5fothNSmn9t9xc/YwTlc2c9LUCoT3Q489q4/ACHEbByAtNk+KtyzlPHrEcvcpWzp/T
         3sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371491; x=1690976291;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96J8ue6w3N5F5gQkGyEj5Vzg0FhfRUkwh2AMDzs/Bwk=;
        b=R+5XBVRzA5Qe0HS2RMC3zveylvcHT2haExvdEmdNIL5GhroEwt6LpPYVW8KJyjjXN/
         ZujHcggB4bJlY9msku3tYnX5YUBLo4x31IRqE6+hDWIhy32Vfh6RVL6lejG6EG0MIW/P
         zzMCGKStCz/QKIpnKxK9WFz1G0upx9LH5QqiSI4m5AHT/i8Wyp/4B4aF043e5E9uicN8
         YMnLxvfFFgZ6MMnJtUiysbLDXvy8mz673Re8TDHvs+oiSmoikXfmoQGc5s6m1BjobvoK
         o+ypcc8sgciZUxCblC4YxtmjBWhKNxlgcAidKeiRe/npnmvT9O+MdTC8wwTc7OiirZhE
         xQpw==
X-Gm-Message-State: ABy/qLYO214QFn/KnGGz9MHMpyAzR3A67L45nvIvaROw6YeuG6sM1ENi
        2ZmqlqSIn7++bI7j+gS2EpYigN9z2co+dwjcvRLo9g==
X-Google-Smtp-Source: APBJJlEaVidNukQVQWzs4brZpcRH3GwvYZOdBdI8uzkOCFcd3L60jNpiZxNFPCGshC/aBz73ce0gUPlgo18wOaDrA9o=
X-Received: by 2002:a25:fc16:0:b0:d0a:1721:84e9 with SMTP id
 v22-20020a25fc16000000b00d0a172184e9mr1422512ybd.6.1690371491111; Wed, 26 Jul
 2023 04:38:11 -0700 (PDT)
MIME-Version: 1.0
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 13:37:34 +0200
Message-ID: <CAPDyKFrHVhg_Jt+nd9H7MtF_ZU+SPF2gtuA1QA0DKRAuq6kexA@mail.gmail.com>
Subject: linux-next: New tree for generic PM domain providers
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

I would like to add a new tree to the linux-next integration tree. The
new tree is intended to host drivers for the so-called generic PM
domains providers (aka genpd providers). Most of the changes that I
intend to collect will thus be within drivers/genpd/*, which is a new
subsystem especially targeted for this.

These are the branches:
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git fixes

The plan is to start collecting patches beyond v6.6-rc1, but that
isn't really clear yet.

Kind regards
Uffe
