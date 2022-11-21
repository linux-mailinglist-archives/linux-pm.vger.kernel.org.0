Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B17631A86
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 08:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUHpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 02:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKUHpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 02:45:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A45766D
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 23:45:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v28so10583266pfi.12
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 23:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U4YrBZ+z5Rv0IVGY54zvMFMIIXczOnV6KezpP9Psod8=;
        b=d8JZSgvT5BA2o/z4WbLW3psSTivyO8g7XPXzffla04xDuMJhu8t4lVOKt8Vbe2Pop7
         yTKPTlgh7whFG5+4J9zoqSqNK3JWDAQiwSJYw290shiuW1+HElSc6++iWGKLKT7pIlCg
         GVLSmOLBHJViK/P4R9c+NZy9F7BrmolbUwsKA4sExYcmRk6ydtfWwkfhK9N/8T7ARc+G
         UayKsstAExOiUvc2e1AtdHm+5N2sxj7qv4GLwG6mjxf0QlmLm8wSDgyuI9QbW2UlRdhA
         OJYl1+ZTB37mwUDlclsEmd8AkFm65UkVyV4P2XSFa7b3ptRGh29Xg3rjPkydhtR5iIeI
         6Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4YrBZ+z5Rv0IVGY54zvMFMIIXczOnV6KezpP9Psod8=;
        b=vL58i/nG/0l41J1eyr4UIUCQVrGoormdMVly4+tDNn/c5PqD1S3dZY7M9n/ddL3UZ3
         0+P2F2muPkXowbf8Gr4qHeXTgAcy9gz7f5X+2KTMEf1lpu2Rw/FkkZsSTeXVSsvxTaC2
         uPnqe83Qtxt2JOQHahMHHGg0QYwdO9+vf1R4OsWeFimH53AJUdIRyuIKyjgZQq14RSgj
         Gkkd8v79eyym/kF0PcWJ4PFFmW8zptTBSChGIV/KCaHN/phC8ei3l2EHF/oPWPDOl5C0
         ZkEhLQVi4kCmh8sW1kSEzmYHgoprxWKpLfXD9MW3Bji2pL4SmzCQg7/pDHBhkk5jzZhI
         MHtA==
X-Gm-Message-State: ANoB5pnUvUJQ3B/xmn4O6Bwmywmwn0K/FLNYUZ6x45SXxYLAarD/BEz5
        yqtZG8xlDqcH1Z/hDhY2kIh2
X-Google-Smtp-Source: AA0mqf4f7se5taUJcccRbDf6HECYnxDm8eEEqavRBFe/z+MIHaXDoJXozlpOjk3olLjSJ9faNG3Cbw==
X-Received: by 2002:a63:d948:0:b0:46f:1081:f517 with SMTP id e8-20020a63d948000000b0046f1081f517mr16962151pgj.297.1669016701452;
        Sun, 20 Nov 2022 23:45:01 -0800 (PST)
Received: from thinkpad ([59.92.99.222])
        by smtp.gmail.com with ESMTPSA id m8-20020a170902db0800b001783f964fe3sm9085680plx.113.2022.11.20.23.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:45:00 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:14:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221121074453.GF11945@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121073817.7ollj7jeixrx5og5@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 21, 2022 at 01:08:17PM +0530, Viresh Kumar wrote:
> On 21-11-22, 08:22, Johan Hovold wrote:
> > On Mon, Nov 21, 2022 at 12:27:48PM +0530, Viresh Kumar wrote:
> > > This removes the special code added by the commit 2083da24eb56 ("OPP:
> > > Allow multiple clocks for a device"), to make it work for Qcom SoC.
> > > 
> > > In qcom-cpufreq-hw driver, we want to skip clk configuration that
> > > happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
> > > the "opp-hz" property so we can use the freq based OPP helpers.
> > > 
> > > The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
> > > no longer need the special handling of the same in the OPP core.
> > 
> > Didn't this affect also sc8280xp?
> 
> I assumed Mani fixed all affected Qcom SoCs :(
> 
> > Perhaps you can hold off with applying
> > this one for a bit until the needed devicetree changes are in linux-next
> > for all the affected platforms.
> 
> Sure.
> 
> > (It looks like Mani's series only updated sm8450 and I guess Bjorn
> > hasn't picked up that one up yet either.)
> 
> I applied that series today to my cpufreq/arm/linux-next, since it had
> cpufreq updates too and these patches are rebased on top of them.
> 

Ah, I thought you applied only cpufreq patches. DTS and bindings patches are
supposed to go through Bjorn's tree. Can you please drop them?

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
