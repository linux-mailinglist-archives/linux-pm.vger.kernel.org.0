Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862CB7875E9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbjHXQrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242729AbjHXQqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 12:46:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBEF19B4;
        Thu, 24 Aug 2023 09:46:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26fa19322b5so483475a91.0;
        Thu, 24 Aug 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692895593; x=1693500393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl3PFvJyj6Nc96D4YdaEEhHesJUYcDBBfF077zXjExs=;
        b=Cra/RY1DU2ZlQjbk9E4XkgQASG9k8CALF2UZqmCk2XcTUBj9U1pAXrnBXcDq2IChrb
         KmUHT4AsEzuZ72OqKcxmz3TVggP8JOxTSZPh4ccVMSIY+TQB8WtiDhIxiBaf3WYICoRt
         M02DqnYqRBJN59A79L+w43G8A/fgnquagtU+qMEYCn6knE0vkaXKT1e5LKflNZgwOhRC
         sGo8C+hV36/uY53ninaLKY+GZohD8q/yrG3CaifMJ06TVOaHvdnimqHcjhnZsSry3XXv
         o3aEHW0LgYcwCZnc6hcMhQpnk0/mdeCevp+4K9dI/D7f44nNvDNrNxB3sXzDSgWkjhqe
         9GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895593; x=1693500393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl3PFvJyj6Nc96D4YdaEEhHesJUYcDBBfF077zXjExs=;
        b=is6fL8vD9Zjg65quoOh9peq+LQLq4YsQJwtms87n8WgoQ+tAaDtABeNlz+0SceL5bu
         Vv570hxZDEmbBIZPL3MgbQ/UmQruG+M0kbKPwT724ACtq2wO6RZvL1iJs5L0BOKcngAm
         2R/yusSW388CCDQQOG1NeXHTzokT8V6UX3qliJBkeIErOadOpFDu5t6gqdJhOAV6euJ9
         qmLKohBHQHyH3Ri7LqtjsRlBDlu2zvby80s6JEgIokGnhIFXB2ZbMn9nmgHVmVcgetwt
         NJ3xhkDkd2PE+YiRFR7bE2vZLjEWDYGJQe6ksQGiZFXSWhkZsHxd69hfkLNxjqkc51e3
         K/NA==
X-Gm-Message-State: AOJu0YypullvNY9jlXFWxYh2Hr2JQmKFxVYdkIKCayjR09A7diLBR4z4
        zqaJ98RLTNIaY3fIT7jCoy4VOY6xcRsk5KAUdQ18JK+yv/0=
X-Google-Smtp-Source: AGHT+IHXsc1EGG4teFvNAFCt8C8bAL5yQkdLbuqsySgoXF4wg762cneoaYMGuwQCGh6tPn6R2XV/RfPCWbY4Ka8u1v4=
X-Received: by 2002:a17:90a:4142:b0:26d:412d:9ce8 with SMTP id
 m2-20020a17090a414200b0026d412d9ce8mr14585252pjg.0.1692895592930; Thu, 24 Aug
 2023 09:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230823173334.304201-1-festevam@gmail.com> <cd1985cf-f13b-8d5b-1f67-f93bae98ce7d@linaro.org>
 <CAOMZO5CPz=ysfjb_x3T0FqKxjTPy1zippZRnkMXCTuyD7fF57g@mail.gmail.com>
 <8070b293-b187-b0cc-fd3d-d057c5623094@linaro.org> <CAOMZO5AZh6DUbZJecwaK8jwGBRCj+40GF5OqyuV2c8mgXT9ZYg@mail.gmail.com>
 <36e24244-3382-b6bb-5975-044112d21eed@linaro.org> <71a842cb-86c4-cd36-ba4c-0be480f8b16c@linaro.org>
 <e73d8321-9471-bbff-d273-9b53c938655f@linaro.org>
In-Reply-To: <e73d8321-9471-bbff-d273-9b53c938655f@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 13:46:21 -0300
Message-ID: <CAOMZO5Crcqv9xhiR0nOhn+ka3-9P+PT-U=cQ6NZMpFVOwYaG6w@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof and Daniel,

On Thu, Aug 24, 2023 at 12:43=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> OK, if this is supposed to be also accessed before user-space or even
> before kernel, then it makes sense in DT.

I think we reached a consensus now.

I will send a new version that uses the DT approach and populate
tmu_tz_ops.critical inside probe() as suggested by Daniel.

Thanks a lot for the review
