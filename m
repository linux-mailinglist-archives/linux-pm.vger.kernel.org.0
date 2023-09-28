Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B47B1C1B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjI1MVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjI1MVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 08:21:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A0D180;
        Thu, 28 Sep 2023 05:21:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27730028198so1972685a91.1;
        Thu, 28 Sep 2023 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695903706; x=1696508506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B21X9dmaxwZE3mzaK+7U7+N6rJD170rHOiuhq7p9uFU=;
        b=mCJpwCEIMQwqQWxM6LbbZtXtERR/Ogr5KQloGmLqk35ZY0kgalvyTPWECviakTCA/M
         wF/T0q9/oOGgNwCa4/1/U/8r//R7fzJrAXmPzH2l9t9bmgnoh4SsCDFS3X5Iuvm+BuGd
         BSSTnkg3KLyunaX50uwnITWccHz4mUN4Z0S8LzmOZVFnAsl0lznlKyoKAJMcNDG2C2vm
         mrlI5hbOX6LWLPW2CAI5wnmgH4sTtG87vFA5X+MkCf0WIJZoXGD8Lx2x2bvqrRDtxY56
         SrSHZ+YJHzBFxUyWEH0wIMnDwOFUtBsnwx11GVsCoxJq0AOdD9WkUz8UEcss2hGHwlCg
         UhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903706; x=1696508506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B21X9dmaxwZE3mzaK+7U7+N6rJD170rHOiuhq7p9uFU=;
        b=rUxq+5glNmMfvU9Ja1sMzxPNyfiLNth8BErIhhPoS+xVu4EZbOpT1tkXH8pVRQSZHu
         Pzp4+MQGitKPHzuqsLJ2tICU8Vt/gyuMQDBD1wY01ZzuBHH6Of7PCT244QWTAzsN0iyE
         CSMdJMwiSibTmyQwkVRvhwrMxeYXfnj2KlLVwamRuN9RiElUNCPpvmkPSSxnKcZxgq/r
         2j06KqAQrQdxv77FIvHptXJg8FvJVkH3PCAxh3Rym1QxPTz0DWVCio0DQbsBJxVtGxGs
         SUjORKS3DdK6h4xnQV4b78vgf+vIe5xrOxUjcELgceJvHAUcLcHpOPFzb6gi6uPsZc9W
         EiMw==
X-Gm-Message-State: AOJu0YxbdF0SOl7aMe8N6QYIaf6AY9q9FXsGMYpjgBX0Dnp5q2adDoQv
        6GGOUFtSYwj3CiFAGo59UlKDqph+SVJ1EiwHmizZDbXo
X-Google-Smtp-Source: AGHT+IF3Ue/c1xVnjCQOVCBsG3rbFhfOutZQmmT6xrqjj7KUjDTfbXCgu3ZlKW7rbpNNfigucagz4Rjkv1tYN4rWehg=
X-Received: by 2002:a17:90a:6e06:b0:278:f656:ca0e with SMTP id
 b6-20020a17090a6e0600b00278f656ca0emr935927pjk.0.1695903705574; Thu, 28 Sep
 2023 05:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230916014928.2848737-1-festevam@gmail.com>
In-Reply-To: <20230916014928.2848737-1-festevam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 28 Sep 2023 09:21:33 -0300
Message-ID: <CAOMZO5DC=9FJttz9v64XZASLbO0wSu1cF9J0D1h_gso9_mUY4Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: thermal-zones: Document critical-action
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Amit and Daniel,

On Fri, Sep 15, 2023 at 10:49=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.
>
> The possible values are "shutdown" and "reboot".
>
> The motivation for introducing the critical-action property is that
> different systems may need different thermal actions when the critical
> temperature is reached.
>
> For example, a desktop PC may want the OS to trigger a shutdown
> when the critical temperature is reached.
>
> However, in some embedded cases, such behavior does not suit well,
> as the board may be unattended in the field and rebooting may be a
> better approach.
>
> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Could you please help review this series?

Thanks
