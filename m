Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E372E83A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbjFMQUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243157AbjFMQTx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 12:19:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0C92;
        Tue, 13 Jun 2023 09:19:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so6378085e9.1;
        Tue, 13 Jun 2023 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686673190; x=1689265190;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5XtHbUOFnSndKzIwlOTnUJluTBGdp3FK7IhsGYnnMU=;
        b=ipIGPCXHvxK+vy2hv3GHnTeYBFM2CYeQpZ6xvydjhD+vP57AT9GmbQ6jeMbaOCRSKX
         Og9Z/AvktaWT9pa9VvcT8cceJbWvNzttxD5vvasOcS92xh6c1sT2DL1ZRpHV9DZdMhA2
         4E4+CLYIkZq8/XVV/uRqK6gTuyYODf88KARma7NeHKnXqBSoFQ/5jhmDjBDkkYMzNrqX
         huUHas1llPu169RODp74EDy89jhy2OMytq+8g8ehzwAFkcZAVZ/bBKTd41oUP/c/qbw3
         6RSWWCkaLtrEuMbyrksBK+WYhWWR8g8QXT3BxZHkmYqqOhyhTMMGjFKtdOj3n4tMesBI
         8uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686673190; x=1689265190;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5XtHbUOFnSndKzIwlOTnUJluTBGdp3FK7IhsGYnnMU=;
        b=O1G//FPvUGy4gIjSs+M1ju2FIT9tQ6KLuaXg5NB4pjXzkTZGnT+pZAmzuzzPB2kBDO
         6HKz3IxF+jjQNPftfuKmlCJnpNUDFIaiiGTTZ864pXRBMiR6/vP09gsZvYU08WkCtYS/
         FsChAod0485igqt7FQ7tXPXBNBqXE4Wruw8woj617aihJoxCX/O2j0QYLS4FqiRBjK+c
         yumxgb6G/X/7G+ktNgKhSPWnGy4xasAr2i3R3QghS6E0FSeKsrACf1k21k2cMhvjLmc6
         iChpyuni0r06e0E58BFrZiWWSCirOBn63K+6s1eofU/MKUrRkts/aYBKSLUQyQDLXiH/
         ZClQ==
X-Gm-Message-State: AC+VfDwTiR+oF1YNjOv8tKSeuemu8gfYKrgsz6jE2zqLmqqSAgYXAfqG
        GwHq1UlTcvNXkViZL+71Gmg=
X-Google-Smtp-Source: ACHHUZ7xruECPZ92fCI0M68RCn1Xs8LlKYnjkYt2Flr4gM04otike18nlbYR4c4WFBE1tNhtwZUkIw==
X-Received: by 2002:a7b:c38b:0:b0:3f6:7e6:44ea with SMTP id s11-20020a7bc38b000000b003f607e644eamr7969928wmj.18.1686673189633;
        Tue, 13 Jun 2023 09:19:49 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b003047ae72b14sm15845460wrt.82.2023.06.13.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:19:49 -0700 (PDT)
Message-ID: <64889725.5d0a0220.9f037.0597@mx.google.com>
X-Google-Original-Message-ID: <ZIiXIhMijioZr3zX@Ansuel-xps.>
Date:   Tue, 13 Jun 2023 18:19:46 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
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
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 00/18] ARM: qcom: apq8064: support CPU frequency scaling
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <6486dcef.050a0220.4c054.4c59@mx.google.com>
 <99a68056-a4c9-d475-9245-e0802ffe4c89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a68056-a4c9-d475-9245-e0802ffe4c89@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 12, 2023 at 05:20:02PM +0300, Dmitry Baryshkov wrote:
> On 11/06/2023 19:27, Christian Marangi wrote:
> > On Mon, Jun 12, 2023 at 08:39:04AM +0300, Dmitry Baryshkov wrote:
> > > Implement CPUFreq support for one of the oldest supported Qualcomm
> > > platforms, APQ8064. Each core has independent power and frequency
> > > control. Additionally the L2 cache is scaled to follow the CPU
> > > frequencies (failure to do so results in strange semi-random crashes).
> > 
> > Hi, can we talk, maybe in private about this interconnect-cpu thing?
> 
> Hi, sure. Feel free to ping me on IRC (lumag) or via email. Or we can just
> continue our discussion here, as it might be interesting to other people
> too.
>

