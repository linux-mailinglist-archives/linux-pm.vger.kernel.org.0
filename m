Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF978DA1E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjH3Sfc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245590AbjH3Pip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 11:38:45 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568B185;
        Wed, 30 Aug 2023 08:38:41 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bf106fb6a0so988763a34.0;
        Wed, 30 Aug 2023 08:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693409921; x=1694014721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhMs9V81K6FB1BimkjzkWIito0Rxj1AsF45fFqPpSDY=;
        b=VYE0uhUqyPTZphfymf+g8rW9Wg46GN8v8ec4XhEaf8fD9oaN/eaVRmCy5IvrLNUGUu
         7GprQBbSdqaRCDrT3dfTcUlhnJlENMAYp9+1T6ZIiA04ioxUdCwMAxNL2cRWE/xIQ9wx
         XkzTQANAmAojQa8amlFiM1FkH/EMV1ImSLRw6aifbaK9Ib6jPG7THjktMiJnRq4WmTJ2
         S++5Y/Qbsu6NrZ8Ed2Qej/aI1rYdGivTcaFC4wxCkIaAG/VRF2YjNrs5721C7R1U3Erg
         k5TS8d1rsV2+RUmrFiBo+pZ/B9da3I0SQSpFgi2dMgUUk+DkPr+N8/bQSctE9xKF/y8Z
         2IgA==
X-Gm-Message-State: AOJu0YxfN+twBcqUrGV2uA+r0REiozJ0MdzjSJU599Zwv0b4rTEpXhby
        Rg4m4jl29qsJG6mNMhYSAgCsDg0S25sPCJw8n80=
X-Google-Smtp-Source: AGHT+IGEievzo3k6W+ScbVtsgWJb9qlrVRVYWsPxxuprgk/UCICWIhG0InifTM3bKHfQPZVb7OFmVgA5k1Ia+lB+YNI=
X-Received: by 2002:a4a:ca87:0:b0:573:4a72:6ec with SMTP id
 x7-20020a4aca87000000b005734a7206ecmr2478140ooq.1.1693409920640; Wed, 30 Aug
 2023 08:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com> <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
 <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org> <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
 <88f29c9a-3faf-1470-6865-27f88b135f87@linaro.org>
In-Reply-To: <88f29c9a-3faf-1470-6865-27f88b135f87@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 17:38:29 +0200
Message-ID: <CAJZ5v0hY16=sMUkq=PaX1fVj4beiZv=dG0xaEzvzGkWqRdHZ6g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal-zones: Document critical-action
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 30, 2023 at 5:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2023 15:54, Rafael J. Wysocki wrote:
> > On Wed, Aug 30, 2023 at 3:07 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 30/08/2023 13:37, Rafael J. Wysocki wrote:
> >>> On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
> >>>>
> >>>> From: Fabio Estevam <festevam@denx.de>
> >>>>
> >>>> Document the critical-action property to describe the thermal action
> >>>> the OS should perform after the critical temperature is reached.
> >>>>
> >>>> The possible values are "shutdown" and "reboot".
> >>>>
> >>>> The motivation for introducing the critical-action property is that
> >>>> different systems may need different thermal actions when the critical
> >>>> temperature is reached.
> >>>>
> >>>> For example, a desktop PC may want the OS to trigger a shutdown
> >>>> when the critical temperature is reached.
> >>>>
> >>>> However, in some embedded cases, such behavior does not suit well,
> >>>> as the board may be unattended in the field and rebooting may be a
> >>>> better approach.
> >>>>
> >>>> The bootloader may also benefit from this new property as it can check
> >>>> the SoC temperature and in case the temperature is above the critical
> >>>> point, it can trigger a shutdown or reboot accordingly.
> >>>>
> >>>> Signed-off-by: Fabio Estevam <festevam@denx.de>
> >>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>> Changes since v4:
> >>>> - None.
> >>>>
> >>>>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> index 4f3acdc4dec0..c2e4d28f885b 100644
> >>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> @@ -75,6 +75,15 @@ patternProperties:
> >>>>            framework and assumes that the thermal sensors in this zone
> >>>>            support interrupts.
> >>>>
> >>>> +      critical-action:
> >>>> +        $ref: /schemas/types.yaml#/definitions/string
> >>>> +        description:
> >>>> +          The action the OS should perform after the critical temperature is reached.
> >>>> +
> >>>> +        enum:
> >>>> +          - shutdown
> >>>> +          - reboot
> >>>> +
> >>>>        thermal-sensors:
> >>>>          $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>>          maxItems: 1
> >>>> --
> >>>
> >>> I'm wondering if this should be a bool property called
> >>> "critical-reboot", say, which when present would mean to carry out a
> >>> reboot instead of a shutdown in an emergency.
> >>>
> >>> As defined above, the "shutdown" value is simply redundant, because
> >>> the code will effectively convert any other value to "shutdown"
> >>> anyway.
> >>
> >> We covered this at v1. Bool does not allow this property to change in
> >> the future, e.g. for a third mode. And how would you change the action
> >> to shutdown if default action in the system was reboot?
> >
> > Well, as a matter of fact, it isn't, so I'm not sure where this is going.
>
> It isn't in which system and firmware?

There is a specific default behavior present in the Linux kernel
today.  The addition of this property isn't going to change it AFAICS.

> Maybe most, but how can you know
> for sure. Bindings are independent of given OS implementation, thus
> relying on default OS choice is shortsighted.

So can you point me to any project other than the Linux kernel that
will support this property once it gets to the DT bindings
documentation in the kernel source?

> >
> > Bool definitely allows the property to be not present, which means
> > that the default behavior is intended and this is all about overriding
> > a known default behavior.
> >
> > Anyway, if the maintainers of DT bindings are fine with the current
> > definition, I'm not going to block this.  I just wanted to make a note
> > that it wasn't looking particularly straightforward to me.
>
> Sure. It has one DT's maintainer Ack (mine) and maybe also Rob will
> comment on it.

OK
