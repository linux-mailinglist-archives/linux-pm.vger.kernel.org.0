Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB34BF70D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiBVLPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 06:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiBVLPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 06:15:48 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBFD048C
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 03:15:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u16so11649338pfg.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RmHLUrQ1Rpyk2THswbQEMpnI4viq+yykZdb0ldmGCg=;
        b=G7iic9SHp/6ylIs67c92Rk6Q87tO/mn8sbUSp8if18jc3Ew5J/TDaFSuXrZwNbbKjO
         2QBNhonlXNCVMwKBu993Ga6Gvp+CYqs/PP43UMt3+GAFqARuC+4gnF+o/zQ50J9KsRar
         i35tmUa+bXpQDy+ohGtkZstRyn3e3d3FRAwPS1AcIGlJuoEE+g8do4YQCJrCe1j/uiPf
         TrqQzeIjfL4ALB2vISZxPeZZvHwqKJVmT1iRVNw63qGyEZ8XDkodz1K1fEzUgCTwjfq9
         QAXskOlWlzwG7dYa08NobIg1h1o1zBgFNdMW73wfm2JmCrpX80pO/bX5xbKZc5Jss/4T
         W6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RmHLUrQ1Rpyk2THswbQEMpnI4viq+yykZdb0ldmGCg=;
        b=mnEp9ERn9WF+CWxHik9Ebha7roIdTAkpaoQACs8npnWRQ9PRGcyqyuAw9g/gDTCejj
         Mp9krz/ac6abU/mnsndezTSfTFNNFHtOKKYGeea3JuLbVP6N/BWuRtOGEtmvtUI/QEbE
         7Tp8CQA+vWem5neyJRhgfjamPBk3w7RT/4ZF25dy9MSV/hLpCPw9v12U4q4EJP91Tqyq
         MODRX0K9Rcp7wbJ1zUMs4LTtBKoJMJ0G3TqBOKpBg2y2ojDBUg7/t1SRV6gwt8ly2irt
         4TRTKCS7VPjBeY3ht2AlFsiJnnr31OTlwgZ9q38Ppbp0g5p/0Ruf87XAy7p7yNec2sAp
         HcCw==
X-Gm-Message-State: AOAM531YeKYn5CEotcXx/FKQPu+zpez34GOaeIZpmEo07UNagVygN6JS
        m/BKB0LurT6y0TILERzPwroiDQ==
X-Google-Smtp-Source: ABdhPJzDXTDR9vMzhJ3K5I8b2RIPS9LxkDKD54q8x3Dw8RVW6mUaFP9e3BvSzPmQMIqvq1KdMCohAA==
X-Received: by 2002:a63:5f0f:0:b0:370:1db0:5766 with SMTP id t15-20020a635f0f000000b003701db05766mr19286773pgb.532.1645528522107;
        Tue, 22 Feb 2022 03:15:22 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id l7sm16081473pfu.47.2022.02.22.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:15:21 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:45:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Message-ID: <20220222111519.rd5m4fxd7rvkuqqf@vireshk-i7>
References: <20220221225131.15836-1-lukasz.luba@arm.com>
 <20220221225131.15836-2-lukasz.luba@arm.com>
 <20220222030337.ijnfrh367illmidr@vireshk-i7>
 <147e48e5-e310-cd8f-ba8c-ff32e3094be3@arm.com>
 <20220222094547.tgj4bciq6rez62nk@vireshk-i7>
 <c83ae91b-6901-de2b-913e-b28af73c52fa@arm.com>
 <20220222101242.chwcxan2nyhczqth@vireshk-i7>
 <e979397d-c522-e0da-b997-16609fe308c5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e979397d-c522-e0da-b997-16609fe308c5@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-02-22, 11:03, Lukasz Luba wrote:
> OK, I misunderstood that. If that is possible than it would
> be great. I'm assuming you are taking about OPP v2.

Yes.

> I can relax the
> requirement that I need to provide this DT-EM for arm32, since they
> have a legacy OPP v1.

OPP V2 or V1 doesn't have anything to do with arm32/64. Anyone can implement the
newer V2 version (basically whoever wants something more than a simple freq/volt
pair). So arm32 SoC's that want to use the DT-EM thing, should migrate to
opp-v2, we can't support that with opp-v1.

> So we might have an entry similar that interconnect for the
> bandwidth, but for us it would be 'opp-power-uw'?

I will rather say similar to opp-microvolt or opp-microamp, so it better be
opp-microwatt.

> Let me have a look about some examples how that could be just
> added/extended in the opp table but from board file.
> If you have some handy link, I would be grateful.

The file I provided earlier:

arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts

This is updating opp-microvolt property of a single OPP node in the whole table.
Pretty much like this only.

-- 
viresh
