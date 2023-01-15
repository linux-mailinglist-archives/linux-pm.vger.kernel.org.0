Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096166B07E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jan 2023 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjAOLDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Jan 2023 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjAOLDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jan 2023 06:03:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21CC166
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 03:03:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q8so6256231wmo.5
        for <linux-pm@vger.kernel.org>; Sun, 15 Jan 2023 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doTQsI33/pI0MomsV4wMaYUWnpKm4+aMmHQhmWnnGnc=;
        b=Jwu6oQkRs/AdEBVDg7vBaTHhrcKWyH+BCoq8vZGqQsBWwFfOMYG2QAOn0azh0Lbf2H
         isu9t1dya38oRsIeLiKdHutP1frt1X3Lk41byxGagfjoKU+C5QapRhM2pY4bbFMtsQOe
         ik8kqEVluOmZx0N4hV2DQynddNQYc007TdQNof17ZmyLucovAYyebPA48Wu4aWQ3oXeK
         qIXJphHW1PiLuqVoOFCYi61DI3VlKUz2r5MzU/uSDDDsMXOwooupQOco9H1isW95x1uz
         oz11dwcpu0fShnSzGvnMSI6wK4ruljaeXrdIMYUGEyEk23tCixfPZy3yom+kZU/vBetr
         dV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doTQsI33/pI0MomsV4wMaYUWnpKm4+aMmHQhmWnnGnc=;
        b=YFFhUjEjZu6tApp8BuZ8n7/LYYpU/lEuGM3ZUj6xq69Gi3jtHJWPXOR8Q4tzQkO8VQ
         mBVE/kIMSopqXWIhMWtYVj3RNFB5JEizikrBMHJQUxjPDUY6XYr7D/t5nYhw+R/LpUAT
         dZg/EPEJejS0EcosqWUuL+eFCUesNaNFZTaKSO5SdyOOXxCgwLZnGsQPomEn9pL17zFO
         18d60qsNCpof5Vq32Xha1wQW3kVQ3yuyIFUBkPNAnSvQ5BZmFm/lkEE6SdPmxNfu66kc
         OagR0ZaHMiaGlCP4pD4LiGJbxkbyBbLOouatYzZ7x5j4SIwJwOCXf27bK1RQ9xz4H3no
         u1Jw==
X-Gm-Message-State: AFqh2kp44nNjPBmZ42OpTwb1/Kx8rpgGNnUlz19qUAj990NMyhE2MvWZ
        y4yRNymJM+s+2NY0+pQfiXEGbIvl6ME=
X-Google-Smtp-Source: AMrXdXsAFj7LX2jPPBlDWaIUPL21a+ULihyM8agjTYJ8iDhxCSbtuDDZ1Ami1KM1SumLWG0tPlBouA==
X-Received: by 2002:a05:600c:4f12:b0:3d9:f492:f25f with SMTP id l18-20020a05600c4f1200b003d9f492f25fmr19251855wmq.16.1673780623365;
        Sun, 15 Jan 2023 03:03:43 -0800 (PST)
Received: from [192.168.1.10] (198.red-79-146-135.dynamicip.rima-tde.net. [79.146.135.198])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003d1de805de5sm34425441wmb.16.2023.01.15.03.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 03:03:42 -0800 (PST)
Message-ID: <adf4e0ce-21e4-2b12-dc1a-492973da2697@gmail.com>
Date:   Sun, 15 Jan 2023 12:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Subject: intel_idle: question about RaptorLake support
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, rafael.j.wysocki@intel.com,
        vinay.kumar@intel.com, baieswara.reddy.sagili@intel.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

In the past months support for Raptor Lake was introduced in the linux 
kernel, but are there any plans to add C states support for Raptor Lake 
CPUs in intel_idle?
https://github.com/torvalds/linux/commit/d1cf8bbfed1edc5108220342ab39e4544d55fbc3
https://github.com/torvalds/linux/commit/65c0c2367e9e695b13d0d39307ebc8818bcdbd8d
(Excuse me if it's already planned and I spoke too soon, I don't want to 
bother anyone).

On my Core i5 13600k (+ MSI B760M Mortar Wifi) I can only get up to C3 
(and yes, the BIOS is set to C10) with Debian 11 + unstable kernel 
(6.1.0-1-amd64).

$ sudo cpupower idle-info
CPUidle driver: intel_idle
CPUidle governor: menu
analyzing CPU 0:

Number of idle states: 4
Available idle states: POLL C1_ACPI C2_ACPI C3_ACPI
POLL:
Flags/Description: CPUIDLE CORE POLL IDLE
Latency: 0
Usage: 2382
Duration: 89828
C1_ACPI:
Flags/Description: ACPI FFH MWAIT 0x0
Latency: 1
Usage: 60318
Duration: 10929541
C2_ACPI:
Flags/Description: ACPI FFH MWAIT 0x21
Latency: 127
Usage: 95333
Duration: 163522677
C3_ACPI:
Flags/Description: ACPI FFH MWAIT 0x60
Latency: 1048
Usage: 167392
Duration: 2160818143

Best regards,
Álvaro.
