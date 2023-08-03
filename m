Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79A76DC9A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 02:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHCAZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHCAZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 20:25:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B924330E5;
        Wed,  2 Aug 2023 17:25:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 86E076607088;
        Thu,  3 Aug 2023 01:25:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691022344;
        bh=a4ZVvuCVIjytPB9Xa+qzo7sw1T+PCxguID4EgDUegNc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TBzsdyAyY3G7T6+EIiTdwsFEZTdDyNw4SVfJtM2s3k8U++fOslAEWn85/D+bpwYGO
         gWFrrtb5ZlUrKHvvbfdh4sOLysGJvs46nvfvWtEEmkkSpGmmr/nZO9lKTlzoHh1gU+
         HXIHnIugq7CnENJt6+iyV+rLPU8QsMFMadtoX6WRNlujlUknepn7NE8ef0um5xTd2F
         eclPf6A/j03ajNsHwGfYJhGD2C9Ij8cHsN0aGMgdRe8Rj+BVmvec2e9YQ5TSG5z1d2
         rUvNO6nfqj5qkH0p7Sf6IjkGAB7KYTuj/ZU+W4Gh5sw05IEuNKLkTXokjSXwEQfegN
         zglmcfFxRJ/9A==
Received: by mercury (Postfix, from userid 1000)
        id 712791060927; Thu,  3 Aug 2023 02:25:42 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20230802-pmi8998-charger-fixes-v1-0-a8f1e8b84c1e@linaro.org>
References: <20230802-pmi8998-charger-fixes-v1-0-a8f1e8b84c1e@linaro.org>
Subject: Re: [PATCH 0/2] power: supply: qcom_pmi8998_charger fixes
Message-Id: <169102234245.232087.1076719973314019851.b4-ty@collabora.com>
Date:   Thu, 03 Aug 2023 02:25:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 02 Aug 2023 15:49:27 +0100, Caleb Connolly wrote:
> Drop the useless CHARGE_CONTROL_LIMIT_* properties and
> fix incorrect status reporting on some devices when the
> battery is full.
> 

Applied, thanks!

[1/2] power: supply: qcom_pmi8998_charger: remove CHARGE_CONTROL_LIMIT_* props
      commit: f57f5838c044d1554b71186d3d277619eab58d31
[2/2] power: supply: qcom_pmi8998_charger: fix charger status
      commit: 7e6311f04b41174ccc738d37dcb4b93cd4de98b0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

