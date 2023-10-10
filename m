Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9E7BF31C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442266AbjJJGco (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 02:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442248AbjJJGcn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 02:32:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E4B0
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 23:32:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35140cc9187so22485215ab.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Oct 2023 23:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696919559; x=1697524359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMjAqcpLnIT/rrI7hIEQLgNPdRLO8Rld137dNw3SF7I=;
        b=mP8I8d6e5a5ShtHsoOZr83t0almE7JYNg5YZ6NV/SnQDGUb79i6xA6b7xjWu9mh4bH
         hyB1+eZWuhlmIiT7PCBILsMlUO49kQfTqEfu4SuYdyoo41ZLzlUEwC/cSJqonBOyOgxS
         uAJURKxKWPXFXhGEGebvl0Qzgz3OGJkSW9EBdvuzV/WAc5zFVvHhbWxKTESaZAQOyNXi
         iGqKBKeFTi536sVR9+KlgUcKR36uTUCp+beRa7ezXd/bdb2US5APZf1F6PQmSclYTtCt
         gJTQTsm8XEzrWjN4W2lJ0FgiAY/j+H2ZdbH8SuXIECZHm8QtkR/+H+sOVnJs8qslygI+
         BOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696919559; x=1697524359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMjAqcpLnIT/rrI7hIEQLgNPdRLO8Rld137dNw3SF7I=;
        b=eVdmmJdFJK12Trdhr6GQtwrYjYCbWhv+jd5F6IlZgpC+tnfBmnJSdff7RWZuiwpvzx
         xWxN0hxBmVOA6bTX/Ts4M91ft6KkuRXE6+BfQ0qaRA9Ny6HSL+IIicVfBQWmFXVYB1jF
         CNn4ljPrmir/HgA/FRm0xR4IZpaJk3WiPQoCIZvL93lTVxxdZNvpjFVTDeTPPrJEy4k4
         8KqaUbIIoGMckSGdZVcWF/vLh3ZyG4zt1f2YICWajXSRo74CyGgcS3Y3G3eCHrFjChMA
         865Gpnfx5lq0p1D5OCIEHD00MlHoBNlj8PtMMkvEvP4Y6cZirwpogsoR68hH+pXZ+JAb
         +LkA==
X-Gm-Message-State: AOJu0Ywfk8A7jHkvYwvnnvuNsT1UGRCDmoxaO2/TMxtvjA2pBupuB7HR
        RwV9yoFNsRYrFjwry5VVEYXb8w==
X-Google-Smtp-Source: AGHT+IFudao3PbpP569Ne+5jwXH4fImT8uscTRIidiWKdGzpzFr6qyIB+LvshslYWivEZAwnbXVarQ==
X-Received: by 2002:a05:6e02:180a:b0:357:3d82:2d48 with SMTP id a10-20020a056e02180a00b003573d822d48mr381725ilv.8.1696919558757;
        Mon, 09 Oct 2023 23:32:38 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b005776446f7cbsm9400467pgc.66.2023.10.09.23.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 23:32:38 -0700 (PDT)
Date:   Tue, 10 Oct 2023 12:02:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v5 0/6] cpufreq: qcom-nvmem: support apq8064 cpufreq
 scaling
Message-ID: <20231010063235.rj2ehxugtjr5x2xr@vireshk-i7>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-10-23, 21:59, Dmitry Baryshkov wrote:
> This is a split of APQ8064 cpufreq series, as requested by Viresh. This
> series includes only opp and cpufreq parts, with the DT and soc parts
> being split to a separate patchset.
> 
> Each core has independent power and frequency control. Additionally the
> L2 cache is scaled to follow the CPU frequencies (failure to do so
> results in strange semi-random crashes).
> 
> Core voltage is controlled through the SAW2 devices, one for each core.
> The L2 has two regulators, vdd-mem and vdd-dig.
> 
> Changes since v4:
> - Reordered variables in qcom_cpufreq_init() (Konrad)
> - Fixed of_platform_device_create() error check (Konrad)
> - Dropped unused ret variable in qcom_cpufreq_apq8064_name_version() (Konrad)

Applied. Thanks.

-- 
viresh
