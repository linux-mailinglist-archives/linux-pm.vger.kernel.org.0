Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4945371438F
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjE2FF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 01:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjE2FFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 01:05:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7710DC
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 22:04:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so2097927b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 22:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685336689; x=1687928689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOFWTFkk4SKxYHlUqAq7J1c+lpLs5WOB6FRNfH9nXJo=;
        b=iVYw4lCM/2Qu8g105LxQBGkfe4xT8aBzNIWp4igMCOe2C8ScPtCI80Rg6jeX6FVxC4
         MfmKMV2GXJBcINE9w8oMvlihD3XdFI+3FHAQtlrIDveUHCCBIeU4HaLtc99NY/M2ccCL
         XcMBUp4A1IsVr4qFwC0njvhTFBMtfRgnMQfUcAIlBXYaj28UMHoLLcHcRuLhugmP5R4M
         ms+Y88655cFAbgMnAofBke2Hla20HA49t6FSiwVxt+Ixj02DZZAyKL9AuWVph43oyrXO
         tKb+nOVIG6ewdEUFhP2N+Mme+qZoOCUDcqCLGCMbzwguECiuAyTavhiROOYrfa6URdyc
         I2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336689; x=1687928689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOFWTFkk4SKxYHlUqAq7J1c+lpLs5WOB6FRNfH9nXJo=;
        b=HbRFRhbVUfAPGdJ8GZWfJe1+9fRC7tRQrWhQvw66TP60Qgh0lXDYtRbQ70k2nDpzCo
         Ly91GaKN2FWH54rSlBx8mUC2gc2Xi6vZvjwYP2jDnfTor0iWl8994NsVACu6C3RXTENh
         miZXRi7ntLuFm+2Rh3v+GFOoL/TK1B6tGBvad+p6B305kOMbCjCDVdRloYgvdpLeNKVf
         ckPW8Qawe+loiRXZ6iAoLkgPJduk6e/WYzpRVmaFiXfmW6rTJo1PM4xw8xMHpUZcETmo
         tAefMy7VcnVV7Mkb4cjeGXIhf7W+ke4nTmf7nbnkacNgee2a0p0kSoUi/GHM4z0Ho9ID
         K4rw==
X-Gm-Message-State: AC+VfDye3ThA11PAvTpxGcCpwUnDSHw8IMtF4PAk9reZaaDzWeeQH/iU
        emjlceiqcD5CzZGZDmJ8qVzXGQ==
X-Google-Smtp-Source: ACHHUZ5jfYa3+t66dq7oO6dlAu6iaa1Op31sk1qeJzIjGFTJ3p9l76ZI2e0Ja+VRKl7wjdJboknNPg==
X-Received: by 2002:a05:6a00:218f:b0:64e:bada:2411 with SMTP id h15-20020a056a00218f00b0064ebada2411mr14027159pfi.25.1685336688728;
        Sun, 28 May 2023 22:04:48 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78109000000b0063d46ec5777sm789897pfi.158.2023.05.28.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:04:48 -0700 (PDT)
Date:   Mon, 29 May 2023 10:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vibhore Vardhan <vibhore@ti.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, d-gole@ti.com
Subject: Re: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62A7 CPUFreq
Message-ID: <20230529050446.ur2wvqirksy5ko2r@vireshk-i7>
References: <20230526144354.38478-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526144354.38478-1-vibhore@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-05-23, 09:43, Vibhore Vardhan wrote:
> Hi,
> 
> This series adds cpufreq support for TI AM62A7 SoC.
> 
> AM62A7 has the same A53 and efuse configuration as AM625. Thus, soc_data
> from AM625 is reused. This series adds compatible string for AM62A7 to
> ti-cpufreq and cpufreq-dt-platdev drivers respectively.
> 
> Tested on am62a-sk board using manual frequency changes and then reading
> back frequency with k3conf, and this shows matching frequency to what
> was set. 
> 
> Link to the complete series including the DT patches:
> https://github.com/DhruvaG2000/v-linux/commits/am62a_cpufreq_2023
> 
> Based on patch series for AM625 by Dave Gerlach.

Applied. Thanks.

-- 
viresh
