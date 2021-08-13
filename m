Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BBF3EB626
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhHMNmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhHMNml (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 09:42:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A9C0617AD;
        Fri, 13 Aug 2021 06:42:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x7so15674873ljn.10;
        Fri, 13 Aug 2021 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1viBBWczlkP+CWERm1XEX0a0CTiI/0fH6f0ytu3rz0A=;
        b=Jk7CiyxDYkrXr5bbKit/p4MHUUka1PofWoSEPX1jc3vqzmVk0y8poFKZIbnkgf5nLp
         tA6MkLjmivgUBesIOomSSFXs+kleh82GTyJ3DTTb7dkVAykCfIDNQ7fjqZju5QFIvMkR
         I2cAKrjUFrxG0r4wM60hEPQpOU0X6tKwmTkxMScCtKuSO7dh7g7K604c47/WO571eWpH
         3E7RmQ/jMfJ9pPLZFh49oh5yZm84B+F0oqV503szFEtG4JexKrXI5rzGnR+A5d1xQB9x
         zp3iZIwDL8N6O8JXJQoKGMkSE9Epux/XsniOuPwJDnjSXP/e33CCWIZBl8VaVTUdeh+/
         8cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1viBBWczlkP+CWERm1XEX0a0CTiI/0fH6f0ytu3rz0A=;
        b=qxOEd3KKGqgFyjR6r0puHYt7ywoB4WiXL7IzAp8RSyfytKE0WgwJyunepftx80hh5w
         hD8h8W8gHWZgRSDKSIrTco22aksx6BWw3/lvreTUKlIA4oIA2tL+KKppcQTq62zcycyn
         bK1KEpauC2Ry0cw36k6aL3wI8Tj5WDQ5fXZ364lFmtfQdga2Cw6fuHpe4fjhpC9rApze
         IikCZVBNdyFQcpu/n/aH/nMK4kzBiNWFtqKr2X0aUsKM1RykhuEkkKsEitWFni8rDGDw
         dOqOl/6i5sxwegAZgIr7lRjv5PN1Hou+L6pT+0q4snG8u9oOKZLgY4YswoEippjAZ/kV
         ezmA==
X-Gm-Message-State: AOAM531OU9Oi03bo1hX6ZFt4T3Td9OT79oSKpAVlrN/q15k741B3NYZp
        sIAPbwGMlMwR+TyVCw+Y6SNRylE/xRc=
X-Google-Smtp-Source: ABdhPJywSoDJ82jiwrgfLUNe2QMY1zh+Wyyr2KJVU6xTQ0y7uT5/84WlYebcZAZiVcSCWvEapUbOIQ==
X-Received: by 2002:a2e:f02:: with SMTP id 2mr1918749ljp.112.1628862133066;
        Fri, 13 Aug 2021 06:42:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id j16sm175418ljc.71.2021.08.13.06.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 06:42:12 -0700 (PDT)
Subject: Re: [PATCH v6 04/12] usb: phy: tegra: Support OTG mode programming
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-5-digetx@gmail.com>
Message-ID: <c61e0bb0-07e8-b9ce-35f2-b071fdb68ba3@gmail.com>
Date:   Fri, 13 Aug 2021 16:42:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731173842.19643-5-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.07.2021 20:38, Dmitry Osipenko пишет:
> Support programming USB PHY into OTG mode.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c   | 197 +++++++++++++++++++++++++++++-
>  include/linux/usb/tegra_usb_phy.h |   5 +
>  2 files changed, 197 insertions(+), 5 deletions(-)

Greg/Felipe, could you please ack this patch? This series should go via
tegra tree since patches are interdependent.
