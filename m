Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636F7C422D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJJVPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjJJVPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 17:15:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AB999
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 14:15:31 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d865854ef96so6577037276.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696972530; x=1697577330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvI4JdBdo0Del7uPub93wekvHqBlqsqy/IwqeKSuLQQ=;
        b=lapc1czUCbRZABYrn1fmGqIY64RE30gmN9iEF4215EU4POjubVan7MyHa/OIbuFqhN
         gILJrvoIWux04gJe+9hpuuIrLU94DZuywkLESYlZxBeFUobUkkF4Slgz0bTfvT9NgbGq
         qRVKU6QewidLlvntj5dMM07Zlv1fe0wEMbEO4PyydhCcip38jObpxAWbHkjYO0+57Jbz
         x/BRCdKf6oBFoBEwxwCyhfzTmuA6ltg6rrnTw1uZlhlTRoBvEkA3t3Ptg8LyrjuCuOoZ
         VjnIxoekLg9BVs9foJ0KxY61DUW2Y2JizW6E6VpabcxWJKtex5zYyLpNmuY/YyScjD0a
         eP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972530; x=1697577330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvI4JdBdo0Del7uPub93wekvHqBlqsqy/IwqeKSuLQQ=;
        b=HfURcDWspO3Ob8Ek32mu41y4cAO5qi8XoP2gs4KjLnG9du9sXy8PtNj+xptmqiewBk
         FBpkvYs0TDZ1o9zj2Dg5dxQjT6JoQz6ZI1I6D7c2J7EyLZoEOasTqllS0N48TQqcwgtC
         AV8ovIQgEvoScZdKwGhuvD5BtHVq28au95n/rEv9i/KuzJ4pBoWcE+GgXf7V1IkL8aI3
         YbN2VYS3UtHrfRUgZKMVxMKa7Xm6SL+185RKIrHA5mZiOHYrXQtoH90xaIGag7bYz6ph
         t8TfZ7hCQGNFLj7a+oKz69fBKDHllBa8gI4Y8CmRy6AF+0E06CFaOZ0Lc7htKDmZgROB
         uDiA==
X-Gm-Message-State: AOJu0Yy2J8HgpC4AyDXsB58qcHV8akp/YsNGE9YZeXKxgzX1ZKK8v9Dz
        fmYldJhfRByAPHT4nu8k1gjX0Hd9XVnlaXFu3d7kHFB0AlAc8l8Y2As=
X-Google-Smtp-Source: AGHT+IG88cgIR/XnTHRBIla58RrjrchOoK0wQzSPau5L0kIilDk13Adk+T1dy2E69PVxkSgUrNr5Banu1u06YIivQTo=
X-Received: by 2002:a5b:709:0:b0:d9a:3ba9:b884 with SMTP id
 g9-20020a5b0709000000b00d9a3ba9b884mr4482383ybq.3.1696972530255; Tue, 10 Oct
 2023 14:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus> <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus> <CAPDyKFrBXz1MrqqcRaSf3dkO5YByxehi96TO9F=5b43_LAqRSg@mail.gmail.com>
 <20231010162347.d7ekxeuw2gepk27d@bogus>
In-Reply-To: <20231010162347.d7ekxeuw2gepk27d@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 23:14:52 +0200
Message-ID: <CAPDyKFqajT2=79Y81yjuLXjWy0D6bhK=UdLpMNfy0f1_J8tYXQ@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Abel

On Tue, 10 Oct 2023 at 18:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 10, 2023 at 05:23:41PM +0200, Ulf Hansson wrote:
>
> [...]
>
> >
> > Another option could be to discuss how we can extend the SCMI spec
> > and/or the DT bindings, to optionally allow us to use a 1:1 mapping of
> > an SCMI perf/power domain.
> >
>
> Well I leave that to the spec author and relevant discussion there as
> what are the merits in doing so.
>
> In absence of such a support in the spec, we need to support what we have
> even after we get that in the spec to support all the platforms without
> it. So, IMO it is better to look at that angle as well.

Ack!

Still, I don't think it would be a bad idea to have a chat about it.
Probably best suited at some f2f call. In particular as it could
potentially also enable additional optimizations [1].

Kind regards
Uffe

[1]
commit ae8ac19655e0 ("PM: domains: Reverse the order of performance
and enabling ops")