Don't know if here is the right place to discuss my concern and problem
with L2 scaling on ipq8064...

> > I see you follow the original implementation of the msm_bus where in
> > practice with the use of the kbps the correct clock and voltage was set.
> > (and this was also used to set the fabric clock from nominal to fast)
> > 
> > On ipq806x and I assume other SoC there isn't always a 1:1 map of CPU
> > freq and L2 freq. For example on ipq8064 we have max CPU freq of 1.4GHz
> > and L2 freq of 1.2GHz, on ipq8065 we have CPU 1.7GHz and L2 of 1.4GHz.
> 
> This is also the case for apq8064. The vendor kernel defines 15 frequencies
> for L2 cache clock, but then for some reasons all PVS tables use just 3
> entries from these 15.
> 

Eh who knows why they did this... Probably the hfpll was limited or they
notice no temp/power benefits were present with scaling with that much
of steps?

> > (and even that is curious since I used the debug regs and the cxo
> > crystal to measure the clock by hardware (yes i ported the very ancient
> > clk-debug to modern kernel and it works and discovered all sort of
> > things) the L2 (I assume due to climitation of the hfpll) actually can't
> > never reach that frequency (1.4GHz in reality results to something like
> > 1.2GHz from what I notice a stable clock is there only with frequency of
> > max 1GHz))
> 
> I would like to point you to https://github.com/andersson/debugcc/, which is
> a userspace reimplementation of clk-debug. We'd appreciate your patches
> there.
> 

Hi, I wasted some good time on the implementation but manage to make it
work and proposed a pr! I assume the thing can be reused for apq8064 if
someone ever wants to have fun with that.

> > So my idea was to introduce a simple devfreq driver and use the PASSIVE
> > governor where it was added the possibility to link to a CPU frequency
> > and with interpolation select the L2 frequency (and voltage)
> 
> I stumbled upon this idea, when I was working on the msm8996 and it's CBF
> clock (CBF = interconnect between two core clusters). While it should be
> possible to use DEVFREQ in simple cases (e.g. L2 clock >= max(CPU clock), if
> possible). However real configurations are slightly harder.
> E.g. for the purpose of this patchset, the relationship for apq8064 is the
> following (in MHz):
> 
>  CPU    L2
>  384    384
>  486    648
>  594    648
>  702    648
> ....    ...
> 1026    648
> 1134   1134
> ....   ....
> 1512   1134
> ....   ....
> 
> It should be noted that msm8960 also used just three values for the L2 cache
> frequencies. From what I can see, only msm8x60 made L2 freq tightly follow
> the CPU frequency.
> 

Happy to test and found a common path... With the merge of the cpu opp
and nvmem work, I was just about to send the L2 devfreq driver... And
also the fabric devfreq driver. But I wonder if I can use this
interconnect thing for the 2 task.

> >  From some old comments in ancient qsdk code it was pointed out that due
> > to a hw limitation the secondary cpu can't stay at a high clock if L2
> > was at the idle clock. (no idea if this is specific to IPQ806x) So this
> > might be a cause of your crash? (I also have random crash with L2
> > scaling and we are planning to just force the L2 at max frequency)
> 
> It might be related. It was more or less the same story with msm8996, which
> was either 'maxcpus=2' or scaling the CBF clock.
> 

Might be a krait defect... and this is pretty bad...

> > But sorry for all of this (maybe) useless info. I checked the other
> > patch and I didn't understand how the different L2 frequency are
> > declared and even the voltage. Is this something that will come later?
> > I'm very interested in this implementation.
> 
> The L2 frequency (<&kraitcc 4>) is converted into bandwidth vote, which then
> goes into the OPP tables. But please also see the discussion started at the
> patch 15.
> 

I didn't notice you were defining multiple supply, scaling the voltage
under the hood with that trick. It's not a bad idea but as pointed out
it might be problematic, since is seems krait is very sensible with L2
frequency and voltage so we should simulate the original implementation
as close as possible...

> > 
> > > 
> > > Core voltage is controlled through the SAW2 devices, one for each core.
> > > The L2 has two regulators, vdd-mem and vdd-dig.
> > > 
> > > Depenency: [1] for interconnect-clk implementation
> > > 
> > > https://lore.kernel.org/linux-arm-msm/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/
> > > 
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel
