Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5C443177
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhKBPYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhKBPYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 11:24:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE0FC061714;
        Tue,  2 Nov 2021 08:22:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l13so43689685lfg.6;
        Tue, 02 Nov 2021 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtEPX2fvz2bHKMErtGoD/T8bBkILX2HzJEJylUqYa+M=;
        b=hbN+HJjBkutSURpJVSD+mcskxqjFPaJfW4ZqZNAggLehdEltjTJVQ5NKsSxQ5qRvvZ
         rc3dVT0jQspBKkT8KmWvbsip7K8zSzAGHesnFUQBa998juM+ym698yGaRT2iQSHd38Qx
         2ZWm638uePx2zSj2CP+iTWI2r8ZOgQhz6va9TpmypkFQ8fRvcYxoN9GjUxYfJxpZWQvc
         N+IJulVVSwAU4KkYJCKl/OVekB+RNGlfuS+zUQN/nAFBVFI87xoi/ZMhhOWw47hTZLel
         gQYu+MSEACPLDi1g4oeY5K0gxLvOk48WigGVubo0R5Km424A+MpG/QKxPQKXVTWbb0i4
         nuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtEPX2fvz2bHKMErtGoD/T8bBkILX2HzJEJylUqYa+M=;
        b=BY97qFg4mrjvxkaIpMRyJPVB/kEfgy3RzuLfrxNVmDgKR5hKcBV/N3qwU64kD3ms1M
         ZCeX3L6IQbrRt3bGqbJvteCmnW56aeKE59XgzqowmOpMSCnvRWqdJk4r/OHzM+RmOi8H
         dmckXlwppXBdUJn/9wzitS5I/aySK7mFrKjF8GNgZgUa+rzA/+h/+7JXaDVqqxKGif0G
         SNhoKrH6fe7Kyr8gjZz71qZaSwLcIFVuIBen/LnCa26urtoBJw0Bil7VigVZbSOEMdFn
         /p0FapGsSXEVADdRi9mp5iS2DzsKlK0Y6kxNzVe26eZo4vOtalB5IVqhnGw7EVggaaqI
         M8dA==
X-Gm-Message-State: AOAM530QeJVNlAZFm8AjROghJBnptgAevoTt6Wlm2HyaK2whUBzKgDqi
        5Ika3DYTRYQFtau2BkYnTJMawbtHYBs=
X-Google-Smtp-Source: ABdhPJwq4SU4gjcvTcIZ/txMGmzkGemcIOIzPLoP3wB1gpljy9kaHLHnQiqg8+fdp3+zHRL/9VEKJg==
X-Received: by 2002:a19:654a:: with SMTP id c10mr32917656lfj.670.1635866537503;
        Tue, 02 Nov 2021 08:22:17 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm250952lfr.151.2021.11.02.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:22:17 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
Date:   Tue,  2 Nov 2021 16:22:04 +0100
Message-Id: <20211102152207.11891-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

During my work on MFD binding for Broadcom's TWD block I received
comment from Rob saying that "syscon-reboot" should use "reg" property.
I'm not sure if my understanding & implementation are correct so I'm
sending this RFC.

What bothers me is non-standard "reg" property usage. Treating it as a
simple (unsigned) integer number means different logic when it comes to
ranges.

Consider this example:

timer@400 {
	compatible = "simple-mfd", "syscon";
	reg = <0x400 0x3c>;
	ranges;

	#address-cells = <1>;
	#size-cells = <1>;

	reboot@434 {
		compatible = "syscon-reboot";
		reg = <0x34 0x4>;
		mask = <0x1>;
	};
};

I've reboot@434 node with reg 0x34. Also 0x4 is ignored but must be
present because of of MFD addressing.

Please review this idea / binding / implementation.

Rafał Miłecki (3):
  dt-bindings: power: reset: syscon-reboot: use non-deprecated example
  dt-bindings: power: reset: syscon-reboot: add "reg" property
  power: reset: syscon-reboot: support "reg" property

 .../bindings/power/reset/syscon-reboot.yaml   | 28 +++++++++++++------
 drivers/power/reset/syscon-reboot.c           |  9 ++++--
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.31.1

