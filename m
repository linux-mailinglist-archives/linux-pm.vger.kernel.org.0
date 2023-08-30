Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E378DA21
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjH3Sfc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 30 Aug 2023 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbjH3NzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 09:55:13 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F8E8;
        Wed, 30 Aug 2023 06:55:10 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5711d5dac14so1321236eaf.0;
        Wed, 30 Aug 2023 06:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403710; x=1694008510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZv8/1ddCjCFIB4WUHiW7nPhVXBzPUUn+j0xqd454kk=;
        b=Vtna5FpTuYaCEuzZVcNgHMaezQwHUcFOvevAmukX0h5fkZWKHmIfPFlD5jDcYi1NIF
         LSLVbgqyI5/LPMRqhgzUu6uRhrpuyo4SxqDgTRUAQDYeJpWT3qf0Tx0wSB1d51NrlUVP
         TUD+GA9SzE7x7pFAoPYHCgG+blkJHAzy9EWQVyANplDav3S2xpfMZZDFPt7/1wdizfeP
         VRd0kk8QdXrnL7CI7GKxr6/X3NcUQNAk48vukK5vbzsi1BJu62cI/pLjnonnYwjqhYkp
         XOY+TCLsTlbuPW4Hgk3rrVsyCq+k2g0VeqqQlhfvDRtaEQ5v6V/GJUZcQC40xIWrhpKH
         WJMQ==
X-Gm-Message-State: AOJu0YwUwJ8xGOrl/Anoqj9EGLjuK5Fm1HNCIOS2gCxdq2R0GvKODjtq
        lTnzCSiROxrud2HNJZiuQ0f6qe+qOxzlliaqVX8=
X-Google-Smtp-Source: AGHT+IFkOfV/Y+byHhRZ0TCeaZuJhHV1eq6BIDMnfnES1FFM8rzU+/3+pvEiV76Mpklm3B0fccCb50WWmh1nPBGK3xk=
X-Received: by 2002:a4a:bd8f:0:b0:573:2a32:6567 with SMTP id
 k15-20020a4abd8f000000b005732a326567mr2133213oop.0.1693403710232; Wed, 30 Aug
 2023 06:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230829194200.1901988-1-festevam@gmail.com> <CAJZ5v0hZR3WD+wMA6c-Gt86hM5oCRZDcSsYF4SrYTvT2HtQ=fQ@mail.gmail.com>
 <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org>
In-Reply-To: <c5d72559-4a97-c865-e51e-855d2bc1edee@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 15:54:58 +0200
Message-ID: <CAJZ5v0gexPEV2M5kfgCEUti=EE+_oR+wUjRboo0Rh=fPfNeDew@mail.gmail.com>
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

On Wed, Aug 30, 2023 at 3:07 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/08/2023 13:37, Rafael J. Wysocki wrote:
> > On Tue, Aug 29, 2023 at 9:42 PM Fabio Estevam <festevam@gmail.com> wrote:
> >>
> >> From: Fabio Estevam <festevam@denx.de>
> >>
> >> Document the critical-action property to describe the thermal action
> >> the OS should perform after the critical temperature is reached.
> >>
> >> The possible values are "shutdown" and "reboot".
> >>
> >> The motivation for introducing the critical-action property is that
> >> different systems may need different thermal actions when the critical
> >> temperature is reached.
> >>
> >> For example, a desktop PC may want the OS to trigger a shutdown
> >> when the critical temperature is reached.
> >>
> >> However, in some embedded cases, such behavior does not suit well,
> >> as the board may be unattended in the field and rebooting may be a
> >> better approach.
> >>
> >> The bootloader may also benefit from this new property as it can check
> >> the SoC temperature and in case the temperature is above the critical
> >> point, it can trigger a shutdown or reboot accordingly.
> >>
> >> Signed-off-by: Fabio Estevam <festevam@denx.de>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >> Changes since v4:
> >> - None.
> >>
> >>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> index 4f3acdc4dec0..c2e4d28f885b 100644
> >> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> @@ -75,6 +75,15 @@ patternProperties:
> >>            framework and assumes that the thermal sensors in this zone
> >>            support interrupts.
> >>
> >> +      critical-action:
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        description:
> >> +          The action the OS should perform after the critical temperature is reached.
> >> +
> >> +        enum:
> >> +          - shutdown
> >> +          - reboot
> >> +
> >>        thermal-sensors:
> >>          $ref: /schemas/types.yaml#/definitions/phandle-array
> >>          maxItems: 1
> >> --
> >
> > I'm wondering if this should be a bool property called
> > "critical-reboot", say, which when present would mean to carry out a
> > reboot instead of a shutdown in an emergency.
> >
> > As defined above, the "shutdown" value is simply redundant, because
> > the code will effectively convert any other value to "shutdown"
> > anyway.
>
> We covered this at v1. Bool does not allow this property to change in
> the future, e.g. for a third mode. And how would you change the action
> to shutdown if default action in the system was reboot?

Well, as a matter of fact, it isn't, so I'm not sure where this is going.

Bool definitely allows the property to be not present, which means
that the default behavior is intended and this is all about overriding
a known default behavior.

Anyway, if the maintainers of DT bindings are fine with the current
definition, I'm not going to block this.  I just wanted to make a note
that it wasn't looking particularly straightforward to me.
