Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C333D22CD6E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 20:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXSYK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 14:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGXSYK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:10 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAA6206F6;
        Fri, 24 Jul 2020 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615050;
        bh=zKnG2VC/v8+fyF5WfOvD1jU6Pi7niG9nBIQEyDhp88Y=;
        h=From:To:Cc:Subject:Date:From;
        b=T5zjIv6+XFHcxDsseIpmWmVeLIY4fSlvyl5Ap+z1gxzHPkqJ/dJN7agaG9cvMZxh5
         kYqzMuoL2VHts6lZTN/CY3WPmcwt+10GJUUNF5qzDaxjaMYVLETeiLT3FY65jLp3z2
         +i7uE9V76LBjy8hcpja1V6BL6jq3MjQ1ZGFovXts=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/16] memory: Further cleanups
Date:   Fri, 24 Jul 2020 20:23:12 +0200
Message-Id: <20200724182328.3348-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I have few other cleanups which I could take.  Two patches need here testing as
they are not trivial.

Best regards,
Krzysztof

