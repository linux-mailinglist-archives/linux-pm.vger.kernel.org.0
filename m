Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232511F5151
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgFJJmM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFJJmM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 05:42:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F69C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:42:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n24so1612750lji.10
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6IM8HZkBTsTCtJCNJrWL83PXKs3jC9VH6grLKGicZQ=;
        b=ginlMGioWdNyYUtlQPRf2HXg4R51WjeoOdKcIOGEPmCEun2SAlBkFK4AvudGvS5dtu
         mcU5Gu9F4mr+CXgz/+DtawHStRUwOEmLfddyQ/M0fQPRfHBXO9tWXYKcXduraDiP2GHf
         nNOoWY6woHlbOLUe8vm1k/8QE/vWRMC11ai2WkEdy20sTcJGNr+0V/Gk7AKs2LWVnFS8
         cIl4apzdWwWmENuaX/JnjnNG7Ww7lU2KDI2ZZqA2aHiP9YyvB2rGB/k8JFeZ+DKElbAo
         jYe9F97RvJXV44rhQSSPcpcuYxCKDSSBO5FOc76iWb0cM1dPtuPACPo+QJL+w4n9iZp5
         duSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6IM8HZkBTsTCtJCNJrWL83PXKs3jC9VH6grLKGicZQ=;
        b=mxVNQCYJIwBNpFJuAluALJmwCyH1lAgweGHT/ZdBINgvtj6Nzj5KGCbrWpTFVOby6j
         gyLDK+eDpNXJqn8hYTjBAZzCLNxIfJbgoYSBPc6ovhuX5tQtEjh//JDFuFtlhQXQZSc+
         K+PmEw/X1TmFKmETZ3J0kPwKJtXztmuJs4NMqjjmH1u4NPO3af74Un6GSRLMsWH+ARUV
         rA+OWFWYlDBnI4DLNzpBuCPV6btwFFWiyqisdrJyiXAK01qjz9M/QhELkdqS0v/F4Bxm
         e9kWJlmD0soXDAPv/pX5+BaOXq1lk8nvsUhGKyTe4mPS7Fp+pbLCSXwf1e3LkTKVzhww
         dqsQ==
X-Gm-Message-State: AOAM533E9qmBaFHwdZS01uuwkBRd/+7mkoCtHMBwuMwg5XaPJAM8sjKo
        r5OE8VBYS1BnUfzK1xZJQLG0o8y+0p941DmitXiGC2vj
X-Google-Smtp-Source: ABdhPJxoXuTFk1is/RO31yyyl5TxCVVZ0c+U2ViqAP54c/q3iqGbZn3p/7J7Ck85VUJCcikAOmvYyaaUzgoVKURdnk4=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr1341404ljj.283.1591782129924;
 Wed, 10 Jun 2020 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-2-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-2-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:41:59 +0200
Message-ID: <CACRpkdbx2kRjxhWzfFDHKojY0Yyour2+BCSVeqWHyoT5LhAwtw@mail.gmail.com>
Subject: Re: [PATCHv2 1/6] dt-bindings: power: supply: gpio-charger: convert
 to yaml
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Convert the gpio-charger bindings from text format to
> new YAML based representation.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Looks good to me, if it passes the checks:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
