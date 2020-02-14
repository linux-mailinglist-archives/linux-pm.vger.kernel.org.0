Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474D615F6A2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 20:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgBNTOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 14:14:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52347 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387972AbgBNTOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 14:14:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so11086230wmc.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2020 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3/uupSJ5RdwyA7ehfydikl3HpiFLgfBAqG7GerpJi7c=;
        b=bhg9/ibeciuu4Ehv/+5VnxzdhVR6BHlImtjOZ+pPpe4yBnv3DYy5GkYmSdTQ0lf3wI
         ulBkqUncQAxNdUqMhsIWhWlhC88PGD1o+rW4i8a3nBi1xj65vzIjPEKwHZnAs/fwBE2x
         cDbmW6ayWu9v5S3BLzcVxXkdcDiFgbNaR86dZ7S1c2aEWE68cE49eX1Z9GHikMH9M2tY
         DkjeV5xIBEucE8volM/K6bNCmnRL7Pg2raIr8DOxI0/2n/JvPlxmFrco1AByyKR/eM0m
         xxR2PIOVmDxUK2hAFYs8kAf4X11yxS/8Edi2bzzIxpxNW5Hwr19KuARUlkbAIzYXFO5S
         KxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3/uupSJ5RdwyA7ehfydikl3HpiFLgfBAqG7GerpJi7c=;
        b=G8jJCcvByr23byu5DHLamrS4cL2DUE9WpSpF72d9wa6aYLM1/LSl75fv6adX6SJIk1
         SvEn7T5oydY/f0jZ6fgbLYKhpYUic7d5VFkb5Ts55gsGMsNTVylJG2QcPuL7JpsO6JFK
         fw0daV5z4wHIKJ0Ls0/v/17NIm1WZgCFI2h95Sa4wYXSRr+abqqc3wFXYmRa/QX4PBlZ
         P85cBWDDzO87PxI+TJ+2ZAWLEai86am6Bo1YxAM1KCN8k4vxTYfWaMT4Sqav6p7FL+i+
         wNuFFK2aZVg4r+OyfRoWCN4mndUUfPIxQn7QNE9qrIQyi0Gac9WQ0rLvleJgdXBHSLTr
         bGIg==
X-Gm-Message-State: APjAAAUAiEjT6/jPccAIeYpt65EGP03d17D8CYJuTSqKLCJGbNruw2V5
        g4dHHjgLYd78TgUHLZnvK5e0Fg==
X-Google-Smtp-Source: APXvYqwOROtwg8ZpOG1fo2gk0W+2Y4A+QNx4Yrvyeo3f6izuFJXQ4Xs25CzIa4xAOjzg1uSQfJHE/A==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr6420025wmi.161.1581707690024;
        Fri, 14 Feb 2020 11:14:50 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x21sm7922966wmi.30.2020.02.14.11.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:14:49 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v6 0/4] arm64: meson: add support for A1 Power Domains
In-Reply-To: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
References: <1579087831-94965-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Fri, 14 Feb 2020 11:14:46 -0800
Message-ID: <7hd0ahasm1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> This patchset introduces a "Secure Power Doamin Controller". In A1/C1, power
> controller registers such as PWRCTRL_FOCRSTN, PWRCTRL_PWR_OFF, PWRCTRL_MEM_PD
> and PWRCTRL_ISO_EN, are in the secure domain, and should be accessed from ATF
> by smc.

Series queued for v5.7 with Rob's ack on the DT bindings.

Thanks,

Kevin
