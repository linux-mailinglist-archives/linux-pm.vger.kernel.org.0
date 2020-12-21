Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58442DFCB6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLUOUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 09:20:04 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44460 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgLUOUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 09:20:03 -0500
Received: by mail-wr1-f45.google.com with SMTP id w5so11207112wrm.11;
        Mon, 21 Dec 2020 06:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0lmMik1k5i6nuzbQhkwVj6/AmGBYXDatcnotMUxz6g=;
        b=He05Q1gQalfQ+JDTn7e3egO8JmfaiOnOVdh23SUfw/Nv7dpLeaR22/cZs4tV1WpHOX
         1vDJwFoQQ7d6ofQLTSrygm+HsZWGINgP4e94LfQ+LlE/bJEazwgK0S2ElmGAUji47BZo
         e3pJYv6mOsBux9WrmIxHp684WrtgTvbANoAO8TKRLc8xn4enpkZdjBjD718OxBG9Wizf
         u0QDsRPxZVF2fX724sOmaCLCa87dzeuhBFcbkIqC5lQgK2+xLeKJt5aUag1PfeTHZHe6
         HAyHZEtxbmv7ciScfdHsOOxI3qk4M7sAW+1lUZ5GIf2c185eKncXRrEG6xOmLlJ0PFvH
         I/cg==
X-Gm-Message-State: AOAM53389fuLHH8rImSluFGCB4POO5vqh1P+uK8o3KOMmM2jcPiAEwqN
        gI4e27R/beZYbIg1iNv5Mp0=
X-Google-Smtp-Source: ABdhPJyQpl8RbhxrrL3WFCwkhC3BWHFtbejFd/BhmHWGSAnT3lFzs0PF8LdZ0TbCB6JdtNxtVnMbjA==
X-Received: by 2002:adf:f681:: with SMTP id v1mr18674306wrp.133.1608560361776;
        Mon, 21 Dec 2020 06:19:21 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v1sm19169888wmj.31.2020.12.21.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 06:19:20 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:19:19 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/6] ARM: dts: exynos: Fix charging regulator voltage
 and current for i9100
Message-ID: <20201221141919.GC33797@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095001.595366-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 09:53:22AM +0000, Timon Baetz wrote:
> Set CHARGER current and CHARGER_CV voltage according to Galaxy S2 vendor
> sources [0,1].

Mention that the vendor sources are for Galaxy S2 Epic 4G Touch SPH-D710
Android.

This seems to depend on driver changes, so it will have to wait till
they reach mainline.

Best regards,
Krzysztof
