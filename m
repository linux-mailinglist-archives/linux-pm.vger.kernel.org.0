Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7064056C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiLBLBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 06:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLBLBo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 06:01:44 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD32A6595
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 03:01:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r18so4074561pgr.12
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2022 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8oIXI7Gl5Ev+i5ApjJf4B1139RK0U5wYzKaGEnlId8=;
        b=avwdmFPuRneeA3KhE8NokWJqbXBFQUFRt+Le0emrAqH6JCX9m2f+I4qwYEG9qWBHfT
         WJknGmyBaCWEHq/PHJ8dJ6dJQto1+pHiS3GieU+GSesq7ex+DgozS86v37eb9Kb+qs9q
         Yb2rM6b+8cNY9aJFqDBHIDHe+eXtG9+MiCXKLZs0x/70mg1lS+FF2IBaofX+SQWF50J6
         l00EgXHKzbSW5ZcI3w+YDo8WgdAAvI3wy1Y545B985jl6vDhXjqwAFVTlaaX4bREP+fX
         nteliqkMaovhvS9EdCcEjIf8Nk75NJTZADRKgLmQ0JxKUarxgwQQ3+oEGB1nOk5rHP4d
         mhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8oIXI7Gl5Ev+i5ApjJf4B1139RK0U5wYzKaGEnlId8=;
        b=55eKVRnh+xNWbtWSM4/vz74FaT0OdCr0WVX5J0IpmFsAJI6BIVPdzbEWxkvuGJ/dZy
         zZ+V7bA8O6Hx1IHCaxzmtPPbHtQM3apnjaih06fYGEEaFbFOJ0yVQEoGZAmdSpTu992m
         gfmxxV97QuHogxZs2mc+OiV2H+IHNYqjgQR3BoUF6/hLkFJ92SaVU10LBROjhSVDZvRU
         6JNqk4SUrIHg21MuGRaGUX5BO5+s1ar4eVsPElcku2IA0c6z2bAFYJxF2yWZJ8nlTwAw
         JOcoELhUD/mIDIQDzMh3aFHioFKDyOm6OSNQgZdPVTrfGMFLHxOtVXkAB3WXCFuqKQtl
         6tFQ==
X-Gm-Message-State: ANoB5plstcXNCmC6rlCjFvfq+0+ON8pfFaBdDCbDJ7ECLmWSoE+jrGIx
        Ppn7LctG9Oygl2cfw68StXk2Bhzy+dow4pY4
X-Google-Smtp-Source: AA0mqf6krRyOgR/NF3iJ1mIRdAiblHmqLcgvZJ/2SOOQuX//EFRr0Lv9KilgJukZF+G+kVQsuFqUdQ==
X-Received: by 2002:a63:ed46:0:b0:476:e11d:8d51 with SMTP id m6-20020a63ed46000000b00476e11d8d51mr47557303pgk.252.1669978902476;
        Fri, 02 Dec 2022 03:01:42 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id y2-20020a623202000000b00574740c99e9sm4834948pfy.129.2022.12.02.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:01:41 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:31:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "vincent@systemli.org" <vincent@systemli.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Jia-wei Chang =?utf-8?B?KOW8teS9s+WBiSk=?= 
        <Jia-wei.Chang@mediatek.com>,
        Rex-BC Chen =?utf-8?B?KOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "thomas.huehn@hs-nordhausen.de" <thomas.huehn@hs-nordhausen.de>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
Subject: Re: Kernel Kernel bug caused by (cpufreq: mediatek: Refine
 mtk_cpufreq_voltage_tracking()) on Banana Pi R64 (MT7622)
Message-ID: <20221202110139.vmwcmoudakm2nap4@vireshk-i7>
References: <02c2c955-940b-b315-0474-85d0eddad7a3@leemhuis.info>
 <Y4jHvomTrU8guBox@makrotopia.org>
 <47a4665e-333d-a6e7-a2da-96cb06c2d87b@leemhuis.info>
 <20221202052716.uj3kzkunazmgazeq@vireshk-i7>
 <0ebef1a2-6b5a-04b9-a79b-79eb3349c32b@collabora.com>
 <c76bd301-0e8d-2d2b-0d3e-a57ece9b496f@collabora.com>
 <b1822bbc3775730c4cedf9652323c7d72e663e4b.camel@mediatek.com>
 <8be3e050-f32a-6761-8ebd-49c38dfcf9eb@collabora.com>
 <c186d104-43e0-ca10-3ce2-c2f922acd8bf@leemhuis.info>
 <37468027-6a27-dcb8-9c14-8f8426ec50d1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37468027-6a27-dcb8-9c14-8f8426ec50d1@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-22, 12:00, AngeloGioacchino Del Regno wrote:
> If Viresh can add those while applying the patch, that's fine for me - otherwise
> I can send a v2 adding the two suggested missing tags.

Sure, no problem.

-- 
viresh
