Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4803B8BE3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhGACIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbhGACIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:08:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABEC061756
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 19:05:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s14so4583129pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jun 2021 19:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hYLPIH+F1aB/Ex8sZNkV7diVvNOcwuZCotdh6VJ4Qbg=;
        b=IMylXk/p+JZY6Th53oRg8tCZv2NfvEyCZI7o7oPHuEPZELUmkzU/2DoYZCQI15uRCz
         XWIBEHm5MAkoMJ++7E0BDKGSHZzx8lRKWOIdLGJq8KKW/GfF8Tmfk5LTxJxQc4PfbvPZ
         u/FLSTsH8GyLcR0N+IwDlHWdvV3hHzQXL8dKa5Q5MpOyBeZUFZyu7S/bIpX3LdMHCCRC
         OuufR3sird9A0LNyal/9hWVm0LCwlS4BYBVN7TP/g2RSl0XD/0ai729/uze7+q1w2zql
         g3W7eqw60T9lvuUDAF8C5TFKJclwpIBt6O3iRiIIXPtCuifL6lkUaMQ//IkJyR8TsD5Z
         ZtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hYLPIH+F1aB/Ex8sZNkV7diVvNOcwuZCotdh6VJ4Qbg=;
        b=D2Q+tgKKmFyBfSg+/QQ2XPNMvxGlqfeoL0/BpVnnnAGsqTM3H05GCrnNkP5ckxLBuD
         MzuLS8AIPYQ7+HKnM/JXv8f3XWzIcoqhH3xPbBwgMQe51Cbtrw+k6n7eTgkcvc2tZHx6
         GWTw191doMleI7P77emR6olT3WmWu1bq8+GfVJD2gBZ9/vURX1eHdJ647KwbSIOXwzIm
         Kl8or4+wbXMMdO4Co9u1EuaRNDVTmhAyFpghROQN9IgLY13O/x1MEDyIGJgp22LW+pAJ
         UDXR0ir2N3Im3TxQBRedQ4YXyCo04LoMtJujxiH/ryxI3GUf/+TKKD4aDLVrb298k9Sp
         sK2Q==
X-Gm-Message-State: AOAM531Oz0DBe/mTM4i9wyzJUICTmJwW4esCEcaoBakB3Foim1cq9gya
        VjDerIy0G7bNEMfwCyotHhONVw==
X-Google-Smtp-Source: ABdhPJyTDL/dfNm7m2yjLiMW1+Cu0+vTJmiQm1v7xjgUfCHQu6Ku4fAV7DpWI5a/ySOmX/Oy8rzeQw==
X-Received: by 2002:a63:5052:: with SMTP id q18mr36695578pgl.349.1625105154108;
        Wed, 30 Jun 2021 19:05:54 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id e4sm4186275pgu.15.2021.06.30.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:05:53 -0700 (PDT)
Date:   Thu, 1 Jul 2021 07:35:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Konstantin Porotchkin <kostap@marvell.com>,
        nnet <nnet@fastmail.fm>, Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz
 variant
Message-ID: <20210701020551.svhbjpbdw526cq7a@vireshk-i7>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210630225601.6372-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-21, 00:56, Marek Behún wrote:
> The 1.2 GHz variant of the Armada 3720 SOC is unstable with DVFS: when
> the SOC boots, the WTMI firmware sets clocks and AVS values that work
> correctly with 1.2 GHz CPU frequency, but random crashes occur once
> cpufreq driver starts scaling.
> 
> We do not know currently what is the reason:
> - it may be that the voltage value for L0 for 1.2 GHz variant provided
>   by the vendor in the OTP is simply incorrect when scaling is used,
> - it may be that some delay is needed somewhere,
> - it may be something else.
> 
> The most sane solution now seems to be to simply forbid the cpufreq
> driver on 1.2 GHz variant.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> ---
> If someone from Marvell could look into this, it would be great since
> basically 1.2 GHz variant cannot scale, which is a feature that was
> claimed to be supported by the SOC.
> 
> Ken Ma / Victor Gu, you have worked on commit
> https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/d6719fdc2b3cac58064f41b531f86993c919aa9a
> in linux-marvell.
> Your patch takes away the 1202 mV constant for 1.2 GHz base CPU
> frequency and instead adds code that computes the voltages from the
> voltage found in L0 AVS register (which is filled in by WTMI firmware).
> 
> Do you know why the code does not work correctly for some 1.2 GHz
> boards? Do we need to force the L0 voltage to 1202 mV if it is lower,
> or something?
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I am not picking it up for 5.14-rc1 to make sure others get a chance
to provide reviews.

-- 
viresh
