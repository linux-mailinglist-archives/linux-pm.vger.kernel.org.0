Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF2786C65
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjHXJ6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbjHXJ5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 05:57:50 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EF61984;
        Thu, 24 Aug 2023 02:57:48 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1cc69d1f9b1so671326fac.1;
        Thu, 24 Aug 2023 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692871067; x=1693475867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnuz4h1zVd36bEnzyA6pdlf7BZw/b0KCDnLlZw78Kp4=;
        b=q/Sx37/+RpLmb9stgSdO3orPmabVWqg2V5QarM4CeBikVjhKlDFWGmCyL1YusxRBXx
         rZI+XrDFElONpaTWauc9uZd407w/2Yy4AxRtqHQ4R6bzFSVJ9pEB7m9jGQxWRO9/9f1Y
         8XijKJtGShv8bUe1CEnHg5N4NY5XmXxX5mtxjh2B9qQxTy26edR7Kdizad2arfeXDjkf
         pSzHyGUUUKtOV3y1YVL0xBW56mxT4Dl/Dy/cp+nmDr+DGUHhj9F8liKGagf2deQYZieQ
         /SWOM3tbE/G3hdbSZpOhJ8boltZUmF/IgoEIDl7A68C6XT/7ol5/I3BcHTebgYI1DA2m
         8c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871067; x=1693475867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnuz4h1zVd36bEnzyA6pdlf7BZw/b0KCDnLlZw78Kp4=;
        b=URUOBr/zxXWmCCemPbLLHWtdSqPT4GWBz4nPPlO8JULQRZ86EBDzEpavMzZW+ef6GA
         DpkzdI8rudGKJe3Z5nQ4xHf0lGpSqhroAgFQXPKO6OWQpnb7dM+lRA+Xzrmvx70lt0GI
         IXtxMEsSPokYT6o1LWaPHxYUN4jA1/q9+7MCuUBVYVIayhX+qtTHdbHsJyRYGPnVklOm
         IsEDCaFEY2vImQNn3gXMH5C8YEhvyPabPzj4gBTEahyxGCpvTV6U/uIQovvB7IJBPgmH
         iLN23rYW600EKUYrQe5M17zi03SZVJIdOMuK3uBhq3stsVI1Ek1hhXvAaBOhTrlFiTEz
         8ptQ==
X-Gm-Message-State: AOJu0YxMKBw6eT01qxMC9wyfCarKG9ZC3B8oKeZtbwE6iIDWdoqbax01
        ioZwzqjAA1QzJNXuB9I3Wxc74kvQx5Iv35f28qPxfsfi
X-Google-Smtp-Source: AGHT+IHhyz6p+ZQQn7I9tEK9nh2T+c1j2QRDXmVhjZDgwgVbyhwc+CwjohCWirQ/6CZfuAe0ACEmNyNKCXFHD082bkE=
X-Received: by 2002:a05:6870:828d:b0:1c8:b870:4e5e with SMTP id
 q13-20020a056870828d00b001c8b8704e5emr16153469oae.3.1692871067391; Thu, 24
 Aug 2023 02:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230823173334.304201-1-festevam@gmail.com> <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
In-Reply-To: <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 06:57:35 -0300
Message-ID: <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document 'nxp,reboot-on-critical'
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 24, 2023 at 4:18=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> And if Linux changes the behavior of critical temperature to be "reboot"
> instead of "poweroff", what happens with this property? You add now
> property for a SW policy depending on one given implementation. Not
> suitable for bindings, sorry.

Ok, understood.

I will try a different approach by introducing a Kconfig option.

Thanks
