Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1D3387CC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhCLIkl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 03:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhCLIkg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 03:40:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D72C061574
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:40:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n16so44481241lfb.4
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zd/n8ZjoI52cW2RYj7i2eUpePlcI6znelKNfg1+/N6g=;
        b=o1nZH2ZQ0X9VrXrbqEGFgEhNlN3QHg85Kk3IILWmL2ENheieF9vVLkN5fJt17kg3U5
         FvgjB1qbromZUMkt9zI6zOdss0FIje9puol31R/yXM+1rtLSk7FzhW8FSmloGOINUzAb
         OOEd8aEnqm+hyqnyl8d3C5sb1bGiWkf+N7iO66TyOvtPM9sI3Ps8kuwqm9vGUcuq87A8
         GiaDX4uOCCemdq8R7tZvrXiPFuwreIqRT6OlikLjxl/anV2q6b/TuJrH3yrBgVAJ87Nr
         nJ4m/y5Yye87cZvqse9uO2f8TErSc3CV+vh9yUFLx/1xqh6zkgCsNqyfEIPSD426uw5D
         LErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zd/n8ZjoI52cW2RYj7i2eUpePlcI6znelKNfg1+/N6g=;
        b=musaN02e9TYsRSPawuMgSihlHXfrZHb4EbaHSvh4orWzoraBDueX+69Bz1yk+OQDny
         EpyYU22sjZ2bLnhR+HpFL3QJjaOOnjCS1wkzvkGpfKQa6o4qYQAcwxoS3xyJHoxdoH9p
         daohUNxDSko9toGoPWgG7q5L4XeVYuFbE7k13pYZgeV7/btkVNF/2MVbLbO0K6mqqBMa
         nHU7gEG6zxdyC+ebPXvYTuhb1IxN7n8Zypyj7siKJ8OHBp4/vL0vNYGu8mmpM4HRwcKK
         pJG+E/FuG/HsUbNvsjbtn7wpP5t1UoGRsjB8JFf8az0MswV6FhGRklX1CC5z0fGSy98S
         0fJQ==
X-Gm-Message-State: AOAM530wIHY+mAHwvP6kxroChPONJztz3o5oTlbCIeRloXlrTYVe/wn3
        R0NxOm2GPm6jtdcef6ucn/cQGbbFK6A1uzG5MlyBiA==
X-Google-Smtp-Source: ABdhPJyemyZC2ugXlOB2/+8Bbu5VIHXDl/v5G/z59y/hua8qqd9ZcFkO7qbCqiZ4L3RX5HZb+5pdHg2Je6jQM+soCbE=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr4985373lfe.29.1615538433856;
 Fri, 12 Mar 2021 00:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Mar 2021 09:40:22 +0100
Message-ID: <CACRpkdaHOf-WQVueBhiH20D8YvcoXe1Yjri5Vsp9sw_V4p3Cuw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mfd/power: Push data into power supply
To:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 12, 2021 at 9:36 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> - The power maintainer (Sebastian) provide an ACK

Ooops I noticed actuall Sebastian already gave an ACK for these
patches:
https://lore.kernel.org/linux-pm/20210128001700.pkuyfpq6uzcjb5ud@earth.universe/

Sorry for keeping bad track.

This means Lee can add Sebastians ACK and
merge these patches at will. (I can also resend
with the ACKs if need be.)

Yours,
Linus Walleij
