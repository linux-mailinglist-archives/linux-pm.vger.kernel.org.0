Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72B2FBC74
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhASQ36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 11:29:58 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:47774 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbhASQU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 11:20:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611073178; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=iy/S8TWo4V1brHw5rkLeSCIVsbtOU9fUJpOaqjSNd/I=; b=eyYEHDXpXR98iym9qHK91LZJ2cWSRWmX64hH8qulPXaPUXEwbOrf5BFxn2mBhFUhwLGGwHa+
 gEAyF/QWTpDBds1kpQKpzFqaI4HkM2ySPR8gy6xxp2qJMPvDJtS4cH4wCAjuBDsXpFMm5ZJa
 S7U9TTBrTLYfeTbpRWsfU71pKKM=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6007067f02b2f1cb1a0ff9db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 16:19:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D73DCC43463; Tue, 19 Jan 2021 16:19:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CF45C433CA;
        Tue, 19 Jan 2021 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF45C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: Re: [PATCH 1/2] net: wireless: intel: iwlwifi: mvm: tt: Replace thermal_notify_framework
References: <20210119140541.2453490-1-thara.gopinath@linaro.org>
        <20210119140541.2453490-2-thara.gopinath@linaro.org>
Date:   Tue, 19 Jan 2021 18:19:05 +0200
In-Reply-To: <20210119140541.2453490-2-thara.gopinath@linaro.org> (Thara
        Gopinath's message of "Tue, 19 Jan 2021 09:05:40 -0500")
Message-ID: <87pn20garq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thara Gopinath <thara.gopinath@linaro.org> writes:

> thermal_notify_framework just updates for a single trip point where as
> thermal_zone_device_update does other bookkeeping like updating the
> temperature of the thermal zone and setting the next trip point etc.
> Replace thermal_notify_framework with thermal_zone_device_update as the
> later is more thorough.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

The title could be just "iwlwifi: mvm: tt: Replace
thermal_notify_framework".

But via which tree is this going? I assume it's not
wireless-drivers-next so:

Acked-by: Kalle Valo <kvalo@codeaurora.org>


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
