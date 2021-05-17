Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFC382A2D
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhEQKvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:51:36 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:16338 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhEQKve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:51:34 -0400
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 06:51:34 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1621247895; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iPzpJ29Vi0Gn0hxmTNWYGokZvDY7IatYN8XPZXKzpDEV7DTkWU7YETZ5iyY/OzzOB4
    lqZpIns2hBTeDY8+R7C+J53XJDBTkQorNVBdma8Af6hSilF8BPiu8fMZ4zLZzW65SY3C
    1Gvd7XZJr9m0Md7RLBK+kWDdQuWyBbBUhkX6RSfE0hAM+q1smxO8IPPR9eV31YyyPgyC
    LWSy4xb7UqqfSN0vajP4mNZaJq4BSxjk4pjqXNXLQwFHw9n2qV5pXjnB3DGFlj6l8U/Q
    mycJwulwn/8KeNtvATYYLcWnXgD+wMVy5nqUkM6pUposA2RnpzEtgEbg/w6Dfjk44YY/
    2c5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247895;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4Dcy2LTLgJk8PaoF6Y+q8hdBpMw3cHT4pkb5zRFtSJs=;
    b=OXEniK7HR/0LnpA1e7zNHIRG7NKxdRl37+mZjjrqXSvTWZ4V13bmHrC30GloIxgviE
    X6QTHSRaEC9IaFlLIOeV4e6Kq/McbckyKtsDIAD50dTt3Fz6ytPVpe09h6Vj72s279B7
    o6w5RnkQpLSRNpO5WAr57dSg5d/3S0ktxIEFENEs1KwtuyzvK/XB/HJSnQ9uNLBxHgCt
    eHzjaX91CQFM57sxfYN+y3gsY/aTSc9cH17sV8DVZ2KzZoyyed/CFpUS6dV4wfjDIpmw
    r5J6XxomzhlO+Jt/VNcn7dI3fpm61MSuRqEKbK2ypET0ZAAT5TAnRi3luItXp6RingcE
    Sb+A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621247895;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4Dcy2LTLgJk8PaoF6Y+q8hdBpMw3cHT4pkb5zRFtSJs=;
    b=sTqEKLDR0rD5fy4p5UPOM3VQhI8e1H3u6pb2IzvC5UglygtXaFg2sZkvgqgKSHl6I/
    FmtKrPiqTCsAVrCob45IVWB8IQ9YKxEIYcdB1EUjJCwXkreTiSUXTP/XLsYp644MA+Al
    W8dE0q56Zfw0CLHh4i35/8tI//fuTdoB/PvWU8+8LDrPbRqq6biENg96YQ8v0/0PK9yS
    3I+OliATnF+tT/3vNun8r4MCTTd3FhWeyNNwJQ9UAx8RrOEi6CF/8lH3UJYpyb8V2eAy
    mlQesXPoXklyY5LqmPqVnWlQfbIUaIIFkVPe697OPoFBzpUmgvIxb2AMIW9gsKz4Bo3b
    zmTQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAcF1PV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:38:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/3] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Mon, 17 May 2021 12:35:54 +0200
Message-Id: <20210517103554.168159-4-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517103554.168159-1-stephan@gerhold.net>
References: <20210517103554.168159-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
and interrupt lines. Therefore, it is not part of the MFD device
and needs to be specified separately in the device tree.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/mfd/rt5033.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index f1236a9acf30..df095e91e266 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -41,9 +41,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
-- 
2.31.1

