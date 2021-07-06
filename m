Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA13BC7D8
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGFIbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhGFIbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 04:31:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C2C061574;
        Tue,  6 Jul 2021 01:28:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f17so7274068pfj.8;
        Tue, 06 Jul 2021 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J2tGUbG+Wytqc+476/++1CACVBlZ75emW59na3YRlEg=;
        b=AmZA1/Dfb6g6UIWzEppKBmTWnke2q/qrUWsQWwNt9DA+UDTBt73g/IPlDO3GWkoyfz
         K0MLYfzEOPTnZrKhHYEkkyQMj+UNpoDnznzUT3xw7Y1b8D/aL81YQVvQk91lsv2KHYgb
         RgOOWgCFU93+zEmLYAVbs3j/f3lyrxF+l+qTAbnHIXxMjE1eoSxNY3dPxRkip9sMUVcP
         wcgblnDTtfk3I4Fm1jV3s5J7Dm4dP8e8EtFHeZeU52HPUA0prDFxDPHt9QKp91cV+8C7
         NbweUXdxs+ZHX1TABNLttesx1nyhTJPLxV6SFKjyOSQaIvm03eNBzRWIp93ef+SJYMN4
         2WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2tGUbG+Wytqc+476/++1CACVBlZ75emW59na3YRlEg=;
        b=QmIa6uAUYRrL/KWhx9BXNFlboSHoRVKtIn4ytX0fsxdTIAwASKkh773gplwUHZzGNX
         p1nteXKitNGEFKMsYlcjWO/+wmNNW3BYOjPRn9I0G14uQpklieRLRBv9ThoJaFFpJBN7
         tmTG05tXpuSYCLu8FTvYM9dOPXtNr+k6vll3HmLYtQ6cgyPDyY1+svUtSLMAhC1GSOYV
         SJY7fw7tjOXrhdxuca/FWD71wedShknpe/Txtwy7VrHTVkLueziUQ/2sDMsyVzZH+Z/Q
         KXzBkREFjQlZm+luYNwP8s/bXEt2bvxMsikHjELAWLBQ2QztFyRyzK/yUJNFd9eRNKdl
         cy8w==
X-Gm-Message-State: AOAM533nWU/P7yEHfyaVUPlTCqPgEpA66o9nrtMmrVj2f8PH3pqvYSuj
        hjJrGHUhPB/Kpzgq3Wdl/u4=
X-Google-Smtp-Source: ABdhPJwI/xtmjCCiI7aBIswYg+N4dDu3PCJvOF2JH+ytaLekcGGRh0k3cKqeg957nxmsFIPoEg6qxQ==
X-Received: by 2002:a63:af53:: with SMTP id s19mr18285303pgo.147.1625560136445;
        Tue, 06 Jul 2021 01:28:56 -0700 (PDT)
Received: from [10.101.46.79] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id i8sm15067817pfo.154.2021.07.06.01.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 01:28:56 -0700 (PDT)
Subject: Re: [PATCH 0/2] thermal: int340x: processor_thermal: Add new PCI MMIO
 based thermal driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org
References: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
From:   You-Sheng Yang <vicamo@gmail.com>
Message-ID: <e4a407a4-aca4-0abd-8946-af34c3c16c4a@gmail.com>
Date:   Tue, 6 Jul 2021 16:28:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Verified this initialize [8086:461d] correctly. An additional thermal
zone TCPU_PCI added.

Tested-by: You-Sheng Yang <vicamo.yang@canonical.com>

On 5/26/21 4:48 AM, Srinivas Pandruvada wrote:
> This series adds a new thermal driver, which uses PCI MMIO for temperature and trips. To reuse
> the code the first patch just reorganizes the existing code.
> 
> This series needs the following patch to cleanly apply:
> [PATCH 1/2] thermal: int340x: processor_thermal: Export mailbox interface
> sent on 16th May, 21.
> 
> Srinivas Pandruvada (2):
>   thermal: int340x: processor_thermal: Split enumeration and processing
>     part
>   thermal: int340x: processor_thermal: Add PCI MMIO based thermal driver
> 
>  .../thermal/intel/int340x_thermal/Makefile    |   3 +
>  .../intel/int340x_thermal/int3401_thermal.c   |  82 ++++
>  .../processor_thermal_device.c                | 289 ++------------
>  .../processor_thermal_device.h                |   9 +-
>  .../processor_thermal_device_pci.c            | 371 ++++++++++++++++++
>  .../processor_thermal_device_pci_legacy.c     | 163 ++++++++
>  6 files changed, 658 insertions(+), 259 deletions(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/int3401_thermal.c
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
> 
