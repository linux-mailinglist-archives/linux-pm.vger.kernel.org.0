Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376A754FC9D
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiFQSBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiFQSBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 14:01:13 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569AF50B22
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 11:01:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w2so8470871ybi.7
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJfafNFGMHYiA8EwtUDEDFiN9A8iVgpbljvHPjVk9+0=;
        b=CZrgaSYRE689Ko864tH3HNiFvBgadMCz3IiapO5WtexRaRXz1UUIsfsBCnPPX2LQA5
         wEnPeflhEZa22JL6JR24D9m9LPcAi3aOu/YxsR5XFJdculsKXHxpxIyHMK+N2ngBQLTj
         hxnyBbkWxlbHu+hwmiv5GkfBOvX64KEoOVzh+f1pCpjWv3Q/9jfKahd1iwKjuocUlp/J
         IXjWsMr2IHfhv7cOcBASQ/ZBQWxmeI2NRoFT1v9qNZYk44Mm+cE2FmvVjgExc1dHA7ib
         vt45d/LYYd1OFxUh7LO7kvRelustZcRTl5C4adMz0mHVv5dMe75Isiku4JvHU4OHUL/S
         l6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJfafNFGMHYiA8EwtUDEDFiN9A8iVgpbljvHPjVk9+0=;
        b=hd3ZpV82GK2W8tF8gA7SWpsCF9aeX37XnV3iRe0RpuInhY2GUJ92Xlpiwcyx2eV6e1
         gZJxqDIOuYoEn5mke0Tr29fy0dPSz5+4m1WHlqIqvWKj4UKyQoA2JS4r1td5q5FTAOtt
         FZjMOt/sPpAxXI6LM0ahc1RIdV9m5J14t8hLmZ7dudUf9ZlEtVaLb8stU4GpeuCRFk7s
         eQ0qbhtYSDKYUlz7qgkcaK8nhEhyKiJ4kgpEKpUIugOe08ych6fV6vcwfK054M59blLl
         iU3n/WChAM53UGCa76MurdHX/ZmTVu9t1elnvdNlAummDFPc7V8khORc6CYioj3+CROL
         9f7w==
X-Gm-Message-State: AJIora9W8tG9llN0zEzzHaRBIEJFZe2oZ/0qG6cJPCXZbrhhOGHzwBR8
        kewhfkYwHLVy+LT4Y1TNNBg0dtOLaA6rVib2R7OscQ==
X-Google-Smtp-Source: AGRyM1vqgEVQiRdQBqYV1ExEWY74oDgB8uPun0J/r/LzMJt+lL/rC3Ytps1OBspe1/xkmsUBVdPG8lEg1V8uO/8FFi8=
X-Received: by 2002:a05:6902:10c1:b0:668:b4e5:57c8 with SMTP id
 w1-20020a05690210c100b00668b4e557c8mr5061472ybu.530.1655488871285; Fri, 17
 Jun 2022 11:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
 <CACRpkdaXJh_Qc-DuD7SFsZPM9GBMUgnoufcFKsy3BPUYFHMHWQ@mail.gmail.com>
In-Reply-To: <CACRpkdaXJh_Qc-DuD7SFsZPM9GBMUgnoufcFKsy3BPUYFHMHWQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Jun 2022 11:00:35 -0700
Message-ID: <CAGETcx-io_5tVbRBfuB-qOwm4tV0A5FR82Q21Z1dJcLbAOkd=A@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 17, 2022 at 1:21 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jun 16, 2022 at 5:25 AM Saravana Kannan <saravanak@google.com> wrote:
>
> > Since fw_devlink=on is the default behavior and fw_devlink understands
> > approximately 24 DT bindings,
>
> How can I see which these are, in the kernel tree?

device/of/property.c has an array of these binding handling functions
in of_supplier_bindings[].

Most of the functions there are created using DEFINE_SIMPLE_PROP() or
DEFINE_SUFFIX_PROP() that's also in the same file.

-Saravana
