Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43967BF919
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjJJLCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJJLCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 07:02:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D194
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 04:02:38 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso316659276.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696935757; x=1697540557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q+WyrI9j4abdwV0YBhLQ/kg+Y/kGGfGHeoaoeG1aVxM=;
        b=BhIdj9iyYDWIP+PyWEClcKrqWRVnaZfPqeynTvi1qDygXIS6zRtXJE4Bqu78cU6wXd
         3TJqmHfkwy2rTlKbG4iZG7+NlCi4jjRvvi38NHwbmmzR4cKbyZ/yhT97esgR7uRTYE52
         slvsH921C3zSXzDyWluIg5RSLRW/7RcTHg3Q9ATtuWPBn9+LueSu2wwmF00Mor86D6y4
         qsU2K45E0r3OVfBLdXGJ6edNhiu7HhVJAreJOEuXMib4NR6OXt4nbFqKy71f2iFYnK46
         M1g12nyA2hxgkC+8qE4iDJXHWkhMbtUAtmxhE9x5hsPGzggDT8bbkBi8UjH1+k+5IRIj
         mkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696935757; x=1697540557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+WyrI9j4abdwV0YBhLQ/kg+Y/kGGfGHeoaoeG1aVxM=;
        b=fEkwuaYZ+lzKftUTo1zEaluI4wxXIMCxOJxUxjyMRZz0ipTq372ejAIKr5etQF114G
         dEuRii71EbAFn9tiP7eWRsd03g5hEqm+HmA1SEyzqmEufebCvKgnACtC7d2Uv/bQUJSq
         82vGb6GqRXeTXyKDP4feHhIe/6q47aqPL588bYpEC8yX0KAwDtnFbmeGXkBGIfHDu6hv
         nRM8G1QsNdh/m1qBPS/wDSZpBXxFu8FWqGMdJBo5EFdUm/s+XuzFd7wQhd6EtfGO2b+f
         3DJwc+0ci77W2E3LZO5mBj6M0Ldw5HWsLX6VRm5zahqVfp0RPp92rCwLz1jZv9s9+YNH
         KFgA==
X-Gm-Message-State: AOJu0YxHJrtLwVNNf0ceSRMRke/6ak2jKeIdLLIdtnydkctcE4jNM1L4
        jEcpFbasIDXN8lFc763fWM3xBsb7lFjQB9EQwWYb2PMzcDjYIfxs
X-Google-Smtp-Source: AGHT+IHxJSpWQv54WojeH/3ASEP2e9R7zkbLPXMmkRAMSSWgpoGi5Kithn+IxOeUCStEa0kVsRAH7s7wbepatjxsguY=
X-Received: by 2002:a25:a423:0:b0:d90:6778:ad80 with SMTP id
 f32-20020a25a423000000b00d906778ad80mr15404550ybi.7.1696935757411; Tue, 10
 Oct 2023 04:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
In-Reply-To: <20231010105503.jwrmjahuvcjgwtk5@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 13:02:01 +0200
Message-ID: <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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

On Tue, 10 Oct 2023 at 12:55, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Oct 10, 2023 at 10:30:17AM +0000, Peng Fan wrote:
> > Hi Ulf,
> >
> > I just see you wrote scmi_perf_domain.c, just wonder this driver is only
> > for devices, not support arm cores, right?
> >
> > For ARM cores, we still need scmi_cpufreq.c for performance settings,
> > right?
>
> Sorry if I wasn't clear. The reason I mentioned it in private is that
> we now support the power domain bindings in the scmi-cpufreq.c as you
> were little bit nervous to use the clock bindings(though they work just
> fine, I understand the possible confusion with the clock protocol).

Right, good point!

I think we discussed earlier whether we should deprecate the use of
the clock bindings. Maybe that's a good idea, to indicate that we
prefer the power-domain bindings when going forward?

[...]

Kind regards
Uffe
