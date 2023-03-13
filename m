Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD346B8199
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 20:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCMTTQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCMTTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 15:19:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2419686
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 12:18:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id fd25so8324699pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RajhfLYDraG9eWSB41u7VR+4RMGlGZ9+XgWUGRTk49Y=;
        b=IizE98SUhWJgY2eglPa4ZuP3kWcqFg4hJVN05U/mbbINxG5jAQIaikLdD1nWQ3eIn9
         Es6daxY6vPCyxr+u9NPOn79hJuhl8FzU43KdG5icqsQuvOvT6y8wyWDt/8UUScmtpkeb
         gt+4wa/aR7BKTPIBnUtD7IucVhI0M1jmou50Kc327oys5z6DJ3+ln5dQiMnQ9PjJaDXp
         ZLx6gW/574tLl1njYit3A+/TF0oUHcTFKsVBXASERbVYW9/j2LHHjfPU5LWg5a0zCBkc
         aLy9XUEV5BoaurBZ+ZX2cAn4jrhmNZ/HMSZpWVSdj7RuYoSn8r8RBpGdSlzxXwU8Hdx7
         Sumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RajhfLYDraG9eWSB41u7VR+4RMGlGZ9+XgWUGRTk49Y=;
        b=XGVbdg3e2wytJgSJecYlZ5qFNYk6MDZM3mAG3cTMZIq2rW8o8Y6f7xk4RLuG7tuvRt
         dMy1H7tn9WZZY4jShzNpxgUAOzcoT4IYsqNFwwmtXkeOXquCu9rUDsyqWs9MMWvtsiAm
         UU8LdBY11P+wBiftbnw7Z/seX0myK88zM6rVq5O9phG4dda7Nhai6tckiFHy+IFlot03
         nVxki69pp6KgWM7ZgQcKi0wD2dO7tDxWPw6EDrJ4jmZ/Otw1TfPO9Dhxnn2hXaeeE6kW
         wUwlw5FZyAERj+fZsge3LpcRiY71gx4LgzEcA99E1NKsgag8meozLgvRXSmsk5Fk7lc+
         c8Tw==
X-Gm-Message-State: AO0yUKWCv7zx+soKvNsQz7VrnSOQOZdraM/W1UMpJV7BK4hw5wf7btQ7
        CRqgJdRAeT6Iqay0T6H/MW+Gr7g/GSokcY+BL/i9hn2jnXM=
X-Google-Smtp-Source: AK7set+eMtTsXuL5Vmwi3eUnGfy+2tMLfzuxV3VbzIx9PW2Z9q+pBXJctcHewZQvskV7KcIq1dVWXylxkOSXjnbCTU0=
X-Received: by 2002:a63:201d:0:b0:507:4697:392d with SMTP id
 g29-20020a63201d000000b005074697392dmr9440631pgg.7.1678735086412; Mon, 13 Mar
 2023 12:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <2176690.usQuhbGJ8B@steina-w>
In-Reply-To: <2176690.usQuhbGJ8B@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 13 Mar 2023 14:17:55 -0500
Message-ID: <CAHCN7x+rEcXfC9GcJxPgro7XBb=K9kvF60htxtHRG0kVXHF0LQ@mail.gmail.com>
Subject: Re: NOC (interconnect) lockup on i.MX8MP during resume
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 9, 2023 at 9:11=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> while debugging another issue regarding suspend/resume I noticed that the=
 imx
> interconnect driver locks up the system when writing into registers. This
> happens during resume of the 'g2' power domain. imx8m_blk_ctrl_power_on()
> will eventually call down to imx_icc_node_set(). Using the debug diff fur=
the
> down I get this output:
>
> [   71.493062] imx_icc_node_set: node: VPU G2
> [   71.497163] imx_icc_node_set: peak_bw: 1
> [   71.501091] imx_icc_node_set: prio: 0x80000303
> <freeze here>
>
> Unfortunately there is absolutely no documentation regarding NOC in the
> reference manual, so no idea whats happening here.
> This is on next-20230309 using imx8mp-tqma8mpql-mba8mpxl.dts with USB
> disabled (prevents suspend) and Ethernet-PHY-IRQ disabled (the issue I'm
> tackling).
> Is there some idea what do in order to support resume on i.MX8MP?

I haven't played with suspend-resume myself, but there was a thread
[1] with discussions about fixing a race condition on the imx8mp
interconnect.

adam

[1] - https://lore.kernel.org/lkml/20230201101559.15529-5-johan+linaro@kern=
el.org/



>
> Best regards,
> Alexander
>
> ---8<---
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/im=
x.c
> index 979ed610f704..93ec79cc7c06 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -44,13 +44,18 @@ static int imx_icc_node_set(struct icc_node *node)
>         u32 prio;
>         u64 freq;
>
> +       pr_info("%s: node: %s\n", __func__, node->name);
> +       pr_info("%s: peak_bw: %u\n", __func__, node->peak_bw);
>         if (node_data->setting && node->peak_bw) {
>                 base =3D node_data->setting->reg + node_data->imx_provide=
r->noc_base;
>                 if (node_data->setting->mode =3D=3D IMX_NOC_MODE_FIXED) {
>                         prio =3D node_data->setting->prio_level;
>                         prio =3D PRIORITY_COMP_MARK | (prio << 8) | prio;
> +                       pr_info("%s: prio: %#x\n", __func__, prio);
>                         writel(prio, base + IMX_NOC_PRIO_REG);
> +                       pr_info("%s: mode: %#x\n", __func__, node_data->s=
etting->mode);
>                         writel(node_data->setting->mode, base + IMX_NOC_M=
ODE_REG);
> +                       pr_info("%s: ext_control: #%x\n", __func__, node_=
data->setting->ext_control);
>                         writel(node_data->setting->ext_control, base + IM=
X_NOC_EXT_CTL_REG);
>                         dev_dbg(dev, "%s: mode: 0x%x, prio: 0x%x, ext_con=
trol: 0x%x\n",
>                                 node_data->desc->name, node_data->setting=
->mode, prio,
> ---8<---
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>
