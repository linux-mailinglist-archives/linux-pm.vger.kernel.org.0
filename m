Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3706AB470
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 02:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCFB4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 20:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFB4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 20:56:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713D126F6;
        Sun,  5 Mar 2023 17:56:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v11so8640326plz.8;
        Sun, 05 Mar 2023 17:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678067776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzPp0T0Iz2OCH/ssErWbnD+a0LZ1Z5/2YbBIw3913po=;
        b=WwkALN05TjToh6nSJ4CciRYpf3PSAflvOdqZmXvTAbQTMRscXWckSjlC5YaBfRN49a
         THEU4UITS3BtiHtLyo63xORXuvAlOe9Bn7EBYlLi6DT6PP5B7lxWLbm62BU34M+rI/a8
         0ooZ8EF+X9BYaIGpqx9wJekHg1cumBWqQEivZvVBlEPU+uBMZKeGU5HMH0yh3d27AVDy
         DbAGfdOmV50VOF1yuxQeKZgE2Df+n3VjAc94fS7kkmpPAl/PnLeBxUfWId0Bcy6pXs4n
         WG7sT7CNQrp9IAJ2riRBB+coogymaTWhbYTOjyGWzoJ+aBeXvaMxqYeI5Vn/1ysCNfbY
         vQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678067776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzPp0T0Iz2OCH/ssErWbnD+a0LZ1Z5/2YbBIw3913po=;
        b=A82SR37Qig6TWBVoIsmptj+4kvDPeMNefswPcQMnvFbH90yrxx64pkEHGIZSjSLQcD
         w5QOwH4EVk7GSoTJo/Iu/i45RUVPtgV27coqOupxYiWjSS56syIqO/LQfCspqsVbERkM
         C7SQehSBXYBvPcA124Deb+9oWDQdafrsXXkvrTxy+3OLOwz0nbdOzZfMEQXb74zTcgDP
         9M6xEYwM7ZooU32IWO9dscHJd9cTC/kcqoH7YEbR7Z7orxhUpu6vMBl9C9WY8PD7rLnP
         G6D4FdjFSCxzOtcFp0UdkhxRmEGjFB2TaqcmMI26tiv4AGP5Xv233BUnFfTajKSmKpQg
         Ahsw==
X-Gm-Message-State: AO0yUKUpZ4OCvgZXYkEdCfwD4Qg/T4pfFnrtL/k/0qw6+//fmtHx7Eo8
        LSxDHOLRfTk+cjGMF1VgnfOBdSqr2f4XkomsPlM=
X-Google-Smtp-Source: AK7set8bcrK7zoQ779HZIb3j07XzbrJVZvaY//JUHmj7tqiw7fteVc0fuGgfVTFkD5UsuvbYn3fYNw4GXvfkZ6Kw/Hw=
X-Received: by 2002:a17:902:ab0f:b0:19a:64f6:e147 with SMTP id
 ik15-20020a170902ab0f00b0019a64f6e147mr3768180plb.2.1678067776377; Sun, 05
 Mar 2023 17:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20230305225901.7119-1-stefan.wahren@i2se.com> <20230305225901.7119-7-stefan.wahren@i2se.com>
In-Reply-To: <20230305225901.7119-7-stefan.wahren@i2se.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 5 Mar 2023 22:56:05 -0300
Message-ID: <CAOMZO5B1-FKNtKrJz6+TD9GJRixXO_Ca+kk53f3zYeDne4NhkA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: imx6ul: Add clock and PGC node to GDC
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jacky Bai <ping.bai@nxp.com>
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

Hi Stefan,

On Sun, Mar 5, 2023 at 7:59=E2=80=AFPM Stefan Wahren <stefan.wahren@i2se.co=
m> wrote:
>
> According to fsl,imx-gpc.yaml the General Power Control requires
> a ipg clock and a Power Gating Control node. So add them to fix
> the dtbs_check warnings on i.MX6UL boards:
>
> gpc@20dc000: 'clocks' is a required property
> gpc@20dc000: 'clock-names' is a required property
> gpc@20dc000: 'pgc' is a required property

There is a typo in the Subject: s/GDC/GPC.
