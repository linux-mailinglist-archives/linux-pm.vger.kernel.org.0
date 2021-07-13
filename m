Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA273C68F6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 05:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhGMEA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 00:00:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21962 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGMEAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 00:00:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626148680; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=w42WAE4DU8ptf8ebzyNY4PLTveQspPorDiUyQcBnboo=;
 b=oYgMQZanp1u8lbYD7YtVCRfaEYE+pNWcta6ZBNwqZBmy647gZeQt4b0QGd+1TYIO4Y9d1I07
 D0v6n3lDbCYyYmju3hoOapKTQnkmJoeYqxKjKPwaWQ8yAS6emHX8oM4Vy22BsuaDJj5GEszu
 8odFq19/HyWuxmkZrtKaOK6IFJA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ed0f457b2963a282f2e13b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Jul 2021 03:57:57
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60FF4C4338A; Tue, 13 Jul 2021 03:57:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF787C433D3;
        Tue, 13 Jul 2021 03:57:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Jul 2021 09:27:55 +0530
From:   skakit@codeaurora.org
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V4 0/5] Add support for PMK8350 PON_HLOS PMIC peripheral
In-Reply-To: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
Message-ID: <676720d932927fa0850924500da565df@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 2021-05-12 11:44, satya priya wrote:
> David Collins (2):
>   input: pm8941-pwrkey: add support for PMK8350 PON_HLOS PMIC 
> peripheral
>   dt-bindings: input: pm8941-pwrkey: add pmk8350 compatible strings
> 


> satya priya (3):
>   dt-bindings: power: reset: Change 'additionalProperties' to true
>   dt-bindings: input: pm8941-pwrkey: Convert pm8941 power key binding 
> to
>     yaml
>   dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml
> 
Could you please pick these 3 patches.

Thanks,
Satya Priya
>  .../bindings/input/qcom,pm8941-pwrkey.txt          |  53 -----------
>  .../bindings/input/qcom,pm8941-pwrkey.yaml         |  51 ++++++++++
>  .../devicetree/bindings/power/reset/qcom,pon.txt   |  49 ----------
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  |  80 
> ++++++++++++++++
>  .../bindings/power/reset/reboot-mode.yaml          |   2 +-
>  drivers/input/misc/pm8941-pwrkey.c                 | 103 
> ++++++++++++++-------
>  6 files changed, 204 insertions(+), 134 deletions(-)
>  delete mode 100644
> Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>  create mode 100644
> Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
>  delete mode 100644 
> Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>  create mode 100644 
> Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
