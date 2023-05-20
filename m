Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74D70AADC
	for <lists+linux-pm@lfdr.de>; Sat, 20 May 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjETUNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 May 2023 16:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjETUNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 May 2023 16:13:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08410B4
        for <linux-pm@vger.kernel.org>; Sat, 20 May 2023 13:13:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so6667704276.0
        for <linux-pm@vger.kernel.org>; Sat, 20 May 2023 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684613623; x=1687205623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8A5e/BMecddVCjsyHoCAAdtVZiJwdMNPvTuwsbGkk4=;
        b=RCiNtiAr1wDrXNh+tvT9gkTBq8oaLF9ahFIYTI6oQanPYxUE94QTt156jpJ/RaSvBa
         pT2GnQAbnrBKMcG+raCVxtt+BZwzSj25cR7bdARfuJImyDsZbIBtT6woQb8hfE4gaM7w
         xtsf8OGoVDJGvi4WzfaZQyqAieCl4YTJawDvtJnhZpztS8Gdz6u/GmE+yX/R9cBAbstZ
         soIRjVZjVjd1poXPoo8NICEV5dWvlE1f+aABLN+CaBFzTXDNyYa4vG0UbCTdeVdIYXhy
         /Agenhg68PWH1/uRfHQi6SQpfDv4df7Wcj0mgP/2FRPDbUFTDqJyrVpWHC0uYxxTpyOq
         fWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684613623; x=1687205623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8A5e/BMecddVCjsyHoCAAdtVZiJwdMNPvTuwsbGkk4=;
        b=JYS3CH+MrCHm33flJ192/ptdGHA7467TP1i34PWE/n1UHwz1KJ2HlWQe0AHc8aGBeo
         NR0QtCJyN2W04bdpsZzX+CzygxPx6i5rU74Rcv8W3zSTwXgZ4yx9aWS55DUyRYPIj+DY
         14fohiEqmnDvIUUhJXBdv9j7CBboHD4pPc3s870RnQ8FU9HdrjzNeHEFlfRs1vOvZ2uq
         p1eVmsDPqPTcAwIIR/4LxWzsCltHDlY4WxQUb1lnR+/PXodDvizq2UUXc5g5p4fVJEyB
         pCMbyRiAOJs7UHjG2V2ILduQu7jAwFv23nAAnC2/vkoqCBu4yPYKcwD50zgjO1X7Hbgp
         vBLg==
X-Gm-Message-State: AC+VfDwq4lyZngNSgdBNqYjrqWxksimWubk4qs3L89vhasoZY7Y9nnJd
        tHeiRUU6wAbtqzQAqob/u2wIhTb0kNOT+Was2lN/Gw==
X-Google-Smtp-Source: ACHHUZ7+r6iC5qvsZ0bUND1BSuO8MAZ3VQmowhvV+EtUZMJSxXJkh1dwaX/EXnFtxc7mAEjTHNKw6GaxWrcVgiEcwmk=
X-Received: by 2002:a25:317:0:b0:bab:d457:76e5 with SMTP id
 23-20020a250317000000b00babd45776e5mr635544ybd.59.1684613623245; Sat, 20 May
 2023 13:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230519130753.3a9d3d65@canb.auug.org.au> <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
 <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
In-Reply-To: <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 20 May 2023 23:13:31 +0300
Message-ID: <CAA8EJpom8JnhquM8R0mXK6CVia=7o45hDbFG6rRLCF=_CmFq1w@mail.gmail.com>
Subject: Re: linux-next: Tree for May 19 (drivers/interconnect/icc-clk.o)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sat, 20 May 2023 at 23:12, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 5/20/23 12:51, Randy Dunlap wrote:
> >
> >
> > On 5/18/23 20:07, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20230518:
> >>
> >
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o
>
>
> I'll send a patch since there are other build errors too.

The patch was posted yesterday:

https://lore.kernel.org/linux-arm-msm/20230519230122.3958816-1-dmitry.baryshkov@linaro.org/T/#u



-- 
With best wishes
Dmitry
