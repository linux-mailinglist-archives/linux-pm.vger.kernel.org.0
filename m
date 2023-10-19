Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C147CF512
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbjJSKXr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbjJSKXq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 06:23:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E24F11F
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:23:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c434c33ec0so54363195ad.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697711024; x=1698315824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/3xZPvtfr/mVQnjF0aV9JZSvUaXwPGYQtJwXr+UJtY=;
        b=gpdSxC4XEl28o2IF8VPY8+8hvE0vvDvQGkm4Zm1pjipNMCaqq4HE/eZQAzjzKEJJ42
         QT3o/nRMXcaAsan3XeU3CDFpSZItds5CS/w22QXzNynkF+Rpx11FGT9D6wTGvDmetVyh
         XGZjiiiKYWAMWPTuDSXwVIWEfMy2viEfsLH5OIGqBunw5r6jBqBG8iW8qkank9JgNCY7
         naL8eADf1OI8+qKKD8XLXhiSRpuvS5KMqq4ABxd9fGU6ZC4WQPEVZIv50XL99BOd5z+f
         lf6kOShT7Pxs+kG7YsCaXlOz+8U+1psDcJ5CYYbVvtHCJ7fNIiZwguw7c3NT9lcQ/e0L
         kevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711024; x=1698315824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/3xZPvtfr/mVQnjF0aV9JZSvUaXwPGYQtJwXr+UJtY=;
        b=wRuw4IHLwWOHiMRtX7NnFBGD7nbo6LQh5vpTpllrcV6wI1t8V98aBYjzCn8I6KHewS
         ZmN6T5yp3ha3bMWCCIqYltjN7cK0fUBQPBb7JahCTxGjwnztG/MLgyBBHSZY99xDKsd4
         c+/iwJW/3X961T38SALfMVlCDca34dA9G8lZbvj4ZVr0anXBBhYVOrCjirwUsQjkYDZG
         Ao4k1FTp3ycu7NHOCbgvtdJDd5sbJzkjgV6ydK33lxNcVGHjSE0p6l9dPc0QyGryg554
         vS/EzZbLZYqhImzzFgCfNrpbpS92j1ta5S5goCJSdV+Q97N25b+x2T8CeIvffIO/+1fR
         Dyzg==
X-Gm-Message-State: AOJu0Ywg1JgTSwsiGZ3e7NN0pHqbWmwTlPqdA/19sXWgeP7/3FM7Ey0+
        T+/KJmPV+YWfC7Ph4P0jLvIBWQ==
X-Google-Smtp-Source: AGHT+IGUAjPiZZOm9dg7VwgfsgXj4ik9Y/90jwwsCROkUKLNGl6vWXGCfziiFvgFDewXwyHGK1nb4w==
X-Received: by 2002:a17:903:2443:b0:1c3:83e2:d0a9 with SMTP id l3-20020a170903244300b001c383e2d0a9mr2213230pls.58.1697711024544;
        Thu, 19 Oct 2023 03:23:44 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001c9ba6c7287sm1562203plg.143.2023.10.19.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:23:43 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:53:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <20231019102342.5f4oyxd6hmjcju6g@vireshk-i7>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-10-23, 11:46, Viresh Kumar wrote:
> On 18-10-23, 10:06, Stephan Gerhold wrote:
> > Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> > support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> > the necessary power domains vary depending on the actual PMIC the SoC
> > was combined with. With PM8909 the VDD_APC power domain is shared with
> > VDD_CX so the RPM firmware handles all voltage adjustments, while with
> > PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> > of a dedicated CPU regulator using CPR.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> 
> Applied patch 1 and 3. Thanks.

Hi Stephan,

I think your platform has exactly what I am looking for. Can you
please help me test this, before it lands into linux-next :)

https://lore.kernel.org/cover.1697710527.git.viresh.kumar@linaro.org

TIA.

-- 
viresh
