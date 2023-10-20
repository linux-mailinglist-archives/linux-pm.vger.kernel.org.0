Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6A7D06C1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 05:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjJTDIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 23:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTDIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 23:08:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FCC2
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 20:08:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so91710b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697771288; x=1698376088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kLwBHML8lGW5VuMmviVsYWs3c7t5w+HkP2XdXVC+6g=;
        b=Rn7EyHKDq2KOD2x81dhNfQGm7dfwh1S1BHd0mEABkYNXssWzZ8D9hSue0qWZEdZ3mi
         AgcC2qUlPcmrxvKpBQ8CUBFzQXYBJ0lh0MMaXSVuUT76lCNWtsSzeP0Q45a/aaoS4Bet
         lUIWKK3rENE+R7OHN+w/dmmsq0oDRUpqann42DIbxvALgYGTbjrx4GKzKFjtfvTYoh78
         FHAYNKV5WPqY+IrfTAXucOMnDmy1Tb4BUuvBOGoX2UQ3i1mu8wBFUHYlFEg+kjQebAqF
         U2FoekHvgPk9wazjJUW0tzqrH5AZeP0yBss+jET8Cdu9oB5wQAma2pOgtK73emq8U36F
         PGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697771288; x=1698376088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kLwBHML8lGW5VuMmviVsYWs3c7t5w+HkP2XdXVC+6g=;
        b=utCLo8z+xxuQ+AyE/CFECTV4skmJqxMxJsJ9ZO9USwfe1pg5LNiPqvs0gbmAZ2ubq5
         KxnSb80qiaYObmragh27v9WqJro4gHmSqjm72obNysHpY5qFyKmLidULFqp3YhhDeXjw
         arlDE14cmd2eF2uR4BaQYazbmMr3xzZl1TqPgMu8u2TOsG+0QG6fdaCtzET0ottw2aUa
         rR9O5GtbxYHCKd41YZkvjkYufPF4gCdIg58cREaN+g67gIj2KzHRHnQKucAJnOBeOMa8
         OAfJ9LOqdblfeRaBE1GRFDF5KSHWO0FnJxYzv7b1xWvqx6RZBGdVGGvx0fCw6dCqWKSX
         8C1w==
X-Gm-Message-State: AOJu0YwkNZsX7uH2wY9a1s5kpuFN3eZi3g62GAARw0fVeV7sEvSOPkTQ
        S4zUJhH9UXKB9gl+V93/dtoVJOovHiv/bQ7QqBjK+54pPkU=
X-Google-Smtp-Source: AGHT+IG35yxnz9yz50j9XF9GTou8mh7brf/3jGM5C+RSpW9BslExRhoD6uIe8d0b9PbONMtIBQvgpombPuYZmNDH8y4=
X-Received: by 2002:a05:6a20:a10c:b0:15d:f804:6907 with SMTP id
 q12-20020a056a20a10c00b0015df8046907mr646457pzk.0.1697771288070; Thu, 19 Oct
 2023 20:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231020185949.537083-1-pengfei.li_1@nxp.com>
In-Reply-To: <20231020185949.537083-1-pengfei.li_1@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 20 Oct 2023 00:07:56 -0300
Message-ID: <CAOMZO5Ag5Juh2=KBpRKXmUp-wCEJ6AB2uTXde0HF1H3kb0CZGw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: Make imx pgc power domain also set the fwnode
To:     Pengfei Li <pengfei.li_1@nxp.com>,
        Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linus.walleij@linaro.org, rafael@kernel.org, heiko@sntech.de,
        robh@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hi Pengfei,

On Fri, Oct 20, 2023 at 12:00=E2=80=AFAM Pengfei Li <pengfei.li_1@nxp.com> =
wrote:
>
> Currently, The imx pgc power domain doesn't set the fwnode
> pointer, which results in supply regulator device can't get
> consumer imx pgc power domain device from fwnode when creating
> a link.
>
> This causes the driver core to instead try to create a link
> between the parent gpc device of imx pgc power domain device and
> supply regulator device. However, at this point, the gpc device
> has already been bound, and the link creation will fail. So adding
> the fwnode pointer to the imx pgc power domain device will fix
> this issue.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Please see this thread:
https://lore.kernel.org/linux-arm-kernel/CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9=
ATGpemxvcc8mtL86g@mail.gmail.com/T/
