Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A85144E34
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 10:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVJHa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 04:07:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJH3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 04:07:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so6295172wmi.5
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2020 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xjivJm+vtcjvY+FQxebUX6xWquR7Et93xpYy1Kzxpc4=;
        b=wvCnHv8U/q5EEx8u/+S6BSKlG/GwCEU0ss0zlHCWJmpTyXmcu9sSThWIDInuy0tYNB
         nG0+AeQl8IlzSUEKR/sWM3dfFAw7PTruatycp2znJ4c/i8hKUYZqFZduChRqVDl5+zDe
         jLkUmdouR4FLbB6aK4kbPSoYNbvAUkxDc1QkUK0krVsE4wjsqaO5BPbonWzt2n+2f8Au
         4A/ruEgN4bTQV5MH/3iTluzF0+XmhVtb9K9SkZ2MyTBQLj7ZBBE3mWgfaQLlo1tui3i8
         yI69kaTfL3N4pE5t6wlOohaejKGaTFZUTV1uv1DX+ONF/fD6c8Zo2AHw7tzIPhRVKGTJ
         77wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xjivJm+vtcjvY+FQxebUX6xWquR7Et93xpYy1Kzxpc4=;
        b=rNfhqTNfqZiyCNLFPoUKNdoPzvkuXIKdfoB59OwuDTxzLa8rMgceulEVhBIsbtAd4X
         U7Ltdett7FEMexcD/EaDp/AfDT6GWhfR7mRyvc2+AdFeUe8yxliSNehtIPWNCHd0hYvH
         XlQcjTkrMq3+xIK+PhvCWL0TmC57XCNinXt1UxRSnceh109EHsLDaBJM3bUrWzaS0oG1
         8f7/ueKx8ql4sOZISAS+WyZYzp8IEYIqTTpu7ThPhooq1MkxzGBNHUmwOxzZsttHwSqA
         sgk6hjNPVujSfvq331u+OHKBvt46tUlmvwdjUrkipZ79ZoDBA1wcP3gpiPavubwHyf1M
         er5A==
X-Gm-Message-State: APjAAAWWSxR711tjgCSsznOsvsJuWEfhygQNMHu0aGrktOfAa34mEg5E
        7w/NxXL6ubgd4sG1aBRflZ4PKGQ0MZg=
X-Google-Smtp-Source: APXvYqy4ZcPkeQyJkcrdM+gRZ6HpO56ub6wP7r67JoMliKU6H6aVSzFrJzNlVtEH5MGn4Qdlb9wBUQ==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr1893020wma.95.1579684047327;
        Wed, 22 Jan 2020 01:07:27 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g7sm55926077wrq.21.2020.01.22.01.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 01:07:26 -0800 (PST)
Subject: Re: [GIT PULL 00/12] interconnect changes for 5.6
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ec627a0c-3f84-2b7b-e42b-36cb46ceb594@linaro.org>
Date:   Wed, 22 Jan 2020 11:07:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

On 1/17/20 11:58, Georgi Djakov wrote:
> Hi Greg,
> 
> Here are the interconnect patches for the 5.6-rc1 merge window.
> 
> - New core helper functions for some common functionalities in drivers.
> - Improvements in the information exposed via debugfs.
> - Basic tracepoints support.
> - New interconnect driver for msm8916 platforms.
> - Misc fixes.
> 
> All patches have been for a while in linux-next without reported issues.
> Please consider queuing them into char-misc-next.
> 
> The same is also available via a pull request with a signed tag below.
> 
> Thanks,
> Georgi

A gentle ping to check whether this email got lost or you require any
changes?

Thanks,
Georgi

> 
> The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:
> 
>   Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.6-rc1
> 
> for you to fetch changes up to 30c8fa3ec61a46da80698e1f8ab95df4d42bf374:
> 
>   interconnect: qcom: Add MSM8916 interconnect provider driver (2020-01-07 09:30:09 +0200)
> 
> ----------------------------------------------------------------
> interconnect patches for 5.6
> 
> Here are the interconnect patches for the 5.6-rc1 merge window.
> 
> - New core helper functions for some common functionalities in drivers.
> - Improvements in the information exposed via debugfs.
> - Basic tracepoints support.
> - New interconnect driver for msm8916 platforms.
> - Misc fixes.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> ----------------------------------------------------------------
> Georgi Djakov (11):
>   interconnect: Add a common helper for removing all nodes
>   interconnect: qcom: Use the new common helper for node removal
>   interconnect: Move internal structs into a separate file
>   interconnect: Add a name to struct icc_path
>   interconnect: Add basic tracepoints
>   interconnect: Add a common standard aggregate function
>   interconnect: qcom: Use the standard aggregate function
>   interconnect: Print the tag in the debugfs summary
>   interconnect: Check for valid path in icc_set_bw()
>   dt-bindings: interconnect: Add Qualcomm MSM8916 DT bindings
>   interconnect: qcom: Add MSM8916 interconnect provider driver
> 
> Leonard Crestez (1):
>   interconnect: Add interconnect_graph file to debugfs
> 
>  .../bindings/interconnect/qcom,msm8916.yaml   |  77 +++
>  Documentation/driver-api/interconnect.rst     |  22 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/core.c                   | 168 ++++--
>  drivers/interconnect/internal.h               |  42 ++
>  drivers/interconnect/qcom/Kconfig             |   9 +
>  drivers/interconnect/qcom/Makefile            |   2 +
>  drivers/interconnect/qcom/msm8916.c           | 554 ++++++++++++++++++
>  drivers/interconnect/qcom/msm8974.c           |  32 +-
>  drivers/interconnect/qcom/qcs404.c            |  32 +-
>  drivers/interconnect/qcom/sdm845.c            |  16 +-
>  drivers/interconnect/trace.h                  |  88 +++
>  .../dt-bindings/interconnect/qcom,msm8916.h   | 100 ++++
>  include/linux/interconnect-provider.h         |  14 +
>  14 files changed, 1057 insertions(+), 100 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
>  create mode 100644 drivers/interconnect/internal.h
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>  create mode 100644 drivers/interconnect/trace.h
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
> 
