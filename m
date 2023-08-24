Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F57871B4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjHXOgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbjHXOgW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 10:36:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5E1BE2;
        Thu, 24 Aug 2023 07:35:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2690803a368so1147480a91.1;
        Thu, 24 Aug 2023 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887757; x=1693492557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aySJ+AJJUMP4UObvbytkumvPBMwHCCnyuinlNa0r84=;
        b=PMO/nlHNvYkqAh5a7R50Dc2GndpqkA/QVhffm7IlAPwwHLF2Ai799GUJhLc8fZCULg
         nXN3o8vUJn00evh3dzHkINnetMLjsg7bTXuutd57vUIsxDzFCDPDk5EdcDbWDWkMkvAY
         WCqXq6/tsA1HBDUtQX4XNsO6t9jgQM9vd+Wp3ie9hldUsQN2JIZVk/o+FGjn7Kyy0W+t
         63fKA2d/uCDJTRwPi0QHt+mXkVTa/Bg6DdB6knNUzDLDbf95XNuhe93RYC85x1UpRmTq
         ekR43gVmk+U/wbm9DgpVfkFPvnNgc6uuA9OJuX9wqkIEZIlrb3Mov01/wyuaqFxBloMn
         ucOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887757; x=1693492557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aySJ+AJJUMP4UObvbytkumvPBMwHCCnyuinlNa0r84=;
        b=hWrMrX21xOIiI5O5tsyc3rqLBiBi5QlYUwGlpJqKcrQCOzO5wkeFbvhbDBES8J7ujV
         XBiBPII9XDJY2AseqlLMIPQHv7BYKXcEK49HMQidWR0vWYRpamh5/5iA4Mv+0v2kBYgi
         prq5E48qB62S+zIM+QxVl4bSsP3EXn+gRr7Vs5MNv3wQ4fJhCLEKZVX0bispXRCXxByW
         HowpM5eXyeybWMTl7mjDL4nWi1IhVc4VrOhkzseqqyXD5DET7QuGKhjFNNFw0FSJqdcl
         Ok5PE/o04mkLBsUaLfKNzaGMC8+NQjUPSXms4LuK3qAwVSANE3zkvwuxuiH8owqfANk/
         qm6A==
X-Gm-Message-State: AOJu0YzreSMXSjR6DzFga/g0iN76aBTe/d2ZpoWVVyZCrGYvy86ZI2RA
        1j5VO/opEv5QPijPeH90KUknJzX1DB8WRExGMJRyTuVXLnA=
X-Google-Smtp-Source: AGHT+IEtb4PsF19HnIIfXVqWihAHggsH+VsjHmXUGzROmvndySi8FMNFurqpZqaTpo+6Cr5HlOuyKepNtmfVF9zO+SE=
X-Received: by 2002:a17:90a:2a07:b0:25c:1ad3:a4a1 with SMTP id
 i7-20020a17090a2a0700b0025c1ad3a4a1mr14481202pjd.1.1692887757413; Thu, 24 Aug
 2023 07:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230823173334.304201-1-festevam@gmail.com> <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
 <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org> <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
 <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
In-Reply-To: <36e24244-3382-b6bb-5975-044112d21eed@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 11:35:45 -0300
Message-ID: <CAOMZO5D4p9OZ8mHy-6D_Jqm2gr5BNUqxYoBQrQLdVp9_r=5hDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: imx8mm-thermal: Document 'nxp,reboot-on-critical'
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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

Hi Krzysztof,

On Thu, Aug 24, 2023 at 9:38=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Module params are usually discouraged and it also does not allow any
> runtime configuration. I think you need sysfs ABI.

I will go with the sysfs approach then, thanks.
