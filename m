Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A062786D2B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHXKxw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 06:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjHXKxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 06:53:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B7B1BC8;
        Thu, 24 Aug 2023 03:53:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a4dab8172so715288b3a.0;
        Thu, 24 Aug 2023 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692874404; x=1693479204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gUHdUrECoEc8fKuUIWJlVGzJ7tfO882UEJY0YGuwF0=;
        b=mhHTD2pTpOUZsBknlsz7LGxov8DXy1OkPFhvQUHOI1Juy5zuQH/9d/uHaqpPg/fPJ+
         EYz3l6Zymrsk2DOKUYZTRH0/mgzTVi+Tf/WYao24HskGG+hQkK1xq3hNbXz/xJaY0TSx
         VBZDrOQOmwsR6WoEKJl7ieBXJKVstL7D+LiaQNXoinOjhLWq7Rh0ZmfEwi32jPQtYBiH
         F/axHDzSrecxf+/nbw3zUMTc+8s+sJGPhXNT0ieb9vfvST06f5F9hhKmTLTxB9gBRvNg
         KgstsDMC7stPjZP3957glGecArXF4nsfiqe0E5eS1ly0cOam9BxQUvT+YfwFHigGGWkQ
         Qpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874404; x=1693479204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gUHdUrECoEc8fKuUIWJlVGzJ7tfO882UEJY0YGuwF0=;
        b=fDHma4ZLY2frCXRmf7d0o+p05c+t0wrFJAnunGZpcV3XAfqJf3rp9Z8gmcAjsxosnY
         52GxLp1plY+8x5JchZakCnz8jrXJdCsWBtOwqNpfbo4UmKqBXLcRynmKuDidWC9EFFyg
         uvhi4QpihTrzp9gTUhPA0hp0ghIwpK3b6Nj6qOyHsA88tx2oPwIzYC1NsaWtoQxJCD5G
         bNeagPSphdsTuDNGeT90YJN1b4tSA90uheRIkHuORHbX4FWA9z8F3MuCuNX2TA0jbdYm
         WmsgPER6jxyIgixiA8hrHjl4CcqWeSEsh6DlZlDHMLp5QOBUwJ2NeXlA39DsTV26Awq2
         Me3w==
X-Gm-Message-State: AOJu0Ywc60VYNLnHmigY8haQCNWOxxNVu5c+KPa9xggVUu47i7GxLeNY
        5w920ZQKeTItZtNjFFgpnoHnYvMeEBRJf4o95+8=
X-Google-Smtp-Source: AGHT+IF60DrziaWfCvYr06XqIGyxNhW+r2ME39cwrMpcuB7GN9L6OyaY7e5u+VPuhzCZUOSEhyCOb1iNifEtuv1XlMo=
X-Received: by 2002:a17:90a:2a47:b0:263:730b:f568 with SMTP id
 d7-20020a17090a2a4700b00263730bf568mr13585315pjg.3.1692874404257; Thu, 24 Aug
 2023 03:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230823173334.304201-1-festevam@gmail.com> <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com> <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org>
In-Reply-To: <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 07:53:12 -0300
Message-ID: <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document 'nxp,reboot-on-critical'
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Thu, Aug 24, 2023 at 7:35=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> > I will try a different approach by introducing a Kconfig option.
>
> Alternatively, the 'chosen' DT node could be used, no ?

Good idea. I will introduce a module_param() then.

Thanks!
