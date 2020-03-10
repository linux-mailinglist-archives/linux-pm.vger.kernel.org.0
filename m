Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAD1801F5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 16:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJPfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 11:35:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJPfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 11:35:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so16437107wrm.9
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pg+ee1cpf0I56dBXZYlWH8+GfpDAR/oLM1LChHL11OE=;
        b=TEU4Xb4Nj2JTgQGqMIsKquU4DA+8l74mfb2aLF2fXNSUhulCw6Ts/Z3shDrBR09hN2
         xuNROZm3F1E0JXW7yhW8nTHDPYH2RM23J5T3DP7WBfXs6RXZ78+TftyuQH3nLOaWKcPv
         exFQdrjKR5Jc1JE0C8hsqAOnCT4eU4sVAMzy8emuiylfI/9gQNEc3HSIScw9ePq9uWhT
         RS2HChfOKnR1PSe2pcp/Gx94hanP9q8k+cYC9iHkt/hLJu9jUTGmTfhsc/ZmuJ30eHjZ
         i2lRy7ko+qy6aAuKWFhMag5PaqO/8l7EB+3jq7pxM6QyoAqlEuLw3ZzgxdubQzNOafdT
         IzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pg+ee1cpf0I56dBXZYlWH8+GfpDAR/oLM1LChHL11OE=;
        b=IYAzjqn1P7jhjPvFY/vw1S8MrGiHsr0SL6gvgO75AY6/nhQgcJAqK/NNtaXgoaVKgU
         TDhk14Doc2qBXV6jACyhU4YxIZNGNjBHZZEqqgP5TtrXPdcNoSAQ89Naj3HVO26y9pTy
         hgS51LXMxvkK+MvTqgM1Nlr0bHjN/zndwQV4pTFP+YvNy0nzS/R16aMmroPL+fLgcdSl
         OCJxFwsVlCt7uCt4jeYciEowe7XUOum+4jlKvsGshL4/h6rZRZRYbY3Q3RQwBgjYk13W
         O26xfsFvGd8ddmnmp8pt89c+/yG7EijYsXEfaOflvPnHvK9rtf8c7BQmo+8FA7FT8qm/
         R76g==
X-Gm-Message-State: ANhLgQ3TTRuk9m/Jr3/4PwDr7GBuvFBzkvJwEL8dQKeKBquNNj2DQnmq
        wWPp83QK0OLxgCnVDmaUDqJujLlEeOQ=
X-Google-Smtp-Source: ADFU+vvjb6Nn7KupVxFXeO3Y0Zp6+S9aQDU7y1PpacP1t+aKi1MLOGykt3bJ+F4UmvskzIAERbEkPQ==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr27396766wrv.353.1583854543104;
        Tue, 10 Mar 2020 08:35:43 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id j66sm4672937wmb.21.2020.03.10.08.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:35:42 -0700 (PDT)
Subject: Re: [v5, 2/3] interconnect: qcom: Add SC7180 interconnect provider
 driver
To:     Evan Green <evgreen@google.com>,
        Odelu Kukatla <okukatla@codeaurora.org>
Cc:     David Dai <daidavid1@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1583241493-21212-1-git-send-email-okukatla@codeaurora.org>
 <1583241493-21212-3-git-send-email-okukatla@codeaurora.org>
 <CAE=gft5LE=_hBLbkWHDAQ6O9vrbfF=LtS7B=1tWWDE3euZov_g@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <cdd73fe7-c7e4-d035-d1dd-be4f1b9c142c@linaro.org>
Date:   Tue, 10 Mar 2020 17:35:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAE=gft5LE=_hBLbkWHDAQ6O9vrbfF=LtS7B=1tWWDE3euZov_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/9/20 19:33, Evan Green wrote:
> On Tue, Mar 3, 2020 at 5:18 AM Odelu Kukatla <okukatla@codeaurora.org> wrote:
>>
>> Add driver for the Qualcomm interconnect buses found in SC7180 based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  drivers/interconnect/qcom/Kconfig  |  10 +
>>  drivers/interconnect/qcom/Makefile |   2 +
>>  drivers/interconnect/qcom/sc7180.c | 641 +++++++++++++++++++++++++++++++++++++
>>  drivers/interconnect/qcom/sc7180.h | 149 +++++++++
>>  4 files changed, 802 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/sc7180.c
>>  create mode 100644 drivers/interconnect/qcom/sc7180.h
>>
>> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
>> index f6418a6..482c5be 100644
>> --- a/drivers/interconnect/qcom/Kconfig
>> +++ b/drivers/interconnect/qcom/Kconfig
>> @@ -42,6 +42,16 @@ config INTERCONNECT_QCOM_RPMH
>>         depends on INTERCONNECT_QCOM || COMPILE_TEST
>>         depends on QCOM_COMMAND_DB
>>
>> +config INTERCONNECT_QCOM_SC7180
>> +       tristate "Qualcomm SC7180 interconnect driver"
>> +       depends on INTERCONNECT_QCOM
>> +       depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
>> +       select INTERCONNECT_QCOM_RPMH
>> +       select INTERCONNECT_QCOM_BCM_VOTER
>> +       help
>> +         This is a driver for the Qualcomm Network-on-Chip on sc7180-based
>> +         platforms.
>> +
>>  config INTERCONNECT_QCOM_SDM845
>>         tristate "Qualcomm SDM845 interconnect driver"
>>         depends on INTERCONNECT_QCOM
>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> index d591bb5..5325558 100644
>> --- a/drivers/interconnect/qcom/Makefile
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -5,6 +5,7 @@ qnoc-msm8916-objs                       := msm8916.o
>>  qnoc-msm8974-objs                      := msm8974.o
>>  qnoc-qcs404-objs                       := qcs404.o
>>  icc-rpmh-obj                           := icc-rpmh.o
>> +qnoc-sc7180-objs                       := sc7180.o
>>  qnoc-sdm845-objs                       := sdm845.o
>>  icc-smd-rpm-objs                       := smd-rpm.o
>>
>> @@ -13,5 +14,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
>> +obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
>> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
>> new file mode 100644
>> index 0000000..dcf493d
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sc7180.c
>> @@ -0,0 +1,641 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
> 
> Nit: As Georgi mentioned in the previous review, you can remove this
> an replace it with of_device.h. No need to spin for just that, though.

I have already applied this version, so any follow-up patches are welcome.

Thanks,
Georgi
