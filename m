Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F657D619F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Oct 2023 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJYGZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Oct 2023 02:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjJYGZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2023 02:25:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22D132
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 23:25:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca816f868fso35456635ad.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698215111; x=1698819911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRNx4/VhgJBUmPLhfW0nzhO+j+HC6thHIfSQat4cc5Q=;
        b=E2TrS5twCMhJnRkIHOMNNqcEgDS2AEsF0M3m9s/HaI9gY729q04tRAq/7QNZ7+cBOU
         Ba3IzzbiUn1t9ozMz5lMCVCxxV04VZsgGe7Mef8ndh2b3IbF9I90FaV3B6AIbdmEendN
         7V6BQMSzkID7eUnXBxSTDFx30/8UNfiT6V0slAQzrxjyddUaNQXMC/r1hhKmpZjRa9BL
         1RcKEPoEXeWiwUNaknv0M6FSUYhkpcaq760kb502SEUH4C9ycryn4f5cmCVnW9PKqalD
         OSx8eu6mq9eDvN3qx/UaZ2be5KHJqA1ebie6Or7IrZ3otksLjy9AanbrLfstZjfBjCUr
         xImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698215111; x=1698819911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRNx4/VhgJBUmPLhfW0nzhO+j+HC6thHIfSQat4cc5Q=;
        b=mIrdp4V9gaH2Tu1nHsKtBiCH6nLDj4VuZQooSjhQmyEmEQztCELEQ6lOPN2g6aMeOq
         PaIl0cWQTnzU/q1ysMlsIslAKbarhwmr54KMsjeVOWyH8zed1dnfYBiN6Twj8bzpjGwd
         UH563Wpsj0p3yxdJxNn8x0JEHXl5p1Eyi2FbrxFh9MqC1NXo+jQZmDNytkPii3P/V+90
         4Ol4BqKZOissyUPSchShpC55B5J2RNnasg7zJelC9ClHadlP6bbxB9rlMtYhfWubC46+
         2SQRnEsSC1tVpIvrpsPF+YD5+V3xUeuxAy1CJBu/rCUBTx4ec/btQ54RTQoCPaKKM/dM
         5vpg==
X-Gm-Message-State: AOJu0Yyhp3hYRDvoAYjm27PqRy+UCzPb+Tr+yk3Wccav6DrJ53r5ySc7
        E1pOPqocVetsK4SdHmMKY7UB4Q==
X-Google-Smtp-Source: AGHT+IGohNcTFzm2Bh0bFriQkaNYjeD1yBiORs4U/Gyp7N7O3RPbMKBRyGUEMkF90cJRpigxhPHV9Q==
X-Received: by 2002:a17:903:11cd:b0:1c7:29fd:33b6 with SMTP id q13-20020a17090311cd00b001c729fd33b6mr13396486plh.40.1698215111463;
        Tue, 24 Oct 2023 23:25:11 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e5d100b001b89a6164desm8371393plf.118.2023.10.24.23.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 23:25:10 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:55:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, ilia.lin@kernel.org, sivaprak@codeaurora.org,
        quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Enable cpufreq for IPQ5332 & IPQ9574
Message-ID: <20231025062508.vccrmkem45p3fnwe@vireshk-i7>
References: <cover.1697781921.git.quic_varada@quicinc.com>
 <20231020070947.cwigtaa2haij56hz@vireshk-i7>
 <20231020080339.GA6197@varda-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020080339.GA6197@varda-linux.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-10-23, 13:33, Varadarajan Narayanan wrote:
> On Fri, Oct 20, 2023 at 12:39:47PM +0530, Viresh Kumar wrote:
> > On 20-10-23, 11:49, Varadarajan Narayanan wrote:
> > > Varadarajan Narayanan (9):
> > >   cpufreq: qti: Enable cpufreq for ipq53xx
> > >   cpufreq: qti: Introduce cpufreq for ipq95xx
> >
> > Can I pick just these two ?
> 
> ipq53xx patch is dependent on the previous safe source switching
> patch, hence not safe to pick that.
> 
> 	No -> cpufreq: qti: Enable cpufreq for ipq53xx
> 	Yes -> cpufreq: qti: Introduce cpufreq for ipq95xx

The patches don't apply cleanly. Please resend.

-- 
viresh
