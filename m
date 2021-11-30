Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76093462A1E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhK3CGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Nov 2021 21:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK3CGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Nov 2021 21:06:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46271C061574;
        Mon, 29 Nov 2021 18:03:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso18286251wml.1;
        Mon, 29 Nov 2021 18:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNAyLgnuZABX+bMA51k+CzRNb1OQiDBReWGxpwrvkAA=;
        b=ESmty3TuZqmk8BEd9I61fOy+QGqtPAfmBTZAQxLblWJkEazUKnzIJQP4TnVikuDtC9
         7ZY6nXEbueVbMMdm4go2LwFHT81DXrY6uIPH6mM63PLILkBr0tY5MJ//ftbQ4KlcalaV
         eHmWVrT5HLMFmzGEaQPGhjhrrfVbaq0aQZKBRha8quIazJEIq+p+3Igi/XBmsNNwbVte
         thYYLn4z1Kq9cwUirUkdM3+a9dg/lMftgcrbxJU+U4jNG0MkYPhPZ4WSHasIw8MlZs+S
         oLUNKjqWrz7iFKtwladsdT07nHOCFJ+cM8mMRUlr0PAu/TTUDz9txkZFeYd84x8iM8WP
         wSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNAyLgnuZABX+bMA51k+CzRNb1OQiDBReWGxpwrvkAA=;
        b=kUaIECIAU2WJHTtYWd/ZJOtdNI+LUCLl9XbbKFM+MwvOrwxpDl4hebp9lyYN9Phf5+
         sdkrG9f6D3uWN1wHnki9GK8HoWp/WLOul2l0/lkLe4NvfWzpUHWqen3w1pQ4pPbo02fi
         AvPcLeK5HV+7F5dCs8MutexKJdNYAvKtEP6Gllljrva3kXsPj64I2+2jkxOo+0lsQlrO
         9DGIoA5IY1ysltLIjoredU0zYf7eGgy2+6IxJOLol3NvtWju/J9Evpi69GNvSGZZ8XwL
         6OfSbSpNKXG7MCdhL8d3laiOHaYNjyNKeUCy33JDe/eu6hlSnB4OxoabTFvhYbHqL88b
         BQKA==
X-Gm-Message-State: AOAM53087zGuVs5GyjOU3Cl+PzfReGQhlIzsrVy0DhPDMuqrH11Aiery
        AonjqiBPmAjXXjGzmwWREwU=
X-Google-Smtp-Source: ABdhPJyoyZIn7vYgj4XrwOEkc0ib3WyviLwl6D1rFwxG20nXGR+6JZAT3PPQpF9WiXhUbOxMA4Dcnw==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr1871268wml.20.1638237784953;
        Mon, 29 Nov 2021 18:03:04 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r17sm983950wmq.5.2021.11.29.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:03:04 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, heiko@sntech.de,
        sre@kernel.org, maccraft123mc@gmail.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v4 RESEND 0/4] power: supply: Add Support for RK817 Charger
Date:   Tue, 30 Nov 2021 03:03:03 +0100
Message-ID: <2759402.V8G6Gt6Xmj@archbook>
In-Reply-To: <20210916194208.10387-1-macroalpha82@gmail.com>
References: <20210916194208.10387-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Donnerstag, 16. September 2021 21:42:04 CET Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> This series is to add support for the Rockchip rk817 battery charger
> which is present in all Rockchip RK817 PMICs. The driver was written
> as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> myself Chris Morgan <macromorgan@hotmail.com>.

Hi Chris and Maya,

Gave this a whirl on my Quartz64 Model A. I noticed that this will
happily let me discharge past voltage_min_design:

 $ cat /sys/class/power_supply/rk817-battery/voltage_min_design 
 3625000
 $ cat /sys/class/power_supply/rk817-battery/voltage_avg 
 3381360

Is this normal? It went all the way to under 3V before the
board finally locked up.

Does the minimum voltage not affect some sort of cutout on
the RK817? Does it even have one? Is it the driver's job to
do something here or not?

Regards,
Nicolas Frattaroli


