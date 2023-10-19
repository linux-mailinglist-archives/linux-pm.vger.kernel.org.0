Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC27CF068
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjJSGtz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSGty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 02:49:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA412D
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:49:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c434c33ec0so52820165ad.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697698192; x=1698302992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iypGtD7DPCwKUP/xzbPis5St8GeNHklM3nIt7ym+WcE=;
        b=jqYhMhwqKtBqd6MLEsiwgDyQ1tlPZvFIDZJM+Lxk0PbkrrbvJZEWEwHrrNsK24cefg
         fOXP1Ryl8JjREr7Y298KJ3YoBQkOcslHc8OqTgr3LzBQfychKLozzPX26K4A2mfSKFI1
         nO4UaWQ1INbo3Vc9XdgJf8TAGW23SzA3wi/E7Mt187+n2j1WoTemvlFqtA8fjogEQ3Hf
         Q0pkdqKTbTOMYaKtCc4vhw46QyFd3EXPOOagpjgwNROvrTL+a1rWfN/pVgmkVOr8mQn+
         dn7C8l/hLSo6ccuxBtXBtcr00YJ9YqcYuuHk8UVvaEMOeRjuTqF2jEGuUQwkEvDH7b0h
         xOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698192; x=1698302992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iypGtD7DPCwKUP/xzbPis5St8GeNHklM3nIt7ym+WcE=;
        b=a6fIqpRMG7YwS+J9cQ5e5BBxmsqHE0BvZOb8aZI9zBlokpk/bzON4SmqlwFke1/aiF
         Utpy1Kyktqsh35X2hsuvoPmF3wULUkiWZOUH8ee+O/lWI+VFMoIn6NhIjH7o06qLtkGh
         lL+POe3uCK4e4jY9NUfXLa5EgOM+FZNPgNQ23XGtrWEGZDx5h/ORKcOme0P342aboMcO
         6M4MpcJ2Xsjmaa8CbxhzmpMqsaKO6WBdo9abvFo3iJjNWmqGMK2+ZbUFDFfKQjA+seuj
         HmCRjzBIVKNQJ7JIo/Sl9ImrsVP+NJRvOTlfHkEuvvuo98Sala19GANW8jdrwgY+PkcI
         xn7A==
X-Gm-Message-State: AOJu0YxXrJ7ScuGUFec+diSJaNZjIMXbpidqks40T8kY0e7RuJVUt2mJ
        cA9+0XftMMuQRwbVTBHUUSNY1w==
X-Google-Smtp-Source: AGHT+IH82EMATIWoNzRSDE2s4yk4Kx2MxpgdCm4diwfW3pESmg8Yb6n4T8gXs9GRjAhlBrLMIO5LWQ==
X-Received: by 2002:a17:903:210d:b0:1c9:97b7:b3cc with SMTP id o13-20020a170903210d00b001c997b7b3ccmr1170380ple.47.1697698192143;
        Wed, 18 Oct 2023 23:49:52 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001c74876f018sm1077747plh.18.2023.10.18.23.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:49:51 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:19:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: qcom-nvmem: add support for IPQ6018
Message-ID: <20231019064949.ly6e6c5u4g7jobjm@vireshk-i7>
References: <20231016175532.2081344-1-robimarko@gmail.com>
 <20231016175532.2081344-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016175532.2081344-2-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-23, 19:55, Robert Marko wrote:
> IPQ6018 SoC series comes in multiple SKU-s, and not all of them support
> high frequency OPP points.
> 
> SoC itself does however have a single bit in QFPROM to indicate the CPU
> speed-bin.
> That bit is used to indicate frequency limit of 1.5GHz, but that alone is
> not enough as IPQ6000 only goes up to 1.2GHz, but SMEM ID can be used to
> limit it further.
> 
> IPQ6018 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 58 ++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)

Applied. Thanks.

-- 
viresh
